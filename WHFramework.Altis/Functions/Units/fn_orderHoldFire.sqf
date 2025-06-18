/*
Function: WHF_fnc_orderHoldFire

Description:
    Prevent the given group and its current units from firing at
    targets until fired upon.
    Function must be executed where the group and units are local.

Parameters:
    Group group:
        The group to order.

Author:
    thegamecracks

*/
params ["_group"];
if (!local _group) exitWith {};

private _enableTargeting = {
    params ["_unit"];
    _unit removeEventHandler [_thisEvent, _thisEventHandler];
    _unit enableAI "AUTOTARGET";
    _unit enableAI "TARGET";
};

_group setCombatMode "WHITE";

{
    if (!local _x) then {continue};
    _x disableAI "AUTOTARGET";
    _x disableAI "TARGET";
    _x setUnitCombatMode "WHITE";
    _x addEventHandler ["FiredNear", _enableTargeting];
    _x addEventHandler ["Hit", _enableTargeting];
} forEach units _group;
