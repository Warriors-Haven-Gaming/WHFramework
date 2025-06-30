/*
Function: WHF_fnc_inAreaMarkers

Description:
    Check if the given objects or positions are in any area marker
    starting with the given prefix.

Parameters:
    Array | Location | Object positions:
        The objects, locations, or positions to check.
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
if (count _markers < 1) exitWith {[]};

private _normalized = _positions;
if (_normalized findIf {_x isEqualType locationNull} >= 0) then {
    _normalized = _normalized apply {
        if (_x isEqualType locationNull) then {locationPosition _x} else {_x}
    };
};

private _matched = flatten (_markers apply {_normalized inAreaArrayIndexes _x});
_matched = _matched arrayIntersect _matched;
_matched sort true;

// Produce stable ordering based on input
_matched apply {_positions # _x}
