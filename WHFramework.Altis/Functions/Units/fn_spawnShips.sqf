/*
Function: WHF_fnc_spawnShips

Description:
    Spawn ships at the given position.

Parameters:
    Side side:
        The group's side.
    Array types:
        One or more group types to spawn ships from.
        See WHF_fnc_getShipTypes for allowed values.
    Array unitTypes:
        One or more group types to spawn units from.
        See WHF_fnc_getUnitTypes for allowed values.
    Number quantity:
        The number of ships to spawn.
    PositionATL center:
        The position at which ships will spawn around.
    Number radius:
        The radius around the position at which ships will spawn around.
    Array flags:
        (Optional, default [])
        An array containing any of the following flags:
            "": No flags are currently supported.

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

// private _dynamicSimulation = !("noDynamicSimulation" in _flags);

private _group = createGroup [_side, true];
private _shipTypes = _types call WHF_fnc_getShipTypes;
private _vehicles = [];
for "_i" from 1 to _quantity do {
    private _pos = _center;
    private _special = "NONE";
    if (_radius > 0) then {
        private _empty = [_center, 0, _radius, 5, 2, 0, 0, [], [[0,0], [0,0]]] call BIS_fnc_findSafePos;
        if (_empty isEqualTo [0,0]) then {break};
        _pos = _empty;
        _special = "CAN_COLLIDE";
    };

    private _vehicle = createVehicle [selectRandom _shipTypes, _pos, [], 0, _special];
    _vehicle setDir random 360;
    _group addVehicle _vehicle;
    _vehicles pushBack _vehicle;

    // WHF_usedPositions pushBack [_vehicle, 10];
};

{
    private _vehicle = _x;
    private _seats = _vehicle emptyPositions "";
    private _quantity = selectRandom [3, 5, 7] min _seats;
    private _pos = [-random 500, -random 500, 0];
    private _units = [_group, _unitTypes, _quantity, _pos, 0] call WHF_fnc_spawnUnits;
    {_x moveInAny _vehicle} forEach _units;
    deleteVehicle (_units select {isNull objectParent _x});
} forEach _vehicles;

_group allowFleeing 0;
_group setBehaviourStrong "SAFE";
_group setCombatMode "RED";

// FIXME: ships seem to not support dynamic simulation
// if (_dynamicSimulation) then {
//     private _objects = _vehicles + [_group];
//     [_objects, true, 1] spawn WHF_fnc_enableDynamicSimulation;
// };

_group
