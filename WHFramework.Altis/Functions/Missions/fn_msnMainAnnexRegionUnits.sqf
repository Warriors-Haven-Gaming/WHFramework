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

private _infCount = floor (_radius / 50 + random (count allPlayers / 10));
for "_i" from 1 to _infCount do {
    private _pos = [_center, _radius] call WHF_fnc_randomPos;
    if (_pos isEqualTo [0,0]) then {continue};
    private _group = [opfor, "standard", selectRandom [2, 4, 8], _pos, 10] call WHF_fnc_spawnUnits;
    [_group, getPosATL leader _group, 200] call BIS_fnc_taskPatrol;
    _groups pushBack _group;
};

// NOTE: may result in positions being double garrisoned
private _garrisonCount = floor (_radius / 15 + random (count allPlayers / 2));
private _garrisonGroup = [opfor, "standard", _garrisonCount, _center, _radius min 100] call WHF_fnc_spawnUnits;
[units _garrisonGroup select [0, floor (_garrisonCount / 2)], _buildings] call WHF_fnc_garrisonBuildings;
[_garrisonGroup, _center, _radius, true] call WHF_fnc_garrisonUnits;
[[_garrisonGroup], _groups] spawn WHF_fnc_ungarrisonLoop;
_groups pushBack _garrisonGroup;

private _vehicleCount = floor (_radius / 100 + random (count allPlayers / 10));
for "_i" from 1 to _vehicleCount do {
    private _pos = [_center, _radius] call WHF_fnc_randomPos;
    if (_pos isEqualTo [0,0]) then {continue};
    private _group = [opfor, "standard", 1, _pos, 10] call WHF_fnc_spawnVehicles;
    _groups pushBack _group;
    _vehicles append assignedVehicles _group;
};

[_groups] spawn WHF_fnc_attackLoop;

[_groups, _vehicles]
