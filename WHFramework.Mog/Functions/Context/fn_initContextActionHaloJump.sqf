/*
Function: WHF_fnc_initContextActionHaloJump

Description:
    Add a context menu action to halo jump.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
[
    "WHF_context_action_haloJump",
    localize "$STR_WHF_context_action_haloJump",
    {call WHF_fnc_haloJumpGUI},
    nil,
    true,
    {
        count allPlayers <= WHF_halo_limit_player
        && {
            (
                isTouchingGround vehicle focusOn
                || {private _z = getPos vehicle focusOn # 2; _z <= 0 && {_z > -3}}
            )
            && {!(objectParent focusOn isKindOf "Air")}
        }
    },
    false,
    "\a3\ui_f\data\map\vehicleicons\iconParachute_ca.paa"
] call WHF_fnc_contextMenuAdd;
