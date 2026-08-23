/*
Function: WHF_fnc_vehSpawnDespawn

Description:
    Despawn one or more spawned vehicles.
    Function must be remote executed from server on the client
    where any of the vehicles are local.

Parameters:
    Array | Object vehicles:
        The vehicles to despawn. Only local vehicles will be removed.
    Object owner:
        The player requesting the vehicle to be despawned.

Author:
    thegamecracks

*/
params ["_vehicles", "_owner"];
if (!isServer && {remoteExecutedOwner isNotEqualTo 2}) exitWith {};
if !(_vehicles isEqualType []) then {_vehicles = [_vehicles]};

_vehicles = _vehicles select {local _x};
_vehicles = _vehicles arrayIntersect _vehicles;
private _reason = ["$STR_WHF_vehSpawnDespawnMessage", name _owner];

{
    private _vehicle = _x;
    private _players = crew _vehicle select {alive _x && {isPlayer _x}};
    _reason remoteExec ["WHF_fnc_localizedHint", _players];
    deleteVehicle _vehicle;
} forEach _vehicles;
