/*
Function: WHF_fnc_timeMultiplierLoop

Description:
    Periodically updates the time multiplier.
    Function must be executed on server.

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
