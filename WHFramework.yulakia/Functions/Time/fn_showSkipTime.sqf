/*
Function: WHF_fnc_showSkipTime

Description:
    Show a time skip in progress.
    Function must be remote executed on client from the server.

Parameters:
    Object player:
        The player that requested the time skip.
    String timeOfDay:
        The time of day being skipped to.
        Must be one of "morning", "noon", or "evening".
    Number duration:
        The expected duration of the time skip.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
params ["_player", "_timeOfDay", "_duration"];
if !(_timeOfDay in ["morning", "noon", "evening"]) exitWith {};

private _key = format ["$STR_WHF_showSkipTime_%1", _timeOfDay];
[side group _player, "BLU"] sideChat format [
    localize _key,
    name _player,
    [_duration, "HH:MM:SS"] call BIS_fnc_secondsToString
];
