/*
Function: WHF_fnc_reportJTACTarget

Description:
    Report the given target for the JTAC's side.
    Function must be remote executed on server from a client.

Parameters:
    Object unit:
        The unit reporting the target.
        Must be owned by the client remote executing this function.
    Object target:
        The target to be reported.

Author:
    thegamecracks

*/
params ["_player", "_target"];
if (!isServer) exitWith {};
if (!isPlayer _player) exitWith {};
if (isMultiplayer && {!isRemoteExecuted}) exitWith {};
if (owner _player isNotEqualTo remoteExecutedOwner) exitWith {};
if !([_player, _target] call WHF_fnc_canReportJTACTarget) exitWith {};

private _tasks = _target getVariable "WHF_jtac_tasks";
if (isNil "_tasks") then {_tasks = createHashMap};

private _side = side group _player;
if (_side in _tasks) exitWith {};

if (isNil "WHF_jtac_parentTasks") then {WHF_jtac_parentTasks = createHashMap};
private _parentID = WHF_jtac_parentTasks get _side;
if (isNil "_parentID") then {isNil {
    _parentID = [_side, "", "jtacParent", objNull, "CREATED", -1, false, "attack"] call WHF_fnc_taskCreate;
    WHF_jtac_parentTasks set [_side, _parentID];
}};

// FIXME: maybe make this JIP-compatible?
[_target, [_side, true]] remoteExec ["confirmSensorTarget", _target];
[_side, [_target, 3600]] remoteExec ["reportRemoteTarget", _target];
[_player, _target] remoteExec ["WHF_fnc_showJTACTarget", _side];

// FIXME: localize display names on client (requires custom Task Framework)
private _targetName = [configOf _target] call BIS_fnc_displayName;
private _taskID = [
    _side,
    ["", _parentID],
    [
        ["STR_WHF_jtacTarget_description", _targetName, name _player],
        ["STR_WHF_jtacTarget_title", _targetName, name _player]
    ],
    [_target, true],
    "CREATED",
    -1,
    true,
    "target"
] call WHF_fnc_taskCreate;

_tasks set [_side, _taskID];
_target setVariable ["WHF_jtac_tasks", _tasks, true];

if (isNil "WHF_jtac_targets") then {WHF_jtac_targets = createHashMap};
private _targets = WHF_jtac_targets getOrDefault [_side, [], true];
_targets pushBackUnique _target;
if (count _targets > WHF_jtac_tasks_max) then {
    [_side, _targets # 0, true] call WHF_fnc_completeJTACTask;
};
