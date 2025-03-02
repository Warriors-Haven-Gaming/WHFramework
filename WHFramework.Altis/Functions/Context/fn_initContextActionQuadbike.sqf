/*
Function: WHF_fnc_initContextActionQuadbike

Description:
    Add a context menu action to deploy a quadbike.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
[
    localize "$STR_WHF_context_action_quadbike",
    {
        private _pos = focusOn getPos [4, getDir focusOn] findEmptyPosition [0, 0, "B_Quadbike_01_F"];
        if (_pos isEqualTo []) exitWith {hint localize "$STR_WHF_context_action_quadbike_obstructed"};
        if (!isNil "WHF_quadbike" && {!isNull WHF_quadbike}) then {deleteVehicle WHF_quadbike};

        // FIXME: JIP players lose track of their last quadbike
        WHF_quadbike = createVehicle ["B_Quadbike_01_F", _pos, [], 0, "CAN_COLLIDE"];
        WHF_quadbike setDir (focusOn getDir _pos);
        WHF_quadbike engineOn true;
        WHF_quadbike setVariable ["WHF_vehicleLock_driver", ["uid", getPlayerUID focusOn], true];
        // playSound3D ["", WHF_quadbike];

        WHF_quadbike remoteExec ["WHF_fnc_queueGCDeletion", 2];
    },
    nil,
    "",
    "
    isNull objectParent _this
    && {isTouchingGround _this
    && {focusOn getVariable 'WHF_role' in ['medic', 'sniper']}}
        && {isNil 'WHF_quadbike' || {!alive WHF_quadbike}}"
] call WHF_fnc_contextMenuAdd;
