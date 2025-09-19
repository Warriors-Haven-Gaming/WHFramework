if (!isClass (configFile >> "CfgPatches" >> "cba_xeh")) then {
    call compileScript ["XEH_preInit.sqf"];
};

if (isServer) then {
    WHF_globalPlayerTarget = [0, -2] select isDedicated;
    publicVariable "WHF_globalPlayerTarget";
};

setMissionOptions createHashMapFromArray [
    ["IgnoreNoDamage", true],
    ["IgnoreFakeHeadHit", true],
    ["IgnoreUpsideDownDamage", true],
    ["AIThinkOnlyLocal", true]
];

addMissionEventHandler ["PreloadFinished", {
    removeMissionEventHandler [_thisEvent, _thisEventHandler];
    if (!hasInterface) exitWith {};

    private _firstPlayed = missionProfileNamespace getVariable ["WHF_play_first", systemTimeUTC];
    missionProfileNamespace setVariable ["WHF_play_first", _firstPlayed];

    private _timesPlayed = missionProfileNamespace getVariable ["WHF_play_times", 0];
    missionProfileNamespace setVariable ["WHF_play_times", _timesPlayed + 1];
    saveMissionProfileNamespace;

    [] spawn WHF_fnc_startIntroSequence;
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
