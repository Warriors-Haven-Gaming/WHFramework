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
    params ["_target"];
    if (!alive _target) exitWith {_searchAltitude};
    private _targetAltitude = _hidePos # 2 max 1;
    linearConversion [30, 150, _distance2D, _targetAltitude, _searchAltitude, true]
};

private _isPiloted = !isNull _pilot;
private _searchAltitude = 20 + random 30;
private _moveDelay = 5;
private _lastMove = time - _moveDelay;

driver _drone setBehaviour "CARELESS";
driver _drone setSkill 1;
_drone flyInHeight [_searchAltitude, true];

private _charge = createVehicle ["DemoCharge_Remote_Ammo", [0,0,0], [], 0, "CAN_COLLIDE"];
_charge attachTo [_drone, [0, 0, -0.1]];
_charge setDir 90;
if (alive _pilot) then {side group _pilot revealMine _charge};

while {alive _drone} do {
    sleep 1;

    if (!alive _charge) exitWith {_drone setDamage [1, false]};
    if (_isPiloted && {!(lifeState _pilot in ["HEALTHY", "INJURED"])}) exitWith {
        _drone setDamage [1, false];
    };

    private _target = _drone findNearestEnemy _drone;
    if (isNull _target) then {continue};

    private _distance = _drone distance _target;
    if (_distance < 10) exitWith {triggerAmmo _charge; sleep 1};

    private _hidePos = _drone getHideFrom _target;
    private _distance2D = _drone distance2D _target;
    _drone flyInHeight [call _nextAltitude, true];

    private _time = time;
    if (_time >= _lastMove + _moveDelay) then {
        private _dir = _drone getDir _target;
        private _aimPos = _hidePos getPos [10, _dir];
        _drone doMove _aimPos;
        _lastMove = _time;
    };
};

if (alive _charge) then {deleteVehicle _charge};
