/*
Function: WHF_fnc_msnMainAnnexRegionUnits

Description:
    Generate units and vehicles within the mission area.

Parameters:
    Position2D center:
        The center of the mission area.
    Number radius:
        The radius of the mission area.
    String faction:
        The faction to spawn units from.
    Array buildings:
        (Optional, default [])
        An array of buildings to prioritize garrisoning units first.

Returns:
    Array
        An array containing two elements:
            1. An array of groups that were created.
            2. An array of vehicles that were created.

Author:
    thegamecracks

*/
params ["_center", "_radius", "_faction", ["_buildings", []]];

private _standard = ["standard", _faction];
private _unitTypes = +WHF_missions_annex_units_types;
private _vehicleTypes = WHF_missions_annex_vehicles_types;
private _garrisonTypes = [[_unitTypes # 0 # 0, _faction]];

for "_i" from 0 to (count _unitTypes - 1) step 2 do {
    private _type = _unitTypes # _i # 0;
    _unitTypes # _i set [0, [[_type, _faction]]];
};
_vehicleTypes = _vehicleTypes apply {[_x, _faction]};

private _groups = [];
private _vehicles = [];

private _infCount = 40 + floor (_radius / 8) call WHF_fnc_scaleUnitsMain;
private _infGroups = [opfor, _unitTypes, _infCount, _center, _radius] call WHF_fnc_spawnUnitGroups;
{[_x, getPosATL leader _x, 200] call BIS_fnc_taskPatrol} forEach _infGroups;
_groups append _infGroups;

// NOTE: may result in positions being double garrisoned
private _garrisonCount = 30 + floor (_radius / 15) call WHF_fnc_scaleUnitsMain;
private _garrisonGroup = [opfor, _garrisonTypes, _garrisonCount, _center, _radius min 100] call WHF_fnc_spawnUnits;
[units _garrisonGroup select [0, floor (_garrisonCount / 2)], _buildings] call WHF_fnc_garrisonBuildings;
[_garrisonGroup, _center, _radius, true] call WHF_fnc_garrisonUnits;
[[_garrisonGroup], _groups] spawn WHF_fnc_ungarrisonLoop;
_groups pushBack _garrisonGroup;

private _vehicleCount = 4 + floor (_radius / 70);
_vehicleCount = _vehicleCount * WHF_missions_annex_vehicles call WHF_fnc_scaleUnitsMain;
for "_i" from 1 to _vehicleCount do {
    private _group = [opfor, _vehicleTypes, [_standard], 1, _center, _radius] call WHF_fnc_spawnVehicles;
    [_group, getPosATL leader _group, 200] call BIS_fnc_taskPatrol;
    _groups pushBack _group;
    _vehicles append assignedVehicles _group;
};

private _shipTypes = [["light", _faction], ["heavy", _faction]];
private _shipCount = 1 + floor (_radius / 150);
_shipCount = _shipCount * WHF_missions_annex_vehicles call WHF_fnc_scaleUnitsMain;
for "_i" from 1 to _shipCount do {
    private _group = [opfor, _shipTypes, [_standard], 1, _center, _radius] call WHF_fnc_spawnShips;
    if (count units _group < 1) then {break};
    [_group, getPosASL leader _group, 500] call WHF_fnc_taskWaterPatrol;
    _groups pushBack _group;
    _vehicles append assignedVehicles _group;
};

private _area = [_center, _radius, _radius];
private _maxDistance = 500;
[_groups, _area, _maxDistance] spawn WHF_fnc_attackLoop;

[_groups, _vehicles]
