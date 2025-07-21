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

[] call WHF_fnc_waitSyncCBA;
if (!hasInterface) exitWith {};
if (isMultiplayer) then {["InitializePlayer", [player]] call BIS_fnc_dynamicGroups};

// Functions that require mission display
call WHF_fnc_initContextHandlers;
call WHF_fnc_initCruiseKeybind;
call WHF_fnc_initDetainKeybind;
call WHF_fnc_initEarplugsKeybind;
call WHF_fnc_initHolsterKeybind;
call WHF_fnc_initMagRepackKeybind;
call WHF_fnc_initMinimapHandlers;

spawn WHF_fnc_laserLightLoop;
spawn WHF_fnc_updateChannelLoop;
spawn WHF_fnc_initEnemyIcons;
spawn WHF_fnc_initFriendlyIcons;
spawn WHF_fnc_initProjectileIcons;

addMissionEventHandler ["PlayerViewChanged", WHF_fnc_initMinimapHandlers];

[player] call compileScript ["onPlayerRespawn.sqf"];
