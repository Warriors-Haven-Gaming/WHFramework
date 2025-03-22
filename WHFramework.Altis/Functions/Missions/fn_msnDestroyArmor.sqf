/*
Function: WHF_fnc_msnDestroyArmor

Description:
    Players must destroy an armor staging area.
    Function must be ran in scheduled environment.

Parameters:
    PositionATL ecnter:
        (Optional, default [])
        If specified, the given position is used for the intel instead of
        attempting to find a suitable location.

Author:
    thegamecracks

*/
params [["_center",[]]];

if (_center isEqualTo []) then {
    private _options = selectBestPlaces [
        [worldSize / 2, worldSize / 2],
        sqrt 2 / 2 * worldSize,
        "meadow - forest - trees",
        100,
        200
    ];
    {
        _x params ["_pos"];
        _pos pushBack 0;
        if ([_pos, 1000] call WHF_fnc_isNearRespawn) then {continue};
        if (_pos nearRoads 100 isNotEqualTo []) then {continue};
        if (_pos isFlatEmpty [-1, -1, 1, 40] isEqualTo []) then {continue};
        _center = _pos;
        break;
    } forEach _options;
};
if (_center isEqualTo []) exitWith {
    diag_log text format ["%1: No center found", _fnc_scriptName];
};

private _radius = 150;
private _area = [_center, _radius, _radius, 0, false];

private _terrainObjects = nearestTerrainObjects [_center, [], 30, false];
_terrainObjects apply {hideObjectGlobal _x};

private _depot = [
    [["StorageBladder_01_fuel_forest_F",[-1,1,0],90],["CamoNet_ghex_open_F",[0,0,1.09],90],["B_Slingload_01_Fuel_F",[-1,-7,0],60],["Box_East_AmmoVeh_F",[-3,7,0],0],["Land_RepairDepot_01_green_F",[-8,3,0],0],["Land_RepairDepot_01_green_F",[-8,-3,0],0],["Land_FuelStation_01_pump_F",[-6,7,0],0],["Land_FuelStation_01_pump_F",[-9,7,0],0],["B_Slingload_01_Ammo_F",[-8,-9,0],90]],
    _center,
    random 360,
    ["frozen", "normal"]
] call WHF_fnc_objectsMapper;

private _groups = [];
private _vehicles = [];

{
    _x params ["_vehicleType", "_vehicleQuantity"];
    private _pos = [_center, [30, _radius]] call WHF_fnc_randomPos;
    if (_pos isEqualTo [0,0]) then {continue};

    private _vehicleArgs = [opfor, _vehicleType, _vehicleQuantity, _pos, 30];
    private _vehicleGroup = _vehicleArgs call WHF_fnc_spawnVehicles;
    [_vehicleGroup, _pos] call BIS_fnc_taskDefend;
    _groups pushBack _vehicleGroup;
    _vehicles append assignedVehicles _vehicleGroup;

    private _infantryQuantity = selectRandom [8, 12, 16];
    private _infantryArgs = [opfor, "standard", _infantryQuantity, _pos, 30];
    private _infantryGroup = _infantryArgs call WHF_fnc_spawnUnits;
    [_infantryGroup, _pos] call BIS_fnc_taskDefend;
    _groups pushBack _infantryGroup;
} forEach [
    ["standard", 4 + floor random 5],
    ["supply", 3 + floor random 4],
    ["mrap", 2 + floor random 3],
    ["apc", 2 + floor random 3],
    ["ifv", 2 + floor random 3],
    ["mbt", 2 + floor random 3]
];

if (count _vehicles < 1) exitWith {
    diag_log text format ["%1: center %2 not clear to spawn vehicles", _fnc_scriptName, _center];
    [_depot] call WHF_fnc_queueGCDeletion;
    [_terrainObjects] call WHF_fnc_queueGCUnhide;
    {[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
};

private _taskCenter = _center getPos [20 + random 20, random 360];
private _taskArea = [_taskCenter, _radius, _radius, 0, false];
private _areaMarker = [["WHF_msnDestroyArmor_"], _taskArea, true] call WHF_fnc_createAreaMarker;
_areaMarker setMarkerBrushLocal "FDiagonal";
_areaMarker setMarkerColorLocal "ColorRed";
_areaMarker setMarkerAlpha 0.7;

private _activeVehicles = {_vehicles select {alive _x} inAreaArray _area};
private _current = count call _activeVehicles;

private _getDescription = {[
    ["STR_WHF_destroyArmor_description", _current],
    "STR_WHF_destroyArmor_title"
]};

private _taskDescription = call _getDescription;
private _taskID = [
    blufor,
    "",
    _taskDescription,
    _taskCenter,
    "CREATED",
    -1,
    true,
    "destroy"
] call WHF_fnc_taskCreate;

while {true} do {
    sleep 10;

    _current = count call _activeVehicles;
    if (_current < 1) exitWith {
        [_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
    };

    private _description = call _getDescription;
    if (_taskDescription isNotEqualTo _description) then {
        [_taskID, nil, _description] call BIS_fnc_setTask;
        _taskDescription = _description;
    };
};

deleteMarker _areaMarker;

[_depot] call WHF_fnc_queueGCDeletion;
[_terrainObjects] call WHF_fnc_queueGCUnhide;
{[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
{[_x] call WHF_fnc_queueGCDeletion} forEach _vehicles;
