/*
Function: WHF_fnc_canServiceVehicle

Description:
    Checks if the player is looking at a vehicle that can be serviced.

Returns:
    Boolean

Author:
    thegamecracks

*/
if (!isNull objectParent focusOn) exitWith {false};
if (!WHF_service_enabled) exitWith {false};

private _vehicle = objNull;
private _distance = 0;
private _isTarget = false;
if (isNil "WHF_service_target") then {
    private _params = getCursorObjectParams;
    _vehicle = _params # 0;
    _distance = _params # 2;
} else {
    _vehicle = WHF_service_target;
    _distance = focusOn distance _vehicle;
    _isTarget = true;
};

if (!alive _vehicle) exitWith {false};
if (_distance > 7) exitWith {false};
if (_isTarget) exitWith {true}; // Fast check

private _isLand = _vehicle isKindOf "LandVehicle";
private _isAir = !_isLand && {_vehicle isKindOf "Air"};
private _isShip = !_isLand && !_isAir && {_vehicle isKindOf "Ship"};
if !(_isLand || _isAir || _isShip) exitWith {false};

private _lastService = _vehicle getVariable "WHF_service_last";
private _cooldown = 60;
if (!isNil "_lastService" && {time - _lastService < _cooldown}) exitWith {false};

private _depots = ["Land_RepairDepot_01_base_F"];
private _repairDistance = [25, 50] select _isAir;
if (nearestObjects [_vehicle, _depots, _repairDistance] isEqualTo []) exitWith {false};

true
