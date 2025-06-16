/*
Function: WHF_fnc_msnDefendAidSupplies

Description:
    Players must defend civilian aid supplies from being stolen by OPFOR.
    Function must be ran in scheduled environment.

Parameters:
    PositionATL center:
        (Optional, default [])
        If specified, the given position is used for the supplies instead of
        attempting to find a suitable location.
    String factionAid:
        (Optional, default "")
        The defending faction to spawn units from.
        If not provided, a preferred faction is selected if available,
        or otherwise a random BLUFOR faction from WHF_factions_pool.
    String factionRaid:
        (Optional, default "")
        The attacking faction to spawn units from.
        If not provided, a random OPFOR faction is selected from WHF_factions_pool.

Author:
    thegamecracks

*/
params [["_center", []], ["_factionAid", ""], ["_factionRaid", ""]];

private _radius = 100;

if (_center isEqualTo []) then {
    private _locations = nearestLocations [
        [worldSize / 2, worldSize / 2],
        ["NameVillage", "NameCity", "NameCityCapital"],
        sqrt 2 / 2 * worldSize
    ];
    _locations = _locations call WHF_fnc_arrayShuffle;

    private _units = allUnits;
    private _safeRadius = _radius + 500;
    scopeName "center";
    {
        private _locationPosition = locationPosition _x;
        private _locationRadius = selectMax size _x * 0.75;
        for "_i" from 1 to 5 do {
            private _pos = [_locationPosition, _locationRadius] call WHF_fnc_randomPos;
            if (_pos isEqualTo [0,0]) exitWith {};

            if ([_pos, _safeRadius] call WHF_fnc_isNearRespawn) then {continue};
            if (_pos nearRoads _radius isEqualTo []) then {continue};

            private _area = [_pos, _safeRadius, _safeRadius, 0, false];
            if ([_units, _area] call WHF_fnc_anyInArea) then {continue};

            _center = _pos;
            breakTo "center";
        };
    } forEach _locations;
};
if (_center isEqualTo []) exitWith {
    diag_log text format ["%1: No center found", _fnc_scriptName];
};

if (_factionAid isEqualTo "") then {
    private _factions = ["ws_una", "gendarmerie"];
    _factions = _factions select {_x call WHF_fnc_isFactionSupported};
    _factionAid = _factions # 0;
};
private _civiliansAid = ["civilians", _factionAid];
private _standardAid = ["standard", _factionAid];
if (_factionRaid isEqualTo "") then {_factionRaid = selectRandom (WHF_factions_pool get opfor)};

private _supplyTypes = [
    "Land_PaperBox_01_open_boxes_F",
    "Land_PaperBox_01_open_water_F",
    "Land_FoodSacks_01_cargo_brown_idap_F",
    "Land_FoodSacks_01_large_brown_idap_F",
    "Land_WaterBottle_01_stack_F"
];

private _supplies = [];
for "_i" from 0 to 4 + random 6 do {
    private _type = selectRandom _supplyTypes;
    private _supply = createVehicle [_type, _center, [], _radius, "NONE"];
    _supply setDir random 360;
    _supply setVectorUp surfaceNormal getPosATL _supply;
    _supply allowDamage false;
    _supply enableSimulationGlobal false;
    _supplies pushBack _supply;
};
[_supplies, _center, _radius] call WHF_fnc_setPosOnRoads;

private _vehicleTypes = [_civiliansAid, _standardAid] call WHF_fnc_getVehicleTypes;
private _vehicles = [];
for "_i" from 0 to 4 + random 6 do {
    private _type = selectRandom _vehicleTypes;
    private _vehicle = createVehicle [_type, _center, [], _radius, "NONE"];
    _vehicle setFuel (0.2 + random 0.6);
    _vehicle setDir random 360;
    _vehicle setVectorUp surfaceNormal getPosATL _vehicle;
    _vehicle enableDynamicSimulation true;
    _vehicles pushBack _vehicle;
};
[_vehicles, _center, _radius] call WHF_fnc_setPosOnRoads;

private _groups = [];
{
    private _center = getPosATL _x getPos [5, random 360];
    private _quantity = 4 + floor random 5;

    private _guardGroup = [blufor, [_standardAid], _quantity, _center, 100, 1] call WHF_fnc_spawnUnits;
    [_guardGroup, _center, 50] call BIS_fnc_taskPatrol;
    _groups pushBack _guardGroup;

    private _civGroup = [civilian, [_civiliansAid], _quantity, _center, 100] call WHF_fnc_spawnUnits;
    [_civGroup, _center] call BIS_fnc_taskDefend;
    _groups pushBack _civGroup;
} forEach _supplies;

private _taskID = [
    blufor,
    "",
    "defendAidSupplies",
    _center,
    "CREATED",
    -1,
    true,
    "heal"
] call WHF_fnc_taskCreate;

private _playersInArea = {
    allPlayers
        select {side group _x isEqualTo blufor}
        inAreaArray [_center, _radius, _radius, 0, false, 20]
};

private _sideChat = {
    params ["_source", "_message", ["_params", []]];
    private _players = call _playersInArea;
    [_source, _message, _params] remoteExec ["WHF_fnc_localizedSideChat", _players];
};

private _scripts = [];
private _signal = [true];
call {
    scopeName "main";

    while {true} do {
        sleep 10;

        if (_supplies findIf {alive _x} < 0) exitWith {
            [_taskID, "CANCELED"] spawn WHF_fnc_taskEnd;
            breakOut "main";
        };

        if (count call _playersInArea > 0) exitWith {};
    };

    [[blufor, "HQ"], "$STR_WHF_defendAidSupplies_start"] call _sideChat;

    sleep 3;

    private _endAt = time + 600 + random 300;
    private _statusScript = [_signal, _supplies, _taskID, _endAt] spawn WHF_fnc_msnDefendAidSuppliesStatus;
    _scripts pushBack _statusScript;

    // TODO: spawn script to mark crates and let attackers steal them

    private _reinforceGroups = [];
    private _reinforceVehicles = [];
    private _reinforceScript =
        [_signal, _center, _supplies, _factionRaid, _reinforceGroups, _reinforceVehicles]
        spawn WHF_fnc_msnDefendAidSuppliesReinforcements;
    _scripts pushBack _reinforceScript;

    {[_x, false] remoteExec ["enableDynamicSimulation"]} forEach _groups;

    while {true} do {
        sleep 3;

        if (scriptDone _statusScript) exitWith {
            sleep 3;
            [_taskID, "FAILED"] spawn WHF_fnc_taskEnd;
            false
        };

        // TODO: add message on first contact by guards
        // TODO: add message when close to completion

        if (time >= _endAt) exitWith {
            _signal set [0, false];
            waitUntil {sleep 1; scriptDone _statusScript};
            // TODO: show message that raiders are retreating
            sleep 10;
            // TODO: show message of gratitude for players
            [_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
        };
    };

    _groups append _reinforceGroups;
    _vehicles append _reinforceVehicles;
};

_signal set [0, false];
waitUntil {sleep 1; _scripts findIf {!scriptDone _x} < 0};

[_supplies] call WHF_fnc_queueGCDeletion;
{[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
{[_x] call WHF_fnc_queueGCDeletion} forEach _vehicles;
