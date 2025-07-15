/*
Function: WHF_fnc_coerceGroups

Description:
    Coerce values in an array into groups, and return an array of unique groups.

Parameters:
    Array groups:
        An array of values to be coerced.

Returns:
    Array

Author:
    thegamecracks

*/
params ["_values"];
private _groups = [];
{
    if (_x isEqualType objNull) then {_x = group _x};
    if !(_x isEqualType grpNull) then {continue};
    if (isNull _x) then {continue};
    _groups pushBackUnique _x;
} forEach _values;
_groups
