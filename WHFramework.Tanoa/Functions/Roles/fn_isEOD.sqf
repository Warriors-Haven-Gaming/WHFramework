/*
Function: WHF_fnc_isEOD

Description:
    Check if the given unit is an explosive specialist.

Parameters:
    Object unit:
        The unit to check.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_unit"];
if (_unit getUnitTrait "explosiveSpecialist") exitWith {true};
if (!isClass (configFile >> "CfgPatches" >> "ace_common")) exitWith {false};
_unit call ace_common_fnc_isEOD
