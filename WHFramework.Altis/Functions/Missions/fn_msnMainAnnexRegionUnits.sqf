/*
Function: WHF_fnc_msnMainAnnexRegionUnits

Description:
    Generate units and vehicles within the mission area.

Parameters:
    Position2D center:
        The center of the mission area.
    Number radius:
        The radius of the mission area.

Returns:
    Array
        An array containing two elements:
            1. An array of groups that were created.
            2. An array of vehicles that were created.

Author:
    thegamecracks

*/
params ["_center", "_radius"];

private _groups = [];
private _vehicles = [];

private _infCount = floor (_radius / 50 + random (count allPlayers / 10));
for "_i" from 1 to _infCount do {
    private _pos = [_center, _radius] call WHF_fnc_randomPos;
    if (_pos isEqualTo [0,0]) then {continue};
    private _group = [opfor, "standard", selectRandom [2, 4, 8], _pos, 10, ["flashlights"]] call WHF_fnc_spawnUnits;
    [_group, getPosATL leader _group, 200] call BIS_fnc_taskPatrol;
    _groups pushBack _group;
};

private _garrisonCount = floor (_radius / 15 + random (count allPlayers / 2));
private _garrisonGroup = [opfor, "standard", _garrisonCount, _center, 0, ["flashlights"]] call WHF_fnc_spawnUnits;
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
