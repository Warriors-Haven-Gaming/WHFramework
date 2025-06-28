/*
Function: WHF_fnc_initDiary

Description:
    Initializes all diary records.
    Function must be ran on client.

Examples:
    (begin example)
        call WHF_fnc_initDiary;
    (end)

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};

call WHF_fnc_diaryGuide;
