/*
Function: WHF_fnc_spawnUnitGroups

Description:
    Spawn groups of units at the given position.

Parameters:
    Side side:
        The side to spawn the unit groups in.
    Array types:
        A weighted array consisting of subarrays in this format:
            [type, min, max, skill, equipment]
        Type must be one or more values suitable for WHF_fnc_getUnitTypes.
        Min and max determine the minimum and maximum number of units
        per group of this type, rounded to the nearest interval of two.
        Skill is an optional offset applied to each unit's skill in that group.
        Equipment is an optional array of equipment types to add for this group.
    Number quantity:
        The approximate total number of units to spawn.
        This function may spawn up to max - 1 more units than intended,
        or fewer units if there is insufficient space to spawn them.
    PositionATL center:
        The position at which unit groups will spawn around.
    Array | Number radius:
        The radius around the position at which unit groups will spawn around.
        An array can be passed to specify the minimum and maximum radius.
    Array flags:
        (Optional, default [])
        An array containing any of the following flags:
            "hidden": Find hidden positions to spawn groups.
            "noDynamicSimulation": Disable dynamic simulation on groups.

Returns:
    Array

Examples:
    (begin example)
        private _groups = [
            opfor,
            [
                [[["standard", "base"]], 2, 8, 0], 0.80,
                [[[   "recon", "base"]], 2, 8, 1], 0.10,
                [[[   "elite", "base"]], 4, 6, 2], 0.05,
                [[[  "sniper", "base"]], 2, 2, 3], 0.05
            ],
            60,
            _center,
            _radius
        ] call WHF_fnc_spawnUnitGroups;
    (end)

Author:
    thegamecracks

*/
params [
    "_side",
    "_types",
    "_quantity",
    "_center",
    "_radius",
    ["_flags", []]
];

private _randomPos =
    [WHF_fnc_randomPos, WHF_fnc_randomPosHidden]
    select ("hidden" in _flags);
private _dynamicSimulation = !("noDynamicSimulation" in _flags);

private _groups = [];
while {_quantity > 0} do {
    private _pos = [_center, _radius] call _randomPos;
    if (_pos isEqualTo [0,0]) then {break};

    selectRandomWeighted _types params [
        "_type",
        "_min",
        "_max",
        ["_skill", 0],
        ["_equipment", WHF_units_equipment]
    ];
    private _size = 2 + 2 * floor random ((_max - _min) / 2 + 1);
    private _group =
        [_side, _type, _size, _pos, 10, _skill, _dynamicSimulation, _equipment]
        call WHF_fnc_spawnUnits;
    _groups pushBack _group;
    _quantity = _quantity - _size;
};
_groups
