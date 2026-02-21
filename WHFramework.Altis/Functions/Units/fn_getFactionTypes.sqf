/*
Function: WHF_fnc_getFactionTypes

Description:
    Returns an array of classnames for one or more given types in a category.
    If none of the types are valid, an empty array is returned.

Parameters:
    Array types:
        One or more types to return in the format:
            [
                // category, type, faction
                ["units",    "standard", "csat"],
                ["vehicles", "standard", "csat"],
                ["aircraft", "standard", "csat"],
                ["ships",    "light",    "csat"]
            ]

Returns:
    Array

Author:
    thegamecracks

*/
if (isNil "_this") exitWith {[]};
if !(_this isEqualType []) then {throw format [
    "Expected [[category, type, faction], ...] array, got %1",
    _this
]};

private _factions = call WHF_fnc_allFactions;
{
    if !(_x isEqualType [] || {count _x < 3}) then {throw format [
        "Expected [category, type, faction] at index %1, got %2",
        _forEachIndex,
        _x
    ]};

    _x params ["_category", "_type", "_faction"];
    // If this throws an exception, you probably did something like this:
    //     ["units", "standard", "base"] call WHF_fnc_getFactionTypes;
    // When specifying the category, type, and faction, it must be its own
    // element in another array:
    //     [["units", "standard", "base"]] call WHF_fnc_getFactionTypes;
    // If you're not sure where this occurred, run Arma with the -debug flag
    // and you should receive a traceback indicating which scripts led to this
    // ambiguous input.
    if (_type in _factions) then {throw format [
        "Misuse of faction name '%1' as type at index %2",
        _type,
        _forEachIndex
    ]};
} forEach _this;

private _resolvedTypes = _this apply {
    private _types = WHF_faction_types get _x;
    switch (true) do {
        case (!isNil "_types"): {_types};
        case !(_x # 1 in ["civilians", "standard"]): {[[_x # 0, "standard", _x # 2]] call WHF_fnc_getFactionTypes};
        case (_x # 2 isNotEqualTo "base"): {[[_x # 0, _x # 1, "base"]] call WHF_fnc_getFactionTypes};
        default {[]};
    };
};

// The arrays returned by WHF_faction_types are immutable.
// This part both de-duplicates those types and produces mutable arrays.
_resolvedTypes = flatten _resolvedTypes;
_resolvedTypes = _resolvedTypes arrayIntersect _resolvedTypes;
_resolvedTypes
