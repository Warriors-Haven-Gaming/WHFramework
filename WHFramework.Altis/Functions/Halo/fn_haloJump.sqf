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

private _allUnits = units focusOn select {
    _x isEqualTo focusOn
    || {!isPlayer _x
    && {local _x
    && {focusOn distance _x < 100}}}
};
{_x setUnitFreefallHeight 50} forEach _allUnits;

private _vehicles = _allUnits apply {objectParent _x} select {
    local _x
    && {!(_x isKindOf "Air")
    && {effectiveCommander _x in _allUnits}}
};

// NOTE: in localhost, this can steal a bunch of UGVs from the base
_vehicles append (allUnitsUAV select {
    private _commander = effectiveCommander _x;
    local _x
    && {alive _commander
    && {side group _commander isEqualTo side group focusOn
    && {!(_x isKindOf "Air")
    && {focusOn distance _x < 100}}}}
});

_vehicles = _vehicles arrayIntersect _vehicles;
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
sleep 3; // CAUTION: unit/vehicle locality can change after this point

private _altitude = if (count _vehicles > 0) then {WHF_halo_altitude_vehicle} else {WHF_halo_altitude_unit};
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

    if (!isPlayer _x || {count _vehicles > 0}) then {_x spawn {
        waitUntil {sleep (0.5 + random 0.5); getPos _this # 2 < WHF_halo_parachuteAltitude_unit};
        [_this] call WHF_fnc_deployParachute;
    }};
} forEach _allUnits;

{
    if (!local _x) then {continue}; // Someone else got into the driver seat >:(

    _x setPosATL ([WHF_halo_spacing_vehicle, false] call _getNextPos);
    _x setDir _direction;

    _x spawn {
        waitUntil {sleep (0.5 + random 0.5); getPos _this # 2 < WHF_halo_parachuteAltitude_vehicle};
        [_this] call WHF_fnc_deployParachute;
    };
} forEach _vehicles;
