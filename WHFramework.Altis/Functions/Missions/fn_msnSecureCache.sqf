/*
Function: WHF_fnc_msnSecureCache

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
        If not provided, a random faction is selected from WHF_factions_pool.
    String factionB:
        (Optional, default "")
        The second faction to spawn units from.
        If not provided, a random faction is selected from WHF_factions_pool,
        preferring a different one from factionA if possible.

Author:
    thegamecracks

*/
params [["_center", []], ["_factionA", ""], ["_factionB", ""]];

private _radius = 100;

if (_center isEqualTo []) then {
    private _options = selectBestPlaces [
        [worldSize / 2, worldSize / 2],
        sqrt 2 / 2 * worldSize,
        "meadow + houses - forest - trees",
        100,
        50
    ];
    {
        _x params ["_pos"];
        _pos pushBack 0;
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

// Find a suitable position for the cache, and adjust the center to match it
_center = call {
    private _buildings = _center nearObjects _radius select {!isObjectHidden _x};
    _buildings = _buildings select {_x buildingPos 0 isNotEqualTo [0,0,0]};
    if (count _buildings > 0) exitWith {
        private _positions = selectRandom _buildings buildingPos -1;
        selectRandom _positions
    };
    [_center, [3, _radius]] call WHF_fnc_randomPos
};
private _reinforceArea = [_center, _radius / 2, _radius / 2, 0, false];

if (_factionA isEqualTo "") then {_factionA = selectRandom WHF_factions_pool};
if (_factionB isEqualTo "") then {
    private _factions = WHF_factions_pool;
    if (count _factions > 1) then {_factions = _factions - [_factionA]};
    _factionB = selectRandom _factions;
};
private _standard = [["standard", _factionA], ["standard", _factionB]];
private _supply = [["supply", _factionA], ["supply", _factionB]];

// TODO: add multiple caches
private _cache = createVehicle ["Box_FIA_Ammo_F", [-random 500, -random 500, 500], [], 0, "CAN_COLLIDE"];
_cache enableSimulationGlobal false;
_cache setDir random 360;
_cache setPosATL _center;
[_cache] remoteExec ["WHF_fnc_msnSecureCacheAction", 0, _cache];

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

private _vehicleCount = 1 + floor random 4;
private _vehicleGroup =
    [opfor, _supply, _standard, _vehicleCount, _center, 100]
    call WHF_fnc_spawnVehicles;
_groups pushBack _vehicleGroup;
_vehicles append assignedVehicles _vehicleGroup;
[_vehicleGroup, _center] call BIS_fnc_taskDefend;

private _taskID = [
    blufor,
    "",
    [
        [
            "STR_WHF_secureCache_description",
            [_factionA] call WHF_fnc_localizeFaction,
            [_factionB] call WHF_fnc_localizeFaction
        ],
        "STR_WHF_secureCache_title"
    ],
    _center getPos [25 + random 50, random 360],
    "CREATED",
    -1,
    true,
    "rifle"
] call WHF_fnc_taskCreate;

private _reinforced = false;
while {true} do {
    sleep 3;
    if (!alive _cache) exitWith {[_taskID, "CANCELED"] spawn WHF_fnc_taskEnd};
    if (!_reinforced && {[units blufor, _reinforceArea] call WHF_fnc_anyInArea}) then {
        [_center, _radius, _factionA, _factionB, _groups, _vehicles]
            call WHF_fnc_msnSecureCacheReinforcements;
        _reinforced = true;
    };
    if (_cache getVariable ["WHF_cache_secured", false] isEqualTo true) exitWith {
        [_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
    };
};

[_cache] call WHF_fnc_queueGCDeletion;
{[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
{[_x] call WHF_fnc_queueGCDeletion} forEach _vehicles;
