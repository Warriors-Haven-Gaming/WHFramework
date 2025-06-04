/*
Function: WHF_fnc_msnSecureCacheReinforcements

Description:
    Spawn reinforcements around the cache.

Parameters:
    Position2D center:
        The center of the mission.
    Number radius:
        The radius of the mission.
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
params ["_center", "_radius", "_factionA", "_factionB", "_groups", "_vehicles"];

private _reinforceUnits = {
    private _pos = [_center, [_radius, _radius * 2]] call WHF_fnc_randomPosHidden;
    if (_pos isEqualTo [0,0]) exitWith {};

    // TODO: use WHF_fnc_spawnUnitGroups
    private _quantity = selectRandom [2, 4, 6, 8];
    private _group = [opfor, _standard, _quantity, _pos, 10] call WHF_fnc_spawnUnits;
    call _attackWaypoint;

    _groups pushBack _group;
};

private _reinforceVehicles = {
    private _group = [
        opfor,
        _standard,
        _standard,
        1,
        _center,
        [_radius, _radius * 2],
        ["hidden"]
    ] call WHF_fnc_spawnVehicles;

    call _attackWaypoint;
    _groups pushBack _group;
    _vehicles append assignedVehicles _group;
};

private _attackWaypoint = {
    _group setBehaviourStrong "AWARE";
    _group setSpeedMode "FULL";

    if (count _targets < 1) exitWith {};
    private _target = selectRandom _targets;
    _group reveal [_target, 4];

    private _waypoint = _group addWaypoint [_target, -1];
    _waypoint waypointAttachObject _target;
    _waypoint setWaypointType "DESTROY";
};

private _standard = [["standard", _factionA], ["standard", _factionB]];

private _targets = units blufor inAreaArray [_center, _radius, _radius, 0, false];
for "_i" from 1 to 3 + random 5 do {call _reinforceUnits};
for "_i" from 1 to 1 + random 4 do {call _reinforceVehicles};
