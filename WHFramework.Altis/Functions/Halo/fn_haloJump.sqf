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
params ["_center", "_direction"];;

if (isNil "_direction") then {_direction = getPosATL player getDir _center};

disableUserInput true;
cutText ["", "BLACK", 2];
private _soundVolume = soundVolume;
2 fadeSound 0;
sleep 2;

playSoundUI ["surrender_fall"];
playSoundUI ["Planes_Passby", 0.2];
sleep (0.75 + random 0.5);

playSoundUI ["UAV_05_tailhook_up_sound"];

private _units = units player select {
    _x isEqualTo player
    || {!isPlayer _x
    && {local _x
    && {player distance _x < 100}}}
};
private _vehicles = _units apply {objectParent _x} select {!isNull _x && {effectiveCommander _x in _units}};
_vehicles = _vehicles arrayIntersect _vehicles;

{_x setUnitFreefallHeight 50} forEach _units;
_units = _units select {isNull objectParent _x};

private _altitude = if (count _vehicles > 0) then {WHF_halo_altitude_vehicle} else {WHF_halo_altitude_unit};
_center set [2, _altitude];

private _posIndex = 0;
private _getNextPos = {
    params [["_front", _posIndex % 2 > 0]];
    private _distance = _posIndex * WHF_halo_spacing;
    if (!_front) then {_distance = -_distance};
    private _pos = _center vectorAdd [_distance * sin _direction, _distance * cos _direction];
    _posIndex = _posIndex + 1;
    _pos
};

{
    _x setPosATL ([] call _getNextPos);
    _x setDir _direction;

    if (!isPlayer _x || {count _vehicles > 0}) then {_x spawn {
        waitUntil {sleep (0.5 + random 0.5); getPos _this # 2 < WHF_halo_parachuteAltitude_unit};
        [_this] call WHF_fnc_deployParachute;
    }};
} forEach _units;

{
    _x setPosATL ([false] call _getNextPos);
    _x setDir _direction;

    _x spawn {
        waitUntil {sleep (0.5 + random 0.5); getPos _this # 2 < WHF_halo_parachuteAltitude_vehicle};
        [_this] call WHF_fnc_deployParachute;
    };
} forEach _vehicles;

5 fadeSound _soundVolume;
sleep (2 + random 3);

cutText ["", "BLACK IN", 1];
disableUserInput false;
