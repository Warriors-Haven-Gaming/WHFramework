/*
Function: WHF_fnc_msnSecureCaches

Description:
    Players must secure a weapons cache between two factions.
    Function must be ran in scheduled environment.

Parameters:
    PositionATL center:
        (Optional, default [])
        If specified, the given position is used for the cache instead of
        attempting to find a suitable location.
    String factionA:
        (Optional, default "")
        The first faction to spawn units from.
        If not provided, a random OPFOR faction is selected from WHF_factions_pool.
    String factionB:
        (Optional, default "")
        The second faction to spawn units from.
        If not provided, a random OPFOR faction is selected from WHF_factions_pool,
        preferring a different one from factionA if possible.

Author:
    thegamecracks

*/
params [["_center", []], ["_factionA", ""], ["_factionB", ""]];

private _radius = 100;
private _cacheRadius = 30;

if (_center isEqualTo []) then {
    private _options = ["houses + meadow - forest - sea - trees"] call WHF_fnc_selectBestPlaces;
    {
        private _pos = _x;
        if ([_pos, _radius + 500] call WHF_fnc_isNearRespawn) then {continue};
        if (_pos isFlatEmpty [-1, -1, 0.45, 12] isEqualTo []) then {continue};
        if ([_pos, _radius + 100] call WHF_fnc_isNearUsedPosition) then {continue};
        _center = _pos;
        break;
    } forEach _options;
};
if (_center isEqualTo []) exitWith {
    diag_log text format ["%1: No center found", _fnc_scriptName];
};
private _reinforceArea = [_center, _cacheRadius, _cacheRadius, 0, false];

if (_factionA isEqualTo "") then {_factionA = selectRandom (WHF_factions_pool get opfor)};
if (_factionB isEqualTo "") then {
    private _factions = (WHF_factions_pool get opfor);
    if (count _factions > 1) then {_factions = _factions - [_factionA]};
    _factionB = selectRandom _factions;
};
private _standard = [["standard", _factionA], ["standard", _factionB]];
private _supply = [["supply", _factionA], ["supply", _factionB]];

private _positions = call {
    private _positions = [];
    private _objects = _center nearObjects _cacheRadius select {!isObjectHidden _x};
    {_positions append (_x buildingPos -1)} forEach _objects;
    _positions call WHF_fnc_arrayShuffle
};

private _caches = [];
for "_i" from 0 to 1 + random 4 do {
    private _pos = if (_i < count _positions) then {_positions # _i} else {
        [_center, [3, _cacheRadius]] call WHF_fnc_randomPos
    };
    if (_pos isEqualTo [0,0]) then {break};

    private _cache = createVehicle ["Box_FIA_Ammo_F", [-random 500, -random 500, 500], [], 0, "CAN_COLLIDE"];
    _cache enableSimulationGlobal false;
    _cache setDir random 360;
    _cache setVectorUp surfaceNormal _pos;
    _cache setPosATL _pos;
    [_cache] remoteExec ["WHF_fnc_msnSecureCachesAction", 0, _cache];
    _caches pushBack _cache;
};

if (count _caches < 1) exitWith {
    diag_log text format ["%1: center %2 not clear to spawn caches", _fnc_scriptName, _center];
};

private _groups = [];
private _vehicles = [];

private _quantity = 10 + floor random (count allPlayers min 10);
private _group = [opfor, _standard, _quantity, _center, _radius] call WHF_fnc_spawnUnits;
_groups pushBack _group;
[_group, _center] call BIS_fnc_taskDefend;

private _garrisonGroup = [opfor, _standard, _quantity, _center, 100] call WHF_fnc_spawnUnits;
[_garrisonGroup, _center, _radius, true] call WHF_fnc_garrisonUnits;
[[_garrisonGroup], _groups] spawn WHF_fnc_ungarrisonLoop;
_groups pushBack _garrisonGroup;

// WHF_fnc_garrisonUnits doesn't filter obstructed positions.
// As a workaround, delete any units that spawn inside our caches.
{
    private _unit = _x;
    if (_caches findIf {_unit distance _x < 2.5} < 0) then {continue};
    deleteVehicle _unit;
} forEach units _garrisonGroup;

private _vehicleCount = 2 + floor random 4;
private _vehicleGroup =
    [opfor, _supply, _standard, _vehicleCount, _center, 100]
    call WHF_fnc_spawnVehicles;
_groups pushBack _vehicleGroup;
_vehicles append assignedVehicles _vehicleGroup;

call {
    private _vehicles = assignedVehicles _vehicleGroup;
    if (count _vehicles < 1) exitWith {};

    private _roads = _center nearRoads _cacheRadius * 1.5 apply {getRoadInfo _x} select {
        _x # 0 in ["ROAD", "MAIN ROAD", "TRACK"] && {!(_x # 2)}
    };
    _roads = _roads call WHF_fnc_arrayShuffle;

    private _index = 0;
    {
        if (_index >= count _vehicles) then {break};
        private _vehicle = _vehicles # _index;

        private _pos = [_x, random 1, 0.3 - random 0.6] call WHF_fnc_getRoadPos;
        if (_pos nearObjects 5 isNotEqualTo []) then {continue};

        _x params ["", "", "", "", "", "", "_begPos", "_endPos"];
        private _dir = _begPos getDir _endPos;
        _vehicle setDir _dir;
        _vehicle setPosATL _pos;

        _index = _index + 1;
    } forEach _roads;
};

private _taskID = [
    blufor,
    "",
    [
        [
            "STR_WHF_secureCaches_description",
            [_factionA] call WHF_fnc_localizeFaction,
            [_factionB] call WHF_fnc_localizeFaction
        ],
        "STR_WHF_secureCaches_title"
    ],
    _center,
    "CREATED",
    -1,
    true,
    "rifle"
] call WHF_fnc_taskCreate;

private _allCachesSecured = {
    _caches findIf {
        !isNull _x
        && {_x getVariable ["WHF_cache_secured", false] isNotEqualTo true}
    } < 0
};

private _playersInArea = {
    private _players = allPlayers select {side group _x isEqualTo blufor};
    [_players, _reinforceArea] call WHF_fnc_anyInArea
};

private _reinforced = false;
while {true} do {
    sleep 3;
    if (call _allCachesSecured) exitWith {
        [_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
    };

    if (!_reinforced && _playersInArea) then {
        [_center, _radius, _factionA, _factionB, _groups, _vehicles]
            call WHF_fnc_msnSecureCachesReinforcements;
        _reinforced = true;
    };
};

[_caches] call WHF_fnc_queueGCDeletion;
{[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
{[_x] call WHF_fnc_queueGCDeletion} forEach _vehicles;
