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
    select {_x # 0 in ["ROAD", "MAIN ROAD", "TRACK"]}
    call WHF_fnc_arrayShuffle;

private _index = 0;
{
    if (_index >= count _objects) then {break};
    private _obj = _objects # _index;

    // TODO: parameterize x and y coefficients?
    private _pos = [_x, random 1, 0.3 - random 0.6] call WHF_fnc_getRoadPos;
    // FIXME: use bounding box?
    if (_pos nearObjects 5 isNotEqualTo []) then {continue};

    // TODO: randomize direction?
    _x params ["", "", "", "", "", "", "_begPos", "_endPos"];
    private _dir = _begPos getDir _endPos;

    _obj setDir _dir;
    _obj setVectorUp surfaceNormal _pos;
    _obj setPosATL _pos;

    _index = _index + 1;
} forEach _roads;

_objects select [_index]
