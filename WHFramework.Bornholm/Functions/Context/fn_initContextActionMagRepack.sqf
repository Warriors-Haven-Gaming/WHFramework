/*
Function: WHF_fnc_initContextActionMagRepack

Description:
    Add a context menu action to repack magazines.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
if (isClass (configFile >> "CfgPatches" >> "ace_magazinerepack")) exitWith {false};
if (isClass (configFile >> "CfgPatches" >> "outlw_magRepack")) exitWith {false};
[
    "WHF_context_action_magrepack",
    localize "$STR_WHF_context_action_magrepack",
    {[focusOn] spawn WHF_fnc_magRepack},
    nil,
    true,
    {[focusOn] call WHF_fnc_canMagRepack},
    false,
    "\z\ace\addons\common\UI\repack_ca.paa"
] call WHF_fnc_contextMenuAdd;
