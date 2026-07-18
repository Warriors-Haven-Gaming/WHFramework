/*
Function: WHF_fnc_initContextActionDetain

Description:
    Add a context menu action to detain a unit.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
[
    "WHF_context_action_detain",
    localize "$STR_WHF_context_action_detain",
    WHF_fnc_detainAction,
    nil,
    true,
    {[focusOn, cursorObject] call WHF_fnc_canDetainUnit},
    false,
    getText (configFile >> "CfgVehicles" >> "CAManBase" >> "ACE_Actions" >> "ACE_ApplyHandcuffs" >> "icon")
] call WHF_fnc_contextMenuAdd;
