/*
Function: WHF_fnc_reinforceLoop

Description:
    Periodically spawn reinforcements in the given area.
    Unlike other functions, the arguments array can be modified in-place
    to change behaviour mid-execution.
    Function must be ran in scheduled environment.

Parameters:
    Boolean running:
        Whether the function should run. By setting this to false,
        the function can be safely terminated during execution.
    Array | Number frequency:
        How often this function should spawn reinforcements.
        If an array is passed, it is treated as the minimum and maximum time.
    Number threshold:
        The maximum number of units before reinforcements are paused.
    Array inputGroups:
        An array of groups to count units from.
    Array arguments:
        The arguments to pass to the reinforce function.
    Code function:
        The function to use for reinforcements. Must return a single group.

Author:
    thegamecracks

*/
private _sleepIteration = {
    _frequency params ["_min", "_max"];
    if (isNil "_max" || {_min > _max}) then {
        sleep _min;
    } else {
        sleep (_min + random (_max - _min));
    };
};

while {_this # 0} do {
    params [
        "",
        "_frequency",
        "_threshold",
        "_inputGroups",
        "_arguments",
        "_function"
    ];

    call _sleepIteration;
    if !(_this # 0) exitWith {};

    _inputGroups = [_inputGroups] call WHF_fnc_coerceGroups;
    private _total = 0;
    {_total = _total + count units _x} forEach _inputGroups;
    if (_total >= _threshold) then {continue};
    _arguments call _function;
};
