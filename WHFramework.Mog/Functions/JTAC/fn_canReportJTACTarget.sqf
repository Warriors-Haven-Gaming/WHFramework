/*
Function: WHF_fnc_canReportJTACTarget

Description:
    Check if a JTAC can report the given target.

Parameters:
    Object unit:
        The unit reporting the target.
    Object target:
        The target to be reported.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_unit", "_target"];
if (WHF_jtac_tasks_max < 1) exitWith {false};
if (_unit getVariable ["WHF_role", ""] isNotEqualTo "jtac") exitWith {false};
if !(lifeState _unit in ["HEALTHY", "INJURED"]) exitWith {false};
if (!alive _target) exitWith {false};
if (local _unit && {currentWeapon _unit isNotEqualTo binocular _unit}) exitWith {false};
if (["LandVehicle", "Air", "Ship"] findIf {_target isKindOf _x} < 0) exitWith {false};

private _side = side group _unit;
private _commander = effectiveCommander _target;
if !([_side, side group _commander] call BIS_fnc_sideIsEnemy) exitWith {false};

private _tasks = _target getVariable "WHF_jtac_tasks";
if (!isNil "_tasks" && {_side in _tasks}) exitWith {false};

true
