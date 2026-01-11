/*
Function: WHF_fnc_vehSpawnRequest

Description:
    Request a vehicle to be spawned.
    Function must be remote executed on server from a client.

Parameters:
    Object player:
        The player requesting the vehicle.
        Must be owned by the client remote executing this function.
    Object spawner:
        The vehicle spawner object used by the player.
    String category:
        The vehicle category.
    String vehicle:
        The vehicle type.

Author:
    thegamecracks

*/
params ["_player", "_spawner", "_category", "_vehicle"];
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
if (isNil "_pos" || {isNil "_dir" || {isNil "_categories" || {isNil "_safeArea"}}}) exitWith {};

if (count _categories > 0 && {!(_category in _categories)}) exitWith {};

private _cooldown = [_uid] call WHF_fnc_vehSpawnCooldownGet;
if (_cooldown > 0) exitWith {};

// NOTE: This cooldown check also validates that the vehicle exists
_cooldown = [_category, _vehicle] call WHF_fnc_vehSpawnCatalogCooldown;
if (isNil "_cooldown") exitWith {};

private _role = _player getVariable "WHF_role";
if !([_category, _vehicle, _role] call WHF_fnc_vehSpawnCatalogRoleAllowed) exitWith {};

_safeArea params ["_radius"];
private _objects = [_pos, _radius] call WHF_fnc_nearObjectsRespawn;
if (count _objects > 0) then {_pos = _pos findEmptyPosition _safeArea};
if (_pos isEqualTo []) exitWith {
    remoteExec ["WHF_fnc_vehSpawnObstructed", remoteExecutedOwner];
};

if (isNil "WHF_vehSpawn_lastVehicles") then {WHF_vehSpawn_lastVehicles = createHashMap};
private _lastVehicle = WHF_vehSpawn_lastVehicles getOrDefault [_uid, objNull];
if (!isNull _lastVehicle) then {
    [_lastVehicle, _player] remoteExec ["WHF_fnc_vehSpawnDespawn", _lastVehicle];
    private _timeout = time + 3;
    waitUntil {sleep 0.2; isNull _lastVehicle || {time > _timeout}};
};

_vehicle = createVehicle [_vehicle, [-random 500, -random 500, random 500], [], 0, "CAN_COLLIDE"];
if (isNull _vehicle) exitWith {
    diag_log text format [
        "%1: failed to spawn %2 for %3",
        _fnc_scriptName,
        _vehicle,
        name _player
    ];
};

WHF_vehSpawn_lastVehicles set [_uid, _vehicle];

_vehicle setDir _dir;
_vehicle setPosATL _pos;
_vehicle setVariable ["WHF_vehicle_side", side group _player, true];
[_category, _vehicle, _player] call WHF_fnc_vehSpawnCatalogAddVehicleLocks;
[_uid, _cooldown] call WHF_fnc_vehSpawnCooldownSet;

if (isMultiplayer) then {
    // HACK: wait a bit and hope position is propagated before transferring locality
    sleep 2;
    _vehicle setOwner owner _player;
};

if (unitIsUAV _vehicle) then {
    [side group _player, _vehicle] remoteExec ["createVehicleCrew", _vehicle];
    [_vehicle, _uid] remoteExec ["WHF_fnc_lockDroneByUID"];
};
