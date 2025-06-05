/*
Function: WHF_fnc_isNearUsedPosition

Description:
    Check if the given position is near an object in the WHF_usedPositions array.

Parameters:
    Position2D position:
        The position to check.
    Number radius:
        The min distance allowed from a used position.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_position", "_radius"];

WHF_usedPositions findIf {
    _x params ["_obj", "_objRadius"];
    private _radiusSqr = (_objRadius + _radius) ^ 2;
    !isNull _obj && {_position distanceSqr _obj < _radiusSqr}
} >= 0
