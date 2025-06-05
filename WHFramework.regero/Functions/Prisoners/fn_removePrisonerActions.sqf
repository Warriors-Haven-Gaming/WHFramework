/*
Function: WHF_fnc_removePrisonerActions

Description:
    Remove prisoner actions from a unit.

Parameters:
    Object unit:
        The unit to remove actions from.

Author:
    thegamecracks

*/
params ["_unit"];
private _actionIDs = _unit getVariable "WHF_prisoner_actionIDs";
if (isNil "_actionIDs") exitWith {};

{_unit removeAction _x} forEach _actionIDs;
_unit setVariable ["WHF_prisoner_actionIDs", nil];
