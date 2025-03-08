/*
Function: WHF_fnc_cruiseAction

Description:
    Toggle cruise control on the player's vehicle.

Author:
    thegamecracks

*/
if (isClass (configFile >> "CfgPatches" >> "ace_vehicles")) exitWith {};

private _vehicle = objectParent focusOn;
if !(_vehicle isKindOf "LandVehicle") exitWith {};
if (currentPilot _vehicle isNotEqualTo focusOn) exitWith {};

if (getCruiseControl _vehicle # 0 > 0) exitWith {
    _vehicle setCruiseControl [0, true];
    playSoundUI ["click"];
};

private _speedMPS = vectorMagnitude velocity _vehicle;
if (_speedMPS <= 1.39) exitWith {};

private _speedKPH = _speedMPS * 3.6;
_speedKPH = round (_speedKPH / 5) * 5;

_vehicle setCruiseControl [_speedKPH, true];
playSoundUI ["click"];
