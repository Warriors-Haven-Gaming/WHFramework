/*
Function: WHF_fnc_randomPosHidden

Description:
    Attempts to find a random position that players cannot see
    within the given area.

Parameters:
    Position2D center:
        The center of the area.
    Array | Number radius:
        The radius of the area.
        An array can be passed to specify the minimum and maximum radius.
    Number minPlayerDistance:
        (Optional, default 0)
        The minimum distance allowed from a player.
    Number maxPlayerDistance:
        (Optional, default viewDistance)
        The distance where visibility checks will be skipped.

Returns:
    Array
        The position candidate in format [x,y,z] or [0,0] if position cannot be found.

Examples:
    (begin example)
        [[0,0,0], 50] call WHF_fnc_randomPosHidden;
    (end)
    (begin example)
        [[0,0,0], [20,50]] call WHF_fnc_randomPosHidden;
    (end)

Author:
    thegamecracks

*/
params ["_center", "_radius", ["_minPlayerDistance", 0], ["_maxPlayerDistance", viewDistance]];

private _minPlayerDistanceSqr = _minPlayerDistance * _minPlayerDistance;
private _maxPlayerDistanceSqr = _maxPlayerDistance * _maxPlayerDistance;

private _condition = {
    params ["_pos", "_arguments"];
    _arguments params ["_minPlayerDistanceSqr", "_maxPlayerDistanceSqr"];
    if (count allPlayers < 1) exitWith {true};

    // Assuming a person shouldn't be visible at this position, we'll add
    // 2 metres to the height
    private _posASL = AGLToASL _pos vectorAdd [0, 0, 2];
    {
        private _eyePos = eyePos _x;
        private _distanceSqr = _eyePos distanceSqr _posASL;
        if (_distanceSqr < _minPlayerDistanceSqr) then {continueWith false};
        if (_distanceSqr > _maxPlayerDistanceSqr) then {continueWith true};

        private _surfaces = lineIntersectsSurfaces [_eyePos, _posASL, _x];
        if (_surfaces isEqualTo []) exitWith {false};
        true
    } forEach allPlayers
};

[
    _center,
    _radius,
    [[_minPlayerDistanceSqr, _maxPlayerDistanceSqr], _condition]
] call WHF_fnc_randomPos
