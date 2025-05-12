/*
Function: WHF_fnc_anyInArea

Description:
    Functions similarly to inAreaArray except that this function
    returns a boolean if any of the given positions are in the area.
    This takes advantage of short-circuiting so it will perform better
    when any position that matches is at the start of the array.
    See also: https://community.bistudio.com/wiki/inAreaArray

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_positions", "_area"];
_positions findIf {_x inArea _area} isNotEqualTo -1
