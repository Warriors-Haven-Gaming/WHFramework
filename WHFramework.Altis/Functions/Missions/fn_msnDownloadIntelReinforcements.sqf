/*
Function: WHF_fnc_msnDownloadIntelReinforcements

Description:
    Spawn reinforcements around the intel building.

Parameters:
    Object laptop:
        The intel laptop.
    Array groups:
        An array to append groups to.
        Useful for garbage collection.
    Array vehicles:
        An array to append vehicles to.
        Useful for garbage collection.

Author:
    thegamecracks

*/
params ["_laptop", "_groups", "_vehicles"];

private _reinforceUnits = {
    private _pos = [_center, _radius] call WHF_fnc_randomPosHidden;
    if (_pos isEqualTo [0,0]) then {continue};

    private _quantity = selectRandom [2, 4, 6, 8];
    private _group = [opfor, "standard", _quantity, _pos, 10] call WHF_fnc_spawnUnits;
    call _attackWaypoint;

    _groups pushBack _group;
};

private _reinforceVehicles = {
    private _pos = [_center, _radius] call WHF_fnc_randomPosHidden;
    if (_pos isEqualTo [0,0]) then {continue};

    private _group = [opfor, "standard", 1, _pos, 10] call WHF_fnc_spawnVehicles;
    call _attackWaypoint;

    _groups pushBack _group;
    _vehicles append assignedVehicles _group;
};

private _attackWaypoint = {
    private _waypoint = _group addWaypoint [_center, 3];
    _waypoint setWaypointType "DESTROY";
    _group setBehaviourStrong "AWARE";
    _group setSpeedMode "FULL";
};

private _center = getPosATL _laptop vectorMultiply [1,1,0];
private _radius = [40, 200];
for "_i" from 1 to 3 + random 5 do {call _reinforceUnits};
for "_i" from 1 to 1 + random 4 do {call _reinforceVehicles};
