/*
Function: WHF_fnc_initContextActionHaloJump

Description:
    Add a context menu action to halo jump.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
[
    localize "$STR_WHF_context_action_haloJump",
    {call WHF_fnc_haloJumpGUI},
    nil,
    "",
    "isNull objectParent _this && {isTouchingGround _this}
    || {!isNull objectParent _this && {isTouchingGround objectParent _this}}"
] call WHF_fnc_contextMenuAdd;
