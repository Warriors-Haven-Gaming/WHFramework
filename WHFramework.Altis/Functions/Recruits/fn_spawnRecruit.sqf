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
private _aiCount = {!isPlayer _x} count units player;
if (_aiCount >= WHF_recruits_limit) exitWith {
    hint format [localize "$STR_WHF_spawnRecruit_limit", WHF_recruits_limit];
};

private _unit = group player createUnit ["B_Soldier_F", _position, [], 0, "NONE"];
_unit enableStamina WHF_fitness_stamina;
_unit setCustomAimCoef WHF_fitness_sway;
_unit setDir (_position getDir player);
_unit setSkill 1;
_unit setVariable ["WHF_recruitOwnedBy", getPlayerUID player, true];

private _loadout = call WHF_fnc_getLastLoadout;
if (_loadout isNotEqualTo []) then {_unit setUnitLoadout _loadout};
