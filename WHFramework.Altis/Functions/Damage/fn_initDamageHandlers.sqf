/*
Function: WHF_fnc_initFriendlyFireHandlers

Description:
    Sets up player damage handlers for friendly fire.

Author:
    thegamecracks

*/
player addEventHandler ["HandleDamage", {call {
    params ["_unit", "", "_damage", "", "", "_hitIndex", "_instigator"];
    if (isNull _instigator) exitWith {};
    // if (isPlayer _instigator) exitWith {};
    if (_hitIndex >= 0) then {
        private _old = _unit getHitIndex _hitIndex;
        private _diff = _damage - _old;
        private _diff = _diff * WHF_playerDamageReduction;
        _old + _diff
    } else {
        private _old = damage _unit;
        private _diff = _damage - _old;
        private _diff = _diff * WHF_playerDamageReduction;
        _old + _diff
    }
}}];
