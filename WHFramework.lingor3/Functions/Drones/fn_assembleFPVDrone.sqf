/*
Function: WHF_fnc_assembleFPVDrone

Description:
    Make the given unit assemble an FPV drone.
    Function must be executed in scheduled environment.

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
sleep ([0.75, 1.25] select (stance _unit isEqualTo "PRONE"));

private _pos = _unit getRelPos [2, 0];
_pos set [2, getPosATL _unit # 2];
_drone = createVehicle [_drone, _pos, [], 0, "CAN_COLLIDE"];
_drone setDir getDir _unit;
_drone setVectorUp surfaceNormal _pos;
private _group = side group _unit createVehicleCrew _drone;
if (isNull _group) exitWith {};

removeBackpack _unit;

[_drone, _unit] spawn WHF_fnc_FPVDroneLoop;

[_drone, "ALL"] remoteExec ["WHF_fnc_lockDroneByUID"];
[_drone, -1, 300] remoteExec ["WHF_fnc_queueGCDeletion", 2];
