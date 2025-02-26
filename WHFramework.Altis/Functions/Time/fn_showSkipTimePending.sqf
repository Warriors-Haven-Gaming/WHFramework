/*
Function: WHF_fnc_showSkipTimePending

Description:
    Show that a time skip is already in progress.
    Function must be remote executed on client from the server.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
hint localize "$STR_WHF_showSkipTimePending";
