/*
Function: WHF_fnc_msnDownloadIntel

Description:
    Players must download intel from a research building.
    Function must be ran in scheduled environment.

Parameters:
    PositionATL center:
        (Optional, default [])
        If specified, the given position is used for the intel instead of
        attempting to find a suitable location.
    String faction:
        (Optional, default "")
        The faction to spawn units from.
        If not provided, a random faction is selected from WHF_factions_pool.

Author:
    thegamecracks

*/
params [["_center", []], ["_faction", ""]];

if (_center isEqualTo []) then {
    private _options = selectBestPlaces [[worldSize / 2, worldSize / 2], sqrt 2 / 2 * worldSize, "forest", 100, 50];
    {
        _x params ["_pos"];
        _pos pushBack 0;
        if ([_pos, 500] call WHF_fnc_isNearRespawn) then {continue};
        if (_pos isFlatEmpty [-1, -1, 0.45, 12] isEqualTo []) then {continue};
        if (_pos nearRoads 50 isNotEqualTo []) then {continue};
        if ([_pos, 100] call WHF_fnc_isNearUsedPosition) then {continue};
        _center = _pos;
        break;
    } forEach _options;
};
if (_center isEqualTo []) exitWith {
    diag_log text format ["%1: No center found", _fnc_scriptName];
};

if (_faction isEqualTo "") then {_faction = selectRandom WHF_factions_pool};
private _standard = ["standard", _faction];

private _terrain = nearestTerrainObjects [_center, [], 20, false, true];
_terrain apply {hideObjectGlobal _x};

private _intel = [
    [
        ["Land_Cargo_House_V4_F",[0.0126953,-0.00585938,0],0],
        ["MapBoard_Tanoa_F",[-0.496094,1.24414,0.592813],172.602],
        ["Land_BatteryPack_01_closed_olive_F",[-0.855469,2.28711,1.61578],30.2656],
        ["Land_PortableDesk_01_olive_F",[-1.28125,2.46289,0.728849],0],
        ["Land_Document_01_F",[-0.865234,2.66406,1.62502],194.368],
        ["Land_Laptop_unfolded_F",[-0.503906,2.69141,1.61578],334.87],
        ["Land_PCSet_Intel_01_F",[-1.20313,2.55273,1.62502],201.424],
        ["Land_OfficeChair_01_F",[-1.6875,3.28906,0.728849],0]
    ],
    _center,
    random 360,
    ["frozen", "normal"]
] call WHF_fnc_objectsMapper;
private _laptop = _intel # 5;
[_laptop] remoteExec ["WHF_fnc_msnDownloadIntelLaptop", 0, _laptop];

private _groups = [];
private _vehicles = [];

private _quantity = 10 + floor random (count allPlayers min 20);
private _group = [opfor, [_standard], _quantity, _center, 100] call WHF_fnc_spawnUnits;
_groups pushBack _group;
[_group, _center] call BIS_fnc_taskDefend;

private _vehicleCount = 1 + floor random 4;
private _vehicleGroup =
    [opfor, [_standard], [_standard], _vehicleCount, _center, 100]
    call WHF_fnc_spawnVehicles;
_groups pushBack _vehicleGroup;
_vehicles append assignedVehicles _vehicleGroup;
[_vehicleGroup, _center] call BIS_fnc_taskDefend;

private _taskID = [
    blufor,
    "",
    "downloadIntel",
    _center getPos [50 + random 100, random 360],
    "CREATED",
    -1,
    true,
    "documents"
] call WHF_fnc_taskCreate;

private _downloadStartedOnce = false;
while {true} do {
    sleep 3;
    if (!alive _laptop) exitWith {[_taskID, "FAILED"] spawn WHF_fnc_taskEnd};
    if (_laptop getVariable ["WHF_downloadStarted", false] isEqualTo true) then {
        if (!_downloadStartedOnce) then {
            _downloadStartedOnce = true;
            [_laptop, _faction, _groups, _vehicles] call WHF_fnc_msnDownloadIntelReinforcements;
        };
    };
    if (_laptop getVariable ["WHF_downloadEnded", false] isEqualTo true) exitWith {
        [_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
    };
};

[_intel] call WHF_fnc_queueGCDeletion;
[_terrain] call WHF_fnc_queueGCUnhide;
{[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
{[_x] call WHF_fnc_queueGCDeletion} forEach _vehicles;
