/*
Function: WHF_fnc_initIncapacitatedHandlers

Description:
    Sets up player damage handlers for incapacitation.

Author:
    thegamecracks

*/
player addEventHandler ["HandleDamage", {call {
    params ["_unit", "", "", "", "", "_hitIndex"];
    if (lifeState _unit isNotEqualTo "INCAPACITATED") exitWith {};
    if (isDamageAllowed _unit) then {
        _unit allowDamage false;
        _unit setVariable ["WHF_incapacitatedInvincibility", true];
    };
    if (_hitIndex >= 0) then {_unit getHitIndex _hitIndex} else {damage _unit}
}}];
