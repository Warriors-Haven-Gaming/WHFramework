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

if (!isNil {_module getVariable "WHF_curators_init"}) exitWith {};
_module setVariable ["WHF_curators_init", true];

_module addEventHandler ["CuratorObjectPlaced", {
    params ["", "_entity"];
    {[_x] call WHF_fnc_setUnitSkill} forEach crew _entity;
}];
