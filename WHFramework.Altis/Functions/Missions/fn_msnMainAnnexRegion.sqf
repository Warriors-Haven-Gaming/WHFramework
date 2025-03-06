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
    _locations = _locations call BIS_fnc_arrayShuffle;
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

private _areaMarker = [["WHF_mainMission"], _area, true] call WHF_fnc_createAreaMarker;
_areaMarker setMarkerBrushLocal "FDiagonal";
_areaMarker setMarkerColorLocal "ColorRed";
_areaMarker setMarkerAlpha 0.7;

// FIXME: localize description on clients
private _description = getMissionConfig "CfgTaskDescriptions" >> "mainAnnexRegion";
_description = [_description >> "description", _description >> "title"];
_description = _description apply {format [localize getTextRaw _x, text _location]};
private _taskID = [blufor, "", _description, _area # 0, "AUTOASSIGNED", -1, true, "attack"] call WHF_fnc_taskCreate;

[_center, _radius] call WHF_fnc_msnMainAnnexRegionCompositions
    params ["_compositionObjects", "_compositionTerrain", "_compositionGroups"];

private _buildings = flatten _compositionObjects select {simulationEnabled _x};
[_center, _radius, _buildings] call WHF_fnc_msnMainAnnexRegionUnits
    params ["_groups", "_vehicles"];
private _initialUnitCount = count flatten (_groups apply {units _x});

while {true} do {
    sleep 10;

    private _allThreats = units opfor + units independent;
    private _threatsInRange = _allThreats inAreaArray _area;
    private _threshold = floor (_initialUnitCount * WHF_missions_annex_threshold);
    if (count _threatsInRange <= _threshold) exitWith {
        [_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
    };
};

call WHF_fnc_cycleFaction;

deleteMarker _areaMarker;

{[_x] call WHF_fnc_queueGCDeletion} forEach _compositionObjects;
{[_x] call WHF_fnc_queueGCUnhide} forEach _compositionTerrain;
{[units _x] call WHF_fnc_queueGCDeletion} forEach _compositionGroups;

{[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
{[_x] call WHF_fnc_queueGCDeletion} forEach _vehicles;
