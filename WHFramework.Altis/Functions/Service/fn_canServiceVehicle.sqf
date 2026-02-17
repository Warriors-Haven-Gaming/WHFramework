/*
Function: WHF_fnc_canServiceVehicle

Description:
    Checks if the player is looking at a vehicle that can be serviced.

Parameters:
    Boolean full:
        (Boolean, default true)
        If false, only a partial check is performed which is faster
        and suitable for action conditions.

Returns:
    Boolean

Author:
    thegamecracks

*/
params [["_full", true, [true]]];
if (!isNull objectParent focusOn) exitWith {false};
if (!WHF_service_enabled) exitWith {false};

private _vehicle = objNull;
private _distance = 0;
private _isTarget = false;
private _isEnemyNear = {
    [focusOn, focusOn, WHF_service_enemy_distance]
        call WHF_fnc_nearEnemies isNotEqualTo []
};
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
if (_full && _isEnemyNear) exitWith {
    50 cutText [localize "$STR_WHF_initServiceAction_enemy", "PLAIN", 0.5];
    false
};
if (_isTarget) exitWith {true}; // Fast check

private _isLand = _vehicle isKindOf "LandVehicle";
private _isAir = !_isLand && {_vehicle isKindOf "Air"};
private _isShip = !_isLand && !_isAir && {_vehicle isKindOf "Ship"};
if !(_isLand || _isAir || _isShip) exitWith {false};

private _lastService = _vehicle getVariable "WHF_service_last";
private _cooldown = 60;
if (!isNil "_lastService" && {time - _lastService < _cooldown}) exitWith {false};

private _depots = ["Land_RepairDepot_01_base_F"];
private _repairDistance = [25, 50] select !_isLand;
if (nearestObjects [_vehicle, _depots, _repairDistance] isEqualTo []) exitWith {false};

true
