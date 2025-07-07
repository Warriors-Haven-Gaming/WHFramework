/*
Function: WHF_fnc_canForceRespawnVehicle

Description:
    Check if the given vehicle can be forced to respawn.

Parameters:
    Array vehicle:
        The vehicle to check.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_vehicle"];

if (typeOf _vehicle isEqualTo "") exitWith {false};

if (!isServer && {!local _vehicle}) exitWith {false};
if (hasInterface && {!isNull objectParent focusOn}) exitWith {false};
if (hasInterface && {focusOn distance _vehicle > 5}) exitWith {false};

if (vectorMagnitude velocity _vehicle > 2.5) exitwith {false};
if (crew _vehicle findIf {alive _x} >= 0) exitWith {false};
if (["LandVehicle", "Air", "Ship"] findIf {_vehicle isKindOf _x} < 0) exitWith {false};
if ([focusOn, _vehicle, "driver"] call WHF_fnc_checkVehicleLock isNotEqualTo "") exitWith {false};

if (isRemoteExecuted && {!isServer}) exitWith {false};
if (isRemoteExecuted && {owner _vehicle isNotEqualTo remoteExecutedOwner}) exitWith {false};

true
