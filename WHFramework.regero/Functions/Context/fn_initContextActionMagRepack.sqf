/*
Function: WHF_fnc_initContextActionMagRepack

Description:
    Add a context menu action to repack magazines.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
if (isClass (configFile >> "CfgPatches" >> "ace_magazinerepack")) exitWith {false};
[
    localize "$STR_WHF_context_action_magrepack",
    {[focusOn] spawn WHF_fnc_magRepack},
    nil,
    true,
    "",
    "[_this] call WHF_fnc_canMagRepack"
] call WHF_fnc_contextMenuAdd;
