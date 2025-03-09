/*
Function: WHF_fnc_initIncapacitatedHandlers

Description:
    Sets up player damage handlers for incapacitation.

Author:
    thegamecracks

*/
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) exitWith {};
player addEventHandler ["HandleDamage", {call {
    params ["_unit", "", "_damage", "_source", "", "_hitIndex", "_instigator"];
    if (lifeState _unit isEqualTo "INCAPACITATED") exitWith {};
    if (isNull _instigator) then {_instigator = _source};

    // Check for fatal wounds to body, head, or unknown part
    if !(_hitIndex in [7, 2, -1]) exitWith {_damage min 0.95};
    if (_damage < 0.95) exitWith {};

    if (isDamageAllowed _unit) then {
        _unit allowDamage false;
        private _jipID = netId _unit + ":incapUnit";
        [_unit, _instigator] remoteExec ["WHF_fnc_incapUnit", 0, _jipID];

        if (_hitIndex isEqualTo 2 && {_unit isEqualTo focusOn}) then {
            0 spawn WHF_fnc_headshotEffects;
        };
    };
    0.95
}}];
