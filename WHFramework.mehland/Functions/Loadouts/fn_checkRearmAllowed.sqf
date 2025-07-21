/*
Function: WHF_fnc_checkRearmAllowed

Description:
    Check if the given unit is safe to rearm.

Parameters:
    Object unit:
        The unit to rearm.

Returns:
    String
        If the unit is unsafe, a string containing the reason is returned.
        Otherwise, an empty string is returned.

Author:
    thegamecracks

*/
// TODO: maybe add dedicated stringtable keys for this function?
params ["_unit"];

if ([[_unit]] call WHF_fnc_inAreaMission isNotEqualTo []) exitWith {
    localize "$STR_WHF_haloJumpGUI_mission"
};

if ([_unit, _unit, WHF_loadouts_enemy_distance] call WHF_fnc_nearEnemies isNotEqualTo []) exitWith {
    localize "$STR_WHF_haloJumpGUI_enemy"
};

""
