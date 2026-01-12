/*
Function: WHF_fnc_anyInArea

Description:
    Functions similarly to inAreaArray except that this function
    returns a boolean if any of the given positions are in the area.

    This originally used inArea with short-circuiting for performance,
    but nowadays inAreaArray is very efficient to execute even on
    hundreds of positions.

    See also: https://community.bistudio.com/wiki/inAreaArray

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_positions", "_area"];
_positions inAreaArray _area isNotEqualTo []
