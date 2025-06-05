/*
Function: WHF_fnc_orderHoldFire

Description:
    Prevent the given group and its current units from firing at targets.
    Function must be executed where the group and units are local.

Parameters:
    Group group:
        The group to order.
    Number force:
        (Optional, default 1)
        Determines how resistant each unit is to firing back at targets:
            1: will not return fire when suppressed.
            2: will not return fire when a unit fires near them.
            3: will not return fire even when hit.

Author:
    thegamecracks

*/
params ["_group", ["_force", 1]];
if (!local _group) exitWith {};

private _enableTargeting = {
    params ["_unit"];
    _unit removeEventHandler [_thisEvent, _thisEventHandler];
    _unit enableAI "AUTOTARGET";
    _unit enableAI "TARGET";
};

_group setCombatMode "WHITE";

{
    private _unit = _x;
    if (!local _unit) then {continue};

    _unit disableAI "AUTOTARGET";
    _unit disableAI "TARGET";
    _unit setUnitCombatMode "WHITE";

    private _handlers = _unit getVariable ["WHF_orderHoldFire_handlers", []];
    {_unit removeEventHandler _x} forEach _handlers;

    private _events = ["Hit", "FiredNear", "Suppressed"];
    _events = _events select [0, count _events - _force];
    _handlers = _events apply {[_x, _unit addEventHandler [_x, _enableTargeting]]};
    _unit setVariable ["WHF_orderHoldFire_handlers", _handlers];
} forEach units _group;
