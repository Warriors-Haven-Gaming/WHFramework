/*
Function: WHF_fnc_respawnUnit

Description:
    Respawns the given unit.
    Function must be executed where the unit is local.

Parameters:
    Object unit:
        The unit to be revived.

Author:
    thegamecracks

*/
params ["_unit"];
if (!local _unit) exitWith {};
if (!isPlayer _unit) exitWith {forceRespawn _unit};
if (isMultiplayer) exitWith {forceRespawn _unit};

private _restoreUnit = {
    params ["_unit"];

    _unit call WHF_fnc_reviveUnit;

    // Make unit stand up straight, remoteExec'd since reviveUnit queues its own animation
    [_unit, ["", 1, 0, true]] remoteExec ["switchMove"];

    // NOTE: partially duplicated in onPlayerRespawn.sqf
    private _role = _unit getVariable "WHF_role";
    if (!isNil "_role") then {
        private _loadout = [] call WHF_fnc_getLastLoadout;
        if (_loadout isNotEqualTo []) then {[_unit, _loadout] spawn WHF_fnc_setUnitLoadout};
        [_unit] call WHF_fnc_setRoleTraits;
    };

    private _respawns = [_unit] call WHF_fnc_respawnMarkers;
    if (count _respawns > 0) then {
        private _marker = _respawns # 0;
        _unit setPosASL AGLToASL markerPos [_marker, true];
        _unit setDir markerDir _marker;
    };

    _unit enableStamina WHF_fitness_stamina;
    _unit setCustomAimCoef WHF_fitness_sway;
    _unit setSkill 1;
    _unit setCaptive false;

    if !(_unit isNil "WHF_incapUnit_wasCaptive") then {
        _unit setVariable ["WHF_incapUnit_wasCaptive", nil, true];
    };
};

[_unit, _restoreUnit] spawn {
    params ["_unit", "_restoreUnit"];

    disableUserInput true;

    // For not incapped players, make them act dead
    _unit allowDamage false;
    _unit setCaptive true;
    _unit setUnconscious true;

    private _blur = ppEffectCreate ["DynamicBlur", 474];
    _blur ppEffectEnable true;
    _blur ppEffectAdjust [10];
    _blur ppEffectCommit (1 + random 1);
    2 fadeSound 0;
    sleep 1;

    cutText ["", "BLACK", 1];
    sleep 1;

    disableUserInput false;
    _unit call _restoreUnit;
    sleep 1;

    2 fadeSound 1;
    cutText ["", "BLACK IN", 1];
    _blur ppEffectAdjust [0];
    _blur ppEffectCommit (2 + random 1);
    waitUntil {ppEffectCommitted _blur};

    ppEffectDestroy _blur;
};
