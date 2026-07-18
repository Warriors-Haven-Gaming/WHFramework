/*
Function: WHF_fnc_getVehicleTypes

Description:
    Returns an array of unit classnames for one or more given types.
    If none of the types are valid, an empty array is returned.

Parameters:
    Array types:
        One or more group types to return.
        See WHF_fnc_initFactionCatalog for allowed vehicle values.

Returns:
    Array

Examples:
    (begin example)
        [["supply", "csat"], ["apc", "csat"]] call WHF_fnc_getVehicleTypes;
    (end)

Author:
    thegamecracks

*/
if (isNil "_this") exitWith {[]};
if !(_this isEqualType []) then {throw format [
    "Expected [[type, faction], ...] array, got %1",
    _this
]};
_this = _this apply {["vehicles", _x # 0, _x # 1]};
call WHF_fnc_getFactionTypes
