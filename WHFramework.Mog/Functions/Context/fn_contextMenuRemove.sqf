/*
Function: WHF_fnc_contextMenuRemove

Description:
    Remove an action from the context menu.

Parameters:
    String key:
        The unique identifier of the action.

Author:
    thegamecracks

*/
params ["_key"];
if (!hasInterface) exitWith {};
if (isNil "WHF_contextMenu_entries") exitWith {};

WHF_contextMenu_entries deleteAt _key;

if (!isNil "WHF_contextMenu_actionIDs") then {
    WHF_contextMenu_actionIDs deleteAt _key params ["_unit", "_actionID"];
    _unit removeAction _actionID;
};

if (!isNil "WHF_contextMenu_ace_entries") then {
    WHF_contextMenu_ace_entries deleteAt _key;
    // FIXME: remove ACE interactions
};
