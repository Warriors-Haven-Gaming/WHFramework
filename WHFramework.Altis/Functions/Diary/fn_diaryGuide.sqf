/*
Function: WHF_fnc_diaryGuide

Description:
    Add diary records for the Getting Started guide.
    Function must be ran on client.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};

player createDiarySubject [_fnc_scriptName, localize "$STR_WHF_diaryGuide_subject"];
player createDiaryRecord [
    _fnc_scriptName,
    [
        localize "$STR_WHF_diaryGuide_vehSpawn_title",
        "<img image='images\guide\vehspawn.jpg' width='370' height='185' /><br/><br/>"
        + ("$STR_WHF_diaryGuide_vehSpawn_description" call WHF_fnc_diaryLocalize)
    ]
];
player createDiaryRecord [
    _fnc_scriptName,
    [
        localize "$STR_WHF_diaryGuide_locks_title",
        "<img image='images\guide\locks.jpg' width='370' height='185' /><br/><br/>"
        + ("$STR_WHF_diaryGuide_locks_description" call WHF_fnc_diaryLocalize)
    ]
];
player createDiaryRecord [
    _fnc_scriptName,
    [
        localize "$STR_WHF_diaryGuide_service_title",
        "<img image='images\guide\service.jpg' width='370' height='185' /><br/><br/>"
        + ("$STR_WHF_diaryGuide_service_description" call WHF_fnc_diaryLocalize)
    ]
];
player createDiaryRecord [
    _fnc_scriptName,
    [
        localize "$STR_WHF_diaryGuide_recruits_title",
        "<img image='images\guide\recruits.jpg' width='370' height='185' /><br/><br/>"
        + ("$STR_WHF_diaryGuide_recruits_description" call WHF_fnc_diaryLocalize)
    ]
];
player createDiaryRecord [
    _fnc_scriptName,
    [
        localize "$STR_WHF_diaryGuide_incapacitation_title",
        "<img image='images\guide\incapacitation.jpg' width='370' height='185' /><br/><br/>"
        + ("$STR_WHF_diaryGuide_incapacitation_description" call WHF_fnc_diaryLocalize)
    ]
];
player createDiaryRecord [
    _fnc_scriptName,
    [
        localize "$STR_WHF_diaryGuide_halo_title",
        "<img image='images\guide\halo.jpg' width='370' height='185' /><br/><br/>"
        + ("$STR_WHF_diaryGuide_halo_description" call WHF_fnc_diaryLocalize)
    ]
];
player createDiaryRecord [
    _fnc_scriptName,
    [
        localize "$STR_WHF_diaryGuide_keybinds_title",
        "$STR_WHF_diaryGuide_keybinds_description" call WHF_fnc_diaryLocalize
    ]
];
player createDiaryRecord [
    _fnc_scriptName,
    [
        localize "$STR_WHF_diaryGuide_summary_title",
        "<img image='images\guide\summary.jpg' width='370' height='185' /><br/><br/>"
        + format [
            "$STR_WHF_diaryGuide_summary_description" call WHF_fnc_diaryLocalize,
            getText (configFile >> "CfgWorlds" >> worldName >> "description")
        ]
    ]
];
