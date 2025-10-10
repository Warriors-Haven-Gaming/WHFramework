/*
Function: WHF_fnc_forceRespawnVehicle

Description:
    Force respawn the given vehicle.
    Function must be executed on server.

Parameters:
    Array vehicle:
        The vehicle to force respawn.

Author:
    thegamecracks

*/
params ["_vehicle"];

if (!isServer) exitWith {};
if !([_vehicle] call WHF_fnc_canForceRespawnVehicle) exitWith {};

private _record = _vehicle getVariable "WHF_respawn_data";
deleteVehicle _vehicle;

if (!isNil "_record") then {
    _record set ["_respawnAt", time];
};
