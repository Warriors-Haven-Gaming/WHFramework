/*
Function: WHF_fnc_getGroupUnits

Description:
    Returns an array of unit classnames for one or more given types.
    Note that classnames are not de-duplicated.
    If none of the types are valid, an empty array is returned.

Parameters:
    Array types:
        One or more group types to return. Each element should match one of the following keys:
            ["civilians", "base"]
            ["raiders", "base"]

Returns:
    Array

Author:
    thegamecracks

*/
if (isNil "_this") exitWith {[]};
if ({_x isEqualType ""} count _this > 0) then {_this = [_this]};
{_x pushBack WHF_factions_current} forEach (_this select {count _x isEqualTo 1});

private _resolvedTypes = _this apply {
    switch (_x) do {
        case ["civilians", "base"]: {["C_man_1","C_Man_casual_1_F","C_Man_casual_2_F","C_Man_casual_3_F","C_man_sport_1_F","C_man_sport_2_F","C_man_sport_3_F","C_Man_casual_4_F","C_Man_casual_5_F","C_Man_casual_6_F","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_Man_ConstructionWorker_01_Black_F","C_Man_ConstructionWorker_01_Blue_F","C_Man_ConstructionWorker_01_Red_F","C_Man_ConstructionWorker_01_Vrana_F","C_Man_Fisherman_01_F","C_man_hunter_1_F","C_Man_Paramedic_01_F","C_scientist_F","C_Man_UtilityWorker_01_F","C_man_w_worker_F"]};
        case ["raiders",   "base"]: {["I_C_Soldier_Para_7_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_1_F","I_L_Criminal_SG_F","I_L_Looter_Rifle_F","I_L_Looter_Pistol_F","I_L_Looter_SG_F","I_C_Soldier_Bandit_4_F"]};
        default {
            if (_x # 1 isEqualTo "base") then {[]}
            else {[_x # 0, "base"] call WHF_fnc_getGroupUnits}
        };
    };
};
flatten _resolvedTypes
