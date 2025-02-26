/*
Function: WHF_fnc_showSkipTimeCompleted

Description:
    Show the completion of a time skip.
    Function must be remote executed on client from the server.

Parameters:
    Side side:
        The side of the player that requested the time skip.
    String timeOfDay:
        The time of day that was skipped to.
        Must be one of "morning", "noon", or "evening".

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
params ["_side", "_timeOfDay"];
if !(_timeOfDay in ["morning", "noon", "evening"]) exitWith {};

private _key = format ["$STR_WHF_showSkipTimeCompleted_%1", _timeOfDay];
[_side, "HQ"] sideChat localize _key;
