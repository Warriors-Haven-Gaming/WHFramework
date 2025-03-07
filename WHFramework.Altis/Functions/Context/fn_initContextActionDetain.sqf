/*
Function: WHF_fnc_initContextActionDetain

Description:
    Add a context menu action to detain a unit.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
[
    localize "$STR_WHF_context_action_detain",
    WHF_fnc_detainAction,
    nil,
    "",
    "[focusOn, cursorObject] call WHF_fnc_canDetainUnit"
] call WHF_fnc_contextMenuAdd;
