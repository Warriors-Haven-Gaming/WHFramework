/*
Function: WHF_fnc_msnMainAnnexRegion

Description:
    Players must clear out enemies from a location.
    Function must be ran in scheduled environment.

Parameters:
    Location location:
        (Optional, default locationNull)
        If specified, the given location is used for the mission instead of
        attempting to find a suitable location.

Author:
    thegamecracks

*/
params [["_location", locationNull]];

if (_location isEqualTo locationNull) then {
    private _locations = nearestLocations [
        [worldSize / 2, worldSize / 2],
        ["Hill", "NameVillage", "NameCity", "NameCityCapital"],
        sqrt 2 / 2 * worldSize
    ];
    _locations = _locations call WHF_fnc_arrayShuffle;
    {
        if ([locationPosition _x, 1200] call WHF_fnc_isNearRespawn) then {continue};
        _location = _x;
        break;
    } forEach _locations;
};
if (_location isEqualTo locationNull) exitWith {
    diag_log text format ["%1: No location found", _fnc_scriptName];
};

private _center = locationPosition _location vectorMultiply [1, 1, 0];
_center = _center vectorAdd [50 - random 100, 50 - random 100];

private _minRadius = 250 + count allPlayers * 10 min 650;
private _maxRadius = 500 + count allPlayers * 15 min 1100;
private _radius = selectMax size _location * 2 max _minRadius min _maxRadius;
_radius = _radius * WHF_missions_annex_size;
private _area = [_center, _radius, _radius, 0, false];

[_center, _radius] call WHF_fnc_msnMainAnnexRegionCompositions
    params ["_objects", "_terrain", "_compGroups"];

private _buildings = flatten _objects select {simulationEnabled _x};
[_center, _radius, _buildings] call WHF_fnc_msnMainAnnexRegionUnits
    params ["_groups", "_vehicles"];

// Note that unlike _compGroups, the above function will dynamically append
// newly created groups to its own array. We're using it as the canonical list
// of groups to ensure everyone gets garbage collected.
_groups append _compGroups;

private _initialUnitCount = count flatten (_groups apply {units _x});
private _reinforceArgs = [true, _center, _radius, _initialUnitCount, _groups, _vehicles];
_reinforceArgs spawn WHF_fnc_msnMainAnnexRegionReinforcements;

private _areaMarker = [["WHF_mainMission"], _area, true] call WHF_fnc_createAreaMarker;
_areaMarker setMarkerBrushLocal "FDiagonal";
_areaMarker setMarkerColorLocal "ColorRed";
_areaMarker setMarkerAlpha 0.7;

private _name = if (text _location isNotEqualTo "") then {text _location} else {
    localize "$STR_WHF_mainAnnexRegion_region"
};
private _description = [
    ["STR_WHF_mainAnnexRegion_description", _name],
    ["STR_WHF_mainAnnexRegion_title", _name]
];
private _taskID = [blufor, "", _description, _area # 0, "AUTOASSIGNED", -1, true, "attack"] call WHF_fnc_taskCreate;

private _subObjectiveArgs = [_center, _radius, _taskID, _objects, _terrain, _groups];
private _subObjectives = [
    [_subObjectiveArgs, WHF_fnc_msnMainAnnexRegionCommand],
    [_subObjectiveArgs, WHF_fnc_msnMainAnnexRegionComms],
    [_subObjectiveArgs, WHF_fnc_msnMainAnnexRegionRepair]
];
_subObjectives = _subObjectives call WHF_fnc_arrayShuffle;
_subObjectives = _subObjectives select [0, 2];
_subObjectives = _subObjectives apply {_x # 0 spawn _x # 1};
waitUntil {sleep 3; _subObjectives findIf {!scriptDone _x} < 0};

sleep 3;
private _thresholdScript = [_taskID, _area, _initialUnitCount] spawn WHF_fnc_msnMainAnnexRegionThreshold;
waitUntil {sleep 3; scriptDone _thresholdScript};

[_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;

call WHF_fnc_cycleFaction;
call WHF_fnc_playMusicMissionEnd;

deleteMarker _areaMarker;
_reinforceArgs set [0, false];

// Because the reinforcement script needs to count the number of vehicles
// in the mission and append new vehicles to it, we've kept it separate
// the from objects array.
_objects append _vehicles;

{[_x] call WHF_fnc_queueGCDeletion} forEach _objects;
{[_x] call WHF_fnc_queueGCUnhide} forEach _terrain;
{[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
