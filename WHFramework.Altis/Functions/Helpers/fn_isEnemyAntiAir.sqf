/*
Function: WHF_fnc_isEnemyAntiAir

Description:
    Check if the given vehicle is active, hostile, and likely capable of anti-air.

Parameters:
    Object vehicle:
        The vehicle to check.
    Object unit:
        The unit to test hostility towards.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_vehicle", "_unit"];
if (!someAmmo _vehicle) exitWith {false};
if (!canFire _vehicle) exitWith {false};

private _crew = crew _vehicle;
if (count crew _vehicle < 1) exitWith {false};
if !([side group _unit, side group (_crew # 0)] call BIS_fnc_sideIsEnemy) exitWith {false};

private _sensors = listVehicleSensors _vehicle;
private _allowedSensors = ["IRSensorComponent", "ActiveRadarSensorComponent"];
if (_sensors findIf {_x # 1 in _allowedSensors} >= 0) exitWith {true};

if (typeOf _vehicle in ["I_G_Offroad_01_AT_F", "I_C_Offroad_02_AT_F"]) exitWith {false};

private _weapons = _vehicle weaponsTurret [0];
_weapons findIf {"launcher" in toLowerANSI _x} >= 0
