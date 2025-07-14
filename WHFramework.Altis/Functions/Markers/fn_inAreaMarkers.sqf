/*
Function: WHF_fnc_inAreaMarkers

Description:
    Check if the given objects or positions are in any area marker
    starting with the given prefix.

Parameters:
    Array | Object positions:
        The objects or positions to check.
    String prefix:
        The marker prefix to filter by.

Returns:
    Array
        An array of positions that are in an area marker matching the prefix.

Examples:
    (begin example)
        [player, "WHF_someMarker"] call WHF_fnc_inAreaMarkers;
    (end)

Author:
    thegamecracks

*/
params ["_positions", "_prefix"];

if !(_positions isEqualType []) then {_positions = [_positions]};
if (count _positions < 1) exitWith {[]};

private _markers = allMapMarkers select {_x find _prefix isEqualTo 0};
private _matched = flatten (_markers apply {_positions inAreaArrayIndexes _x});
_matched = _matched arrayIntersect _matched;
_matched sort true;

// Produce stable ordering based on input
_matched apply {_positions # _x}
