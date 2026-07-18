/*
Function: WHF_fnc_getAircraftTypes

Description:
    Returns an array of unit classnames for one or more given types.
    If none of the types are valid, an empty array is returned.

Parameters:
    Array types:
        One or more group types to return.
        See WHF_fnc_initFactionCatalog for allowed aircraft values.

Returns:
    Array

Examples:
    (begin example)
        [["jet_cas", "csat"], ["jet_cap", "csat"]] call WHF_fnc_getAircraftTypes;
    (end)

Author:
    thegamecracks

*/
if (isNil "_this") exitWith {[]};
if !(_this isEqualType []) then {throw format [
    "Expected [[type, faction], ...] array, got %1",
    _this
]};
_this = _this apply {["aircraft", _x # 0, _x # 1]};
call WHF_fnc_getFactionTypes
