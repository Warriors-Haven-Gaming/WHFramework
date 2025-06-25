/*
Function: WHF_fnc_contextMenuShow

Description:
    Show the player's context menu.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
if (isNull focusOn) exitWith {};
if (!isNil "WHF_contextMenu_actionIDs") exitWith {};
WHF_contextMenu_actionIDs = [];
if (isNil "WHF_contextMenu_entries") exitWith {};
{
    _x params ["_title", "_script", "_arguments", "_hideOnUse", "_condition", "_unconscious"];
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
} forEach WHF_contextMenu_entries;
