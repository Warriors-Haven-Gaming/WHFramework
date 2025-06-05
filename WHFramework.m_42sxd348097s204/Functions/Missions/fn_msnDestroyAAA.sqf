/*
Function: WHF_fnc_msnDestroyAAA

Description:
    Players must destroy an AAA emplacement.
    Function must be ran in scheduled environment.

Parameters:
    PositionATL center:
        (Optional, default [])
        If specified, the given position is used for the AA battery instead of
        attempting to find a suitable location.
    String faction:
        (Optional, default "")
        The faction to spawn units from.
        If not provided, a random faction is selected from WHF_factions_pool.

Author:
    thegamecracks

*/
params [["_center", []], ["_faction", ""]];

private _radius = 300;

if (_center isEqualTo []) then {
    private _options = ["meadow - forest - sea - trees"] call WHF_fnc_selectBestPlaces;
    {
        _x params ["_pos"];
        _pos pushBack 0;
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

if (_faction isEqualTo "") then {_faction = selectRandom WHF_factions_pool};
private _standard = ["standard", _faction];
private _supply = ["supply", _faction];

private _area = [_center, _radius, _radius, 0, false];
private _ruins = [];

private _aaTypes = WHF_missions_aaa_types;
[opfor, [_standard], 2 + floor random 3, _center, _radius, _aaTypes, _ruins]
    call WHF_fnc_createEmplacements
    params ["_aaObjects", "_aaTerrain", "_aaGroups"];

sleep (1.5 + random 2.5);
private _aaTurrets = [];
private _allTurrets = [];
{
    private _comp = _x;
    private _turrets = _comp select {alive _x && {_x call WHF_fnc_isAntiAirVehicle}};
    if (count _turrets < 1) then {continue};
    {_comp deleteAt (_comp find _x)} forEach _turrets;
    _aaTurrets pushBack _turrets;
    _allTurrets append _turrets;
} forEach _aaObjects;

if (count _aaTurrets < 1) exitWith {
    diag_log text format ["%1: center %2 not clear to spawn AA emplacements", _fnc_scriptName, _center];
    {[_x] call WHF_fnc_queueGCDeletion} forEach _aaObjects;
    {[_x] call WHF_fnc_queueGCDeletion} forEach _allTurrets;
    {[_x] call WHF_fnc_queueGCUnhide} forEach _aaTerrain;
    {[units _x] call WHF_fnc_queueGCDeletion} forEach _aaGroups;
};

private _groups = _aaTurrets apply {
    private _pos = getPosATL selectRandom _x;
    private _group = [opfor, [_standard], 8 + floor random 13, _pos, 50] call WHF_fnc_spawnUnits;
    [_group, _pos] call BIS_fnc_taskDefend;
    _group
};

private _vehicleCount = 6 + floor random 7;
private _vehicleGroup =
    [opfor, [_standard, _supply], [_standard], _vehicleCount, _center, _radius]
    call WHF_fnc_spawnVehicles;
private _vehicles = assignedVehicles _vehicleGroup;
[_vehicleGroup, _center] call BIS_fnc_taskDefend;

private _areaMarker = [["WHF_msnDestroyAAA_"], _area, true] call WHF_fnc_createAreaMarker;
_areaMarker setMarkerBrushLocal "FDiagonal";
_areaMarker setMarkerColorLocal "ColorRed";
_areaMarker setMarkerAlpha 0.7;

private _taskID = [blufor, "", "destroyAAA", _center, "CREATED", -1, true, "destroy"] call WHF_fnc_taskCreate;
private _childTaskIDs = _aaTurrets apply {
    [blufor, ["", _taskID], "destroyAAAEmplacement", objNull, "CREATED", -1, false, "destroy"] call WHF_fnc_taskCreate;
};
private _completedChildTaskIDs = [];

while {true} do {
    sleep 10;

    {
        private _childTaskID = _childTaskIDs # _forEachIndex;
        if (_childTaskID in _completedChildTaskIDs) then {continue};

        private _active = _x select {alive _x} inAreaArray _area;
        if (count _active > 0) then {continue};

        [_childTaskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
        _completedChildTaskIDs pushBack _childTaskID;
    } forEach _aaTurrets;

    if (count _completedChildTaskIDs isEqualTo count _childTaskIDs) exitWith {
        [_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
    };
};

deleteMarker _areaMarker;
[_ruins] call WHF_fnc_queueGCDeletion;
{[_x] call WHF_fnc_queueGCDeletion} forEach _aaObjects;
{[_x] call WHF_fnc_queueGCDeletion} forEach _allTurrets;
{[_x] call WHF_fnc_queueGCUnhide} forEach _aaTerrain;
{[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
{[units _x] call WHF_fnc_queueGCDeletion} forEach _aaGroups;
[units _vehicleGroup] call WHF_fnc_queueGCDeletion;
{[_x] call WHF_fnc_queueGCDeletion} forEach _vehicles;
