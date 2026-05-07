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
                isTouchingGround cameraOn
                || {private _z = getPos cameraOn # 2; _z <= 0 && {_z > -3}}
            )
            && {!(cameraOn isKindOf "Air" || {cameraOn isKindOf "StaticWeapon"})}
        }
    },
    false,
    "\a3\ui_f\data\map\vehicleicons\iconParachute_ca.paa"
] call WHF_fnc_contextMenuAdd;
