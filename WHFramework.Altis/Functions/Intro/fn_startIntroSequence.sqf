/*
Function: WHF_fnc_startIntroSequence

Description:
    Start the player's intro sequence.
    Function must be executed in scheduled environment.

Parameters:
    Boolean short:
        (Optional, default false)
        If true, skip straight to the role selection GUI.
    Boolean music:
        (Optional, default true)
        If true, play a random music track.

Author:
    thegamecracks

*/
params [["_short", false], ["_music", true]];
sleep 0.5;

if (_music) then {
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

if (!_short) then {
    [] call WHF_fnc_introGUI;
    waitUntil {sleep 0.25; !dialog};
};

[] call WHF_fnc_roleSelectionGUI;
waitUntil {sleep 0.25; !dialog};
