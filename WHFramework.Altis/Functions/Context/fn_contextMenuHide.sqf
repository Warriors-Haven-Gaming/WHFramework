/*
Function: WHF_fnc_contextMenuHide

Description:
    Hide the player's context menu.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
if (isNil "WHF_contextMenu_actionIDs") exitWith {};
{
    _y params ["_unit", "_actionID"];
    _unit removeAction _actionID;
} forEach WHF_contextMenu_actionIDs;
WHF_contextMenu_actionIDs = nil;
