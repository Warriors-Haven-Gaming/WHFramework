/*
Function: WHF_fnc_randomTaskID

Description:
    Generates a random task ID not in use.
    Note that this can potentially return a duplicate string if
    multiple calls are made to this function without a task being
    created for each one. As such, running this in unscheduled environment
    alongside the task creation would be preferable.
    See also: WHF_fnc_taskCreate

Parameters:
    String prefix:
        (Optional, default "")
        A prefix to add in front of the random task ID.

Returns:
    String
        A unique task ID, or an empty string if unsuccessful.

Author:
    thegamecracks

*/
params [["_prefix", ""]];
private _taskID = "";
for "_i" from 1 to 100 do {
    // NOTE: as per documentation, string should be below 15 characters
    private _id = _prefix + ([6] call WHF_fnc_randomString);
    if !([_id] call BIS_fnc_taskExists) exitWith {_taskID = _id};
};
_taskID
