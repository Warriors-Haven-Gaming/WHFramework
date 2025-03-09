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

private _units = units focusOn select {
    _x isEqualTo focusOn
    || {!isPlayer _x
    && {local _x
    && {focusOn distance _x < 100}}}
};
{_x setUnitFreefallHeight 50} forEach _units;
_units = _units select {isNull objectParent _x};

private _vehicles = _units apply {objectParent _x} select {
    !isNull _x
    && {effectiveCommander _x in _units
    && {!(_x isKindOf "Air")}}
};
_vehicles = _vehicles arrayIntersect _vehicles;

disableUserInput true;
private _seed = floor random 1000000;
private _players = _vehicles apply {crew _x} select {isPlayer _x};
_seed spawn WHF_fnc_haloJumpCut;
{_seed remoteExec ["WHF_fnc_haloJumpCut", _x]} forEach _players;
sleep 3;

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
    private _vehicle = objectParent _x;
    if (!isNull _vehicle && {!(_vehicle in _vehicles)}) then {moveOut _x};

    _x setPosATL ([WHF_halo_spacing_unit] call _getNextPos);
    _x setDir _direction;

    if (!isPlayer _x || {count _vehicles > 0}) then {_x spawn {
        waitUntil {sleep (0.5 + random 0.5); getPos _this # 2 < WHF_halo_parachuteAltitude_unit};
        [_this] call WHF_fnc_deployParachute;
    }};
} forEach _units;

{
    _x setPosATL ([WHF_halo_spacing_vehicle, false] call _getNextPos);
    _x setDir _direction;

    _x spawn {
        waitUntil {sleep (0.5 + random 0.5); getPos _this # 2 < WHF_halo_parachuteAltitude_vehicle};
        [_this] call WHF_fnc_deployParachute;
    };
} forEach _vehicles;

sleep 2;
disableUserInput false;
