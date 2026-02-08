/*
Function: WHF_fnc_vehSpawnGUIServer

Description:
    Show the vehicle spawner GUI for a client.
    Function must be remote executed on server from a client.

Parameters:
    Object player:
        The player requesting the vehicle spawner GUI.
        Must be owned by the client remote executing this function.
    Object spawner:
        The vehicle spawner object used by the player.

Author:
    thegamecracks

*/
params ["_player", "_spawner"];
if (!isServer) exitWith {};
if (!isPlayer _player) exitWith {};
if (isMultiplayer && {!isRemoteExecuted}) exitWith {};
if (owner _player isNotEqualTo remoteExecutedOwner) exitWith {};

private _uid = getPlayerUID _player;
if (_uid isEqualTo "") exitWith {};

private _pos = _spawner getVariable "WHF_vehSpawn_pos";
private _dir = _spawner getVariable "WHF_vehSpawn_dir";
private _categories = _spawner getVariable "WHF_vehSpawn_categories";
private _safeArea = _spawner getVariable "WHF_vehSpawn_safeArea";

if (isNil "_pos") exitWith {diag_log text format ["%1: WHF_vehSpawn_pos not defined", _fnc_scriptName]};
if (isNil "_dir") exitWith {diag_log text format ["%1: WHF_vehSpawn_dir not defined", _fnc_scriptName]};
if (isNil "_categories") exitWith {diag_log text format ["%1: WHF_vehSpawn_categories not defined", _fnc_scriptName]};
if (isNil "_safeArea") exitWith {diag_log text format ["%1: WHF_vehSpawn_safeArea not defined", _fnc_scriptName]};

private _cooldown = [_uid] call WHF_fnc_vehSpawnCooldownGet;
[_spawner, _cooldown] remoteExec ["WHF_fnc_vehSpawnGUIClient", remoteExecutedOwner];
