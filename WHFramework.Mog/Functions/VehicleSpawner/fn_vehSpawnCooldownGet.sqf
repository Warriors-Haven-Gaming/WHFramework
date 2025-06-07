/*
Function: WHF_fnc_vehSpawnCooldownGet

Description:
    Return a player's vehicle spawner cooldown in seconds.
    Must be called on server.

Parameters:
    Object | String uid:
        The player to get the current cooldown.

Returns:
    Number

Author:
    thegamecracks

*/
params ["_uid"];
if (!isServer) exitWith {};
if (_uid isEqualType objNull) then {_uid = getPlayerUID _uid};

if (isNil "WHF_vehSpawn_cooldowns") then {WHF_vehSpawn_cooldowns = createHashMap};
private _now = serverTime;
private _time = WHF_vehSpawn_cooldowns getOrDefault [_uid, _now];
_time - _now
