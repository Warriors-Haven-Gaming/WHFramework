/*
Function: WHF_fnc_contextMenuAdd

Description:
    Add an action to the context menu.

Parameters:
    String key:
        A unique identifier for the action.
    String title:
        The title of the action.
    Code script:
        The script to run when the action is selected.
        The same arguments in addAction will be passed here.
    Anything arguments:
        (Optional, default nil)
        Arguments to pass to the script.
    Anything hideOnUse:
        (Optional, default true)
        If true, the player's actions are hidden after the action is used.
    Code condition:
        (Optional, default {true})
        The condition needed for the action to be shown.
        This code will called with the following array of arguments:
            Object target:
                The target that has the attached action.
            Object caller:
                The unit to whom the action will be shown to.
    Boolean unconscious:
        (Optional, default false)
        If true, the action will show up while incapacitated.
    String icon:
        (Optional, default "")
        The icon to show in ACE interactions.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
params [
    "_key",
    "_title",
    "_script",
    "_arguments",
    ["_hideOnUse", true],
    ["_condition", {true}],
    ["_unconscious", false],
    ["_icon", ""]
];

if (isNil "WHF_contextMenu_entries") then {WHF_contextMenu_entries = createHashMap};

[_key] call WHF_fnc_contextMenuRemove;
WHF_contextMenu_entries set [
    _key,
    [
        _title,
        _script,
        if (!isNil "_arguments") then {_arguments} else {nil},
        _hideOnUse,
        _condition,
        _unconscious
    ]
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
        "_this = [_originalTarget, _this]; " + toString _condition,
        50,
        _unconscious
    ];
    WHF_contextMenu_actionIDs set [_key, [focusOn, _actionID]];
};

if (isClass (configFile >> "CfgPatches" >> "ace_interact_menu")) then {
    if (isNil "WHF_contextMenu_ace_entries") then {WHF_contextMenu_ace_entries = createHashMap};

    private _action = [
        _key,
        _title,
        _icon,
        _script,
        _condition,
        {},
        if (!isNil "_arguments") then {_arguments} else {nil}
    ] call ace_interact_menu_fnc_createAction;

    [focusOn, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

    WHF_contextMenu_ace_entries set [_key, _action];
};
