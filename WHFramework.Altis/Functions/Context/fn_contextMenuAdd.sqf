/*
Function: WHF_fnc_contextMenuAdd

Description:
    Add an action to the context menu.

Parameters:
    String title:
        The title of the action.
    Code | String script:
        The script to run when the action is selected.
        The same arguments in addAction will be passed here.
    Anything arguments:
        (Optional, default nil)
        Arguments to pass to the script.
    String shortcut:
        (Optional, default "")
        An optional shortcut key defined in
        https://community.bistudio.com/wiki/inputAction/actions.
    String condition:
        (Optional, default "true")
        The condition needed for the action to be shown.
        The same variables in addAction will be defined here.
    Boolean unconscious:
        (Optional, default false)
        If true, the action will show up while incapacitated.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
params ["_title", "_script", "_arguments", ["_shortcut", ""], ["_condition", "true"], ["_unconscious", false]];
if (isNil "WHF_contextMenu_entries") then {WHF_contextMenu_entries = []};

WHF_contextMenu_entries pushBack [
    _title,
    _script,
    if (!isNil "_arguments") then {_arguments} else {nil},
    _shortcut,
    _condition,
    _unconscious
];

if (!isNil "WHF_contextMenu_actionIDs") then {
    private _actionID = player addAction [
        _title,
        _script,
        if (!isNil "_arguments") then {_arguments} else {nil},
        6,
        true,
        true,
        _shortcut,
        _condition,
        50,
        _unconscious
    ];
    WHF_contextMenu_actionIDs pushBack [player, _actionID];
};
