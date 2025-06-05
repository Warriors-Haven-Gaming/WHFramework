/*
Function: WHF_fnc_initParachuteAction

Description:
    Add a parachute action to the player.

Author:
    thegamecracks

*/
player removeAction (player getVariable ["WHF_parachute_actionID", -1]);
private _actionID = player addAction [
    localize "$STR_A3_action_deploy_parachute",
    {[player] call WHF_fnc_deployParachute},
    nil,
    12,
    true,
    true,
    "",
    "private _info = getUnitFreefallInfo _this; _info # 0 && {_info # 1}"
];
player setVariable ["WHF_parachute_actionID", _actionID];
