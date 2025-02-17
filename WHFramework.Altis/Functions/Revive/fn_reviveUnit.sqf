/*
Function: WHF_fnc_reviveUnit

Description:
    Revives the given unit.
    Function must be executed where the unit is local.

Parameters:
    Object unit:
        The unit to be revived.

Author:
    thegamecracks

*/
params ["_unit"];
if (!local _unit) exitWith {};
_unit setDamage 0;
_unit setCaptive false;
_unit setUnconscious false;
_unit allowDamage true;
