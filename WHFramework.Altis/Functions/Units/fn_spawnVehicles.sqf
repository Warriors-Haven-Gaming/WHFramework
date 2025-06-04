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
    Array unitTypes:
        One or more group types to spawn units from.
        See WHF_fnc_getUnitTypes for allowed values.
    Number quantity:
        The number of vehicles to spawn.
    PositionATL center:
        The position at which vehicles will spawn around.
    Array | Number radius:
        The radius around the position at which vehicles will spawn around.
        An array can be passed to specify the minimum and maximum radius.
    Array flags:
        (Optional, default [])
        An array containing any of the following flags:
            "hidden": Find hidden positions to spawn vehicles.

Returns:
    Group
        The group that was spawned in.

Author:
    thegamecracks

*/
params [
    "_side",
    "_types",
    "_unitTypes",
    "_quantity",
    "_center",
    "_radius",
    ["_flags", []]
];
if (_quantity < 1) exitWith {grpNull};

private _randomPos =
    [WHF_fnc_randomPos, WHF_fnc_randomPosHidden]
    select ("hidden" in _flags);

private _group = createGroup [_side, true];
private _vehicleTypes = _types call WHF_fnc_getVehicleTypes;
private _vehicles = [];
for "_i" from 1 to _quantity do {
    // TODO: add support for random water positions with Ship vehicles
    private _pos = _center;
    private _special = "NONE";
    if (_radius isEqualType [] || {_radius > 0}) then {
        private _empty = [_center, _radius] call _randomPos;
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

    WHF_usedPositions pushBack [_vehicle, 10];
};

{
    private _vehicle = _x;
    private _seats = _vehicle emptyPositions "";
    private _quantity = selectRandom [3, 5, 7] min _seats;
    private _pos = [-random 500, -random 500, 0];
    private _units = [_group, _unitTypes, _quantity, _pos, 0] call WHF_fnc_spawnUnits;
    {_x moveInAny _vehicle} forEach _units;
    {if (isNull objectParent _x) then {deleteVehicle _x}} forEach _units;
} forEach _vehicles;

_group allowFleeing 0;
_group setBehaviourStrong "SAFE";
_group setCombatMode "RED";
_group spawn {sleep 1; [_this, true] remoteExec ["enableDynamicSimulation"]};
_group
