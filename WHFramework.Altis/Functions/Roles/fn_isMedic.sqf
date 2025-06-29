/*
Function: WHF_fnc_isMedic

Description:
    Check if the given unit is a medic.

Parameters:
    Object unit:
        The unit to check.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_unit"];
if (_unit getUnitTrait "medic") exitWith {true};
if (!isClass (configFile >> "CfgPatches" >> "ace_common")) exitWith {false};
_unit call ace_common_fnc_isMedic
