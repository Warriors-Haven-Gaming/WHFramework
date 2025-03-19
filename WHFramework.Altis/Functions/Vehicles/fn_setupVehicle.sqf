/*
Function: WHF_fnc_setupVehicle

Description:
    Apply custom modifications to a vehicle.
    Function must be executed where vehicle is local.

Parameters:
    Object vehicle:
        The vehicle to configure.

Author:
    thegamecracks

*/
params ["_vehicle"];
if (!local _vehicle) exitWith {};
if !(_vehicle isKindOf "AllVehicles") exitWith {};
if (_vehicle isKindOf "Man") exitWith {};

// NOTE: only prevents multiple calls for one client, locality transfer will
//       allow re-initialization
if (!isNil {_vehicle getVariable "WHF_setupVehicle_called"}) exitWith {};
_vehicle setVariable ["WHF_setupVehicle_called", true];

switch (true) do {
};
