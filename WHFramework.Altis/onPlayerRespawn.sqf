/*
Script: onPlayerRespawn.sqf

Description:
    Executed locally when player respawns.
    https://community.bistudio.com/wiki/Event_Scripts#onPlayerRespawn.sqf

Parameters:
    Object newUnit:
        The player unit that respawned.

Author:
    thegamecracks

*/
params ["_newUnit"];

private _loadout = call WHF_fnc_getLastLoadout;
if (_loadout isNotEqualTo []) then {_newUnit setUnitLoadout _loadout};

call WHF_fnc_initUnflipAction;
