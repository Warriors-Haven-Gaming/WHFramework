/*
Function: WHF_fnc_haloJump

Description:
    Halo jumps the player at the given location.
    Function must be executed in scheduled environment.

Parameters:
    PositionATL position:
        The position to teleport the player to.
    Number direction:
        (Optional, default nil)
        The direction to face the player after being halo jumped.

Author:
    thegamecracks

*/
params ["_pos", ["_dir", nil]];;

_pos set [2, 1000];

disableUserInput true;
cutText ["", "BLACK", 2];
private _soundVolume = soundVolume;
2 fadeSound 0;
sleep 2;

playSoundUI ["surrender_fall"];
playSoundUI ["Planes_Passby", 0.2];
sleep (0.75 + random 0.5);

playSoundUI ["UAV_05_tailhook_up_sound"];

// TODO: add support for vehicles
// TODO: teleport AI recruits
player setUnitFreefallHeight 50;
player setPosATL _pos;
if (!isNil "_dir") then {player setDir _dir};

5 fadeSound _soundVolume;
sleep (2 + random 3);

cutText ["", "BLACK IN", 1];
disableUserInput false;
