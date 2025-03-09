/*
Function: WHF_fnc_cruiseActionAdjust

Description:
    Adjust the current cruise control speed on the player's vehicle.

Parameters:
    Boolean increment:
        If true, speed is increased, else speed is decreased.

Author:
    thegamecracks

*/
if (isClass (configFile >> "CfgPatches" >> "ace_vehicles")) exitWith {};
params ["_increment"];

private _vehicle = objectParent focusOn;
if (currentPilot _vehicle isNotEqualTo focusOn) exitWith {};

getCruiseControl _vehicle params ["_speedKPH"];
if (_speedKPH <= 0) then {call WHF_fnc_cruiseAction};
getCruiseControl _vehicle params ["_speedKPH"];
if (_speedKPH <= 0) exitWith {};
private _step = if (_increment) then {5} else {-5};

_vehicle setCruiseControl [_speedKPH + _step max 5, true];
playSoundUI ["click"];
