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
        private _locationRadius = selectMax size _x;
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
if (_factionRaid isEqualTo "") then {_factionRaid = selectRandom (WHF_factions_pool get opfor)};

private _supplyTypes = [
    "Land_PaperBox_01_open_boxes_F",
    "Land_PaperBox_01_open_water_F",
    "Land_FoodSacks_01_cargo_brown_idap_F",
    "Land_FoodSacks_01_large_brown_idap_F",
    "Land_WaterBottle_01_stack_F"
];

private _supplies = [];
for "_i" from 0 to 6 + random 6 do {
    // TODO: spawn supplies on roads
};

// TODO: spawn vehicles on roads
// TODO: spawn guards
// TODO: spawn civilians
private _groups = [];
private _vehicles = [];

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

// TODO: cancel if crates are deleted before starting
// TODO: trigger defense when players are in proximity
// TODO: fail if all crates are stolen
// TODO: succeed after a certain duration from start of defense
// NOTE: above tasks can be broken down into multiple while loops.
while {true} do {
    sleep 3;
};

[_supplies] call WHF_fnc_queueGCDeletion;
{[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
{[_x] call WHF_fnc_queueGCDeletion} forEach _vehicles;
