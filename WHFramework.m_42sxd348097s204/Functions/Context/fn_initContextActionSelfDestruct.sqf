/*
Function: WHF_fnc_initContextActionSelfDestruct

Description:
    Add a context menu action to self-destruct a UAV.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
[
    "WHF_context_action_selfdestruct",
    localize "$STR_WHF_context_action_selfdestruct",
    {objectParent focusOn setDamage [1, false]},
    nil,
    true,
    {unitIsUAV focusOn && {!isNull objectParent focusOn && {local focusOn}}},
    false,
    getTextRaw (configFile >> "CfgVehicles" >> "CAManBase" >> "ACE_SelfActions" >> "ACE_Explosives" >> "icon")
] call WHF_fnc_contextMenuAdd;
