/*
Function: WHF_fnc_unitIsReviving

Description:
    Checks if a unit is currently performing a revive.

Parameters:
    Object caller:
        The unit performing the revive.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_caller"];
if (!alive _caller) exitWith {false};
if !(lifeState _caller in ["HEALTHY", "INJURED"]) exitWith {false};
if (isNull (_caller getVariable ["WHF_revive_target", objNull])) exitWith {false};
true
