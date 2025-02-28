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
    [
        ["Land_Research_house_V1_F",[0.0126953,-0.00585938,0],0],
        ["MapBoard_Tanoa_F",[-0.496094,1.24414,0.592813],172.602],
        ["Land_BatteryPack_01_closed_olive_F",[-0.855469,2.28711,1.61578],30.2656],
        ["Land_PortableDesk_01_olive_F",[-1.28125,2.46289,0.728849],0],
        ["Land_Document_01_F",[-0.865234,2.66406,1.62502],194.368],
        ["Land_Laptop_unfolded_F",[-0.503906,2.69141,1.61578],334.87],
        ["Land_PCSet_Intel_01_F",[-1.20313,2.55273,1.62502],201.424],
        ["Land_OfficeChair_01_F",[-1.6875,3.28906,0.728849],0]
    ],
    _intelCenter,
    _intelDir,
    ["frozen", "normal"]
] call WHF_fnc_objectsMapper;
private _laptop = _intelBuilding # 5;
[_laptop] remoteExec ["WHF_fnc_msnDownloadIntelLaptop", 0, _laptop];

private _quantity = 10 + floor random (count allPlayers min 20);
private _group = [opfor, "standard", _quantity, _intelCenter, 100, ["flashlights"]] call WHF_fnc_spawnUnits;
[_group, _intelCenter] call BIS_fnc_taskDefend;

private _vehicleCount = 1 + floor random 4;
private _vehicleGroup = [opfor, "standard", _vehicleCount, _intelCenter, 100] call WHF_fnc_spawnVehicles;
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
