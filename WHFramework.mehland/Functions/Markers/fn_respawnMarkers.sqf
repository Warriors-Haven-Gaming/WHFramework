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

private _respawnPrefix = switch (side group _unit) do {
    case blufor: {"respawn_west"};
    case opfor: {"respawn_east"};
    case independent: {"respawn_guerrila"};
    case civilian: {"respawn_civilian"};
    default {""};
};
private _rolePrefix = format ["%1_%2", _respawnPrefix, _unit getVariable ["WHF_role", ""]];

(allMapMarkers select {[_x, _rolePrefix] call WHF_fnc_stringStartsWith})
+ (allMapMarkers select {[_x, _respawnPrefix] call WHF_fnc_stringStartsWith})
