/*
Function: WHF_fnc_msnDefendAidSupplies

Description:
    Players must defend civilian aid supplies from being stolen by OPFOR.
    Function must be executed in scheduled environment.

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

private _radius = 200;

if (_center isEqualTo []) then {
    private _locations = nearestLocations [
        [worldSize / 2, worldSize / 2],
        ["NameCity", "NameCityCapital", "NameVillage"],
        sqrt 2 / 2 * worldSize
    ];
    _locations = _locations - ([_locations] call WHF_fnc_inAreaDeadzone);
    _locations = _locations call WHF_fnc_arrayShuffle;

    private _units = allUnits;
    private _safeRadius = _radius + 500;
    scopeName "center";
    {
        private _locationPosition = locationPosition _x;
        private _locationRadius = selectMax size _x * 0.75;
        for "_i" from 1 to 5 do {
            private _pos = [[[_locationPosition, _locationRadius]]] call BIS_fnc_randomPos;
            if (_pos isEqualTo [0,0]) then {break};
            _pos = _pos vectorMultiply [1,1,0];

            if ([_pos, _safeRadius] call WHF_fnc_isNearRespawn) then {continue};
            if (count (_pos nearRoads _radius) < 20) then {continue};

            private _area = [_pos, _safeRadius, _safeRadius];
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
private _supplyCount = [5, 10] call WHF_fnc_scaleUnitsSide;
for "_i" from 1 to _supplyCount do {
    private _type = selectRandom _supplyTypes;
    private _supply = createVehicle [_type, _center, [], _radius, "NONE"];
    _supply setDir random 360;
    _supply setPos (getPosATL _supply vectorMultiply [1,1,0]);
    _supply allowDamage false;
    _supply spawn {sleep 1; _this enableSimulationGlobal false};
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
    _vehicle setPos (getPosATL _vehicle vectorMultiply [1,1,0]);
    _vehicles pushBack _vehicle;
};
[_vehicles, _center, _radius] call WHF_fnc_setPosOnRoads;
[_vehicles, true, 1] spawn WHF_fnc_enableDynamicSimulation;

private _groups = [];
{
    private _center = getPosATL _x getPos [5, random 360];
    private _quantity = 4 + floor random 2;

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
        inAreaArray [_center, _radius, _radius, 0, false, 50]
};

private _sideChat = {
    params ["_source", "_message", ["_params", []]];
    private _players = call _playersInArea;
    [_source, _message, _params] remoteExec ["WHF_fnc_localizedSideChat", _players];
};

private _canDefend = while {true} do {
    sleep 10;

    if (_supplies findIf {alive _x} < 0) exitWith {
        [_taskID, "CANCELED"] spawn WHF_fnc_taskEnd;
        false
    };

    if (count call _playersInArea > 0) exitWith {true};
};

if (!_canDefend) exitWith {
    [_supplies] call WHF_fnc_queueGCDeletion;
    {[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
    {[_x] call WHF_fnc_queueGCDeletion} forEach _vehicles;
};

[[blufor, "HQ"], "$STR_WHF_defendAidSupplies_start"] call _sideChat;
[_groups, false] call WHF_fnc_enableDynamicSimulation;
sleep 3;
[_center, _radius, _supplies, _factionRaid, _taskID, _groups, _vehicles]
    call WHF_fnc_msnDefendAidSuppliesStart;

[_supplies] call WHF_fnc_queueGCDeletion;
{[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
{[_x] call WHF_fnc_queueGCDeletion} forEach _vehicles;
