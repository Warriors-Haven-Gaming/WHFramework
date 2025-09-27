/*
Function: WHF_fnc_holsterWeapon

Description:
    Holster a unit's weapon.

Parameters:
    Object unit:
        The unit to holster their weapon.
        Unit must be local.

Author:
    thegamecracks

*/
params ["_unit"];
if (!local _unit) exitWith {};
if (!isNull objectParent _unit) exitWith {};
if (currentWeapon _unit isEqualTo "") exitWith {};
focusOn action ["SwitchWeapon", focusOn, focusOn, -1];
