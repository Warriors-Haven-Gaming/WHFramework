/*
Function: WHF_fnc_addRespawnVehicle

Description:
    Add a vehicle to the respawn system.
    When adding to an object's init field, all WHF variables
    defined before it will be persisted globally.

Parameters:
    Array vehicle:
        The vehicle to register.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
params ["_vehicle"];

if (isNull _vehicle) exitWith {};
if (typeOf _vehicle isEqualTo "") exitWith {};

// TODO: parameterize vehicle side
_vehicle setVariable ["WHF_vehicle_side", blufor, true];

private _pos = getPosATL _vehicle;
private _radius = sizeOf typeOf _vehicle / 2;
private _objects = [_pos, _radius, [_vehicle]] call WHF_fnc_nearObjectsRespawn;
{_radius = _radius min ((_pos distance _x) - 1)} forEach _objects;
_radius = _radius max 0;

private _animNames = animationNames _vehicle;
private _animations = []; // FIXME: some sources like hidedoor1 on prowler require animate
private _animationSources = _animNames apply {[_x, _vehicle animationSourcePhase _x]};

private _vars =
    allVariables _vehicle
    select {[_x, "whf_"] call WHF_fnc_stringStartsWith}
    apply {[_x, _vehicle getVariable _x, true]};

private _record = createHashMapFromArray [
    ["_type", typeOf _vehicle],
    ["_object", _vehicle],
    ["_pos", _pos],
    ["_dir", getDir _vehicle],
    ["_radius", _radius],
    ["_animations", _animations],
    ["_animationSources", _animationSources],
    ["_vars", _vars],
    ["_respawnAt", -1]
];

WHF_respawn_records pushBack _record;
_vehicle setVariable ["WHF_respawn_data", _record];
_vars pushBack ["WHF_respawn_data", _record, false];
