/*
Script: onPlayerKilled.sqf

Description:
    Executed locally when player is killed.
    https://community.bistudio.com/wiki/Event_Scripts#onPlayerKilled.sqf

Parameters:
    Object unit:
        The player unit that was killed.
    Object killer:
        The unit that killed the player.

Author:
    thegamecracks

*/
params ["_unit", "_killer"];

_unit connectTerminalToUAV objNull;
