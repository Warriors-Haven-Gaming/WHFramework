/*
Function: WHF_fnc_checkAPSTargetPaths

Description:
    Filter an array of projectiles likely to impact a vehicle.

Parameters:
    Object vehicle:
        The vehicle to determine impact for.
    Array projectiles:
        The array of projectiles to filter.

Returns:
    Array

Author:
    thegamecracks

*/
params ["_vehicle", "_projectiles"];
// FIXME: after v2.20, use alternative syntax for parallel intersections
private _scale = WHF_aps_rate * WHF_aps_distance;
_projectiles select {
    private _begPos = getPosASL _x;
    private _endPos = _begPos vectorAdd (velocity _x vectorMultiply _scale);
    private _objects = lineIntersectsObjs [_begPos, _endPos, _x, objNull, false, 16];
    _vehicle in _objects
}
