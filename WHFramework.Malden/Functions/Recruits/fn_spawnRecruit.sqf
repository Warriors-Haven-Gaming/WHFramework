/*
Function: WHF_fnc_spawnRecruit

Description:
    Spawns an AI recruit for the player.

Parameters:
    PositionATL position:
        The position to spawn the recruit on.
    String role:
        The role of the recruit.

Author:
    thegamecracks

*/
params ["_position", "_role"];
private _aiCount = {!isPlayer _x} count units focusOn;
if (_aiCount >= WHF_recruits_limit) exitWith {
    hint format [localize "$STR_WHF_spawnRecruit_limit", WHF_recruits_limit];
};

private _recruitCount = {!isNil {_x getVariable "WHF_recruiter"}} count allUnits;
if (_recruitCount >= WHF_recruits_limit_global) exitWith {
    hint format [localize "$STR_WHF_spawnRecruit_limit_global", WHF_recruits_limit_global];
};

group focusOn setSpeedMode "FULL";

private _type = switch (_role) do {
    case "aa": {"B_soldier_AA_F"};
    case "at": {"B_soldier_AT_F"};
    case "autorifleman": {"B_soldier_AR_F"};
    case "engineer": {"B_engineer_F"};
    case "medic": {"B_medic_F"};
    default {"B_Soldier_F"};
};

private _unit = group focusOn createUnit [_type, _position, [], 0, "NONE"];
[_unit] joinSilent group focusOn;
_unit enableStamina WHF_fitness_stamina;
_unit setCustomAimCoef WHF_fitness_sway;
_unit setDir (_position getDir focusOn);
_unit setSkill WHF_recruits_skill;
_unit setVariable ["WHF_recruiter", getPlayerUID player, true];
_unit setVariable ["WHF_role", _role, true];
[_unit, _role] call WHF_fnc_setRoleTraits;

if (surfaceIsWater _position) then {doStop _unit};

private _loadout = [_role] call WHF_fnc_getLastLoadout;
if (_loadout isNotEqualTo []) then {[_unit, _loadout] spawn WHF_fnc_setUnitLoadout};
_unit call WHF_fnc_addRecruitLoadoutAction;

private _target = WHF_globalPlayerTarget;
private _voice = if (WHF_recruits_speaker in [2, 3]) then {"NoVoice"} else {
    selectRandom WHF_recruits_speaker_types
};
private _speakerJIPID = netId _unit + ":WHF_setSpeaker";
[_unit, _voice] remoteExec ["WHF_fnc_setSpeaker", _target, _speakerJIPID];

[_unit] call WHF_fnc_initVehicleLockHandlers;
if (!isClass (configFile >> "CfgPatches" >> "ace_medical")) then {
    [_unit] call WHF_fnc_addRecruitDamageHandlers;
    _unit setVariable ["WHF_reviveActionAuto_script", _unit spawn WHF_fnc_reviveActionAuto];

    _unit spawn {
        scriptName "WHF_fnc_spawnRecruit_autoHeal";
        while {true} do {
            sleep (10 + random 10);
            if (!alive _this) then {break};
            if (!isPlayer leader _this) then {continue};
            if !(lifeState _this in ["HEALTHY", "INJURED"]) then {continue};
            if (_this getHit "legs" < 0.5) then {continue};

            private _types = ["FirstAidKit"];
            if (_this getUnitTrait "medic") then {_types pushBack "Medikit"};
            private _canHeal = {_x call BIS_fnc_itemType select 1 in _types};
            if (items _this findIf _canHeal < 0) then {continue};

            _this action ["HealSoldierSelf", _this];

            // For whatever reason, if we make them heal while prone,
            // they'll indefinitely stop moving until they stand up
            if (stance _this isEqualTo "PRONE") then {_this playAction "Crouch"};
        };
    };
};
