/*
Function: WHF_fnc_spawnAircraft

Description:
    Spawn aircrafts at the given position.

Parameters:
    Side side:
        The group's side.
    Array types:
        One or more group types to spawn aircraft from.
        See WHF_fnc_getAircraftTypes for allowed values.
    Number quantity:
        The number of aircraft to spawn.
    PositionATL center:
        The position at which aircraft will spawn around.
    Number radius:
        The radius around the position at which aircraft will spawn around.
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
    "_quantity",
    "_center",
    "_radius",
    ["_flags", []]
];
if (_quantity < 1) exitWith {grpNull};

private _aircraftTypes = _types call WHF_fnc_getAircraftTypes;
if (count _aircraftTypes < 1) exitWith {grpNull};

private _group = createGroup [_side, true];
private _vehicles = [];
private _mapCenter = [worldSize / 2, worldSize / 2, 0];
for "_i" from 1 to _quantity do {
    private _pos = [[[_center, _radius]], []] call BIS_fnc_randomPos;
    if (_pos isEqualTo [0,0]) then {break};
    _pos set [2, _center # 2];

    private _dir = _pos getDir _mapCenter;
    private _type = selectRandom _aircraftTypes;
    private _isFlying = _pos # 2 > 10;
    private _isPlane = _type isKindOf "Plane";
    private _special = ["NONE", "FLY"] select _isFlying;
    private _speed = [50, 80] select _isPlane;

    // HACK: assume caller doesn't want helicopters too high in the air
    if (!_isPlane) then {_pos set [2, _pos # 2 min 250]};

    private _vehicle = objNull;
    isNil {
        _vehicle = createVehicle [_type, _pos, [], 0, _special];
        _vehicle setDir _dir;
        _vehicle setPosATL _pos;
        _vehicle flyInHeight _pos # 2;
        // _vehicle setVehicleRadar 1;

        if (_isFlying) then {
            _vehicle setVelocity [_speed * sin _dir, _speed * cos _dir, 0];
        };
    };

    _group addVehicle _vehicle;
    _vehicles pushBack _vehicle;

    // WHF_usedPositions pushBack [_vehicle, 10];
};

private _faction = _types # 0 # 1;
{
    private _vehicle = _x;
    private _seats = _vehicle emptyPositions "";
    private _quantity = selectRandom [3, 5, 7] min _seats;
    private _pos = [-random 500, -random 500, 0];

    private _pilot = ["pilot_heli", "pilot_jet"] select (_vehicle isKindOf "Plane");
    _pilot = [[_pilot, _faction]];

    private _units = [_group, _pilot, 2, _pos, 0] call WHF_fnc_spawnUnits;
    {_x moveInAny _vehicle} forEach _units;
    deleteVehicle (_units select {isNull objectParent _x});
} forEach _vehicles;

_group allowFleeing 0;
_group setBehaviourStrong "SAFE";
_group setCombatMode "RED";

_group
