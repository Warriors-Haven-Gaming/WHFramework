/*
Function: WHF_fnc_msnMainAnnexRegionThreshold

Description:
    Players must sufficiently reduce the number of enemies in the region.
    Function must be ran in scheduled environment.

Parameters:
    String parent:
        The parent task ID.
    Array area:
        The area of the mission in a format suitable for inAreaArray.
    Number initialUnitCount:
        The number of units that were initially spawned by the mission.

Author:
    thegamecracks

*/
params ["_parent", "_area", "_initialUnitCount"];

private _getThreshold = {floor (_initialUnitCount * WHF_missions_annex_threshold)};
private _getCurrent = {
    private _allThreats = units opfor + units independent;
    count (_allThreats inAreaArray _area)
};
private _current = call _getCurrent;
private _threshold = call _getThreshold;
if (_current <= _threshold) exitWith {};

private _getDescription = {[
    ["STR_WHF_mainAnnexRegionThreshold_description", _current - _threshold],
    ["STR_WHF_mainAnnexRegionThreshold_title", _current - _threshold]
]};

private _taskDescription = call _getDescription;
private _taskID = [
    blufor,
    ["", _parent],
    _taskDescription,
    objNull,
    "CREATED",
    -1,
    true,
    "rifle"
] call WHF_fnc_taskCreate;

while {true} do {
    sleep 10;

    _current = call _getCurrent;
    _threshold = call _getThreshold;

    if (_current <= _threshold) exitWith {
        [_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
    };

    private _description = call _getDescription;
    if (_taskDescription isNotEqualTo _description) then {
        [_taskID, nil, _description] call BIS_fnc_setTask;
        _taskDescription = _description;
    };
};
