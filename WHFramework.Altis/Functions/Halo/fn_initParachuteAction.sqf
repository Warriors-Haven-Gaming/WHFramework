/*
Function: WHF_fnc_addParachuteAction

Description:
    Add a parachute action to the player.

Author:
    thegamecracks

*/
player removeAction (player getVariable ["WHF_parachute_actionID", -1]);
private _actionID = player addAction [
    localize "$STR_A3_action_deploy_parachute",
    {
        private _pos = getPosATL player vectorAdd [0, 0, 3];
        private _parachute = createVehicle ["Steerable_Parachute_F", _pos, [], 0, "CAN_COLLIDE"];
        _parachute setDir getDir player;
        _parachute setVelocity velocity player;
        player moveInDriver _parachute;
    },
    nil,
    6,
    true,
    true,
    "",
    "private _info = getUnitFreefallInfo _this; _info # 0 && {_info # 1}"
];
player setVariable ["WHF_parachute_actionID", _actionID];
