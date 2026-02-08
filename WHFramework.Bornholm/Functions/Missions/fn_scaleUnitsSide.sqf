/*
Function: WHF_fnc_scaleUnitsSide

Description:
    Return a random integer in the given range, multiplied by
    the side mission units coefficient.

Parameters:
    Number min:
        The minimum number of units.
        If the unit coefficient is less than 1, this may return
        a number smaller than min.
    Number max:
        (Optional, default nil)
        The maximum number of units.
        If the unit coefficient is greater than 1, this may return
        a number greater than max.
        If omitted, simply returns the scaled minimum.

Returns:
    Number

Author:
    thegamecracks

*/
params ["_min", "_max"];
if (isNil "_max") exitWith {ceil (_min * WHF_missions_side_units)};
private _num = _min + floor random (_max - _min + 1);
ceil (_num * WHF_missions_side_units)
