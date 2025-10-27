/*
Function: WHF_fnc_respawnMarkers

Description:
    Return an array of respawn markers available to a unit.
    Respawn markers matching the unit's role are returned first.

Parameters:
    Object unit:
        The unit to retrieve respawn positions for.

Returns:
    Array

Author:
    thegamecracks

*/
params ["_unit"];

private _basePrefix = switch (side group _unit) do {
    case blufor: {"respawn_west"};
    case opfor: {"respawn_east"};
    case independent: {"respawn_guerrila"};
    case civilian: {"respawn_civilian"};
    default {""};
};
private _prefixes = [_basePrefix];

private _role = _unit getVariable "WHF_role";
if (!isNil "_role") then {
    private _prefix = format ["%1_%2", _basePrefix, _role];
    _prefixes insert [0, [_prefix]];
};

flatten (
    _prefixes apply {
        private _prefix = _x;
        private _markers = allMapMarkers select {[_x, _prefix] call WHF_fnc_stringStartsWith};
        _markers sort true;
        _markers
    }
)
