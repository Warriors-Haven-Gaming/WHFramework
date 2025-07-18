/*
Function: WHF_fnc_initVehicleLockHandlers

Description:
    Set up vehicle lock handlers for a given unit.

Parameters:
    Object unit:
        (Optional, default player)
        The unit to add handlers to.

Author:
    thegamecracks

*/
params [["_unit", player]];

// NOTE: this function runs in postInit so it must tolerate the
//       arguments ["postInit", didJIP].
if (_unit isEqualTo "postInit") then {_unit = player};
if (isNull _unit) exitWith {};

_unit addEventHandler ["GetInMan", {
    params ["_unit", "_role", "_vehicle"];
    if (!local _unit) exitWith {};

    private _onAllowed = {
        _unit setVariable ["WHF_vehicleLock_lastSeat", switch (_role) do {
            case "driver": {["driver"]};
            case "commander";
            case "gunner": {["gunner", _vehicle unitTurret _unit]};
            case "cargo": {["cargo", _vehicle getCargoIndex _unit]};
            default {};
        }];
        [_vehicle] call WHF_fnc_addVehicleLockCopilotHandlers;
    };

    private _reason = [_unit, _vehicle, _role] call WHF_fnc_checkVehicleLock;
    if (_reason isEqualTo "") exitWith {call _onAllowed};

    moveOut _unit;
    unassignVehicle _unit;
    if (_unit isEqualTo focusOn) then {50 cutText [_reason, "PLAIN DOWN", 0.5]};
}];

_unit addEventHandler ["SeatSwitchedMan", {
    params ["_unit", "", "_vehicle"];
    if (!local _unit) exitWith {};

    private _onAllowed = {
        _unit setVariable ["WHF_vehicleLock_lastSeat", switch (_role # 0) do {
            case "driver": {["driver"]};
            case "turret": {["gunner", _vehicle unitTurret _unit]};
            case "cargo": {["cargo", _vehicle getCargoIndex _unit]};
            default {};
        }];
    };

    private _role = assignedVehicleRole _unit;
    if (_role isEqualTo []) exitWith {};

    private _reason = [_unit, _vehicle, _role # 0] call WHF_fnc_checkVehicleLock;
    if (_reason isEqualTo "") exitWith {call _onAllowed};

    moveOut _unit;
    unassignVehicle _unit;
    if (_unit isEqualTo focusOn) then {50 cutText [_reason, "PLAIN DOWN", 0.5]};

    // It would be nice if we could cancel the seat switch directly...
    private _lastSeat = _unit getVariable "WHF_vehicleLock_lastSeat";
    if (isNil "_lastSeat") exitWith {};
    switch (_lastSeat # 0) do {
        case "driver": {_unit moveInDriver _vehicle};
        case "gunner": {
            private _turretPath = _lastSeat # 1;
            if (_turretPath isEqualTo []) then {_unit moveInGunner _vehicle}
            else {_unit moveInTurret [_vehicle, _turretPath]};
        };
        case "cargo": {
            private _cargoIndex = _lastSeat # 1;
            if (_cargoIndex < 0) then {_unit moveInCargo _vehicle}
            else {_unit moveInCargo [_vehicle, _cargoIndex]};
        };
    };
}];
