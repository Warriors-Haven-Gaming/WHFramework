/*
Function: WHF_fnc_spawnRecruit

Description:
    Spawns an AI recruit for the player.

Parameters:
    PositionATL position:
        The position to spawn the recruit from.

Author:
    thegamecracks

*/
params ["_position"];
private _aiCount = {!isPlayer _x} count units focusOn;
if (_aiCount >= WHF_recruits_limit) exitWith {
    hint format [localize "$STR_WHF_spawnRecruit_limit", WHF_recruits_limit];
};

private _unit = group focusOn createUnit ["B_Soldier_F", _position, [], 0, "NONE"];
[_unit] joinSilent group focusOn;
_unit enableStamina WHF_fitness_stamina;
_unit setCustomAimCoef WHF_fitness_sway;
_unit setDir (_position getDir focusOn);
_unit setSkill WHF_recruits_skill;
_unit setUnitTrait ["engineer", focusOn getUnitTrait "engineer"];
_unit setUnitTrait ["explosiveSpecialist", focusOn getUnitTrait "explosiveSpecialist"];
_unit setUnitTrait ["medic", focusOn getUnitTrait "medic"];
_unit setVariable ["WHF_recruitOwnedBy", getPlayerUID player, true];

private _loadout = call WHF_fnc_getLastLoadout;
if (_loadout isNotEqualTo []) then {_unit setUnitLoadout _loadout};
_unit setVariable ["WHF_recruitLoadout", getUnitLoadout _unit];

if (!isClass (configFile >> "CfgPatches" >> "ace_medical")) then {
    _unit addEventHandler ["HandleDamage", {call {
        params ["_unit", "", "_damage", "", "", "_hitIndex", "_instigator"];
        if (isNull _instigator) exitWith {};
        private _old = if (_hitIndex >= 0) then {_unit getHitIndex _hitIndex} else {damage _unit};
        private _diff = _damage - _old;
        private _diff = _diff * WHF_recruitDamageScale;
        _old + _diff
    }}];
};
