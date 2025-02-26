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
        private _moveIntoParachute = {
            params ["_unit"];
            private _pos = getPosATL _unit vectorAdd [0, 0, 3];
            private _parachute = createVehicle ["Steerable_Parachute_F", _pos, [], 0, "CAN_COLLIDE"];
            _parachute setDir getDir _unit;
            _parachute setVelocity velocity _unit;
            _unit moveInDriver _parachute;
        };

        player call _moveIntoParachute;
        private _recruits = units player select {
            isNull objectParent _x && {!isPlayer _x && {
                private _info = getUnitFreefallInfo _x;
                _info # 0 && _info # 1
            }}
        };
        {sleep random 0.5; _x call _moveIntoParachute} forEach _recruits;
    },
    nil,
    6,
    true,
    true,
    "",
    "private _info = getUnitFreefallInfo _this; _info # 0 && {_info # 1}"
];
player setVariable ["WHF_parachute_actionID", _actionID];
