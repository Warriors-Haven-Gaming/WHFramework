/*
Function: WHF_fnc_haloJump

Description:
    Halo jumps the player at the given location.
    Function must be executed in scheduled environment.

Parameters:
    PositionATL position:
        The position to teleport the player to.
    Number direction:
        (Optional, default nil)
        The direction to face the player after being halo jumped.

Author:
    thegamecracks

*/
params ["_pos", ["_dir", nil]];;

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
_pos set [2, _altitude];

{
    _x setPosATL (_pos vectorAdd [random 50 - 25, random 50 - 25]);
    if (!isNil "_dir") then {_x setDir _dir};

    if (!isPlayer _x || {count _vehicles > 0}) then {_x spawn {
        waitUntil {sleep (0.5 + random 0.5); getPos _this # 2 < WHF_halo_parachuteAltitude_unit};
        [_this] call WHF_fnc_deployParachute;
    }};
} forEach _units;

{
    _x setPosATL (_pos vectorAdd [random 100 - 50, random 100 - 50, (_forEachIndex + 1) * 20]);
    if (!isNil "_dir") then {_x setDir _dir};
    _x spawn {
        waitUntil {sleep (0.5 + random 0.5); getPos _this # 2 < WHF_halo_parachuteAltitude_vehicle};
        [_this] call WHF_fnc_deployParachute;
    };
} forEach _vehicles;

5 fadeSound _soundVolume;
sleep (2 + random 3);

cutText ["", "BLACK IN", 1];
disableUserInput false;
