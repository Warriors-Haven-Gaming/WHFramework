/*
Function: WHF_fnc_getUnitLoadout

Description:
    Get a unit loadout, using CBA extended loadouts if available.

Parameters:
    Object unit:
        The unit to return the loadout for.

Returns:
    Array

Author:
    thegamecracks

*/
params ["_unit"];
if (!isNil "CBA_fnc_getLoadout") then {[_unit] call CBA_fnc_getLoadout} else {getUnitLoadout _unit}
