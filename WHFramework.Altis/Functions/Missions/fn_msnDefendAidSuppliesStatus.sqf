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

Author:
    thegamecracks

*/
params ["_signal", "_supplies", "_parent"];

private _initialSupplies = count _supplies;
private _aliveSupplies = {{alive _x} count _supplies};
if (call _aliveSupplies < 1) exitWith {};

private _getDescription = {[
    ["STR_WHF_defendAidSupplies_status_description", call _aliveSupplies, _initialSupplies],
    ["STR_WHF_defendAidSupplies_status_title", call _aliveSupplies, _initialSupplies]
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
    "box"
] call WHF_fnc_taskCreate;

while {true} do {
    sleep 5;

    if !(_signal # 0) exitWith {
        [_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
    };

    if (call _aliveSupplies < 1) exitWith {
        [_taskID, "FAILED"] spawn WHF_fnc_taskEnd;
    };

    private _description = call _getDescription;
    if (_taskDescription isNotEqualTo _description) then {
        [_taskID, nil, _description] call BIS_fnc_setTask;
        _taskDescription = _description;
    };
};
