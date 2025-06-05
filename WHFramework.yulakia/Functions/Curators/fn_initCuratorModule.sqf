/*
Function: WHF_fnc_initCuratorModule

Description:
    Locally initialize a module for a curator.

Parameters:
    Object module:
        The module to initialize.

Author:
    thegamecracks

*/
params ["_module"];

if !(_module isNil "WHF_curators_init") exitWith {};
_module setVariable ["WHF_curators_init", true];

_module addEventHandler ["CuratorObjectPlaced", {
    params ["", "_entity"];
    {[_x] call WHF_fnc_setUnitSkill} forEach crew _entity;
}];

// WARNING: possible race condition with server-side assignCurator call?
if (isRemoteExecuted) then {
    waitUntil [{getAssignedCuratorLogic player isEqualTo _module}, 10, 1];
};

if (getAssignedCuratorLogic player isEqualTo _module) then {
    [player, activatedAddons] remoteExec ["WHF_fnc_addCuratorAddons", 2];
};
