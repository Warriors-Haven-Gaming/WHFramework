/*
Function: WHF_fnc_startIntroSequence

Description:
    Start the player's intro sequence.
    Function must be executed in scheduled environment.

Parameters:
    Boolean short:
        (Optional, default false)
        If true, skip straight to the role selection GUI.

Author:
    thegamecracks

*/
params [["_short", false]];
sleep 0.5;

if (!_short) then {
    [] call WHF_fnc_introGUI;
    waitUntil {sleep 0.25; !dialog};
};

[] call WHF_fnc_roleSelectionGUI;
waitUntil {sleep 0.25; !dialog};
