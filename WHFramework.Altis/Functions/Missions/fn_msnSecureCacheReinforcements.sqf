/*
Function: WHF_fnc_msnSecureCacheReinforcements

Description:
    Spawn reinforcements around the cache.

Parameters:
    Object cache:
        The weapons cache.
    String factionA:
        The first faction to spawn units from.
    String factionB:
        The second faction to spawn units from.
    Array groups:
        An array to append groups to.
        Useful for garbage collection.
    Array vehicles:
        An array to append vehicles to.
        Useful for garbage collection.

Author:
    thegamecracks

*/
params ["_cache", "_factionA", "_factionB", "_groups", "_vehicles"];

private _reinforceUnits = {
    private _pos = [_center, _radius] call WHF_fnc_randomPosHidden;
    if (_pos isEqualTo [0,0]) exitWith {};

    // TODO: use WHF_fnc_spawnUnitGroups
    private _quantity = selectRandom [2, 4, 6, 8];
    private _group = [opfor, _standard, _quantity, _pos, 10] call WHF_fnc_spawnUnits;
    call _attackWaypoint;

    _groups pushBack _group;
};

private _reinforceVehicles = {
    private _pos = [_center, _radius] call WHF_fnc_randomPosHidden;
    if (_pos isEqualTo [0,0]) exitWith {};

    private _group = [opfor, _standard, _standard, 1, _pos, 10] call WHF_fnc_spawnVehicles;
    call _attackWaypoint;

    _groups pushBack _group;
    _vehicles append assignedVehicles _group;
};

private _attackWaypoint = {
    private _target = selectRandom _targets;
    _group reveal [_target, 4];

    private _waypoint = _group addWaypoint [_target, -1];
    _waypoint waypointAttachObject _target;
    _waypoint setWaypointType "DESTROY";
    _group setBehaviourStrong "AWARE";
    _group setSpeedMode "FULL";
};

private _standard = [["standard", _factionA], ["standard", _factionB]];

// NOTE: radius duplicated from WHF_fnc_msnSecureCache
private _radius = 100;
private _targets = units blufor inAreaArray [getPosATL _cache, _radius, _radius, 0, false];
if (count _targets < 1) then {_targets = [_cache]};

private _center = getPosATL _cache vectorMultiply [1,1,0];
private _radius = [40, 200];
for "_i" from 1 to 3 + random 5 do {call _reinforceUnits};
for "_i" from 1 to 1 + random 4 do {call _reinforceVehicles};
