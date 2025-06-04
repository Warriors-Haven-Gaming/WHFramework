/*
Function: WHF_fnc_msnDownloadIntelReinforcements

Description:
    Spawn reinforcements around the intel building.

Parameters:
    Object laptop:
        The intel laptop.
    String faction:
        The faction to spawn units from.
    Array groups:
        An array to append groups to.
        Useful for garbage collection.
    Array vehicles:
        An array to append vehicles to.
        Useful for garbage collection.

Author:
    thegamecracks

*/
params ["_laptop", "_faction", "_groups", "_vehicles"];

private _reinforceUnits = {
    private _pos = [_center, _radius] call WHF_fnc_randomPosHidden;
    if (_pos isEqualTo [0,0]) exitWith {};

    private _quantity = selectRandom [2, 4, 6, 8];
    private _group = [opfor, [_standard], _quantity, _pos, 10] call WHF_fnc_spawnUnits;
    call _attackWaypoint;

    _groups pushBack _group;
};

private _reinforceVehicles = {
    private _group = [
        opfor,
        [_standard],
        [_standard],
        1,
        _center,
        _radius,
        ["hidden"]
    ] call WHF_fnc_spawnVehicles;

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

private _standard = ["standard", _faction];

private _targets = units blufor inAreaArray [getPosATL _laptop, 5, 5, 0, false, 5];
if (count _targets < 1) then {_targets = [_laptop]};

private _center = getPosATL _laptop vectorMultiply [1,1,0];
private _radius = [40, 200];
for "_i" from 1 to 3 + random 5 do {call _reinforceUnits};
for "_i" from 1 to 1 + random 4 do {call _reinforceVehicles};
