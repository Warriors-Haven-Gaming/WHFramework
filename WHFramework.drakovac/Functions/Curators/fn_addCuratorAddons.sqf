/*
Function: WHF_fnc_addCuratorAddons

Description:
    Add a client's addons to their curator module.
    Function must be remote executed on server from a client.

Parameters:
    Object player:
        The player whose curator module to add addons for.
    Array addons:
        The addons to add to the player's curator module.

Author:
    thegamecracks

*/
params ["_player", "_addons"];
if (!isServer) exitWith {};
if (!isPlayer _player) exitWith {};
if (isMultiplayer && {!isRemoteExecuted}) exitWith {};
if (owner _player isNotEqualTo remoteExecutedOwner) exitWith {};

private _module = getAssignedCuratorLogic _player;
if (isNull _module) exitWith {
    diag_log text format [
        "%1: no module found for %3 (%4), ignoring %2 addons",
        _fnc_scriptName,
        count _addons,
        name _player,
        getPlayerUID _player
    ];
};

diag_log text format [
    "%1: adding %2 addons from %3 (%4)",
    _fnc_scriptName,
    count _addons,
    name _player,
    getPlayerUID _player
];
_module addCuratorAddons _addons;
