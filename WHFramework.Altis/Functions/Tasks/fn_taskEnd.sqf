/*
Function: WHF_fnc_taskEnd

Description:
    A simple proxy for BIS_fnc_taskSetState except that after 30 seconds,
    the task is deleted from all playable units and JIP queue.
    This function will sleep until the task is deleted so running in
    scheduled environment is required.
    See also: https://community.bistudio.com/wiki/BIS_fnc_taskSetState

Returns:
    String

Examples:
    (begin example)
        ["myTaskID", "SUCCEEDED", true] spawn WHF_fnc_taskEnd;
    (end)

Author:
    thegamecracks

*/
params ["_taskID"];
_this call BIS_fnc_taskSetState;
sleep 30;
[_taskID, true, true] call BIS_fnc_deleteTask;
