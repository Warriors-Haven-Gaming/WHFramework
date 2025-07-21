/*
Function: WHF_fnc_nearestSurface

Description:
    Return the nearest surface above or below the given position.
    If there is no surface, return the same position.

Parameters:
    PositionASL pos:
        The position to find the nearest surface.

Returns:
    PositionASL

Author:
    thegamecracks

*/
params ["_pos"];

_pos = _pos vectorAdd [0,0,0];
private _posZ = _pos # 2;
private _maxDistance = 10;
private _surfaces = lineIntersectsSurfaces [
    _pos vectorAdd [0, 0, _maxDistance],
    _pos vectorAdd [0, 0, -_maxDistance],
    objNull,
    objNull,
    true,
    -1,
    "VIEW",
    "FIRE",
    false
]; // select {_x # 1 vectorDotProduct [0,0,1] > 0}

// Include sea level as a surface if possible
if (_posZ < _maxDistance && {_posZ > -_maxDistance}) then {
    _surfaces pushBack [_pos vectorMultiply [1,1,0]];
};

_surfaces = _surfaces apply {[abs (_x # 0 # 2 - _posZ), _x # 0 # 0, _x # 0 # 1, _x # 0 # 2]};
_surfaces sort true;
_surfaces = _surfaces apply {[_x # 1, _x # 2, _x # 3]};

if (_surfaces isNotEqualTo []) then {_surfaces # 0} else {_pos}
