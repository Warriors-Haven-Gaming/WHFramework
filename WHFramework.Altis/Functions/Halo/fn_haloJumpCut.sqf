/*
Function: WHF_fnc_haloJumpCutIn

Description:
    Start the halo jump cutscene.
    Function must be executed in scheduled environment.

Parameters:
    Number seed:
        The seed to use for random variations in cutscene length.

Author:
    thegamecracks

*/
params ["_seed"];

cutText ["", "BLACK", 2];
WHF_haloJump_soundVolume = soundVolume;
2 fadeSound 0;
sleep 2;

playSoundUI ["surrender_fall"];
playSoundUI ["Planes_Passby", 0.2];

sleep (0.75 + (_seed random 0.5));

playSoundUI ["UAV_05_tailhook_up_sound"];

5 fadeSound WHF_haloJump_soundVolume;
sleep (2 + (_seed + 1 random 3));

cutText ["", "BLACK IN", 1];
