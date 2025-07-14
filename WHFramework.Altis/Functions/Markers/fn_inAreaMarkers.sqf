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

private _allMatches = [];
{
    if (count _positions < 1) exitWith {};
    if !([_x, _prefix] call WHF_fnc_stringStartsWith) then {continue};
    private _matched = _positions inAreaArray _x;
    _positions = _positions - _matched;
    _allMatches append _matched;
} forEach allMapMarkers;
_allMatches
