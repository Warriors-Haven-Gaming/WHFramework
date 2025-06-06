/*
Function: WHF_fnc_assembleFPVDrone

Description:
    Make the given unit assemble an FPV drone.
    Must be executed in scheduled environment.

Parameters:
    Object unit:
        The unit assembling the FPV drone.
        Must be local and have a backpack drone.

Author:
    thegamecracks

*/
params ["_unit"];
if (!local _unit) exitWith {};
if !(lifeState _unit in ["HEALTHY", "INJURED"]) exitWith {};

private _drone = [backpack _unit] call WHF_fnc_getBackpackDrone;
if (_drone isEqualTo "") exitWith {};

_unit playActionNow "PutDown";
sleep 1.25;

private _pos = _unit getRelPos [2, 0] vectorAdd [0, 0, getPosATL _unit # 2];
_drone = createVehicle [_drone, _pos, [], 0, "CAN_COLLIDE"];
_drone setDir getDir _unit;
private _group = side group _unit createVehicleCrew _drone;
if (isNull _group) exitWith {};

removeBackpack _unit;

[_drone, _unit] spawn WHF_fnc_FPVDroneLoop;

[_drone] remoteExec ["WHF_fnc_disableUAVConnectability", WHF_globalPlayerTarget, _drone];
[_drone] remoteExec ["WHF_fnc_queueGCDeletion", 2];
