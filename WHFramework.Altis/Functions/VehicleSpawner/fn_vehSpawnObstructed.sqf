/*
Function: WHF_fnc_vehSpawnObstructed

Description:
    Show that the vehicle spawner is obstructed.
    Function must be remote executed on client from the server.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
50 cutText [localize "$STR_WHF_vehSpawnRequestObstructed", "PLAIN"];
