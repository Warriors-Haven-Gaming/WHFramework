/*
Function: WHF_fnc_preloadArsenal

Description:
    Preload the vanilla arsenal.

Author:
    thegamecracks

*/
if (isNil "BIS_fnc_arsenal_data") then {["Preload"] call BIS_fnc_arsenal};
if (WHF_loadout_blacklist isEqualTo []) exitWith {};

// ~3.75ms with 5000+ items
private _blacklist = WHF_loadout_blacklist createHashMapFromArray [];
{
    private _group = _x;
    private _toRemove = [];
    {
        if (toLowerANSI _x in _blacklist) then {
            _toRemove pushBack _forEachIndex;
        };
    } forEach _group;
    {_group deleteAt _x} forEachReversed _toRemove;
} forEach BIS_fnc_arsenal_data;
