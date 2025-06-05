/*
Function: WHF_fnc_initJTACTasks

Description:
    Add event handlers for cleaning up JTAC tasks.
    Function must be executed in preInit environment.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};

// Variable reference:
// - WHF_jtac_tasks:
//     A JIP'd object variable mapping sides to task IDs.
//     Used by server to remove tasks once the target is destroyed.
//     Also used by clients to know if a target has been reported.
// - WHF_jtac_parentTasks:
//     A server-only global variable mapping sides to parent task IDs.
//     Used for creating JTAC tasks for each side.
// - WHF_jtac_targets:
//     A server-only global variable mapping sides to target objects.
//     Used to find old targets that can be removed.

private _clearJTACTask = {
    params ["_target"];

    // Just in case WHF_jtac_tasks was removed externally,
    // we'll loop through all JTAC targets to ensure the object is removed.
    if (isNil "WHF_jtac_targets") then {WHF_jtac_targets = createHashMap};
    {
        private _side = _x;
        private _targets = WHF_jtac_targets get _side;
        _targets deleteAt (_targets find _target);
    } forEach keys WHF_jtac_targets;

    private _tasks = _target getVariable "WHF_jtac_tasks";
    if (isNil "_tasks") exitWith {};

    // Prevent double execution after killed + deleted events
    if (!isNil {_target getVariable "WHF_jtac_cleared"}) exitWith {};
    _target setVariable ["WHF_jtac_cleared", true];

    private _silent = _thisEvent isEqualTo "EntityDeleted";
    {
        private _side = _x;
        private _taskID = _tasks get _side;
        [_side, _taskID, _silent] spawn WHF_fnc_completeJTACTask;
    } forEach keys _tasks;
};

addMissionEventHandler ["EntityDeleted", _clearJTACTask];
addMissionEventHandler ["EntityKilled", _clearJTACTask];
