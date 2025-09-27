/*
Function: WHF_fnc_inAreaPrison

Description:
    Check if the given objects or positions are in a prison area.

Parameters:
    Array | Location | Object positions:
        The objects, locations, or positions to check.

Returns:
    Array
        An array of positions that are in a prison.

Author:
    thegamecracks

*/
params ["_positions"];

if !(_positions isEqualType []) then {_positions = [_positions]};
if (count _positions < 1) exitWith {[]};

private _markers = allMapMarkers select {_x find "WHF_prison" isEqualTo 0};
if (_markers isNotEqualTo []) exitWith {[_positions, "WHF_prison"] call WHF_fnc_inAreaMarkers};
_positions select {[_x, 10] call WHF_fnc_isNearArsenal}
