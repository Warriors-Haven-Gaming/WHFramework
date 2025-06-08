/*
Function: WHF_fnc_addRecruitDamageHandlers

Description:
    Set up recruit damage handlers.

Parameters:
    Object recruit:
        The recruit to add damage handlers to.

Author:
    thegamecracks

*/
params ["_recruit"];
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) exitWith {};
_recruit addEventHandler ["HandleDamage", {call {
    params ["_unit", "", "_damage", "_source", "", "_hitIndex", "_instigator"];
    if (isNull _instigator) then {_instigator = effectiveCommander _source};

    _damage = call {
        if (isNull _instigator) exitWith {_damage};
        if (!isDamageAllowed _unit) exitWith {_damage};
        if (lifeState _unit isEqualTo "INCAPACITATED") exitWith {_damage};
        // if (isPlayer _instigator) exitWith {_damage};

        private _old = if (_hitIndex >= 0) then {_unit getHitIndex _hitIndex} else {damage _unit};
        private _diff = [_damage - _old, WHF_playerDamageScale] call WHF_fnc_scaleDamage;
        _old + _diff
    };

    // Check for fatal wounds to body, head, or unknown part
    if !(_hitIndex in [7, 2, -1]) exitWith {_damage min 0.95};
    if (_damage < 0.95) exitWith {_damage};

    private _canIncap = {
        if (WHF_recruits_incap_noFAKs) exitWith {true};
        if (WHF_recruits_incap_FAKs < 1) exitWith {false};
        count ([items _unit] call WHF_fnc_filterFAKs) >= WHF_recruits_incap_FAKs
    };
    if !(call _canIncap) exitWith {_damage}; // Fatal damage

    _unit allowDamage false;
    private _jipID = netId _unit + ":incapUnit";
    if (_instigator isEqualTo _unit) then {_instigator = objNull};
    [_unit, _instigator] remoteExec ["WHF_fnc_incapUnit", 0, _jipID];
    if (WHF_recruits_incap_FAKs > 0) then {
        [_unit, WHF_recruits_incap_FAKs] spawn WHF_fnc_selfReviveAuto;
    };
    0.95
}}];
