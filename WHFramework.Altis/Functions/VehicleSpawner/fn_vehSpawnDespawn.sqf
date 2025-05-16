/*
Function: WHF_fnc_vehSpawnDespawn

Description:
    Despawn a spawned vehicle.
    Function must be remote executed from server on the client
    where the vehicle is local.

Parameters:
    Object vehicle:
        The vehicle to despawn. Must be local to the client.
    Object owner:
        The player requesting the vehicle to be despawned.

Author:
    thegamecracks

*/
params ["_vehicle", "_owner"];
if (!isServer && {remoteExecutedOwner isNotEqualTo 2}) exitWith {};
if (!local _vehicle) exitWith {};

private _reason = ["$STR_WHF_vehSpawnDespawnMessage", name _owner];
{
    if (alive _x) then {moveOut _x} else {_vehicle deleteVehicleCrew _x};
    if (isPlayer _x) then {_reason remoteExec ["WHF_fnc_localizedHint", _x]};
} forEach crew _vehicle;

deleteVehicle _vehicle;
