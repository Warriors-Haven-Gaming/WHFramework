/*
Function: WHF_fnc_getUnitTypes

Description:
    Returns an array of unit classnames for one or more given types.
    If none of the types are valid, an empty array is returned.

Parameters:
    Array types:
        One or more group types to return.

Returns:
    Array

Author:
    thegamecracks

*/
if (isNil "_this") exitWith {[]};
if !(_this isEqualType []) then {_this = [_this]};
_this = _this apply {if (_x isEqualType "") then {[_x]} else {_x}};
{_x pushBack WHF_factions_current} forEach (_this select {count _x isEqualTo 1});

private _resolvedTypes = _this apply {
    switch (_x) do {
        case ["civilians", "base"]: {["C_man_1","C_Man_casual_1_F","C_Man_casual_2_F","C_Man_casual_3_F","C_man_sport_1_F","C_man_sport_2_F","C_man_sport_3_F","C_Man_casual_4_F","C_Man_casual_5_F","C_Man_casual_6_F","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_Man_ConstructionWorker_01_Black_F","C_Man_ConstructionWorker_01_Blue_F","C_Man_ConstructionWorker_01_Red_F","C_Man_ConstructionWorker_01_Vrana_F","C_Man_Fisherman_01_F","C_man_hunter_1_F","C_Man_Paramedic_01_F","C_scientist_F","C_Man_UtilityWorker_01_F","C_man_w_worker_F"]};
        case ["standard", "base"]: {["I_C_Soldier_Para_7_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_6_F","I_C_Soldier_Para_8_F","I_C_Soldier_Para_1_F","I_C_Soldier_Para_5_F"]};
        case ["standard", "csat"]: {["O_Soldier_A_F","O_Soldier_AAR_F","O_Soldier_AHAT_F","O_Soldier_AAA_F","O_Soldier_AAT_F","O_Soldier_AR_F","O_medic_F","O_engineer_F","O_soldier_exp_F","O_Soldier_GL_F","O_HeavyGunner_F","O_soldier_M_F","O_Soldier_AA_F","O_Soldier_AT_F","O_soldier_repair_F","O_Soldier_F","O_Soldier_LAT_F","O_Soldier_HAT_F","O_Soldier_lite_F","O_Sharpshooter_F","O_Soldier_SL_F","O_Soldier_TL_F","O_soldier_UAV_F"]};
        case ["standard", "csat_pacific"]: {["O_T_Soldier_A_F","O_T_Soldier_AAR_F","O_T_Soldier_AHAT_F","O_T_Soldier_AAA_F","O_T_Soldier_AAT_F","O_T_Soldier_AR_F","O_T_Medic_F","O_T_Engineer_F","O_T_Soldier_Exp_F","O_T_Soldier_GL_F","O_T_Soldier_M_F","O_T_Soldier_AA_F","O_T_Soldier_AT_F","O_T_Soldier_Repair_F","O_T_Soldier_F","O_T_Soldier_LAT_F","O_T_Soldier_HAT_F","O_T_Soldier_SL_F","O_T_Soldier_TL_F","O_T_Soldier_UAV_F"]};
        case ["standard", "rhsafrf"]: {["rhs_vdv_rifleman","rhs_vdv_rifleman_asval","rhs_vdv_grenadier","rhs_vdv_grenadier_alt","rhs_vdv_rifleman_lite","rhs_vdv_LAT","rhs_vdv_RShG2","rhs_vdv_rifleman_alt","rhs_vdv_sergeant","rhs_vdv_aa","rhs_vdv_at","rhs_vdv_arifleman_rpk","rhs_vdv_arifleman","rhs_vdv_efreitor","rhs_vdv_engineer","rhs_vdv_grenadier_rpg","rhs_vdv_strelok_rpg_assist","rhs_vdv_junior_sergeant","rhs_vdv_machinegunner","rhs_vdv_machinegunner_assistant","rhs_vdv_marksman","rhs_vdv_marksman_asval","rhs_vdv_medic"]};
        case ["standard", "cup_afrf"]: {["CUP_O_RU_Soldier_AR_VDV_EMR","CUP_O_RU_Engineer_VDV_EMR","CUP_O_RU_Explosive_Specialist_VDV_EMR","CUP_O_RU_Soldier_GL_VDV_EMR","CUP_O_RU_Soldier_MG_VDV_EMR","CUP_O_RU_Soldier_Marksman_VDV_EMR","CUP_O_RU_Medic_VDV_EMR","CUP_O_RU_Soldier_AA_VDV_EMR","CUP_O_RU_Soldier_HAT_VDV_EMR","CUP_O_RU_Soldier_VDV_EMR","CUP_O_RU_Soldier_LAT_VDV_EMR","CUP_O_RU_Soldier_AT_VDV_EMR","CUP_O_RU_Soldier_Saiga_VDV_EMR","CUP_O_RU_Soldier_SL_VDV_EMR","CUP_O_RU_Soldier_TL_VDV_EMR"]};
        case ["standard", "cup_afrf_modern"]: {["CUP_O_RUS_M_Soldier_A_Ratnik_Summer","CUP_O_RUS_M_Soldier_AAR_Ratnik_Summer","CUP_O_RUS_M_Soldier_AAR_Ratnik_Summer","CUP_O_RUS_M_Soldier_AHAT_Ratnik_Summer","CUP_O_RUS_M_Soldier_AAT_Ratnik_Summer","CUP_O_RUS_M_Soldier_AR_Ratnik_Summer","CUP_O_RUS_M_Soldier_Medic_Ratnik_Summer","CUP_O_RUS_M_Soldier_Engineer_Ratnik_Summer","CUP_O_RUS_M_Soldier_Exp_Ratnik_Summer","CUP_O_RUS_M_Soldier_GL_Ratnik_Summer","CUP_O_RUS_M_Soldier_MG_Ratnik_Summer","CUP_O_RUS_M_Soldier_Marksman_Ratnik_Summer","CUP_O_RUS_M_Soldier_AA_Ratnik_Summer","CUP_O_RUS_M_Soldier_AT_Ratnik_Summer","CUP_O_RUS_M_Soldier_Repair_Ratnik_Summer","CUP_O_RUS_M_Soldier_Ratnik_Summer","CUP_O_RUS_M_Soldier_LAT_Ratnik_Summer","CUP_O_RUS_M_Soldier_HAT_Ratnik_Summer","CUP_O_RUS_M_Soldier_Lite_Ratnik_Summer","CUP_O_RUS_M_Soldier_SL_Ratnik_Summer","CUP_O_RUS_M_Soldier_TL_Ratnik_Summer"]};
        case ["standard", "cup_npc"]: {["CUP_I_GUE_Soldier_AA","CUP_I_GUE_Ammobearer","CUP_I_GUE_Soldier_AR","CUP_I_GUE_Officer","CUP_I_GUE_Soldier_GL","CUP_I_GUE_Soldier_MG","CUP_I_GUE_Engineer","CUP_I_GUE_Medic","CUP_I_GUE_Soldier_AKS74","CUP_I_GUE_Soldier_AKM","CUP_I_GUE_Soldier_AKSU","CUP_I_GUE_Soldier_LAT","CUP_I_GUE_Soldier_AT","CUP_I_GUE_Soldier_AA2","CUP_I_GUE_Saboteur","CUP_I_GUE_Commander"]};
        default {
            if (_x # 0 isNotEqualTo "standard") exitWith {["standard", _x # 1] call WHF_fnc_getUnitTypes};
            if (_x # 1 isNotEqualTo "base") exitWith {[_x # 0, "base"] call WHF_fnc_getUnitTypes};
            []
        };
    };
};
_resolvedTypes = flatten _resolvedTypes;
_resolvedTypes = _resolvedTypes arrayIntersect _resolvedTypes;
_resolvedTypes
