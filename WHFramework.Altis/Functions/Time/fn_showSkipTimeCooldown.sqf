/*
Function: WHF_fnc_showSkipTimeCooldown

Description:
    Show the current cooldown for the skip time action.
    Function must be remote executed on client from the server.

Parameters:
    Number cooldown:
        The time remaining in seconds.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
params ["_cooldown"];
hint format [
    localize "$STR_WHF_showSkipTimeCooldown",
    [_cooldown, "HH:MM:SS"] call BIS_fnc_secondsToString
];
