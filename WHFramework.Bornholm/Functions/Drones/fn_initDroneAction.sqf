/*
Function: WHF_fnc_initDroneAction

Description:
    Add drone actions to the player.
    Function must be executed on client.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
if (!isNil "WHF_drones_actionIDs") then {{_x # 0 removeAction _x # 1} forEach WHF_drones_actionIDs};

private _fpvID = player addAction [
    localize "$STR_WHF_context_action_fpv",
    {
        params ["", "_caller"];
        [_caller] call WHF_fnc_assembleFPVDrone;
    },
    nil,
    2,
    true,
    true,
    "",
    "[_this] call WHF_fnc_canAssembleFPVDrone"
];

WHF_drones_actionIDs = [[player, _fpvID]];
