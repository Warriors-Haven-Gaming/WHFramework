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
    true,
    "",
    "
    count allPlayers <= WHF_halo_limit_player
    && {isTouchingGround vehicle _this
    && {!(objectParent _this isKindOf 'Air')}}
    "
] call WHF_fnc_contextMenuAdd;
