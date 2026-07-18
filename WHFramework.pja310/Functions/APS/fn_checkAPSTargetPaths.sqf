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

private _scale = WHF_aps_rate * WHF_aps_distance;
private _vectors = _projectiles apply {
    private _begPos = getPosASL _x;
    private _endPos = _begPos vectorAdd (velocity _x vectorMultiply _scale);
    [_begPos, _endPos, _x, objNull, false, 16]
};

private _threats = [];
{
    if !(_vehicle in _x) then {continue};
    _threats pushBack _projectiles # _forEachIndex;
} forEach lineIntersectsObjs [_vectors];

_threats
