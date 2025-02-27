/*
Function: WHF_fnc_contextMenuShow

Description:
    Show the player's context menu.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
if (isNull player) exitWith {};
if (!isNil "WHF_contextMenu_actionIDs") exitWith {};
WHF_contextMenu_actionIDs = [];
if (isNil "WHF_contextMenu_entries") exitWith {};
{
    _x params ["_title", "_script", "_arguments", "_shortcut", "_condition", "_unconscious"];
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
} forEach WHF_contextMenu_entries;
