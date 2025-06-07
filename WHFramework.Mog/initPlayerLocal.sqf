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

if (isNil {player getVariable "WHF_role"}) then {player setVariable ["WHF_role", "rifleman", true]};
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

addMissionEventHandler ["PreloadFinished", {
    removeMissionEventHandler [_thisEvent, _thisEventHandler];

    private _firstPlayed = missionProfileNamespace getVariable ["WHF_play_first", systemTimeUTC];
    missionProfileNamespace setVariable ["WHF_play_first", _firstPlayed];

    private _timesPlayed = missionProfileNamespace getVariable ["WHF_play_times", 0];
    missionProfileNamespace setVariable ["WHF_play_times", _timesPlayed + 1];
    saveMissionProfileNamespace;

    if (_timesPlayed < 10) then {
        [["WHF", "Intro"], 15, nil, 35, nil, true, true] spawn BIS_fnc_advHint;
    };

    if (isNil {uiNamespace getVariable "WHF_play_intro"}) then {
        uiNamespace setVariable ["WHF_play_intro", true];
        selectRandom [
            ["AmbientTrack02_F_Orange", 0], // Laws of War DLC: Remnants of War
            ["LeadTrack02_F_Tank", 0],      // Tanks DLC: Last Stand
            ["LeadTrack04_F_Tacops", 0],    // Tac-Ops DLC: Outro
            ["LeadTrack01_F_Tank", 0],      // Tanks DLC: Fight for the City
            ["LeadTrack01_F_Orange", 0],    // This Is War (Laws of War Remix)
            ["LeadTrack05_F_Tank", 4],      // Tanks DLC: Wrath of the Giants
            ["LeadTrack02_F_Jets", 0]       // Air Power
        ] params ["_music", "_offset"];
        [_music, 60, 0, 15, 15] spawn WHF_fnc_playMusicSnippet;
    };

    0 spawn {
        sleep 0.5;
        systemChat format ["Finished initialization (%1)", briefingName];
    };
}];
