/*
Function: WHF_fnc_initContextActionMagRepack

Description:
    Add a context menu action to repack magazines.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
[
    localize "$STR_WHF_context_action_magrepack",
    {[focusOn] spawn WHF_fnc_magRepack},
    nil,
    "",
    "[_this] call WHF_fnc_canMagRepack"
] call WHF_fnc_contextMenuAdd;
