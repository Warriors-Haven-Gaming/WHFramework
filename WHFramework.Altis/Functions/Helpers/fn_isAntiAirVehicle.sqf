/*
Function: WHF_fnc_isAntiAirVehicle

Description:
    Check if the given vehicle is likely capable of anti-air.

Parameters:
    Object vehicle:
        The vehicle to check.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_vehicle"];

private _sensors = listVehicleSensors _vehicle;
private _allowedSensors = ["IRSensorComponent", "ActiveRadarSensorComponent"];
if (_sensors findIf {_x # 1 in _allowedSensors} >= 0) exitWith {true};

private _exceptions = [
    "CUP_I_Hilux_metis_NAPA",
    "CUP_I_Hilux_MLRS_NAPA",
    "CUP_Kornet_Base",
    "CUP_Metis_Base",
    "I_G_Offroad_01_AT_F",
    "I_C_Offroad_02_AT_F"
];
if (_exceptions findIf {_vehicle isKindOf _x} >= 0) exitWith {false};

private _weapons = _vehicle weaponsTurret [0];
_weapons findIf {"launcher" in toLowerANSI _x} >= 0
