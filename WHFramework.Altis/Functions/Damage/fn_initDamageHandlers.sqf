/*
Function: WHF_fnc_initDamageHandlers

Description:
    Sets up player damage reduction handlers.

Author:
    thegamecracks

*/
player addEventHandler ["HandleDamage", {call {
    params ["_unit", "", "_damage", "", "", "_hitIndex", "_instigator"];
    if (isNull _instigator) exitWith {};
    // if (isPlayer _instigator) exitWith {};
    private _old = if (_hitIndex >= 0) then {_unit getHitIndex _hitIndex} else {damage _unit};
    private _diff = _damage - _old;
    private _diff = _diff * WHF_playerDamageReduction;
    _old + _diff
}}];
