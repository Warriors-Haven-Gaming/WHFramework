/*
Function: WHF_fnc_initRespawnSystem

Description:
    Set up the respawn system.
    Function must be executed in preinit environment
    to allow registering vehicles in object init fields.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};

WHF_respawn_delay = 15;
WHF_respawn_desertedDistance = 500;

WHF_respawn_records = [];
WHF_respawn_script = 0 spawn WHF_fnc_respawnLoop;

private _requestRespawn = {
    params ["_vehicle"];

    private _data = _vehicle getVariable "WHF_respawn_data";
    if (isNil "_data") exitWith {};
    if (_data get "_respawnAt" >= 0) exitWith {};

    _data set ["_respawnAt", time + WHF_respawn_delay];
};

addMissionEventHandler ["EntityDeleted", _requestRespawn];
addMissionEventHandler ["EntityKilled", _requestRespawn];
