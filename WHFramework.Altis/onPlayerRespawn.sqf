/*
Script: onPlayerRespawn.sqf

Description:
    Executed locally when player respawns.
    https://community.bistudio.com/wiki/Event_Scripts#onPlayerRespawn.sqf

Parameters:
    Object unit:
        The player unit that respawned.

Author:
    thegamecracks

*/
params ["_unit"];

private _loadout = call WHF_fnc_getLastLoadout;
if (_loadout isNotEqualTo []) then {_unit setUnitLoadout _loadout};

_unit enableStamina WHF_fitness_stamina;
_unit setCustomAimCoef WHF_fitness_sway;
_unit setCaptive false;

call WHF_fnc_initParachuteAction;
call WHF_fnc_initServiceAction;
call WHF_fnc_initUnflipAction;
call WHF_fnc_initReviveCancelAction;
