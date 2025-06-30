/*
Function: WHF_fnc_lowerWeapon

Description:
    Lower a unit's weapon.

Parameters:
    Object unit:
        The unit to lower their weapon.
        Unit must be local.

Author:
    thegamecracks

*/
params ["_unit"];
if (!local _unit) exitWith {};
if (!isNull objectParent _unit) exitWith {};
if ("slow" in animationState _unit) exitWith {};
_unit action ["WeaponOnBack", _unit];
