/*
Function: WHF_fnc_isEngineer

Description:
    Check if the given unit is an engineer.

Parameters:
    Object unit:
        The unit to check.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_unit"];
if (_unit getUnitTrait "engineer") exitWith {true};
if (!isClass (configFile >> "CfgPatches" >> "ace_repair")) exitWith {false};
_unit call ace_repair_fnc_isEngineer
