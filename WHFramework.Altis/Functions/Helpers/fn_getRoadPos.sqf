/*
Function: WHF_fnc_getRoadPos

Description:
    Return a position along a given road.

Parameters:
    Array | Object road:
        The road to return a position from.
        If an array is passed, it must match the format returned by getRoadInfo.
    Number x:
        How far along the road the position should be.
        Typical values range between 0 and 1.
    Number y:
        How offset the position should be from the road's center line.
        Typical values range between -1 and +1.

Returns:
    PositionASL

Author:
    thegamecracks

*/
params ["_road", "_x", "_y"];
if (_road isEqualType objNull) then {_road = getRoadInfo _road};

_road params ["", "_width", "", "", "", "", "_begPos", "_endPos"];
private _line = _endPos vectorDiff _begPos;
private _posASL = vectorLinearConversion [0, 1, _x, _begPos, _endPos];
private _normal = vectorNormalized _line vectorCrossProduct [0, 0, 1];
private _distance = _width * _y / 2;
_posASL = _posASL vectorAdd (_normal vectorMultiply _distance);
_posASL
