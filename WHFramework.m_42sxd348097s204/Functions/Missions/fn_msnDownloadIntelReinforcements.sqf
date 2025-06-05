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
    private _newGroups = [
        opfor,
        [
            [_standard, 2, 8, 0], 0.60,
            [   _recon, 2, 8, 1], 0.20,
            [   _elite, 4, 8, 2], 0.10,
            [  _sniper, 2, 2, 3], 0.10
        ],
        [20, 60] call WHF_fnc_scaleUnitsSide,
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
        _radius,
        ["hidden"]
    ] call WHF_fnc_spawnVehicles;

    [_group] call _attackWaypoint;
    _groups pushBack _group;
    _vehicles append assignedVehicles _group;
};

private _attackWaypoint = {
    params ["_group"];
    private _target = selectRandom _targets;
    _group reveal [_target, 4];

    private _waypoint = _group addWaypoint [_target, -1];
    _waypoint waypointAttachObject _target;
    _waypoint setWaypointType "DESTROY";
    _group setBehaviourStrong "AWARE";
    _group setSpeedMode "FULL";
};

private _standard = [["standard", _faction]];
private _recon = [["recon", _faction]];
private _elite = [["elite", _faction]];
private _sniper = [["sniper", _faction]];

private _targets = units blufor inAreaArray [getPosATL _laptop, 5, 5, 0, false, 5];
if (count _targets < 1) then {_targets = [_laptop]};

private _center = getPosATL _laptop vectorMultiply [1,1,0];
private _radius = [40, 200];
call _reinforceUnits;
private _vehicleCount = [1, 4] call WHF_fnc_scaleUnitsSide;
for "_i" from 1 to _vehicleCount do {call _reinforceVehicles};
