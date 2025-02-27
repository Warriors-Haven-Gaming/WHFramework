/*
Function: WHF_fnc_spawnVehicles

Description:
    Spawn vehicles at the given position.

Parameters:
    Side side:
        The group's side.
    Array types:
        One or more group types to spawn vehicles from.
        See WHF_fnc_getVehicleTypes for allowed values.
    Number quantity:
        The number of vehicles to spawn.
    PositionATL center:
        The position at which vehicles will spawn around.
    Number radius:
        The radius around the position at which vehicles will spawn around.

Returns:
    Group
        The group that was spawned in.

Author:
    thegamecracks

*/
params ["_side", "_types", "_quantity", "_center", "_radius"];

private _group = createGroup _side;
private _vehicleTypes = _types call WHF_fnc_getVehicleTypes;
private _vehicles = [];
for "_i" from 1 to _quantity do {
    private _vehicle = createVehicle [selectRandom _vehicleTypes, _center, [], _radius, "NONE"];
    _vehicle enableDynamicSimulation true;
    _group addVehicle _vehicle;
    _vehicles pushBack _vehicle;
};
{_group createVehicleCrew _x} forEach _vehicles;
{_x triggerDynamicSimulation false} forEach units _group;
_group setBehaviourStrong "SAFE";
_group setCombatMode "RED";
_group spawn {sleep 1; [_this, true] remoteExec ["enableDynamicSimulation"]};
_group
