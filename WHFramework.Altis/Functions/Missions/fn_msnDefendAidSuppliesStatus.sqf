/*
Function: WHF_fnc_msnDefendAidSuppliesStatus

Description:
    Create a status task keeping track of alive supplies.
    Returns when all supplies are stolen.
    Function must be ran in scheduled environment.

Parameters:
    Array signal:
        An array that should contain a single boolean.
        By setting this to false, the function can be safely terminated
        during execution. The status task will count as completed.
    Array supplies:
        The supplies being defended.
    String parent:
        The parent task ID.
    Number endAt:
        The time at which the mission is expected to end.
        This is only displayed to players and not used in flow control.

Author:
    thegamecracks

*/
params ["_signal", "_supplies", "_parent", "_endAt"];

private _initialSupplies = count _supplies;
private _threshold = ceil (_initialSupplies / 4);
private _aliveSupplies = {{alive _x} count _supplies};
if (call _aliveSupplies < _threshold) exitWith {};

private _getDescription = {
    private _duration = (_endAt - time) * timeMultiplier;
    private _dayTime = (dayTime + _duration / 3600) % 24;
    private _timeOfDay = [_dayTime, "HH:MM"] call BIS_fnc_timeToString;
    private _args = [call _aliveSupplies, _initialSupplies, _threshold, _timeOfDay];
    [
        ["STR_WHF_defendAidSupplies_status_description"] + _args,
        ["STR_WHF_defendAidSupplies_status_title"] + _args
    ]
};

private _taskDescription = call _getDescription;
private _taskID = [
    blufor,
    ["", _parent],
    _taskDescription,
    objNull,
    "CREATED",
    -1,
    true,
    "box"
] call WHF_fnc_taskCreate;

while {true} do {
    sleep 5;

    private _description = call _getDescription;
    if (_taskDescription isNotEqualTo _description) then {
        [_taskID, nil, _description] call BIS_fnc_setTask;
        _taskDescription = _description;
    };

    if !(_signal # 0) exitWith {
        [_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
    };

    if (call _aliveSupplies < _threshold) exitWith {
        [_taskID, "FAILED"] spawn WHF_fnc_taskEnd;
    };
};
