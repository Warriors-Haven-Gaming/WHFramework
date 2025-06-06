/*
Function: WHF_fnc_FPVDroneLoop

Description:
    Attempt to steer a UAV into an enemy target.
    Must be executed in scheduled environment.

Parameters:
    Object drone:
        The drone to be controlled.
    Object pilot:
        (Optional, default objNull)
        The pilot of the drone.
        If not null, the drone will self-destruct when the pilot is killed.

Author:
    thegamecracks

*/
params ["_drone", ["_pilot", objNull]];

private _nextAltitude = {
    if (!alive _target) exitWith {_searchAltitude};
    private _targetAltitude = _hidePos # 2 max 1;
    linearConversion [30, 150, _distance2D, _targetAltitude, _searchAltitude, true]
};

// NOTE: WHF_fpv_targeted is shared between sides, so a drone from BLUFOR and OPFOR
//       would avoid targeting the same unit, even though they shouldn't be communicating
//       with each other.
// NOTE: WHF_fpv_targeted is not broadcasted, so drones from different clients
//       can still end up targeting the same unit.
private _switchTarget = {
    params [["_newTarget", objNull]];
    if (_target isEqualTo _newTarget) exitWith {};

    private _targeted = _target getVariable ["WHF_fpv_targeted", objNull];
    if (_targeted isEqualTo _drone) then {_target setVariable ["WHF_fpv_targeted", nil]};

    _target = _newTarget;
    _target setVariable ["WHF_fpv_targeted", _drone];
};

private _isPiloted = !isNull _pilot;
private _searchAltitude = 20 + random 30;
private _target = objNull;
private _targetDelay = 5;
private _lastTarget = time - _targetDelay;
private _moveDelay = 5;
private _lastMove = time - _moveDelay;
private _linkDelay = 10;
private _lastLink = time - _linkDelay;

driver _drone setBehaviour "CARELESS";
driver _drone setSkill 1;
_drone flyInHeight [_searchAltitude, true];
_drone doMove (_drone getRelPos [500, 0]);
_drone enableWeaponDisassembly false;

private _charge = createVehicle ["DemoCharge_Remote_Ammo", [0,0,0], [], 0, "CAN_COLLIDE"];
_charge attachTo [_drone, [0, 0, -0.1]];
_charge setDir 90;
if (alive _pilot) then {side group _pilot revealMine _charge};

_drone setVariable ["WHF_fpv_charge", _charge];
_drone addEventHandler ["Killed", {
    params ["_drone"];
    private _charge = _drone getVariable ["WHF_fpv_charge", objNull];
    triggerAmmo _charge;
}];

while {alive _drone} do {
    sleep 1;

    if (!local _drone) then {continue};
    if (!alive _charge) exitWith {_drone setDamage [1, false]};
    if (_isPiloted && {!(lifeState _pilot in ["HEALTHY", "INJURED"])}) exitWith {
        _drone setDamage [1, false];
    };

    private _time = time;
    if (_time >= _lastLink + _linkDelay) then {
        private _targets = _pilot targets [true];
        {_drone reveal [_x, 4]} forEach _targets;
        _lastLink = _time;
    };

    if (_time >= _lastTarget + _targetDelay) then {
        private _targets =
            driver _drone targetsQuery [objNull, sideUnknown, "", [], 0]
            select {
                [side group _drone, _x # 2] call BIS_fnc_sideIsEnemy
                && {_x # 1 getVariable ["WHF_fpv_targeted", objNull] in [objNull, _drone]}
            }
            apply {_x # 1};
        if (count _targets < 1) then {[] call _switchTarget; continue};

        private _distanceTargets = [];
        {
            _distanceTargets pushBack [
                _drone distance _x,
                _forEachIndex,
                _x
            ];
        } forEach _targets;

        _distanceTargets sort true;
        [_distanceTargets # 0 # 2] call _switchTarget;
        _lastTarget = _time;
    };
    if (!alive _target) then {continue};

    private _distance = _drone distance _target;
    if (_distance < 10) exitWith {triggerAmmo _charge};

    private _hidePos = _drone getHideFrom _target;
    private _distance2D = _drone distance2D _target;
    _drone flyInHeight [call _nextAltitude, true];

    if (_time >= _lastMove + _moveDelay) then {
        private _dir = _drone getDir _target;
        private _aimPos = _hidePos getPos [10, _dir];
        _drone doMove _aimPos;
        _lastMove = _time;
    };
};

[] call _switchTarget;
// If the drone was killed just before a new iteration started,
// the explosive charge might still be in the middle of triggering.
// Wait a second first, then check to see if it needs to be deleted.
sleep 1;
if (alive _charge) then {deleteVehicle _charge};
