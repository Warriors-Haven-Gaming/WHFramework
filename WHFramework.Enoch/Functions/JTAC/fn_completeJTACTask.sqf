/*
Function: WHF_fnc_completeJTACTask

Description:
    Complete a side's task associated with the given JTAC target.
    Function must be executed on server in scheduled environment.

Parameters:
    Side side:
        The side of the JTAC target.
    Object | String target:
        The target object or task ID to be cleared.

        If an object is passed, the task ID stored on that object will be
        removed and broadcasted, allowing clients to report the target again.

        If a task ID is passed, the task is simply cleared without removing
        the task ID from the associated target. This prevents clients from
        reporting the target again. As such, this should only be used if
        the target object was deleted.
    Boolean silent:
        (Optional, default false)
        If true, the task will be immediately deleted without a notification.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
params ["_side", "_target", ["_silent", false]];

// Make sure we have a valid task ID to work with.
private _taskID = "";
if (_target isEqualType "") then {_taskID = _target} else {
    private _tasks = _target getVariable "WHF_jtac_tasks";
    if (!isNil "_tasks") then {_taskID = _tasks get _side};
};
if (isNil "_taskID" || {_taskID isEqualTo ""}) exitWith {};

// Just before we remove the task, remove references to the target and task ID.
// For alive targets, this allows clients to immediately report it again.
if (_target isEqualType objNull) then {
    private _tasks = _target getVariable "WHF_jtac_tasks";
    _tasks deleteAt _side;
    _target setVariable ["WHF_jtac_tasks", _tasks, true];

    if (isNil "WHF_jtac_targets") then {WHF_jtac_targets = createHashMap};
    private _targets = WHF_jtac_targets get _side;
    if (!isNil "_targets") then {_targets deleteAt (_targets find _target)};
};

if (_silent) then {
    [_taskID, _side, true] call BIS_fnc_deleteTask;
} else {
    // NOTE: this can sleep alongside other deletions.
    // NOTE: this function passes "true" as the owner to BIS_fnc_deleteTask,
    //       which is technically not the same as above deletion.
    [_taskID, "SUCCEEDED"] call WHF_fnc_taskEnd;
};

if (!isNil "WHF_jtac_parentTasks") then {
    // Don't ask me why, but BIS_fnc_taskExists might incorrectly return true
    // on a just-deleted task in multiplayer.
    if (isMultiplayer) then {sleep 0.5};

    isNil {
        // If all child tasks are deleted, we can delete the parent task.
        private _parentID = WHF_jtac_parentTasks get _side;
        if (isNil "_parentID") exitWith {};

        private _childIDs = _parentID call BIS_fnc_taskChildren;
        if (_childIDs isEqualTo objNull) exitWith {};

        // Annoyingly, BIS_fnc_taskChildren can return task IDs that were deleted...
        if ({[_x] call BIS_fnc_taskExists} count _childIDs > 0) exitWith {};

        [_parentID, _side, true] call BIS_fnc_deleteTask;
        WHF_jtac_parentTasks deleteAt _side;
    };
};
