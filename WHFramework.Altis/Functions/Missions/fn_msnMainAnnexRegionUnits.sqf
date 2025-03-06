/*
Function: WHF_fnc_msnMainAnnexRegionUnits

Description:
    Generate units and vehicles within the mission area.

Parameters:
    Position2D center:
        The center of the mission area.
    Number radius:
        The radius of the mission area.
    Array buildings:
        (Optional, default [])
        An array of buildings to prioritize garrisoning units io first.

Returns:
    Array
        An array containing two elements:
            1. An array of groups that were created.
            2. An array of vehicles that were created.

Author:
    thegamecracks

*/
params ["_center", "_radius", ["_buildings", []]];

private _groups = [];
private _vehicles = [];

private _infCount = 40 + floor (_radius / 8);
while {_infCount > 0} do {
    private _pos = [_center, _radius] call WHF_fnc_randomPos;
    if (_pos isEqualTo [0,0]) then {continue};

    private _quantity = selectRandom [2, 4, 6, 8];
    private _group = [opfor, "standard", _quantity, _pos, 10] call WHF_fnc_spawnUnits;
    [_group, getPosATL leader _group, 200] call BIS_fnc_taskPatrol;

    _groups pushBack _group;
    _infCount = _infCount - _quantity;
};

// NOTE: may result in positions being double garrisoned
private _garrisonCount = 30 + floor (_radius / 15);
private _garrisonGroup = [opfor, "standard", _garrisonCount, _center, _radius min 100] call WHF_fnc_spawnUnits;
[units _garrisonGroup select [0, floor (_garrisonCount / 2)], _buildings] call WHF_fnc_garrisonBuildings;
[_garrisonGroup, _center, _radius, true] call WHF_fnc_garrisonUnits;
[[_garrisonGroup], _groups] spawn WHF_fnc_ungarrisonLoop;
_groups pushBack _garrisonGroup;

private _vehicleCount = 4 + floor (_radius / 70);
for "_i" from 1 to _vehicleCount do {
    private _group = [opfor, "standard", 1, _center, _radius] call WHF_fnc_spawnVehicles;
    [_group, getPosATL leader _group, 200] call BIS_fnc_taskPatrol;
    _groups pushBack _group;
    _vehicles append assignedVehicles _group;
};

[_groups] spawn WHF_fnc_attackLoop;

[_groups, _vehicles]
