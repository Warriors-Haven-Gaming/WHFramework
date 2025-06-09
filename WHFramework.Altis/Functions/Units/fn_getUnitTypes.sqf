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
        case ["standard", "aaf"]: {["I_Soldier_A_F","I_Soldier_AAR_F","I_Soldier_AAA_F","I_Soldier_AAT_F","I_Soldier_AR_F","I_medic_F","I_Soldier_exp_F","I_Soldier_GL_F","I_Soldier_M_F","I_soldier_mine_F","I_Soldier_AA_F","I_Soldier_AT_F","I_Soldier_repair_F","I_soldier_F","I_Soldier_LAT_F","I_Soldier_LAT2_F","I_Soldier_SL_F","I_Soldier_TL_F","I_soldier_UAV_F"]};
        case ["standard", "ldf"]: {["I_E_Soldier_A_F","I_E_Soldier_AAR_F","I_E_Soldier_AAA_F","I_E_Soldier_AAT_F","I_E_Soldier_AR_F","I_E_Medic_F","I_E_Engineer_F","I_E_Soldier_Exp_F","I_E_Soldier_GL_F","I_E_soldier_M_F","I_E_soldier_Mine_F","I_E_Soldier_AA_F","I_E_Soldier_AT_F","I_E_Soldier_Pathfinder_F","I_E_RadioOperator_F","I_E_Soldier_Repair_F","I_E_Soldier_F","I_E_Soldier_LAT_F","I_E_Soldier_LAT2_F","I_E_Soldier_SL_F","I_E_Soldier_TL_F","I_E_Soldier_UAV_F"]};
        case ["standard", "ws_sfia"]: {["O_SFIA_Soldier_AAA_lxWS","O_SFIA_Soldier_AAT_lxWS","O_SFIA_Soldier_AR_lxWS","O_SFIA_medic_lxWS","O_SFIA_exp_lxWS","O_SFIA_Soldier_GL_lxWS","O_SFIA_HeavyGunner_lxWS","O_SFIA_soldier_aa_lxWS","O_SFIA_soldier_at_lxWS","O_SFIA_repair_lxWS","O_SFIA_soldier_lxWS","O_SFIA_soldier_lite_lxWS","O_SFIA_sharpshooter_lxWS","O_SFIA_Soldier_TL_lxWS","O_soldier_UAV_F"]};
        case ["standard", "ws_tura"]: {["O_Tura_deserter_lxWS","O_Tura_enforcer_lxWS","O_Tura_hireling_lxWS","O_Tura_HeavyGunner_lxWS","O_Tura_medic2_lxWS","O_Tura_thug_lxWS","O_Tura_soldier_UAV_lxWS","O_Tura_watcher_lxWS"]};
        case ["standard", "rhsafrf"]: {["rhs_vdv_rifleman","rhs_vdv_rifleman_asval","rhs_vdv_grenadier","rhs_vdv_grenadier_alt","rhs_vdv_rifleman_lite","rhs_vdv_LAT","rhs_vdv_RShG2","rhs_vdv_rifleman_alt","rhs_vdv_sergeant","rhs_vdv_aa","rhs_vdv_at","rhs_vdv_arifleman_rpk","rhs_vdv_arifleman","rhs_vdv_efreitor","rhs_vdv_engineer","rhs_vdv_grenadier_rpg","rhs_vdv_strelok_rpg_assist","rhs_vdv_junior_sergeant","rhs_vdv_machinegunner","rhs_vdv_machinegunner_assistant","rhs_vdv_marksman","rhs_vdv_marksman_asval","rhs_vdv_medic","O_T_Soldier_UAV_F"]};
        case ["standard", "cup_afrf"]: {["CUP_O_RU_Soldier_AR_VDV_EMR","CUP_O_RU_Engineer_VDV_EMR","CUP_O_RU_Explosive_Specialist_VDV_EMR","CUP_O_RU_Soldier_GL_VDV_EMR","CUP_O_RU_Soldier_MG_VDV_EMR","CUP_O_RU_Soldier_Marksman_VDV_EMR","CUP_O_RU_Medic_VDV_EMR","CUP_O_RU_Soldier_AA_VDV_EMR","CUP_O_RU_Soldier_HAT_VDV_EMR","CUP_O_RU_Soldier_VDV_EMR","CUP_O_RU_Soldier_LAT_VDV_EMR","CUP_O_RU_Soldier_AT_VDV_EMR","CUP_O_RU_Soldier_Saiga_VDV_EMR","CUP_O_RU_Soldier_SL_VDV_EMR","CUP_O_RU_Soldier_TL_VDV_EMR"]};
        case ["standard", "cup_afrf_modern"]: {["CUP_O_RUS_M_Soldier_A_Ratnik_Summer","CUP_O_RUS_M_Soldier_AAR_Ratnik_Summer","CUP_O_RUS_M_Soldier_AAR_Ratnik_Summer","CUP_O_RUS_M_Soldier_AHAT_Ratnik_Summer","CUP_O_RUS_M_Soldier_AAT_Ratnik_Summer","CUP_O_RUS_M_Soldier_AR_Ratnik_Summer","CUP_O_RUS_M_Soldier_Medic_Ratnik_Summer","CUP_O_RUS_M_Soldier_Engineer_Ratnik_Summer","CUP_O_RUS_M_Soldier_Exp_Ratnik_Summer","CUP_O_RUS_M_Soldier_GL_Ratnik_Summer","CUP_O_RUS_M_Soldier_MG_Ratnik_Summer","CUP_O_RUS_M_Soldier_Marksman_Ratnik_Summer","CUP_O_RUS_M_Soldier_AA_Ratnik_Summer","CUP_O_RUS_M_Soldier_AT_Ratnik_Summer","CUP_O_RUS_M_Soldier_Repair_Ratnik_Summer","CUP_O_RUS_M_Soldier_Ratnik_Summer","CUP_O_RUS_M_Soldier_LAT_Ratnik_Summer","CUP_O_RUS_M_Soldier_HAT_Ratnik_Summer","CUP_O_RUS_M_Soldier_Lite_Ratnik_Summer","CUP_O_RUS_M_Soldier_SL_Ratnik_Summer","CUP_O_RUS_M_Soldier_TL_Ratnik_Summer","O_T_Soldier_UAV_F"]};
        case ["standard", "cup_npc"]: {["CUP_I_GUE_Soldier_AA","CUP_I_GUE_Ammobearer","CUP_I_GUE_Soldier_AR","CUP_I_GUE_Officer","CUP_I_GUE_Soldier_GL","CUP_I_GUE_Soldier_MG","CUP_I_GUE_Engineer","CUP_I_GUE_Medic","CUP_I_GUE_Soldier_AKS74","CUP_I_GUE_Soldier_AKM","CUP_I_GUE_Soldier_AKSU","CUP_I_GUE_Soldier_LAT","CUP_I_GUE_Soldier_AT","CUP_I_GUE_Soldier_AA2","CUP_I_GUE_Saboteur","CUP_I_GUE_Commander","O_soldier_UAV_F"]};
        case ["standard", "cup_tk"]: {["CUP_O_TK_Soldier_AA","CUP_O_TK_Soldier_AAT","CUP_O_TK_Soldier_AMG","CUP_O_TK_Soldier_HAT","CUP_O_TK_Soldier_AR","CUP_O_TK_Engineer","CUP_O_TK_Soldier_GL","CUP_O_TK_Soldier_MG","CUP_O_TK_Soldier_M","CUP_O_TK_Medic","CUP_O_TK_Soldier","CUP_O_TK_Soldier_Backpack","CUP_O_TK_Soldier_LAT","CUP_O_TK_Soldier_AT","CUP_O_TK_Soldier_SL","O_soldier_UAV_F"]};
        case ["standard", "cup_tk_ins"]: {["CUP_O_TK_INS_Soldier_AA","CUP_O_TK_INS_Soldier_AR","CUP_O_TK_INS_Guerilla_Medic","CUP_O_TK_INS_Soldier_MG","CUP_O_TK_INS_Bomber","CUP_O_TK_INS_Mechanic","CUP_O_TK_INS_Soldier_GL","CUP_O_TK_INS_Soldier","CUP_O_TK_INS_Soldier_FNFAL","CUP_O_TK_INS_Soldier_Enfield","CUP_O_TK_INS_Soldier_AAT","CUP_O_TK_INS_Soldier_AT","CUP_O_TK_INS_Sniper","CUP_O_TK_INS_Soldier_TL","O_soldier_UAV_F"]};
        case ["standard", "nato"]: {["B_Soldier_A_F","B_soldier_AAA_F","B_soldier_AAT_F","B_soldier_AR_F","B_medic_F","B_engineer_F","B_soldier_exp_F","B_Soldier_GL_F","B_HeavyGunner_F","B_soldier_M_F","B_soldier_mine_F","B_soldier_AA_F","B_soldier_AT_F","B_soldier_repair_F","B_Soldier_F","B_soldier_LAT_F","B_Soldier_lite_F","B_soldier_LAT2_F","B_Sharpshooter_F","B_Soldier_SL_F","B_Soldier_TL_F","B_soldier_UAV_F"]};
        case ["standard", "nato_pacific"]: {["B_T_Soldier_A_F","B_T_Soldier_AAA_F","B_T_Soldier_AAT_F","B_T_soldier_AR_F","B_T_medic_F","B_T_engineer_F","B_T_soldier_exp_F","B_T_Soldier_GL_F","B_T_soldier_M_F","B_T_soldier_mine_F","B_T_Soldier_AA_F","B_T_Soldier_AT_F","B_T_soldier_repair_F","B_T_Soldier_F","B_T_Soldier_LAT_F","B_T_Soldier_LAT2_F","B_T_soldier_SL_F","B_T_soldier_TL_F","B_T_soldier_UAV_F"]};
        case ["standard", "ef_mjtf_desert"]: {["EF_B_Marine_AAA_Des","EF_B_Marine_AAT_Des","EF_B_Marine_AR_Des","EF_B_Marine_Medic_Des","EF_B_Marine_Eng_Des","EF_B_Marine_Exp_Des","EF_B_Marine_GL_Des","EF_B_Marine_JTAC_Des","EF_B_Marine_Mark_Des","EF_B_Marine_AA_Des","EF_B_Marine_AT_Des","EF_B_Marine_Repair_Des","EF_B_Marine_R_Des","EF_B_Marine_LAT_Des","EF_B_Marine_LAT2_Des","EF_B_Marine_SL_Des","EF_B_Marine_TL_Des","EF_B_Marine_UAV_Des"]};
        case ["standard", "ef_mjtf_woodland"]: {["EF_B_Marine_AAA_Wdl","EF_B_Marine_AAT_Wdl","EF_B_Marine_AR_Wdl","EF_B_Marine_Medic_Wdl","EF_B_Marine_Eng_Wdl","EF_B_Marine_Exp_Wdl","EF_B_Marine_GL_Wdl","EF_B_Marine_JTAC_Wdl","EF_B_Marine_Mark_Wdl","EF_B_Marine_AA_Wdl","EF_B_Marine_AT_Wdl","EF_B_Marine_Repair_Wdl","EF_B_Marine_R_Wdl","EF_B_Marine_LAT_Wdl","EF_B_Marine_LAT2_Wdl","EF_B_Marine_SL_Wdl","EF_B_Marine_TL_Wdl","EF_B_Marine_UAV_Wdl"]};
        case ["standard", "ws_ion"]: {["B_ION_soldier_AR_lxWS","B_ION_medic_lxWS","B_ION_Soldier_GL_lxWS","B_ION_marksman_lxWS","B_ION_Soldier_lxWS","B_ION_soldier_LAT2_lxWS","B_ION_Soldier_SG_lxWS","B_ION_TL_lxWS","B_ION_soldier_UAV_01_lxWS","B_ION_soldier_UAV_02_lxWS"]};
        case ["standard", "cup_usa_woodland"]: {["CUP_B_US_Soldier_AAT_OEFCP","CUP_B_US_Soldier_AHAT_OEFCP","CUP_B_US_Soldier_AT_OEFCP","CUP_B_US_Soldier_HAT_OEFCP","CUP_B_US_Soldier_AR_OEFCP","CUP_B_US_Soldier_Engineer_OEFCP","CUP_B_US_Soldier_Engineer_EOD_OEFCP","CUP_B_US_Soldier_GL_OEFCP","CUP_B_US_Soldier_MG_OEFCP","CUP_B_US_Soldier_Marksman_OEFCP","CUP_B_US_Soldier_Marksman_EBR_OEFCP","CUP_B_US_Medic_OEFCP","CUP_B_US_Soldier_AA_OEFCP","CUP_B_US_Soldier_OEFCP","CUP_B_US_Soldier_ACOG_OEFCP","CUP_B_US_Soldier_LAT_OEFCP","CUP_B_US_Soldier_Light_OEFCP","CUP_B_US_Soldier_Engineer_Sapper_OEFCP","CUP_B_US_Soldier_SL_OEFCP","CUP_B_US_Soldier_TL_OEFCP","CUP_B_US_Soldier_UAV_OEFCP","B_soldier_UAV_F"]};
        case ["standard", "cup_usmc_woodland"]: {["CUP_B_USMC_Soldier_HAT","CUP_B_USMC_Soldier_AT","CUP_B_USMC_Soldier_AR","CUP_B_USMC_Medic","CUP_B_USMC_Engineer","CUP_B_USMC_Soldier_GL","CUP_B_USMC_Soldier_MG","CUP_B_USMC_Soldier_Marksman","CUP_B_USMC_Soldier_AA","CUP_B_USMC_Soldier","CUP_B_USMC_SpecOps_SD","CUP_B_USMC_Soldier_LAT","CUP_B_USMC_SpecOps","CUP_B_USMC_Soldier_SL","CUP_B_USMC_Soldier_TL","B_T_soldier_UAV_F"]};
        case ["officer", "base"]: {["I_G_Soldier_SL_F"]};
        case ["officer", "csat"]: {["O_officer_F"]};
        case ["officer", "csat_pacific"]: {["O_T_officer_F"]};
        case ["officer", "aaf"]: {["I_officer_F"]};
        case ["officer", "ldf"]: {["I_E_Soldier_MP_F","I_E_Officer_F"]};
        case ["officer", "ws_sfia"]: {["O_SFIA_officer_lxWS"]};
        case ["officer", "ws_tura"]: {["O_Tura_defector_lxWS"]};
        case ["officer", "rhsafrf"]: {["rhs_vdv_officer_armored"]};
        case ["officer", "cup_afrf"]: {["CUP_O_RU_Officer_VDV_EMR"]};
        case ["officer", "cup_afrf_modern"]: {["CUP_O_RU_Officer_VDV_EMR"]};
        case ["officer", "cup_npc"]: {["CUP_I_GUE_Commander"]};
        case ["officer", "cup_tk"]: {["CUP_O_TK_Officer"]};
        case ["officer", "cup_tk_ins"]: {["CUP_O_TK_INS_Commander"]};
        case ["officer", "nato"]: {["B_officer_F"]};
        case ["officer", "nato_pacific"]: {["B_T_officer_F"]};
        case ["officer", "ef_mjtf_desert"]: {["EF_B_Marine_Officer_Des"]};
        case ["officer", "ef_mjtf_woodland"]: {["EF_B_Marine_Officer_Wdl"]};
        case ["officer", "ws_ion"]: {["B_ION_shot_lxWS"]};
        case ["officer", "cup_usa_woodland"]: {["CUP_B_US_Officer_OEFCP"]};
        case ["officer", "cup_usmc_woodland"]: {["CUP_B_USMC_Officer"]};
        case ["crew", "base"]: {["I_C_Soldier_Para_7_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_1_F"]};
        case ["crew", "csat"]: {["O_crew_F"]};
        case ["crew", "csat_pacific"]: {["O_T_Crew_F"]};
        case ["crew", "aaf"]: {["I_crew_F"]};
        case ["crew", "ldf"]: {["I_E_Crew_F"]};
        case ["crew", "ws_sfia"]: {["O_SFIA_crew_lxWS"]};
        case ["crew", "ws_tura"]: {["O_Tura_deserter_lxWS","O_Tura_enforcer_lxWS","O_Tura_medic2_lxWS","O_Tura_thug_lxWS","O_Tura_watcher_lxWS"]};
        case ["crew", "rhsafrf"]: {["rhs_vdv_armoredcrew","rhs_vdv_combatcrew","rhs_vdv_crew_commander"]};
        case ["crew", "cup_afrf"]: {["CUP_O_RU_Crew_VDV_EMR"]};
        case ["crew", "cup_afrf_modern"]: {["CUP_O_RUS_M_Soldier_Crew_VKPO_Summer"]};
        case ["crew", "cup_npc"]: {["CUP_I_GUE_Crew"]};
        case ["crew", "cup_tk"]: {["CUP_O_TK_Crew"]};
        case ["crew", "cup_tk_ins"]: {["CUP_O_TK_INS_Soldier","CUP_O_TK_INS_Soldier_FNFAL","CUP_O_TK_INS_Soldier_Enfield"]};
        case ["crew", "nato"]: {["B_crew_F"]};
        case ["crew", "nato_pacific"]: {["B_T_Crew_F"]};
        case ["crew", "ef_mjtf_desert"]: {["EF_B_Marine_Crew_Des"]};
        case ["crew", "ef_mjtf_woodland"]: {["EF_B_Marine_Crew_Wdl"]};
        case ["crew", "ws_ion"]: {["B_ION_crew_lxWS"]};
        case ["crew", "cup_usa_woodland"]: {["CUP_B_US_Crew_OEFCP"]};
        case ["crew", "cup_usmc_woodland"]: {["CUP_B_USMC_Crew"]};
        case ["diver", "base"]: {["O_diver_F","O_diver_exp_F","O_diver_TL_F"]};
        case ["diver", "csat"]: {["O_diver_F","O_diver_exp_F","O_diver_TL_F"]};
        case ["diver", "csat_pacific"]: {["O_diver_F","O_diver_exp_F","O_diver_TL_F"]};
        case ["diver", "aaf"]: {["O_diver_F","O_diver_exp_F","O_diver_TL_F"]};
        case ["diver", "ldf"]: {["O_diver_F","O_diver_exp_F","O_diver_TL_F"]};
        case ["diver", "ws_sfia"]: {["O_diver_F","O_diver_exp_F","O_diver_TL_F"]};
        case ["diver", "ws_tura"]: {["O_diver_F","O_diver_exp_F","O_diver_TL_F"]};
        case ["diver", "rhsafrf"]: {["O_diver_F","O_diver_exp_F","O_diver_TL_F"]};
        case ["diver", "cup_afrf"]: {["O_diver_F","O_diver_exp_F","O_diver_TL_F"]};
        case ["diver", "cup_afrf_modern"]: {["O_diver_F","O_diver_exp_F","O_diver_TL_F"]};
        case ["diver", "cup_npc"]: {["O_diver_F","O_diver_exp_F","O_diver_TL_F"]};
        case ["diver", "cup_tk"]: {["O_diver_F","O_diver_exp_F","O_diver_TL_F"]};
        case ["diver", "cup_tk_ins"]: {["O_diver_F","O_diver_exp_F","O_diver_TL_F"]};
        case ["diver", "nato"]: {["O_diver_F","O_diver_exp_F","O_diver_TL_F"]};
        case ["diver", "nato_pacific"]: {["O_diver_F","O_diver_exp_F","O_diver_TL_F"]};
        case ["diver", "ef_mjtf_desert"]: {["EF_B_Marine_Diver_Des","EF_B_Marine_Diver_Eng_Des","EF_B_Marine_Diver_Pointman_Des","EF_B_Marine_Diver_Scout_Des","EF_B_Marine_Diver_TL_Des"]};
        case ["diver", "ef_mjtf_woodland"]: {["EF_B_Marine_Diver_Wdl","EF_B_Marine_Diver_Eng_Wdl","EF_B_Marine_Diver_Pointman_Wdl","EF_B_Marine_Diver_Scout_Wdl","EF_B_Marine_Diver_TL_Wdl"]};
        case ["diver", "ws_ion"]: {["O_diver_F","O_diver_exp_F","O_diver_TL_F"]};
        case ["diver", "cup_usa_woodland"]: {["O_diver_F","O_diver_exp_F","O_diver_TL_F"]};
        case ["diver", "cup_usmc_woodland"]: {["O_diver_F","O_diver_exp_F","O_diver_TL_F"]};
        case ["recon", "base"]: {["I_C_Soldier_Bandit_7_F","I_C_Soldier_Bandit_3_F","I_C_Soldier_Bandit_2_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Bandit_6_F","I_C_Soldier_Bandit_1_F","I_C_Soldier_Bandit_8_F","I_C_Soldier_Bandit_4_F"]};
        case ["recon", "csat"]: {["O_recon_exp_F","O_recon_JTAC_F","O_recon_M_F","O_recon_medic_F","O_Pathfinder_F","O_recon_F","O_recon_LAT_F","O_recon_TL_F"]};
        case ["recon", "csat_pacific"]: {["O_T_Recon_Exp_F","O_T_Recon_JTAC_F","O_T_Recon_M_F","O_T_Recon_Medic_F","O_T_Recon_F","O_T_Recon_LAT_F","O_T_Recon_TL_F"]};
        case ["recon", "aaf"]: {["I_Soldier_lite_F"]};
        case ["recon", "ldf"]: {["I_E_Soldier_lite_F"]};
        case ["recon", "ws_sfia"]: {["O_SFIA_medic_lxWS","O_SFIA_soldier_lxWS","O_SFIA_soldier_lite_lxWS","O_SFIA_Soldier_TL_lxWS"]};
        case ["recon", "ws_tura"]: {["O_Tura_deserter_lxWS","O_Tura_enforcer_lxWS","O_Tura_hireling_lxWS","O_Tura_HeavyGunner_lxWS","O_Tura_medic2_lxWS","O_Tura_thug_lxWS","O_Tura_soldier_UAV_lxWS","O_Tura_watcher_lxWS","O_recon_exp_F","O_recon_JTAC_F","O_recon_M_F","O_recon_medic_F","O_Pathfinder_F","O_recon_F","O_recon_LAT_F","O_recon_TL_F"]};
        case ["recon", "rhsafrf"]: {["rhs_vdv_recon_efreitor","rhs_vdv_recon_marksman_vss","rhs_vdv_recon_rifleman_asval","rhs_vdv_recon_rifleman_scout_akm","rhs_vdv_recon_rifleman_scout","rhs_vdv_recon_grenadier_scout","rhs_vdv_recon_arifleman_rpk_scout"]};
        case ["recon", "cup_afrf"]: {["CUP_O_MVD_Soldier_MG","CUP_O_MVD_Soldier_Marksman","CUP_O_MVD_Soldier","CUP_O_MVD_Soldier_GL","CUP_O_MVD_Soldier_AT","CUP_O_MVD_Sniper","CUP_O_MVD_Soldier_TL"]};
        case ["recon", "cup_afrf_modern"]: {["CUP_O_RUS_M_Soldier_A_VKPO_Summer","CUP_O_RUS_M_Soldier_AAR_VKPO_Summer","CUP_O_RUS_M_Soldier_AHAT_VKPO_Summer","CUP_O_RUS_M_Soldier_AAT_VKPO_Summer","CUP_O_RUS_M_Soldier_AR_VKPO_Summer","CUP_O_RUS_M_Soldier_Medic_VKPO_Summer","CUP_O_RUS_M_Soldier_Engineer_VKPO_Summer","CUP_O_RUS_M_Soldier_Exp_VKPO_Summer","CUP_O_RUS_M_Soldier_GL_VKPO_Summer","CUP_O_RUS_M_Soldier_MG_VKPO_Summer","CUP_O_RUS_M_Soldier_Marksman_VKPO_Summer","CUP_O_RUS_M_Soldier_Mine_VKPO_Summer","CUP_O_RUS_M_Soldier_AA_VKPO_Summer","CUP_O_RUS_M_Soldier_AT_VKPO_Summer","CUP_O_RUS_M_Soldier_Repair_VKPO_Summer","CUP_O_RUS_M_Soldier_VKPO_Summer","CUP_O_RUS_M_Soldier_LAT_VKPO_Summer","CUP_O_RUS_M_Soldier_HAT_VKPO_Summer","CUP_O_RUS_M_Soldier_Lite_VKPO_Summer","CUP_O_RUS_M_Soldier_SL_VKPO_Summer","CUP_O_RUS_M_Soldier_TL_VKPO_Summer"]};
        case ["recon", "cup_npc"]: {["CUP_I_GUE_Farmer","CUP_I_GUE_Forester","CUP_I_GUE_Gamekeeper","CUP_I_GUE_Local","CUP_I_GUE_Villager","CUP_I_GUE_Woodman"]};
        case ["recon", "cup_tk"]: {["CUP_O_TK_Soldier_AKS_Night","CUP_O_TK_Soldier_FNFAL_Night","CUP_O_TK_Soldier_AKS_74_GOSHAWK","CUP_O_TK_SpecOps_MG","CUP_O_TK_SpecOps","CUP_O_TK_SpecOps_TL"]};
        case ["recon", "cup_tk_ins"]: {["CUP_O_TK_INS_Soldier_AR","CUP_O_TK_INS_Guerilla_Medic","CUP_O_TK_INS_Soldier","CUP_O_TK_INS_Soldier_FNFAL","CUP_O_TK_INS_Soldier_Enfield","CUP_O_TK_INS_Soldier_AT","CUP_O_TK_INS_Sniper"]};
        case ["recon", "nato"]: {["B_recon_exp_F","B_recon_JTAC_F","B_recon_M_F","B_recon_medic_F","B_recon_F","B_recon_LAT_F","B_Recon_Sharpshooter_F","B_recon_TL_F"]};
        case ["recon", "nato_pacific"]: {["B_T_Recon_Exp_F","B_T_Recon_JTAC_F","B_T_Recon_M_F","B_T_Recon_Medic_F","B_T_Recon_F","B_T_Recon_LAT_F","B_T_Recon_TL_F"]};
        case ["recon", "ef_mjtf_desert"]: {["EF_B_Marine_Recon_Exp_Des","EF_B_Marine_Recon_JTAC_Des","EF_B_Marine_Recon_M_Des","EF_B_Marine_Recon_Medic_Des","EF_B_Marine_Recon_Des","EF_B_Marine_Recon_LAT_Des","EF_B_Marine_Recon_TL_Des"]};
        case ["recon", "ef_mjtf_woodland"]: {["EF_B_Marine_Recon_Exp_Wdl","EF_B_Marine_Recon_JTAC_Wdl","EF_B_Marine_Recon_M_Wdl","EF_B_Marine_Recon_Medic_Wdl","EF_B_Marine_Recon_Wdl","EF_B_Marine_Recon_LAT_Wdl","EF_B_Marine_Recon_TL_Wdl"]};
        case ["recon", "ws_ion"]: {["B_ION_soldier_AR_lxWS","B_ION_medic_lxWS","B_ION_Soldier_GL_lxWS","B_ION_marksman_lxWS","B_ION_Soldier_lxWS","B_ION_soldier_LAT2_lxWS","B_ION_Soldier_SG_lxWS","B_ION_TL_lxWS","B_ION_soldier_UAV_01_lxWS","B_ION_soldier_UAV_02_lxWS"]};
        case ["recon", "cup_usa_woodland"]: {["CUP_B_US_Soldier_AAT_UCP","CUP_B_US_Soldier_AHAT_UCP","CUP_B_US_Soldier_AAR_UCP","CUP_B_US_Soldier_AMG_UCP","CUP_B_US_Soldier_AT_UCP","CUP_B_US_Soldier_HAT_UCP","CUP_B_US_Soldier_AR_UCP","CUP_B_US_Soldier_Engineer_UCP","CUP_B_US_Soldier_Engineer_EOD_UCP","CUP_B_US_Soldier_GL_UCP","CUP_B_US_Soldier_MG_UCP","CUP_B_US_Soldier_Marksman_UCP","CUP_B_US_Soldier_Marksman_EBR_UCP","CUP_B_US_Medic_UCP","CUP_B_US_Soldier_AA_UCP","CUP_B_US_Soldier_UCP","CUP_B_US_Soldier_ACOG_UCP","CUP_B_US_Soldier_LAT_UCP","CUP_B_US_Soldier_Backpack_UCP","CUP_B_US_Soldier_Engineer_Sapper_UCP","CUP_B_US_Soldier_SL_UCP","CUP_B_US_Soldier_TL_UCP","CUP_B_US_Soldier_UAV_UCP"]};
        case ["recon", "cup_usmc_woodland"]: {["CUP_B_FR_Soldier_Assault_GL","CUP_B_FR_Soldier_Assault","CUP_B_FR_Medic","CUP_B_FR_Soldier_Exp","CUP_B_FR_Soldier_Operator","CUP_B_FR_Soldier_GL","CUP_B_FR_Soldier_AR","CUP_B_FR_Soldier_Marksman","CUP_B_FR_Saboteur","CUP_B_FR_Soldier_TL","CUP_B_FR_Soldier_UAV"]};
        case ["elite", "base"]: {["I_G_Soldier_A_F","I_G_Soldier_AR_F","I_G_medic_F","I_G_engineer_F","I_G_Soldier_exp_F","I_G_Soldier_GL_F","I_G_Soldier_M_F","I_G_Soldier_F","I_G_Soldier_LAT_F","I_G_Soldier_lite_F","I_G_Soldier_LAT2_F","I_G_Sharpshooter_F","I_G_Soldier_SL_F","I_G_Soldier_TL_F"]};
        case ["elite", "csat"]: {["O_V_Soldier_Exp_hex_F","O_V_Soldier_jtac_hex_F","O_V_Soldier_m_hex_F","O_V_Soldier_hex_F","O_V_Soldier_Medic_hex_F","O_V_Soldier_lat_hex_F","O_V_Soldier_TL_hex_F"]};
        case ["elite", "csat_pacific"]: {["O_V_Soldier_Exp_ghex_F","O_V_Soldier_jtac_ghex_F","O_V_Soldier_m_ghex_F","O_V_Soldier_ghex_F","O_V_Soldier_Medic_ghex_F","O_V_Soldier_lat_ghex_F","O_V_Soldier_TL_ghex_F"]};
        case ["elite", "aaf"]: {["I_Spotter_F"]};
        case ["elite", "ldf"]: {["I_E_Soldier_CBRN_F"]};
        case ["elite", "ws_sfia"]: {["O_V_Soldier_Exp_hex_F","O_V_Soldier_jtac_hex_F","O_V_Soldier_m_hex_F","O_V_Soldier_hex_F","O_V_Soldier_Medic_hex_F","O_V_Soldier_lat_hex_F","O_V_Soldier_TL_hex_F"]};
        case ["elite", "ws_tura"]: {["O_V_Soldier_Exp_hex_F","O_V_Soldier_jtac_hex_F","O_V_Soldier_m_hex_F","O_V_Soldier_hex_F","O_V_Soldier_Medic_hex_F","O_V_Soldier_lat_hex_F","O_V_Soldier_TL_hex_F"]};
        case ["elite", "rhsafrf"]: {["rhs_vmf_recon_arifleman","rhs_vmf_recon_efreitor","rhs_vmf_recon_machinegunner_assistant","rhs_vmf_recon_marksman","rhs_vmf_recon_marksman_vss","rhs_vmf_recon_medic","rhs_vmf_recon_rifleman","rhs_vmf_recon_rifleman_akms","rhs_vmf_recon_rifleman_asval","rhs_vmf_recon_grenadier","rhs_vmf_recon_rifleman_l","rhs_vmf_recon_rifleman_lat","rhs_vmf_recon_rifleman_scout_akm","rhs_vmf_recon_rifleman_scout","rhs_vmf_recon_grenadier_scout","rhs_vmf_recon_arifleman_scout","rhs_vmf_recon_sergeant"]};
        case ["elite", "cup_afrf"]: {["CUP_O_RUS_Saboteur","CUP_O_RUS_Soldier_GL","CUP_O_RUS_Soldier_Marksman","CUP_O_RUS_SpecOps","CUP_O_RUS_SpecOps_Night","CUP_O_RUS_SpecOps_SD","CUP_O_RUS_SpecOps_Scout","CUP_O_RUS_SpecOps_Scout_Night","CUP_O_RUS_Soldier_TL"]};
        case ["elite", "cup_afrf_modern"]: {["CUP_O_RUS_M_Recon_MG_Gorka_EMR","CUP_O_RUS_M_Recon_Exp_Gorka_EMR","CUP_O_RUS_M_Recon_GL_Gorka_EMR","CUP_O_RUS_M_Recon_Marksman_Gorka_EMR","CUP_O_RUS_M_Recon_Medic_Gorka_EMR","CUP_O_RUS_M_Recon_Rifleman_Gorka_EMR","CUP_O_RUS_M_Recon_LAT_Gorka_EMR","CUP_O_RUS_M_Recon_Sharpshooter_Gorka_EMR","CUP_O_RUS_M_Recon_TL_Gorka_EMR"]};
        case ["elite", "cup_npc"]: {["CUP_I_GUE_Sniper","CUP_I_GUE_Soldier_Scout"]};
        case ["elite", "cup_tk"]: {["CUP_O_TK_Sniper_SVD_Night","CUP_O_TK_Spotter"]};
        case ["elite", "cup_tk_ins"]: {["CUP_O_TK_INS_Soldier_FNFAL","CUP_O_TK_INS_Sniper","CUP_O_TK_INS_Soldier_Enfield"]};
        case ["elite", "nato"]: {["B_Patrol_Soldier_A_F","B_Patrol_Soldier_AR_F","B_Patrol_Medic_F","B_Patrol_Engineer_F","B_Patrol_HeavyGunner_F","B_Patrol_Soldier_MG_F","B_Patrol_Soldier_M_F","B_Patrol_Soldier_AT_F","B_Patrol_Soldier_TL_F","B_Patrol_Soldier_UAV_F"]};
        case ["elite", "nato_pacific"]: {["B_W_Soldier_A_F","B_W_Soldier_AAR_F","B_W_Soldier_AAA_F","B_W_Soldier_AAT_F","B_W_soldier_AR_F","B_W_Soldier_CBRN_F","B_W_medic_F","B_W_engineer_F","B_W_soldier_exp_F","B_W_Soldier_GL_F","B_W_soldier_M_F","B_W_soldier_mine_F","B_W_Soldier_AA_F","B_W_Soldier_AT_F","B_W_RadioOperator_F","B_W_soldier_repair_F","B_W_Soldier_F","B_W_Soldier_LAT_F","B_W_Soldier_LAT2_F","B_W_soldier_SL_F","B_W_soldier_TL_F","B_W_soldier_UAV_F"]};
        case ["elite", "ef_mjtf_desert"]: {["EF_B_Marine_Diver_Des","EF_B_Marine_Diver_Eng_Des","EF_B_Marine_Diver_Pointman_Des","EF_B_Marine_Diver_Scout_Des","EF_B_Marine_Diver_TL_Des"]};
        case ["elite", "ef_mjtf_woodland"]: {["EF_B_Marine_Diver_Wdl","EF_B_Marine_Diver_Eng_Wdl","EF_B_Marine_Diver_Pointman_Wdl","EF_B_Marine_Diver_Scout_Wdl","EF_B_Marine_Diver_TL_Wdl"]};
        case ["elite", "ws_ion"]: {["B_D_recon_exp_lxWS","B_D_recon_JTAC_lxWS","B_D_recon_M_lxWS","B_D_recon_medic_lxWS","B_D_recon_lxWS","B_D_recon_LAT_lxWS","B_D_recon_TL_lxWS"]};
        case ["elite", "cup_usa_woodland"]: {["CUP_B_US_SpecOps_AR","CUP_B_US_SpecOps_JTAC","CUP_B_US_SpecOps_MG","CUP_B_US_SpecOps_M","CUP_B_US_SpecOps_Medic","CUP_B_US_SpecOps","CUP_B_US_SpecOps_Assault","CUP_B_US_SpecOps_Night","CUP_B_US_SpecOps_SD","CUP_B_US_SpecOps_TL","CUP_B_US_SpecOps_UAV"]};
        case ["elite", "cup_usmc_woodland"]: {["CUP_B_USMC_MARSOC_AR_DA","CUP_B_USMC_MARSOC_AR","CUP_B_USMC_MARSOC_CC","CUP_B_USMC_MARSOC_CC_DA","CUP_B_USMC_MARSOC_EL","CUP_B_USMC_MARSOC_EL_DA","CUP_B_USMC_MARSOC_Marksman","CUP_B_USMC_MARSOC_Marksman_DA","CUP_B_USMC_MARSOC_OC","CUP_B_USMC_MARSOC_OC_DA","CUP_B_USMC_MARSOC","CUP_B_USMC_MARSOC_DA","CUP_B_USMC_MARSOC_TC","CUP_B_USMC_MARSOC_TC_DA","CUP_B_USMC_MARSOC_TL","CUP_B_USMC_MARSOC_TL_DA","CUP_B_USMC_MARSOC_Medic","CUP_B_USMC_MARSOC_Medic_DA"]};
        case ["sniper", "base"]: {["I_L_Hunter_F","I_L_Looter_Rifle_F"]};
        case ["sniper", "csat"]: {["O_sniper_F","O_ghillie_ard_F","O_ghillie_lsh_F","O_ghillie_sard_F"]};
        case ["sniper", "csat_pacific"]: {["O_ghillie_lsh_F","O_ghillie_sard_F","O_T_Sniper_F","O_T_ghillie_tna_F"]};
        case ["sniper", "aaf"]: {["I_Sniper_F","I_ghillie_ard_F","I_ghillie_lsh_F","I_ghillie_sard_F"]};
        case ["sniper", "ldf"]: {["I_Sniper_F","I_ghillie_ard_F","I_ghillie_lsh_F","I_ghillie_sard_F"]};
        case ["sniper", "ws_sfia"]: {["O_sniper_F","O_ghillie_ard_F","O_ghillie_lsh_F","O_ghillie_sard_F"]};
        case ["sniper", "ws_tura"]: {["O_Tura_scout_lxWS"]};
        case ["sniper", "rhsafrf"]: {["rhs_vdv_marksman"]};
        case ["sniper", "cup_afrf"]: {["CUP_O_RU_Sniper_VDV_EMR","CUP_O_RU_Sniper_KSVK_VDV_EMR"]};
        case ["sniper", "cup_afrf_modern"]: {["CUP_O_RU_Sniper_VDV_EMR","CUP_O_RU_Sniper_KSVK_VDV_EMR"]};
        case ["sniper", "cup_npc"]: {["CUP_I_GUE_Sniper"]};
        case ["sniper", "cup_tk"]: {["CUP_O_TK_Sniper","CUP_O_TK_Sniper_KSVK"]};
        case ["sniper", "cup_tk_ins"]: {["CUP_O_TK_INS_Sniper"]};
        case ["sniper", "nato"]: {["B_sniper_F","B_ghillie_ard_F","B_ghillie_lsh_F","B_ghillie_sard_F"]};
        case ["sniper", "nato_pacific"]: {["B_ghillie_lsh_F","B_ghillie_sard_F","B_T_Sniper_F","B_T_ghillie_tna_F"]};
        case ["sniper", "ef_mjtf_desert"]: {["B_sniper_F","B_ghillie_ard_F","B_ghillie_lsh_F","B_ghillie_sard_F"]};
        case ["sniper", "ef_mjtf_woodland"]: {["B_ghillie_lsh_F","B_ghillie_sard_F","B_T_Sniper_F","B_T_ghillie_tna_F"]};
        case ["sniper", "ws_ion"]: {["B_sniper_F","B_ghillie_ard_F","B_ghillie_lsh_F","B_ghillie_sard_F"]};
        case ["sniper", "cup_usa_woodland"]: {["CUP_B_US_Sniper_OEFCP","CUP_B_US_Sniper_M107_OEFCP","CUP_B_US_Sniper_M110_TWS_OCP"]};
        case ["sniper", "cup_usmc_woodland"]: {["CUP_B_USMC_Sniper_M40A3_des","CUP_B_USMC_Sniper_M107_des"]};
        case ["pilot_heli", "base"]: {["I_C_Pilot_F","I_C_Helipilot_F"]};
        case ["pilot_heli", "csat"]: {["O_helicrew_F","O_helipilot_F"]};
        case ["pilot_heli", "csat_pacific"]: {["O_T_Helicrew_F","O_T_Helipilot_F"]};
        case ["pilot_heli", "aaf"]: {["I_helicrew_F","I_helipilot_F"]};
        case ["pilot_heli", "ldf"]: {["I_E_Helicrew_F","I_E_Helipilot_F"]};
        case ["pilot_heli", "ws_sfia"]: {["O_SFIA_pilot_lxWS"]};
        case ["pilot_heli", "ws_tura"]: {["O_Tura_deserter_lxWS","O_Tura_watcher_lxWS"]};
        case ["pilot_heli", "rhsafrf"]: {["rhs_pilot_combat_heli","rhs_pilot_transport_heli"]};
        case ["pilot_heli", "cup_afrf"]: {["CUP_O_RU_Pilot_M_EMR","CUP_O_RU_Pilot_VDV_M_EMR","CUP_O_RU_Pilot_EMR","CUP_O_RU_Pilot","CUP_O_RU_Pilot_VDV_EMR","CUP_O_RU_Pilot_VDV"]};
        case ["pilot_heli", "cup_afrf_modern"]: {["CUP_O_RU_Pilot_M_EMR","CUP_O_RU_Pilot_VDV_M_EMR","CUP_O_RU_Pilot_EMR","CUP_O_RU_Pilot","CUP_O_RU_Pilot_VDV_EMR","CUP_O_RU_Pilot_VDV"]};
        case ["pilot_heli", "cup_npc"]: {["CUP_I_GUE_Pilot"]};
        case ["pilot_heli", "cup_tk"]: {["CUP_O_TK_Pilot"]};
        case ["pilot_heli", "cup_tk_ins"]: {["CUP_O_TK_Pilot"]};
        case ["pilot_heli", "nato"]: {["B_helicrew_F","B_Helipilot_F"]};
        case ["pilot_heli", "nato_pacific"]: {["B_T_Helicrew_F","B_T_Helipilot_F"]};
        case ["pilot_heli", "ef_mjtf_desert"]: {["B_helicrew_F","B_Helipilot_F"]};
        case ["pilot_heli", "ef_mjtf_woodland"]: {["B_T_Helicrew_F","B_T_Helipilot_F"]};
        case ["pilot_heli", "ws_ion"]: {["B_ION_Helipilot_lxWS"]};
        case ["pilot_heli", "cup_usa_woodland"]: {["CUP_B_US_Pilot"]};
        case ["pilot_heli", "cup_usmc_woodland"]: {["CUP_B_USMC_Pilot"]};
        case ["pilot_jet", "base"]: {["I_C_Pilot_F","I_C_Helipilot_F"]};
        case ["pilot_jet", "csat"]: {["O_Pilot_F"]};
        case ["pilot_jet", "csat_pacific"]: {["O_T_Pilot_F"]};
        case ["pilot_jet", "aaf"]: {["I_Fighter_Pilot_F","I_pilot_F"]};
        case ["pilot_jet", "ldf"]: {["I_Fighter_Pilot_F","I_pilot_F"]};
        case ["pilot_jet", "ws_sfia"]: {["O_SFIA_pilot_lxWS"]};
        case ["pilot_jet", "ws_tura"]: {["O_Tura_deserter_lxWS","O_Tura_watcher_lxWS"]};
        case ["pilot_jet", "rhsafrf"]: {["rhs_pilot","rhs_pilot_tan"]};
        case ["pilot_jet", "cup_afrf"]: {["CUP_O_RU_Pilot_M_EMR","CUP_O_RU_Pilot_VDV_M_EMR","CUP_O_RU_Pilot_EMR","CUP_O_RU_Pilot","CUP_O_RU_Pilot_VDV_EMR","CUP_O_RU_Pilot_VDV"]};
        case ["pilot_jet", "cup_afrf_modern"]: {["CUP_O_RU_Pilot_M_EMR","CUP_O_RU_Pilot_VDV_M_EMR","CUP_O_RU_Pilot_EMR","CUP_O_RU_Pilot","CUP_O_RU_Pilot_VDV_EMR","CUP_O_RU_Pilot_VDV"]};
        case ["pilot_jet", "cup_npc"]: {["CUP_I_GUE_Pilot"]};
        case ["pilot_jet", "cup_tk"]: {["CUP_O_TK_Pilot"]};
        case ["pilot_jet", "cup_tk_ins"]: {["CUP_O_TK_Pilot"]};
        case ["pilot_jet", "nato"]: {["B_Pilot_F"]};
        case ["pilot_jet", "nato_pacific"]: {["B_T_Pilot_F"]};
        case ["pilot_jet", "ef_mjtf_desert"]: {["B_Pilot_F"]};
        case ["pilot_jet", "ef_mjtf_woodland"]: {["B_T_Pilot_F"]};
        case ["pilot_jet", "ws_ion"]: {["B_Pilot_F"]};
        case ["pilot_jet", "cup_usa_woodland"]: {["CUP_B_US_Pilot"]};
        case ["pilot_jet", "cup_usmc_woodland"]: {["CUP_B_USMC_Pilot"]};
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
