/*
Script: initPlayerLocal.sqf

Description:
    Executed locally when player joins mission.
    https://community.bistudio.com/wiki/Event_Scripts#initPlayerLocal.sqf

Parameters:
    Object player:
        The player unit.

Author:
    thegamecracks

*/
params ["_player"];

if (isMultiplayer && {!isServer}) then {
    // Will run before init.sqf and on clients, unlike initServer.sqf
    if (!isClass (configFile >> "CfgPatches" >> "cba_xeh")) then {
        call compileScript ["XEH_preInit.sqf"];
    };
};

if (!hasInterface) exitWith {};

call WH_fnc_initIncapacitatedHandlers;
0 spawn WH_fnc_selfReviveLoop;

systemChat format ["Finished initialization (%1)", briefingName];
