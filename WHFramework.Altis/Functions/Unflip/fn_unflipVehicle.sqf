/*
Function: WH_fnc_unflipVehicle

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

private _pos = getPosATL _vehicle findEmptyPosition [5, WH_unflip_radius, typeOf _vehicle];
if (_pos isEqualTo []) exitWith {
    if (isRemoteExecuted) then {
        remoteExec ["WH_fnc_showInsufficientRoomToUnflip", remoteExecutedOwner];
    } else {
        call WH_fnc_showInsufficientRoomToUnflip;
    };
};

_vehicle setPos _pos;
