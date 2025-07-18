/*
Function: WHF_fnc_msnDestroyArtillery

Description:
    Players must destroy an artillery emplacement.
    Function must be executed in scheduled environment.

Parameters:
    PositionATL center:
        (Optional, default [])
        If specified, the given position is used for the AA battery instead of
        attempting to find a suitable location.
    String faction:
        (Optional, default "")
        The faction to spawn units from.
        If not provided, a random OPFOR faction is selected from WHF_factions_pool.

Author:
    thegamecracks

*/
params [["_center", []], ["_faction", ""]];

private _radius = 300;

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
private _ruins = [];

[opfor, [_standard], 2 + floor random 3, _center, _radius, ["arty",1], _ruins]
    call WHF_fnc_createEmplacements
    params ["_artyObjects", "_artyTerrain", "_artyGroups"];

sleep (1.5 + random 2.5);
private _artyTurrets = [];
private _allTurrets = [];
{
    private _comp = _x;
    private _turrets = _comp select {alive _x && {_x call WHF_fnc_isArtilleryVehicle}};
    if (count _turrets < 1) then {continue};
    {_comp deleteAt (_comp find _x)} forEach _turrets;
    _artyTurrets pushBack _turrets;
    _allTurrets append _turrets;
} forEach _artyObjects;

if (count _artyTurrets < 1) exitWith {
    diag_log text format ["%1: center %2 not clear to spawn artillery emplacements", _fnc_scriptName, _center];
    {[_x] call WHF_fnc_queueGCDeletion} forEach _artyObjects;
    {[_x] call WHF_fnc_queueGCDeletion} forEach _allTurrets;
    {[_x] call WHF_fnc_queueGCUnhide} forEach _artyTerrain;
    {[units _x] call WHF_fnc_queueGCDeletion} forEach _artyGroups;
};

private _groups = _artyTurrets apply {
    private _pos = getPosATL selectRandom _x;
    private _quantity = [8, 20] call WHF_fnc_scaleUnitsSide;
    private _group = [opfor, [_standard], _quantity, _pos, 50] call WHF_fnc_spawnUnits;
    [_group, _pos] call BIS_fnc_taskDefend;
    _group
};

private _vehicleTypes =
    ["standard", "supply", "mrap", "apc", "ifv", "aa"]
    apply {[_x, _faction]};
private _vehicleCount = [6, 12] call WHF_fnc_scaleUnitsSide;
private _vehicleGroup = [opfor, _vehicleTypes, [_standard], _vehicleCount, _center, _radius] call WHF_fnc_spawnVehicles;
private _vehicles = assignedVehicles _vehicleGroup;
[_vehicleGroup, _center] call BIS_fnc_taskDefend;

private _areaMarker = [["WHF_msnDestroyArtillery_"], _area, true] call WHF_fnc_createAreaMarker;
_areaMarker setMarkerBrushLocal "FDiagonal";
_areaMarker setMarkerColorLocal "ColorRed";
_areaMarker setMarkerAlpha 0.7;

private _taskID = [blufor, "", "destroyArtillery", _center, "CREATED", -1, true, "destroy"] call WHF_fnc_taskCreate;

while {true} do {
    sleep 10;

    private _active = _allTurrets select {canFire _x} inAreaArray _area;
    if (count _active < 1) exitWith {
        private _message = "$STR_WHF_destroyArtillery_success";
        [[blufor, "HQ"], _message] remoteExec ["WHF_fnc_localizedSideChat", blufor];
        [_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
    };
};

deleteMarker _areaMarker;
[_ruins] call WHF_fnc_queueGCDeletion;
{[_x] call WHF_fnc_queueGCDeletion} forEach _artyObjects;
{[_x] call WHF_fnc_queueGCDeletion} forEach _allTurrets;
{[_x] call WHF_fnc_queueGCUnhide} forEach _artyTerrain;
{[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
{[units _x] call WHF_fnc_queueGCDeletion} forEach _artyGroups;
[units _vehicleGroup] call WHF_fnc_queueGCDeletion;
{[_x] call WHF_fnc_queueGCDeletion} forEach _vehicles;
