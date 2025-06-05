/*
Function: WHF_fnc_vehSpawnCooldownSet

Description:
    Set the vehicle spawner cooldown for a player.
    Must be called on server.

Parameters:
    Object | String uid:
        The player to set the cooldown for.
    Number cooldown:
        The cooldown duration in seconds.

Author:
    thegamecracks

*/
params ["_uid", "_cooldown"];
if (!isServer) exitWith {};
if (_uid isEqualType objNull) then {_uid = getPlayerUID _uid};
if (_uid isEqualTo "") exitWith {};

if (isNil "WHF_vehSpawn_cooldowns") then {WHF_vehSpawn_cooldowns = createHashMap};
WHF_vehSpawn_cooldowns set [_uid, serverTime + _cooldown];
