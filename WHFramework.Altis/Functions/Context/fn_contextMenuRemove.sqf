/*
Function: WHF_fnc_contextMenuRemove

Description:
    Remove an action from the context menu.

Parameters:
    Array action:
        The original arguments passed to WHF_fnc_contextMenuAdd.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
if (isNil "WHF_contextMenu_entries") exitWith {};

private _index = WHF_contextMenu_entries find _this;
if (isNil "_index" || {_index < 0}) exitWith {};

WHF_contextMenu_entries deleteAt _index;

if (!isNil "WHF_contextMenu_actionIDs") then {
    WHF_contextMenu_actionIDs deleteAt _index params ["_unit", "_actionID"];
    _unit removeAction _actionID;
};
