/*
Function: WHF_fnc_vehSpawnDespawnMessage

Description:
    Show that a vehicle was despawned by another player.
    Function must be remote executed on client from the server.

Parameters:
    Object owner:
        The player that despawned the vehicle.

Author:
    thegamecracks

*/
params ["_owner"];
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
hint format [localize "$STR_WHF_vehSpawnDespawnMessage", name _owner];
