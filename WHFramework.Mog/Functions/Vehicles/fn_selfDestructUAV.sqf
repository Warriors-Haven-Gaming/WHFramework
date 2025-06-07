/*
Function: WHF_fnc_selfDestructUAV

Description:
    Self-destruct the given UAV.
    If the drone has an owner, the player must be the owner of that drone.
    Function must be remote executed on all clients.

Parameters:
    Object player:
        The player self-destructing the UAV.
    Object drone:
        The UAV to be self-destructed.

Author:
    thegamecracks

*/
params ["_player", "_drone"];
// FIXME: validate remote executed owner
if (!isPlayer _player) exitWith {};
if (!unitIsUAV _drone) exitWith {};

private _owner = _drone getVariable ["WHF_drones_owner", ""];
if (_owner isNotEqualTo "" && {getPlayerUID _player isNotEqualTo _owner}) exitWith {};

if (local _drone) then {_drone setDamage [1, false]};
if (hasInterface) then {
    private _key = [
        "$STR_WHF_selfDestructUAV",
        "$STR_WHF_selfDestructUAV_owner"
    ] select (_owner isNotEqualTo "");

    systemChat format [
        localize _key,
        name _player,
        [configOf _drone] call BIS_fnc_displayName
    ];
};
