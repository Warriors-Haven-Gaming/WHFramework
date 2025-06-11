/*
Function: WHF_fnc_groupMagazines

Description:
    Return a unit's magazines grouped by compatible ammo type and sorted
    by highest capacity and count first.

Parameters:
    Object unit:
        The unit to return magazines for.
    Boolean canRepack:
        (Optional, default false)
        If true, only groups are returned where there are at least
        two partial magazines that can be repacked.

Returns:
    Array
        An array containing sub-arrays of compatible magazines, where each
        magazine is in the format returned by magazinesAmmoFull.

Author:
    thegamecracks

*/
params ["_unit", ["_canRepack", false]];

private _magazines = magazinesAmmoFull _unit select {_x # 3 in [-1, 1, 2, 4]};
private _compatible = createHashMap;
{
    _x params ["_type"];
    private _ammo = getTextRaw (configFile >> "CfgMagazines" >> _type >> "ammo");
    private _entries = _compatible getOrDefault [_ammo, [], true];
    _entries pushBack _x;
} forEach _magazines;

private _magazineGroups = values _compatible apply {
    // BIS_fnc_sortBy doesn't work with composite keys, so we're sorting manually
    _x = _x apply {
        private _count = _x # 1;
        private _capacity = getNumber (configFile >> "CfgMagazines" >> _x # 0 >> "count");
        private _isFull = if (WHF_repack_prefer_capacity || {_count >= _capacity}) then {1} else {0};
        [_isFull, _capacity, _count, _x]
    };
    _x sort false;
    _x apply {_x select 3}
};
if (!_canRepack) exitWith {_magazineGroups};

private _hasPartialMagazines = {
    if (count _this < 2) exitWith {false};
    {_x call _isPartialMagazine} count _this > 1
};

private _isPartialMagazine = {
    private _count = _this # 1;
    private _capacity = getNumber (configFile >> "CfgMagazines" >> _this # 0 >> "count");
    _count < _capacity
};

_magazineGroups select {_x call _hasPartialMagazines};
