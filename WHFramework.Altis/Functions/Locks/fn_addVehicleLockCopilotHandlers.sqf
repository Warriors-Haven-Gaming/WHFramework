/*
Function: WHF_fnc_addVehicleLockCopilotHandlers

Description:
    Set up vehicle lock copilot handlers for a given vehicle.

Parameters:
    Object vehicle:
        The vehicle to add handlers to.

Author:
    thegamecracks

*/
params ["_vehicle"];
if (!isNil {_vehicle getVariable "WHF_vehicleLock_copilotID"}) exitWith {};

private _handlerID = _vehicle addEventHandler ["ControlsShifted", {
    params ["_vehicle", "_unit"];

    private _reason = [_unit, _vehicle, "driver"] call WHF_fnc_checkVehicleLock;
    if (_reason isEqualTo "") exitWith {};
    if (WHF_locks_copilot && {
        _vehicle getVariable "WHF_vehicleLock_driver"
        select 0 in ["role"]
    }) exitWith {};
    _reason = localize "$STR_WHF_vehicleLock_copilot";

    _unit action ["SuspendVehicleControl", _vehicle];
    if (_unit isEqualTo focusOn) then {50 cutText [_reason, "PLAIN DOWN", 0.5]};
}];

_vehicle setVariable ["WHF_vehicleLock_copilotID", ["ControlsShifted", _handlerID]];
