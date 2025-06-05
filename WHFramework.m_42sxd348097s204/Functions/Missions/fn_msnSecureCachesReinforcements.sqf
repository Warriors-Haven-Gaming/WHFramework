/*
Function: WHF_fnc_msnSecureCachesReinforcements

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
    private _newGroups = [
        opfor,
        [
            [_standard, 2, 8, 0], 0.60,
            [   _recon, 2, 8, 1], 0.20,
            [   _elite, 4, 8, 2], 0.10,
            [  _sniper, 2, 2, 3], 0.10
        ],
        20 + floor random 41,
        _center,
        _radius,
        ["hidden"]
    ] call WHF_fnc_spawnUnitGroups;

    {[_x] call _attackWaypoint} forEach _newGroups;
    _groups append _newGroups;
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

    [_group] call _attackWaypoint;
    _groups pushBack _group;
    _vehicles append assignedVehicles _group;
};

private _attackWaypoint = {
    params ["_group"];
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
private _recon = [["recon", _factionA], ["recon", _factionB]];
private _elite = [["elite", _factionA], ["elite", _factionB]];
private _sniper = [["sniper", _factionA], ["sniper", _factionB]];

private _targets = units blufor inAreaArray [_center, _radius, _radius, 0, false];
call _reinforceUnits;
for "_i" from 1 to 1 + random 4 do {call _reinforceVehicles};
