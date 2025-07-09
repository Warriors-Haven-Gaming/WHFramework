/*
Function: WHF_fnc_reinforceLoop

Description:
    Periodically spawn reinforcements in the given area.
    Unlike other functions, the arguments array can be modified in-place
    to change behaviour mid-execution.
    Function must be executed in scheduled environment.

Parameters:
    Boolean running:
        Whether the function should run. By setting this to false,
        the function can be safely terminated during execution.
    Array | Number frequency:
        How often this function should spawn reinforcements.
        If an array is passed, it is treated as the minimum and maximum time.
    Number threshold:
        The maximum number of units before reinforcements are paused.
    Array units:
        An array to count units from.
        Any elements that are groups will have their units counted.
        Other elements are simply considered as one unit.
        Null elements and non-unique elements are ignored.
    Array arguments:
        The arguments to pass to the reinforce function.
    Code function:
        The function to use for reinforcements. Must return a single group.

Author:
    thegamecracks

*/
private _isRunning = {
    _this # 0
};

private _sleepIteration = {
    _frequency params ["_min", "_max"];

    private _duration = if (isNil "_max" || {_min > _max}) then {_min} else {
        _min + random (_max - _min)
    };
    private _deadline = time + _duration;
    waitUntil {sleep 1; !call _isRunning || {time >= _deadline}};
    call _isRunning
};

private _countUnits = {
    private _total = 0;
    {
        if (isNull _x) then {continue};
        if (_x isEqualType grpNull) then {
            _total = _total + ({alive _x} count units _x);
        } else {
            if (alive _x) then {_total = _total + 1};
        };
    } forEach (_units arrayIntersect _units);
    _total
};

while _isRunning do {
    params [
        "",
        "_frequency",
        "_threshold",
        "_units",
        "_arguments",
        "_function"
    ];

    if (!call _sleepIteration) exitWith {};
    if (call _countUnits >= _threshold) then {continue};
    _arguments call _function;
};
