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
    // TODO: add support for random water positions with Ship vehicles
    private _pos = _center;
    private _special = "NONE";
    if (_radius > 0) then {
        private _empty = [_center, [10, _radius]] call WHF_fnc_randomPos;
        if (_empty isEqualTo [0,0]) exitWith {};
        _pos = _empty;
        _special = "CAN_COLLIDE";
    };

    private _vehicle = createVehicle [selectRandom _vehicleTypes, _pos, [], 0, _special];
    _vehicle setDir random 360;
    _vehicle setVectorUp surfaceNormal getPosATL _vehicle;
    _vehicle enableDynamicSimulation true;
    _group addVehicle _vehicle;
    _vehicles pushBack _vehicle;
};
{_group createVehicleCrew _x} forEach _vehicles;
{
    _x enableStamina false;
    _x triggerDynamicSimulation false;
} forEach units _group;
_group allowFleeing 0;
_group setBehaviourStrong "SAFE";
_group setCombatMode "RED";
_group spawn {sleep 1; [_this, true] remoteExec ["enableDynamicSimulation"]};
_group
