/*
Function: WHF_fnc_canServiceVehicle

Description:
    Checks if the player is looking at a vehicle that can be serviced.

Returns:
    Boolean

Author:
    thegamecracks

*/
if (!isNull objectParent player) exitWith {false};

getCursorObjectParams params ["_vehicle", "", "_distance"];
if (!alive _vehicle) exitWith {false};
if (_distance > 7) exitWith {false};
if (["LandVehicle", "Air", "Ship"] findIf {_vehicle isKindOf _x} < 0) exitWith {false};

private _lastService = _vehicle getVariable "WHF_lastService";
private _cooldown = 60;
if (!isNil "_lastService" && {time - _lastService < _cooldown}) exitWith {};

private _depots = ["Land_RepairDepot_01_civ_F", "Land_RepairDepot_01_green_F", "Land_RepairDepot_01_tan_F"];
private _repairDistance = 25;
if (nearestObjects [player, _depots, _repairDistance] isEqualTo []) exitWith {false};

true
