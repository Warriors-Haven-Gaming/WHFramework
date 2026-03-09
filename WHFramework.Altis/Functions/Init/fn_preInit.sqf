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

    private _introPlayed = !isNil {uiNamespace getVariable "WHF_play_intro"};
    private _short = _introPlayed && !isMultiplayer;
    private _music = !_introPlayed;
    [_short, _music] spawn WHF_fnc_startIntroSequence;
    uiNamespace setVariable ["WHF_play_intro", true];

    0 spawn {
        sleep 0.5;
        systemChat format ["Finished initialization (%1)", briefingName];
    };
}];
