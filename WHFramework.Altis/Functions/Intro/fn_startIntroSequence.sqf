/*
Function: WHF_fnc_startIntroSequence

Description:
    Start the player's intro sequence.
    Function must be executed in scheduled environment.

Author:
    thegamecracks

*/
sleep 0.5;

[] call WHF_fnc_introGUI;
waitUntil {sleep 0.25; !dialog};
