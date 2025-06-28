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
    String faction:
        (Optional, default "")
        The faction to spawn units from.
        If not provided, a random OPFOR faction is selected from WHF_factions_pool.

Author:
    thegamecracks

*/
params [["_center", []], ["_faction", ""]];

private _radius = 250;

if (_center isEqualTo []) then {
    private _options = ["meadow - forest - sea - trees"] call WHF_fnc_selectBestPlaces;
    {
        private _pos = _x;
        if ([_pos, _radius + 1000] call WHF_fnc_isNearRespawn) then {continue};
        if (_pos nearRoads 100 isNotEqualTo []) then {continue};
        if (_pos isFlatEmpty [-1, -1, 1, 40] isEqualTo []) then {continue};
        if ([_pos, _radius] call WHF_fnc_isNearUsedPosition) then {continue};
        _center = _pos;
        break;
    } forEach _options;
};
if (_center isEqualTo []) exitWith {
    diag_log text format ["%1: No center found", _fnc_scriptName];
};

if (_faction isEqualTo "") then {_faction = selectRandom (WHF_factions_pool get opfor)};
private _standard = ["standard", _faction];

private _area = [_center, _radius, _radius];

private _objects = [];
private _terrain = [];
private _groups = [];
private _vehicles = [];

call {
    private _turretTypes = [
        "O_HMG_01_high_F",
        "O_HMG_02_high_F",
        "CUP_O_KORD_high_RUS_M_Summer"
    ] select {isClass (configFile >> "CfgVehicles" >> _x)};

    private _centerComp = [["CamoNet_ghex_F",[0.000427246,0.00878906,0.5],268.016],["Land_HBarrier_01_big_4_green_F",[-4.03668,4.41309,0],90],["Land_HBarrier_01_big_4_green_F",[-4.211,-4.2959,0],90],["Land_HBarrier_01_line_3_green_F",[3.02679,7.91406,0],27.2651],["Land_HBarrier_01_line_3_green_F",[3.06683,-8.26172,0],338.379],["Land_HBarrier_01_big_tower_green_F",[-1.91608,-10.5459,0],0],["Land_HBarrier_01_big_tower_green_F",[-1.67633,10.666,0],180],["Land_BagFence_01_long_green_F",[2.77533,-15.6523,0],0],["Land_BagFence_01_long_green_F",[2.46088,15.7344,0],0],["CamoNet_ghex_F",[17.1284,-4.93555,0.5],87.55],["CamoNet_ghex_F",[16.9638,5.79102,0.5],87.55],["Land_HBarrier_01_big_4_green_F",[17.2783,-15.8945,0],0],["Land_HBarrier_01_big_4_green_F",[17.0004,16.5674,0],0],["Land_HBarrier_01_big_tower_green_F",[23.1601,-10.2598,0],0],["Land_HBarrier_01_big_tower_green_F",[23.3124,10.4678,0],180],["Land_HBarrier_01_big_4_green_F",[27.3178,-4.31641,0],90],["Land_HBarrier_01_big_4_green_F",[27.3408,4.52051,0],90]];
    private _centerService = [["B_Slingload_01_Fuel_F",[1.22894,-2.44824,0],179.719],["B_Slingload_01_Ammo_F",[15.9775,5.78711,0],0],["B_Slingload_01_Repair_F",[16.9716,-4.28516,0],0]];
    private _centerTurrets = [[selectRandom _turretTypes,[2.93109,-13.7754,0],206.313],[selectRandom _turretTypes,[3.11127,13.875,0],331.155]];

    private _centerTerrain = nearestTerrainObjects [_center, [], 30, false, true];
    _centerTerrain apply {hideObjectGlobal _x};
    _terrain append _centerTerrain;

    private _dir = random 360;
    _centerComp = [_centerComp, _center, _dir, ["normal", "path", "simple"], _objects] call WHF_fnc_objectsMapper;
    _centerService = [_centerService, _center, _dir, ["frozen", "normal"], _objects] call WHF_fnc_objectsMapper;
    _centerTurrets = [_centerTurrets, _center, _dir, ["normal"], _objects] call WHF_fnc_objectsMapper;
    _objects append _centerComp;
    _objects append _centerService;
    _objects append _centerTurrets;

    private _quantity = [8, 16] call WHF_fnc_scaleUnitsSide;
    private _group = [opfor, [_standard], _quantity, _center, 20] call WHF_fnc_spawnUnits;
    [_group, _center] call BIS_fnc_taskDefend;
    _groups pushBack _group;

    private _turretGroup = [opfor, [_standard], _centerTurrets] call WHF_fnc_spawnGunners;
    _groups pushBack _turretGroup;
};

{
    _x params ["_vehicleType", "_vehicleQuantity"];
    private _pos = [_center, [30, _radius]] call WHF_fnc_randomPos;
    if (_pos isEqualTo [0,0]) then {break};

    private _vehicleArgs = [opfor, [_vehicleType], [_standard], _vehicleQuantity, _pos, 30];
    private _vehicleGroup = _vehicleArgs call WHF_fnc_spawnVehicles;
    [_vehicleGroup, _pos] call BIS_fnc_taskDefend;
    _groups pushBack _vehicleGroup;
    _vehicles append assignedVehicles _vehicleGroup;

    private _infantryQuantity = [8, 16] call WHF_fnc_scaleUnitsSide;
    private _infantryArgs = [opfor, [_standard], _infantryQuantity, _pos, 30];
    private _infantryGroup = _infantryArgs call WHF_fnc_spawnUnits;
    [_infantryGroup, _pos] call BIS_fnc_taskDefend;
    _groups pushBack _infantryGroup;

    private _depotPos = [_pos, [5, 50]] call WHF_fnc_randomPos;
    if (_depotPos isNotEqualTo [0,0]) then {
        private _depotTerrain = nearestTerrainObjects [_depotPos, [], 30, false, true];
        _depotTerrain apply {hideObjectGlobal _x};
        _terrain append _depotTerrain;

        private _depotDir = ((_depotPos getDir _pos) + 90) % 360;
        private _depot = [
            [["StorageBladder_01_fuel_forest_F",[-1,1,0],90],["CamoNet_ghex_open_F",[0,0,1.09],90],["B_Slingload_01_Fuel_F",[-1,-7,0],60],["Box_East_AmmoVeh_F",[-3,7,0],0],["Land_RepairDepot_01_green_F",[-8,3,0],0],["Land_RepairDepot_01_green_F",[-8,-3,0],0],["Land_FuelStation_01_pump_F",[-6,7,0],0],["Land_FuelStation_01_pump_F",[-9,7,0],0],["B_Slingload_01_Ammo_F",[-8,-9,0],90]],
            _depotPos,
            _depotDir,
            ["normal", "simple"]
        ] call WHF_fnc_objectsMapper;
        _objects append _depot;
    };
} forEach [
    [["standard", _faction], [4, 8] call WHF_fnc_scaleUnitsSide],
    [["supply", _faction],   [3, 6] call WHF_fnc_scaleUnitsSide],
    [["mrap", _faction],     [2, 4] call WHF_fnc_scaleUnitsSide],
    [["apc", _faction],      [2, 4] call WHF_fnc_scaleUnitsSide],
    [["ifv", _faction],      [2, 4] call WHF_fnc_scaleUnitsSide],
    [["mbt", _faction],      [2, 4] call WHF_fnc_scaleUnitsSide]
];

if (count _vehicles < 1) exitWith {
    diag_log text format ["%1: center %2 not clear to spawn vehicles", _fnc_scriptName, _center];
    [_objects] call WHF_fnc_queueGCDeletion;
    [_terrain] call WHF_fnc_queueGCUnhide;
    {[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
};

private _taskCenter = _center getPos [20 + random 20, random 360];
private _taskArea = [_taskCenter, _radius, _radius];
private _areaMarker = [["WHF_msnDestroyArmor_"], _taskArea, true] call WHF_fnc_createAreaMarker;
_areaMarker setMarkerBrushLocal "FDiagonal";
_areaMarker setMarkerColorLocal "ColorRed";
_areaMarker setMarkerAlpha 0.7;

private _activeVehicles = {_vehicles select {alive _x} inAreaArray _area};
private _current = count call _activeVehicles;

private _getDescription = {[
    ["STR_WHF_destroyArmor_description", _current, _areaMarker],
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

[_objects] call WHF_fnc_queueGCDeletion;
[_terrain] call WHF_fnc_queueGCUnhide;
{[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
{[_x] call WHF_fnc_queueGCDeletion} forEach _vehicles;
