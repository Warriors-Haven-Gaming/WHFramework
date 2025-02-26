/*
Function: WHF_fnc_initContextActionHaloJump

Description:
    Add a context menu action to halo jump.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
[
    localize "$STR_WHF_initContextActionHaloJump",
    {call WHF_fnc_haloJumpGUI}
] call WHF_fnc_contextMenuAdd;
