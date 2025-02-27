/*
Function: WHF_fnc_unflipVehicle

Description:
    Unflips the given vehicle.

Parameters:
    Object vehicle:
        The vehicle to be unflipped.
        This must be local to the client calling this function.

Author:
    thegamecracks

*/
params ["_vehicle"];
if (!alive _vehicle) exitWith {};
if (!local _vehicle) exitWith {};

private _pos = getPosATL _vehicle findEmptyPosition [5, WHF_unflip_radius, typeOf _vehicle];
if (_pos isEqualTo []) exitWith {
    private _failedAt = _vehicle getVariable "WHF_unflipVehicle_failedAt";
    private _forceUnflipDuration = 60; // NOTE: must be greater than WHF_unflip_duration
    if (!isNil "_failedAt" && {time < _failedAt + _forceUnflipDuration}) exitWith {
        // Unflip vehicle in-place, and hopefully nothing bad happens
        _vehicle setPos ASLToAGL getPosASL _vehicle;
        _vehicle setVariable ["WHF_unflipVehicle_failedAt", time];
    };

    _vehicle setVariable ["WHF_unflipVehicle_failedAt", time];
    private _message = "$STR_WHF_unflipVehicle_spacing";
    if (isRemoteExecuted) then {
        _message remoteExec ["WHF_fnc_localizedHint", remoteExecutedOwner];
    } else {
        _message call WHF_fnc_localizedHint;
    };
};

_vehicle setPos _pos;
