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

private _minRadius = 0;
private _maxRadius = 0;
if (_radius isEqualType []) then {
    _minRadius = _radius # 0;
    _maxRadius = _radius # 1;
} else {
    _maxRadius = _radius;
};

private _type = switch (true) do {
    case (_minRadius >= 40): {"B_T_VTOL_01_infantry_F"};
    case (_minRadius >= 20): {"B_Plane_CAS_01_dynamicLoadout_F"};
    case (_minRadius >= 15): {"B_Heli_Attack_01_dynamicLoadout_F"};
    case (_minRadius >= 10): {"B_MRAP_01_F"};
    case (_minRadius >= 5): {"B_Quadbike_01_F"};
    default {"B_Soldier_F"};
};

_condition params ["_conditionArgs", "_conditionCode"];
private _checkCondition = {
    params ["_pos"];
    private _ret = [_pos, _conditionArgs] call _conditionCode;
    if (isNil "_ret") exitWith {
        ["Condition returned nil"] call BIS_fnc_error;
        false
    };
    if !(_ret isEqualType true) exitWith {
        ["Condition returned non-boolean: %1", _ret] call BIS_fnc_error;
        false
    };
    _ret
};

private _ret = [0,0];
for "_i" from 1 to 30 do {
    private _pos = [[[_center, _maxRadius]]] call BIS_fnc_randomPos;
    if (_pos isEqualTo [0,0]) then {continue};

    private _empty = _pos findEmptyPosition [0, 50, _type];
    if (_empty isEqualTo []) then {continue};
    if !([_empty] call _checkCondition) then {continue};

    _ret = _empty;
    break;
};

_ret
