/*
Function: WHF_fnc_playMusicMissionEnd

Description:
    Globally play music for the end of a mission.
    Function must be executed on server.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
if (!WHF_missions_music_main) exitWith {};
selectRandom [
    ["LeadTrack01a_F_EXP", 0],      // This Is War (Apex Remix) - Part 1
    ["AmbientTrack02_F_Orange", 0], // Laws of War DLC: Remnants of War
    ["LeadTrack01b_F_EXP", 0],      // This Is War (Apex Remix) - Part 2
    ["LeadTrack01c_F_EXP", 0],      // This Is War (Apex Remix) - Part 3
    ["LeadTrack06_F_Tank", 0],      // Tanks DLC: Iron Gods
    ["LeadTrack02_F_Tank", 0],      // Tanks DLC: Last Stand
    ["LeadTrack04_F_Tacops", 0],    // Tac-Ops DLC: Outro
    ["LeadTrack01_F_Tank", 0],      // Tanks DLC: Fight for the City
    ["LeadTrack02_F_Malden", 0],    // Malden
    ["LeadTrack01_F_Orange", 0],    // This Is War (Laws of War Remix)
    ["LeadTrack05_F_Tank", 4],      // Tanks DLC: Wrath of the Giants
    ["LeadTrack02_F_Jets", 0],      // Air Power
    ["LeadTrack01_F_Mark", 0],      // This is War (Marksmen Remix)
    ["Track_O_01", 0],              // A2 OA: Arrowhead
    ["Track_P_17", 0],              // A2 BAF: Jackals
    ["Track_R_01", 0],              // A2: Manhattan
    ["Track_R_17", 0]               // A2: Insertion
] params ["_music", "_offset"];
[_music, 60, _offset, 15, 15, 2.5] remoteExec ["WHF_fnc_playMusicSnippet", WHF_globalPlayerTarget];
