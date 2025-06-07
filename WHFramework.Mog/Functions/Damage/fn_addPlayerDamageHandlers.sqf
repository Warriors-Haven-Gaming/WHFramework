/*
Function: WHF_fnc_addPlayerDamageHandlers

Description:
    Set up player damage handlers.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) exitWith {};
player addEventHandler ["HandleDamage", {call {
    params ["_unit", "", "_damage", "_source", "", "_hitIndex", "_instigator"];

    _damage = call {
        if (!isNull _source && {isNull _instigator}) exitWith {_damage};

        private _old = if (_hitIndex >= 0) then {_unit getHitIndex _hitIndex} else {damage _unit};
        if (call WHF_fnc_isFriendlyFire) exitWith {_old};

        private _diff = [_damage - _old, WHF_playerDamageScale] call WHF_fnc_scaleDamage;
        _old + _diff
    };
    private _capped = _damage min 0.95;

    if (!isDamageAllowed _unit) exitWith {_capped};
    if (lifeState _unit isEqualTo "INCAPACITATED") exitWith {_capped};

    // Check for fatal wounds to body, head, or unknown part
    if !(_hitIndex in [7, 2, -1]) exitWith {_capped};
    if (_damage < 0.95) exitWith {_capped};

    _unit allowDamage false;
    private _jipID = netId _unit + ":incapUnit";
    if (isNull _instigator) then {_instigator = effectiveCommander _source};
    if (_instigator isEqualTo _unit) then {_instigator = objNull};
    [_unit, _instigator] remoteExec ["WHF_fnc_incapUnit", 0, _jipID];

    if (_hitIndex isEqualTo 2 && {_unit isEqualTo focusOn}) then {
        0 spawn WHF_fnc_headshotEffects;
    };
    _capped
}}];
