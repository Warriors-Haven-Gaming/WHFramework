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

private _allowed = [
    "CUP_B_M6LineBacker_USA_W",
    "CUP_nM1097_Avenger_Base",
    "EF_MRAP_01_LAAD_base",
    "I_LT_01_AA_F"
];
if (_allowed findIf {_vehicle isKindOf _x} >= 0) exitWith {true};

private _exceptions = [
    "APC_Wheeled_02_base_v2_F",
    "CUP_BMP1_base",
    "CUP_BRDM2_Base",
    "CUP_BTR80_Common_Base",
    "CUP_BTR90_Base",
    "CUP_GAZ_Vodnik_Base",
    "CUP_Hilux_Base",
    "CUP_Kornet_Base",
    "CUP_LAV25_Base",
    "CUP_M113New_Base",
    "CUP_M2Bradley_Base",
    "CUP_Metis_Base",
    "CUP_nHMMWV_Base",
    "CUP_StrykerBase",
    "CUP_T72_Base",
    "LT_01_base_F",
    "MRAP_01_base_F",
    "MRAP_03_base_F",
    "Offroad_01_base_F",
    "Offroad_02_base_F"
];
if (_exceptions findIf {_vehicle isKindOf _x} >= 0) exitWith {false};

private _weapons = _vehicle weaponsTurret [0];
_weapons findIf {"launcher" in toLowerANSI _x} >= 0
