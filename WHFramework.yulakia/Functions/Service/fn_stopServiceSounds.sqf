/*
Function: WHF_fnc_stopServiceSounds

Description:
    Stops service sounds from being played, if any.

Author:
    thegamecracks

*/
if (isNil "WHF_serviceSoundScript") exitWith {};
terminate WHF_serviceSoundScript;
WHF_serviceSoundScript = nil;
