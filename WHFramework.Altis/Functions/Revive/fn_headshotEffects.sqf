/*
Function: WHF_fnc_headshotEffects

Description:
    Trigger effects as a result of being incapacitated by a headshot.
    Function must be ran in scheduled environment.

Author:
    thegamecracks

*/
private _sound = selectRandom ["headshot_noHelm_1", "headshot_noHelm_2"];
playSoundUI [_sound, 1, 1, true];

private _blur = ppEffectCreate ["DynamicBlur", 474];
_blur ppEffectEnable true;
_blur ppEffectAdjust [10];
_blur ppEffectCommit random 0.25;
waitUntil {ppEffectCommitted _blur};
_blur ppEffectAdjust [0];
_blur ppEffectCommit (1 + random 1.5);
waitUntil {ppEffectCommitted _blur};
ppEffectDestroy _blur;
