/*
Function: WHF_fnc_msnMainAnnexRegion

Description:
    Players must clear out enemies from a location.
    Function must be executed in scheduled environment.

Parameters:
    Location location:
        (Optional, default locationNull)
        If specified, the given location is used for the mission instead of
        attempting to find a suitable location.
    String faction:
        (Optional, default "")
        The faction to spawn units from.
        If empty, the current OPFOR faction in WHF_factions_current
        will be used.

Author:
    thegamecracks

*/
params [["_location", locationNull], ["_faction", ""]];

private _getRadius = {
    params ["_location"];

    private _playerCount = count allPlayers min 80;
    private _minRadius = 250 + _playerCount * 10;
    private _maxRadius = 500 + _playerCount * 15;

    private _radius = selectMax size _location * 2;
    _radius = _radius max _minRadius min _maxRadius;
    _radius = _radius * WHF_missions_annex_size;

    _radius
};

private _radius = [_location] call _getRadius;

if (_location isEqualTo locationNull) then {
    private _locations = nearestLocations [
        [worldSize / 2, worldSize / 2],
        WHF_missions_annex_location_types,
        sqrt 2 / 2 * worldSize
    ];
    if (WHF_missions_annex_location_named) then {
        _locations = _locations select {text _x isNotEqualTo ""};
    };
    _locations = _locations - ([_locations] call WHF_fnc_inAreaDeadzone);
    _locations = _locations call WHF_fnc_arrayShuffle;

    private _units = units blufor;
    {
        private _pos = locationPosition _x;
        _radius = [_x] call _getRadius;
        private _safeRadius = _radius + 500;

        if ([_pos, _safeRadius] call WHF_fnc_isNearRespawn) then {continue};

        private _area = [_pos, _safeRadius, _safeRadius];
        if ([_units, _area] call WHF_fnc_anyInArea) then {continue};

        _location = _x;
        break;
    } forEach _locations;
};
if (_location isEqualTo locationNull) exitWith {
    diag_log text format ["%1: No location found", _fnc_scriptName];
};

if (_faction isEqualTo "") then {_faction = WHF_factions_current get opfor};

private _center = locationPosition _location vectorMultiply [1, 1, 0];
_center = _center vectorAdd [50 - random 100, 50 - random 100];
private _area = [_center, _radius, _radius];

[_center, _radius, _faction] call WHF_fnc_msnMainAnnexRegionCompositions
    params ["_objects", "_terrain", "_compGroups"];

private _buildings = flatten _objects select {simulationEnabled _x};
[_center, _radius, _faction, _buildings] call WHF_fnc_msnMainAnnexRegionUnits
    params ["_groups", "_vehicles"];

// Note that unlike _compGroups, the above function will dynamically append
// newly created groups to its own array. We're using it as the canonical list
// of groups to ensure everyone gets garbage collected.
_groups append _compGroups;

private _initialUnitCount = count flatten (_groups apply {units _x});
private _reinforceArgs = [true, _center, _radius, _faction, _initialUnitCount, _groups, _vehicles];
private _reinforceScript = _reinforceArgs spawn WHF_fnc_msnMainAnnexRegionReinforcements;

private _areaMarker = [["WHF_msnMainAnnexRegion_"], _area, true] call WHF_fnc_createAreaMarker;
_areaMarker setMarkerBrushLocal "FDiagonal";
_areaMarker setMarkerColorLocal "ColorRed";
_areaMarker setMarkerAlpha 0.7;

private _name = if (text _location isNotEqualTo "") then {text _location} else {
    localize "$STR_WHF_mainAnnexRegion_region"
};
private _description = [
    ["STR_WHF_mainAnnexRegion_description", _areaMarker, _name],
    ["STR_WHF_mainAnnexRegion_title", _name]
];
private _taskID = [blufor, "", _description, _area # 0, "AUTOASSIGNED", -1, true, "attack"] call WHF_fnc_taskCreate;

private _sideChat = {
    params ["_message", ["_params", []]];
    [[blufor, "BLU"], _message, _params] remoteExec ["WHF_fnc_localizedSideChat", blufor];
};

["$STR_WHF_mainAnnexRegion_start", [_name]] call _sideChat;

private _subObjectiveArgs = [_center, _radius, _faction, _taskID, _objects, _terrain, _groups];
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
["$STR_WHF_mainAnnexRegion_success", [_name]] call _sideChat;

call WHF_fnc_cycleFaction;
call WHF_fnc_playMusicMissionEnd;

deleteMarker _areaMarker;

_reinforceArgs set [0, false];
waitUntil {sleep 1; scriptDone _reinforceScript};

// Because the reinforcement script needed to count the number of vehicles
// in the mission and append new vehicles to it, we've kept it separate
// from the objects array.
_objects append _vehicles;

{[_x] call WHF_fnc_queueGCDeletion} forEach _objects;
{[_x] call WHF_fnc_queueGCUnhide} forEach _terrain;
{[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
