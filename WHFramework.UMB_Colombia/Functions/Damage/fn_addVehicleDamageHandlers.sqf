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

private _setVehicleSide = {
    params ["_vehicle", "", "_unit"];
    if !(_vehicle isNil "WHF_vehicle_side") exitWith {};
    private _side = side group _unit;
    if (_side isEqualTo sideUnknown) exitWith {}; // unit is dead
    _vehicle setVariable ["WHF_vehicle_side", _side];
};

// FIXME: side will desync for JIP clients, is this worth fixing?
_vehicle addEventHandler ["GetIn", _setVehicleSide];
[_vehicle, "", effectiveCommander _vehicle] call _setVehicleSide;

_vehicle addEventHandler ["HandleDamage", {call {
    params ["_unit", "", "", "", "", "_hitIndex"];
    if (!call WHF_fnc_isFriendlyFire) exitWith {};
    if (_hitIndex >= 0) then {_unit getHitIndex _hitIndex} else {damage _unit}
}}];
