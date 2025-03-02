/*
Function: WHF_fnc_checkVehicleLock

Description:
    Check if a unit is allowed to enter a vehicle in the given role.

Parameters:
    Object unit:
        The unit to check.
    Object vehicle:
        The vehicle to enter.
    String role:
        The vehicle role to enter. Must be one of "driver", "gunner", "turret", or "cargo".

Returns:
    String
        If the vehicle is locked, a string containing the reason is returned.
        Otherwise, an empty string is returned.

Author:
    thegamecracks

*/
params ["_unit", "_vehicle", "_role"];

if (isNull _unit) exitWith {""};

private _lock = switch (_role) do {
    case "driver": {_vehicle getVariable "WHF_vehicleLock_driver"};
    case "gunner": {_vehicle getVariable "WHF_vehicleLock_gunner"};
    case "turret": {_vehicle getVariable "WHF_vehicleLock_gunner"};
    case "cargo": {_vehicle getVariable "WHF_vehicleLock_cargo"};
    default {};
};
if (isNil "_lock") exitWith {""};

switch (_lock # 0) do {
    case "role": {
        private _roles = _lock # 1;
        private _unitRole = _unit getVariable "WHF_role";
        if (!isNil "_unitRole" && {_unitRole in _roles}) exitWith {""};
        localize "$STR_WHF_vehicleLock"
    };
    case "uid": {
        private _uids = _lock # 1;
        if (getPlayerUID player in _uids) exitWith {""};
        localize "$STR_WHF_vehicleLock"
    };
    default {""};
}
