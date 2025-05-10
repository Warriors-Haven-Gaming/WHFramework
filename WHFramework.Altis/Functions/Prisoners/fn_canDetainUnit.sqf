/*
Function: WHF_fnc_canDetainUnit

Description:
    Check if a unit can detain another unit.

Parameters:
    Object caller:
        The unit attempting to detain the target.
    Object target:
        The unit to be detained.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_caller", "_target"];

private _time = time;
private _last = _caller getVariable ["WHF_detain_attempt", _time - WHF_detain_cooldown];
if (_last + WHF_detain_cooldown > _time) exitWith {false};

if (isNull _target) exitWith {false};
if (isPlayer _target) exitWith {false};
if (captive _target) exitWith {false};
if !(_target isKindOf "Man") exitWith {false};
if !(lifeState _caller in ["HEALTHY", "INJURED"]) exitWith {false};
if !(lifeState _target in ["HEALTHY", "INJURED"]) exitWith {false};
if (_caller distance _target > 10) exitWith {false};

private _sideCaller = side group _caller;
private _sideTarget = side group _target;
if (
    _sideTarget isNotEqualTo civilian
    && {[_sideCaller, _sideTarget] call BIS_fnc_sideIsFriendly}
) exitWith {false};

true
