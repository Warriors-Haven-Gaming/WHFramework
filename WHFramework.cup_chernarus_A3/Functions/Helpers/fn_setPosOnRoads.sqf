/*
Function: WHF_fnc_setPosOnRoads

Description:
    Randomly place objects on roads in a given area.

Parameters:
    Array objects:
        The objects to place.
    Position2D center:
        The center of the area.
    Number radius:
        The radius of the area.

Returns:
    Array
        An array of objects that could not be placed.

Author:
    thegamecracks

*/
params ["_objects", "_center", "_radius"];

private _roads =
    _center nearRoads _radius
    apply {getRoadInfo _x}
    select {!(_x # 2)}
    select {_x # 0 in ["ROAD", "MAIN ROAD", "TRACK"]};

private _positions = [];
{
    for "_i" from 1 to 3 do {
        // TODO: parameterize x and y coefficients?
        private _y = 0.8 - random 1.6;
        private _pos = [_x, random 1, _y] call WHF_fnc_getRoadPos;

        // TODO: parameterize LHD/RHD directions?
        _x params ["", "", "", "", "", "", "_begPos", "_endPos"];
        private _dir = _begPos getDir _endPos;
        if (_y < 0) then {_dir = _dir + 180};

        _positions pushBack [_pos, _dir];
    };
} forEach _roads;
_positions = _positions call WHF_fnc_arrayShuffle;

private _index = 0;
{
    if (_index >= count _objects) then {break};
    private _obj = _objects # _index;
    _x params ["_pos", "_dir"];

    // FIXME: use bounding box?
    if (_pos nearObjects 5 isNotEqualTo []) then {continue};

    _obj setDir _dir;
    _obj setVectorUp surfaceNormal _pos;
    _obj setPosATL _pos;

    _index = _index + 1;
} forEach _positions;

_objects select [_index]
