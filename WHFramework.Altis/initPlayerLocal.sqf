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

if (markerColor "respawn_west" isNotEqualTo "") then {player setPosATL markerPos "respawn_west"};

call WHF_fnc_initArsenalLoadoutHandlers;
call WHF_fnc_initContextActionHaloJump;
call WHF_fnc_initContextHandlers;
call WHF_fnc_initDamageHandlers;
call WHF_fnc_initIncapacitatedHandlers;
0 spawn WHF_fnc_updateChannelLoop;
0 spawn WHF_fnc_initFriendlyMapIcons;

systemChat format ["Finished initialization (%1)", briefingName];
