/*
Function: WHF_fnc_addAPS

Description:
    Add Active Protection System to a vehicle.
    Function must be executed where vehicle is local.

Parameters:
    Object vehicle:
        The vehicle to configure.
    Number ammo:
        The number of charges available for the system.

Author:
    thegamecracks

*/
params ["_vehicle", "_ammo"];
if (!local _vehicle) exitWith {};
if !(_vehicle isKindOf "AllVehicles") exitWith {};
if (_vehicle isKindOf "Man") exitWith {}; // maybe in a future update, wink
if (_ammo < 1) exitWith {};

_vehicle setVariable ["WHF_aps_ammo", _ammo, true];
_vehicle setVariable ["WHF_aps_ammo_max", _ammo, true];
