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

if (side player isEqualTo blufor) then {
    player setPosATL getPosATL blufor_spawn_1;
}

call WH_fnc_initUnflipAction;
