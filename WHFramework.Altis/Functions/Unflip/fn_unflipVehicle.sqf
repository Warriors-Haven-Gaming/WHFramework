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
    private _message = "$STR_WHF_showInsufficientRoomToUnflip";
    if (isRemoteExecuted) then {
        _message remoteExec ["WHF_fnc_localizedHint", remoteExecutedOwner];
    } else {
        _message call WHF_fnc_localizedHint;
    };
};

_vehicle setPos _pos;
