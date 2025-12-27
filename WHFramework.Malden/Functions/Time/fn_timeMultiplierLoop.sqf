/*
Function: WHF_fnc_timeMultiplierLoop

Description:
    Periodically updates the time multiplier.
    Function must be executed on server.

Parameters:
    Array functions:
        The function names of each mission to spawn.
    Code minScripts:
        A function that returns minimum number of active missions allowed.
    Code maxScripts:
        A function that returns maximum number of active missions allowed.
        Takes priority over minScripts.

Author:
    thegamecracks

*/
["reset"] call WHF_fnc_setTimeMultiplier;
while {true} do {
    sleep 10;

    private _state = [] call WHF_fnc_setTimeMultiplier;
    if (_state in ["skip"]) then {continue};
    ["reset"] call WHF_fnc_setTimeMultiplier;
};
