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

private _factions = call WHF_fnc_allFactions;
{
    _x params ["_type", "_faction"];
    // If this throws an exception, you probably did something like this:
    //     ["standard", "base"] call WHF_fnc_getUnitTypes;
    // When specifying both the unit type and faction, it must be its own
    // element in another array:
    //     [["standard", "base"]] call WHF_fnc_getUnitTypes;
    // If you're not sure where this occurred, run Arma with the -debug flag
    // and you should receive a traceback indicating which scripts led to this
    // ambiguous input.
    if (_type in _factions) then {throw format [
        "Misuse of faction name '%1' as unit type at index %2",
        _type,
        _forEachIndex
    ]};
} forEach _this;

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
        case ["standard", "cup_tk_ins"]: {["CUP_O_TK_INS_Soldier_AA","CUP_O_TK_INS_Soldier_AR","CUP_O_TK_INS_Guerilla_Medic","CUP_O_TK_INS_Soldier_MG","CUP_O_TK_INS_Bomber","CUP_O_TK_INS_Mechanic","CUP_O_TK_INS_Soldier_GL","CUP_O_TK_INS_Soldier","CUP_O_TK_INS_Soldier_FNFAL","CUP_O_TK_INS_Soldier_Enfield","CUP_O_TK_INS_Soldier_AAT","CUP_O_TK_INS_Soldier_AT","CUP_O_TK_INS_Sniper","CUP_O_TK_INS_Soldier_TL"]};
        case ["standard", "nato"]: {["B_Soldier_A_F","B_soldier_AAA_F","B_soldier_AAT_F","B_soldier_AR_F","B_medic_F","B_engineer_F","B_soldier_exp_F","B_Soldier_GL_F","B_HeavyGunner_F","B_soldier_M_F","B_soldier_mine_F","B_soldier_AA_F","B_soldier_AT_F","B_soldier_repair_F","B_Soldier_F","B_soldier_LAT_F","B_Soldier_lite_F","B_soldier_LAT2_F","B_Sharpshooter_F","B_Soldier_SL_F","B_Soldier_TL_F","B_soldier_UAV_F"]};
        case ["standard", "nato_pacific"]: {["B_T_Soldier_A_F","B_T_Soldier_AAA_F","B_T_Soldier_AAT_F","B_T_soldier_AR_F","B_T_medic_F","B_T_engineer_F","B_T_soldier_exp_F","B_T_Soldier_GL_F","B_T_soldier_M_F","B_T_soldier_mine_F","B_T_Soldier_AA_F","B_T_Soldier_AT_F","B_T_soldier_repair_F","B_T_Soldier_F","B_T_Soldier_LAT_F","B_T_Soldier_LAT2_F","B_T_soldier_SL_F","B_T_soldier_TL_F","B_T_soldier_UAV_F"]};
        case ["standard", "cup_usa_woodland"]: {["CUP_B_US_Soldier_AAT_OEFCP","CUP_B_US_Soldier_AHAT_OEFCP","CUP_B_US_Soldier_AT_OEFCP","CUP_B_US_Soldier_HAT_OEFCP","CUP_B_US_Soldier_AR_OEFCP","CUP_B_US_Soldier_Engineer_OEFCP","CUP_B_US_Soldier_Engineer_EOD_OEFCP","CUP_B_US_Soldier_GL_OEFCP","CUP_B_US_Soldier_MG_OEFCP","CUP_B_US_Soldier_Marksman_OEFCP","CUP_B_US_Soldier_Marksman_EBR_OEFCP","CUP_B_US_Medic_OEFCP","CUP_B_US_Soldier_AA_OEFCP","CUP_B_US_Soldier_OEFCP","CUP_B_US_Soldier_ACOG_OEFCP","CUP_B_US_Soldier_LAT_OEFCP","CUP_B_US_Soldier_Light_OEFCP","CUP_B_US_Soldier_Engineer_Sapper_OEFCP","CUP_B_US_Soldier_SL_OEFCP","CUP_B_US_Soldier_TL_OEFCP","CUP_B_US_Soldier_UAV_OEFCP"]};
        case ["standard", "cup_usmc_woodland"]: {["CUP_B_USMC_Soldier_HAT","CUP_B_USMC_Soldier_AT","CUP_B_USMC_Soldier_AR","CUP_B_USMC_Medic","CUP_B_USMC_Engineer","CUP_B_USMC_Soldier_GL","CUP_B_USMC_Soldier_MG","CUP_B_USMC_Soldier_Marksman","CUP_B_USMC_Soldier_AA","CUP_B_USMC_Soldier","CUP_B_USMC_SpecOps_SD","CUP_B_USMC_Soldier_LAT","CUP_B_USMC_SpecOps","CUP_B_USMC_Soldier_SL","CUP_B_USMC_Soldier_TL"]};
        case ["officer", "base"]: {["I_G_Soldier_SL_F"]};
        case ["officer", "csat"]: {["O_officer_F"]};
        case ["officer", "csat_pacific"]: {["O_T_officer_F"]};
        case ["officer", "rhsafrf"]: {["rhs_vdv_officer_armored"]};
        case ["officer", "cup_afrf"]: {["CUP_O_RU_Officer_VDV_EMR"]};
        case ["officer", "cup_afrf_modern"]: {["CUP_O_RU_Officer_VDV_EMR"]};
        case ["officer", "cup_npc"]: {["CUP_I_GUE_Commander"]};
        case ["officer", "cup_tk_ins"]: {["CUP_O_TK_INS_Commander"]};
        case ["officer", "nato"]: {["B_officer_F"]};
        case ["officer", "nato_pacific"]: {["B_T_officer_F"]};
        case ["officer", "cup_usa_woodland"]: {["CUP_B_US_Officer_OEFCP"]};
        case ["officer", "cup_usmc_woodland"]: {["CUP_B_USMC_Officer"]};
        default {
            if !(_x # 0 in ["civilians", "standard"]) exitWith {[["standard", _x # 1]] call WHF_fnc_getUnitTypes};
            if (_x # 1 isNotEqualTo "base") exitWith {[[_x # 0, "base"]] call WHF_fnc_getUnitTypes};
            []
        };
    };
};
_resolvedTypes = flatten _resolvedTypes;
_resolvedTypes = _resolvedTypes arrayIntersect _resolvedTypes;
_resolvedTypes
