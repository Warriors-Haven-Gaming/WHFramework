/*
Function: WHF_fnc_randomPos

Description:
    Attempts to find a random position within given area.

Parameters:
    Position2D center:
        The center of the area.
    Array | Number radius:
        The radius of the area.
        An array can be passed to specify the minimum and maximum radius.
    Array condition:
        (Optional, default [0, {true}])
        The [arguments, code] callback used to determine if a given
        position is allowed. The code will be passed an array containing
        the PositionAGL and user-supplied arguments.

Returns:
    Array
        The position candidate in format [x,y,z] or [0,0] if position cannot be found.

Examples:
    (begin example)
        [[0,0,0], 50] call WHF_fnc_randomPos;
    (end)
    (begin example)
        [[0,0,0], [20,50]] call WHF_fnc_randomPos;
    (end)

Author:
    thegamecracks

*/
params ["_center", "_radius", ["_condition", [0, {true}]]];

private _pos = [0,0];
private _randomPosArgs = [];
private _minRadius = 0;
private _maxRadius = 0;
if (_radius isEqualType []) then {
    _minRadius = _radius # 0;
    _maxRadius = _radius # 1;
} else {
    _maxRadius = _radius;
};

_condition params ["_conditionArgs", "_conditionCode"];
private _checkCondition = {
    params ["_pos"];
    [_empty, _conditionArgs] call _conditionCode isEqualTo true
};

_randomPosArgs pushBack [[_center, _maxRadius]];
if (_minRadius > 0) then {
    _randomPosArgs pushBack [[_center, _minRadius]];
};

for "_i" from 1 to 30 do {
    _pos = _randomPosArgs call BIS_fnc_randomPos;
    if (_pos isEqualTo [0,0]) then {continue};
    private _empty = _pos findEmptyPosition [0, 50];
    if (_empty isEqualTo []) then {continue};
    if !([_empty] call _checkCondition) then {continue};
    _pos = _empty;
    break;
};
if (_pos isEqualTo [0,0]) then {
    private _empty = _center findEmptyPosition [_minRadius, _maxRadius];
    if (_empty isEqualTo []) then {continue};
    if !([_empty] call _checkCondition) exitWith {};
    _pos = _empty;
};
_pos
