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
if (!hasInterface) exitWith {};

if (isMultiplayer) then {["InitializePlayer", [player]] call BIS_fnc_dynamicGroups};

// Functions that require mission display
call WHF_fnc_initContextHandlers;
call WHF_fnc_initCruiseKeybind;
call WHF_fnc_initDetainKeybind;
call WHF_fnc_initEarplugsKeybind;
call WHF_fnc_initHolsterKeybind;
call WHF_fnc_initMagRepackKeybind;

0 spawn WHF_fnc_laserLightLoop;
0 spawn WHF_fnc_updateChannelLoop;
0 spawn WHF_fnc_initFriendlyIcons;
