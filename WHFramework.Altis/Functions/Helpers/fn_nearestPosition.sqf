/*
Function: WHF_fnc_nearestPosition

Description:
    Given a center and array of objects or positions, return the nearest
    position from the given center.

Parameters:
    Object | PositionATL center:
        The center to find the closest position to.
    Array positions:
        An array of objects and/or PositionATLs to check.

Returns:
    Object | PositionATL | Nothing
        The nearest position, or nil if center is objNull
        or there are no valid positions provided.

Author:
    thegamecracks

*/
params ["_center", "_positions"];

private _normalizePosition = {
    if (_this isEqualTo objNull) exitWith {-1};
    _this
};

private _centerNormalized = _center call _normalizePosition;
if (_centerNormalized isEqualType 0) exitWith {nil};

private _positionsNormalized = _positions apply {_x call _normalizePosition};
private _distances = _positionsNormalized apply {
    if (_x isEqualType 0) then {1e39} else {_x distance _centerNormalized}
};

private _index = _distances find selectMin _distances;
if (isNil "_index") exitWith {nil};

if (_distances # _index isEqualTo 1e39) exitWith {nil};
_positions # _index
