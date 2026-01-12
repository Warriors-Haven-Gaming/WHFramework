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
if (["LandVehicle", "Air", "Ship"] findIf {_target isKindOf _x} < 0) exitWith {false};

private _canSpot = switch (true) do {
    case (!local _unit): {true}; // Weapon checks are unreliable on remote units
    case (!isNull objectParent _unit): {
        private _vehicle = objectParent _unit;
        _unit in [gunner _vehicle, commander _vehicle]
    };
    // FIXME: add support for reporting JTAC targets within drones
    //        (requires reworking action to show on other units)
    // case (unitIsUAV remoteControlled _unit): {
    //     private _vehicle = objectParent remoteControlled _unit;
    //     focusOn in [gunner _vehicle, commander _vehicle]
    // };
    default {currentWeapon _unit isEqualTo binocular _unit};
};
if (!_canSpot) exitWith {false};

private _side = side group _unit;
private _commander = effectiveCommander _target;
if !([_side, side group _commander] call BIS_fnc_sideIsEnemy) exitWith {false};

private _tasks = _target getVariable "WHF_jtac_tasks";
if (!isNil "_tasks" && {_side in _tasks}) exitWith {false};

true
