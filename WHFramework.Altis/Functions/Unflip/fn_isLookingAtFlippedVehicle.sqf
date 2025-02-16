/*
Function: WH_fnc_isLookingAtFlippedVehicle

Description:
    Checks if the player is looking at a vehicle that can be unflipped.

Returns:
    Boolean

Author:
    thegamecracks

*/
getCursorObjectParams params ["_vehicle", "", "_distance"];
if (!alive _vehicle) exitWith {false};
if (_distance > 2) exitWith {false};
if ({alive _x} count crew _vehicle > 0) exitWith {false};
if (
    ["LandVehicle", "Reammobox_F", "Air", "Ship"]
    findIf {_vehicle isKindOf _x} isEqualTo -1
) exitWith {false};

private _pos = getPosASL _vehicle;
private _surfaceNormal = if (surfaceIsWater _pos) then {[0, 0, 1]} else {surfaceNormal _pos};
private _angle = _surfaceNormal vectorDotProduct vectorUp _vehicle;
_angle <= WH_unflip_angle
