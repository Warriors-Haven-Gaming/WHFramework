/*
Function: WHF_fnc_initVehicleHandlers

Description:
    Set up vehicle mission event handlers.

Author:
    thegamecracks

*/
if (isRemoteExecuted) exitWith {};
if (!isNil "WHF_initVehicleHandlers") exitWith {};

{_x call WHF_fnc_setupVehicle} forEach vehicles;

addMissionEventHandler ["EntityCreated", {
    params ["_entity"];
    if (!local _entity) exitWith {};
    _entity call WHF_fnc_setupVehicle;
}];

WHF_initVehicleHandlers = true;
