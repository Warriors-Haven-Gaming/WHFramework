/*
Function: WHF_fnc_headshotEffects

Description:
    Trigger effects as a result of being incapacitated by a headshot.
    Function must be executed in scheduled environment.

Author:
    thegamecracks

*/
// TODO: native sound effects
private _sounds = [
    "\SFX_ProjectR\SFX\Death\headshot_nohelm_1.wav",
    "\SFX_ProjectR\SFX\Death\headshot_nohelm_2.wav",
    "\SFX_ProjectR\SFX\Death\headshot_nohelm_3.wav"
] select {fileExists _x};
if (_sounds isNotEqualTo []) then {playSoundUI [selectRandom _sounds, 1, 1, true]};

private _blur = ppEffectCreate ["DynamicBlur", 474];
_blur ppEffectEnable true;
_blur ppEffectAdjust [10];
_blur ppEffectCommit random 0.25;
waitUntil {ppEffectCommitted _blur};
_blur ppEffectAdjust [0];
_blur ppEffectCommit (1 + random 1.5);
waitUntil {ppEffectCommitted _blur};
ppEffectDestroy _blur;
