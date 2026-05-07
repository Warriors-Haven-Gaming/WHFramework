/*
Function: WHF_fnc_haloJump

Description:
    Halo jumps the player and nearby recruits to the given location.
    Function must be executed in scheduled environment.

Parameters:
    PositionATL center:
        The position to teleport the player to.
    Number direction:
        (Optional, default nil)
        The direction of the halo jump.
        If not provided, defaults to the direction from the player to the center.

Author:
    thegamecracks

*/
params ["_center", "_direction"];

if (isNil "_direction") then {_direction = getPosATL focusOn getDir _center};

private _area = [focusOn, 100, 100, 0, false, 100];
private _allUnits =
    units focusOn
    select {_x isEqualTo focusOn || {!isPlayer _x && {local _x}}}
    inAreaArray _area;
{_x setUnitFreefallHeight 50} forEach _allUnits;

private _vehicles =
    _allUnits apply {objectParent _x}
    select {local _x && {effectiveCommander _x in _allUnits}};

// NOTE: in localhost, this can steal a bunch of UGVs from the base
_vehicles append (allUnitsUAV select {
    local _x
    && {alive effectiveCommander _x
    && {side group _x isEqualTo side group focusOn}}
} inAreaArray _area);

_vehicles = _vehicles arrayIntersect _vehicles;
_vehicles = _vehicles select {
	(WHF_halo_vehicle_air || {!(_x isKindOf "Air")})
	&& {WHF_halo_vehicle_static || {!(_x isKindOf "StaticWeapon")}}
};
private _units = _allUnits select {isNull objectParent _x};

private _seed = floor random 1000000;
private _players = flatten (_vehicles apply {crew _x}) select {isPlayer _x && {_x isNotEqualTo focusOn}};

focusOn call WHF_fnc_lowerWeapon;
_seed spawn WHF_fnc_haloJumpCut;
[_seed] remoteExec ["WHF_fnc_haloJumpCut", _players];
{[_x, _forEachIndex] spawn {
    params ["_unit", "_i"];
    sleep (0.1 * _i + random 0.5);
    playSound3D [
        selectRandom [
            "a3\sounds_f\characters\ingame\parachute\parachute_rustle_1.wss",
            "a3\sounds_f\characters\ingame\parachute\parachute_rustle_2.wss",
            "a3\sounds_f\characters\ingame\parachute\parachute_rustle_3.wss",
            "a3\sounds_f\characters\ingame\parachute\parachute_rustle_4.wss",
            "a3\sounds_f\characters\ingame\parachute\parachute_rustle_5.wss",
            "a3\sounds_f\characters\ingame\parachute\parachute_rustle_6.wss"
        ],
        _unit
    ];
}} forEach (_units + _vehicles);

// If you're halo jumping aircraft without your engines on...
{_x engineOn true} forEach (_vehicles select {_x isKindOf "Air"});

sleep 3; // CAUTION: unit/vehicle locality can change after this point

private _altitude = [WHF_halo_altitude_vehicle, WHF_halo_altitude_unit] select (_vehicles isEqualTo []);
_center set [2, _altitude];

private _posIndex = 0;
private _getNextPos = {
    params ["_spacing", ["_front", _posIndex % 2 > 0]];
    private _distance = _posIndex * _spacing;
    if (!_front) then {_distance = -_distance};
    private _pos = _center vectorAdd [_distance * sin _direction, _distance * cos _direction];
    _posIndex = _posIndex + 1;
    _pos
};

{
    if (!local _x) then {continue}; // Zeus probably took control

    private _vehicle = objectParent _x;
    if (!isNull _vehicle) then {
        if (_vehicle in _vehicles) then {continue};
        if (!WHF_halo_eject) then {continue} else {moveOut _x; unassignVehicle _x};
    };

    _x setPosATL ([WHF_halo_spacing_unit] call _getNextPos);
    _x setDir _direction;

    if (!isPlayer _x || {_vehicles isNotEqualTo []}) then {_x spawn {
        waitUntil {sleep (0.5 + random 0.5); getPos _this # 2 < WHF_halo_parachuteAltitude_unit};
        [_this] call WHF_fnc_deployParachute;
    }};
} forEach _allUnits;

{
    if (!local _x) then {continue}; // Someone else got into the driver seat >:(

    _x setPosATL ([WHF_halo_spacing_vehicle, false] call _getNextPos);
    _x setDir _direction;

    private _useParachute = true;
    if (_x isKindOf "Air") then {
        _useParachute = false;
        private _speed = [40, 70] select (_x isKindOf "Plane");
        _x setPosATL (getPosATL _x vectorAdd [0, 0, 50]);
        _x setVelocity [sin _direction * _speed, cos _direction * _speed, 10];
    };

    if (_useParachute) then {_x spawn {
        waitUntil {sleep (0.5 + random 0.5); getPos _this # 2 < WHF_halo_parachuteAltitude_vehicle};
        [_this] call WHF_fnc_deployParachute;
    }};
} forEach _vehicles;
