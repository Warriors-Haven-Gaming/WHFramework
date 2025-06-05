/*
Function: WHF_fnc_addVehicleDamageHandlers

Description:
    Set up vehicle damage handlers.

Parameters:
    Object vehicle:
        The vehicle to add damage handlers to.

Author:
    thegamecracks

*/
params ["_vehicle"];
_vehicle addEventHandler ["HandleDamage", {call {
    params ["_unit", "", "", "", "", "_hitIndex"];
    if (!call WHF_fnc_isFriendlyFire) exitWith {};
    if (_hitIndex >= 0) then {_unit getHitIndex _hitIndex} else {damage _unit}
}}];
