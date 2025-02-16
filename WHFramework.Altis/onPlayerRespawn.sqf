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

call WHF_fnc_initUnflipAction;
