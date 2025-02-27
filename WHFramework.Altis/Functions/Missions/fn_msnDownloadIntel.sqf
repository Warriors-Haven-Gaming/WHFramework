/*
Function: WHF_fnc_msnDownloadIntel

Description:
    Players must download intel from a research building.
    Function must be ran in scheduled environment.

Parameters:
    PositionATL intelCenter:
        (Optional, default [])
        If specified, the given position is used for the intel instead of
        attempting to find a suitable location.

Author:
    thegamecracks

*/
params [["_intelCenter",[]]];

private _intelDir = random 360;
if (_intelCenter isEqualTo []) then {
    private _options = selectBestPlaces [[worldSize / 2, worldSize / 2], sqrt 2 / 2 * worldSize, "forest", 100, 50];
    {
        _x params ["_pos"];
        _pos pushBack 0;
        if (_pos isFlatEmpty [-1, -1, 0.45, 12] isEqualTo []) then {continue};
        if (_pos nearRoads 50 isNotEqualTo []) then {continue};
        _intelCenter = _pos;
        break;
    } forEach _options;
};
if (_intelCenter isEqualTo []) exitWith {
    diag_log text format ["%1: No center found", _fnc_scriptName];
};

private _terrainObjects = nearestTerrainObjects [_intelCenter, [], 20, false];
_terrainObjects apply {hideObjectGlobal _x};

private _intelBuilding = [
    _intelCenter,
    _intelDir,
    [
        ["Land_Research_house_V1_F",[0.899902,-1.85547,-0.00143886],0,1,0,[],"","",true,true],
        ["MapBoard_Tanoa_F",[0.391602,-0.604004,0.591373],172.602,1,0,[],"","",false,true],
        ["Land_PortableDesk_01_olive_F",[-0.393555,0.613281,0.727409],0,1,0,[],"","",false,true],
        ["Land_OfficeChair_01_F",[-0.799805,1.44043,0.727409],300,1,0,[],"","",false,true],
        ["Land_PCSet_Intel_01_F",[-0.316406,0.70459,1.62358],201.424,1,0,[],"","",false,true],
        ["Land_BatteryPack_01_closed_olive_F",[0.03125,0.4375,1.61434],30.2656,1,0,[],"","",false,true],
        ["Land_Document_01_F",[0.0219727,0.81543,1.62358],194.368,1,0,[],"","",false,true],
        ["Land_Laptop_unfolded_F",[0.383789,0.842773,1.61434],334.87,1,0,[],"","",true,true]
    ]
] call WHF_fnc_objectsMapper;
private _laptop = _intelBuilding # 7;
[_laptop] remoteExec ["WHF_fnc_msnDownloadIntelLaptop", 0, _laptop];

private _quantity = 10 + floor random (count allPlayers min 20);
private _group = [opfor, "raiders", _quantity, _intelCenter, 100, ["flashlights"]] call WHF_fnc_spawnUnits;
[_group, _intelCenter] call BIS_fnc_taskDefend;

private _vehicleCount = 1 + floor random 4;
private _vehicleGroup = [opfor, "raiders", _vehicleCount, _intelCenter, 100] call WHF_fnc_spawnVehicles;
private _vehicles = assignedVehicles _vehicleGroup;
[_vehicleGroup, _intelCenter] call BIS_fnc_taskDefend;
// TODO: alert nearby enemies when a player starts downloading the intel

private _taskID = [blufor, "", "downloadIntel", [_laptop,true], "CREATED", -1, true, "documents"] call WHF_fnc_taskCreate;

while {true} do {
    sleep 3;
    if (!alive _laptop) exitWith {[_taskID, "FAILED"] spawn WHF_fnc_taskEnd};
    if (_laptop getVariable ["downloadStarted", false] isEqualTo true) then {};
    if (_laptop getVariable ["downloadEnded", false] isEqualTo true) exitWith {
        [_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
    };
};

[_intelBuilding] call WHF_fnc_queueGCDeletion;
[_terrainObjects] call WHF_fnc_queueGCUnhide;
[units _group] call WHF_fnc_queueGCDeletion;
[units _vehicleGroup] call WHF_fnc_queueGCDeletion;
{[_x] call WHF_fnc_queueGCDeletion} forEach _vehicles;
