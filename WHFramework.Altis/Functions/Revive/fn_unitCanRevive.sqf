/*
Function: WHF_fnc_unitCanRevive

Description:
    Checks if a unit can perform a revive.

Parameters:
    Object caller:
        The unit performing the revive.
    Object target:
        The unit to be revived.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_caller", "_target"];
if (!alive _caller) exitWith {false};
if (!alive _target) exitWith {false};
if !(lifeState _caller in ["HEALTHY", "INJURED"]) exitWith {false};
if (lifeState _target isNotEqualTo "INCAPACITATED") exitWith {false};
if (!isNull (_caller getVariable ["WHF_revive_target", objNull])) exitWith {false};
if (!isNull (_target getVariable ["WHF_revive_caller", objNull])) exitWith {false};
true
