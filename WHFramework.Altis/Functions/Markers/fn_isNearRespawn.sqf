/*
Function: WHF_fnc_isNearRespawn

Description:
    Check if the given position is near a respawn marker.

Parameters:
    Position2D position:
        The position to check.
    Number radius:
        The max distance allowed from a respawn marker.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_position", "_radius"];

allMapMarkers findIf {
    [_x, "respawn"] call WHF_fnc_stringStartsWith
    && {markerPos _x distance2D _position <= _radius}
} >= 0
