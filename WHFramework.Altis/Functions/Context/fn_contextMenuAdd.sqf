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
    Anything hideOnUse:
        (Optional, default true)
        If true, the player's actions are hidden after the action is used.
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
params [
    "_title",
    "_script",
    "_arguments",
    ["_hideOnUse", true],
    ["_condition", "true"],
    ["_unconscious", false]
];

if (isNil "WHF_contextMenu_entries") then {WHF_contextMenu_entries = []};

WHF_contextMenu_entries pushBack [
    _title,
    _script,
    if (!isNil "_arguments") then {_arguments} else {nil},
    _hideOnUse,
    _condition,
    _unconscious
];

if (!isNil "WHF_contextMenu_actionIDs") then {
    private _actionID = focusOn addAction [
        _title,
        _script,
        if (!isNil "_arguments") then {_arguments} else {nil},
        13,
        true,
        _hideOnUse,
        "",
        _condition,
        50,
        _unconscious
    ];
    WHF_contextMenu_actionIDs pushBack [focusOn, _actionID];
};
