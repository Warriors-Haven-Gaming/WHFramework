/*
Function: WHF_fnc_getVehicleTypes

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
    //     ["standard", "base"] call WHF_fnc_getVehicleTypes;
    // When specifying both the vehicle type and faction, it must be its own
    // element in another array:
    //     [["standard", "base"]] call WHF_fnc_getVehicleTypes;
    // If you're not sure where this occurred, run Arma with the -debug flag
    // and you should receive a traceback indicating which scripts led to this
    // ambiguous input.
    if (_type in _factions) then {throw format [
        "Misuse of faction name '%1' as vehicle type at index %2",
        _type,
        _forEachIndex
    ]};
} forEach _this;

private _resolvedTypes = _this apply {
    switch (_x) do {
        case ["civilians", "base"]: {["C_Van_01_fuel_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Offroad_02_unarmed_F","C_Offroad_01_F","C_Offroad_01_comms_F","C_Offroad_01_covered_F","C_Offroad_01_repair_F","C_Quadbike_01_F","C_SUV_01_F","C_Tractor_01_F","C_Van_01_transport_F","C_Van_01_box_F","C_Van_02_medevac_F","C_Van_02_vehicle_F","C_Van_02_service_F","C_Van_02_transport_F","C_Truck_02_fuel_F","C_Truck_02_box_F","C_Truck_02_transport_F","C_Truck_02_covered_F"]};
        case ["standard", "base"]: {["I_G_Offroad_01_F","I_G_Offroad_01_AT_F","I_G_Offroad_01_armed_F","I_C_Offroad_02_unarmed_F","I_C_Offroad_02_AT_F","I_C_Offroad_02_LMG_F"]};
        case ["supply",   "base"]: {["I_E_Truck_02_Ammo_F","I_E_Truck_02_fuel_F","I_E_Truck_02_Medical_F","I_E_Truck_02_Box_F"]};
        case ["mrap",     "base"]: {["I_E_Offroad_01_F","I_E_Offroad_01_comms_F","I_E_Offroad_01_covered_F","I_E_Truck_02_transport_F","I_E_Truck_02_F","I_C_Van_01_transport_F","I_E_Van_02_transport_F"]};
        case ["apc",      "base"]: {["I_E_Offroad_01_F","I_E_Offroad_01_comms_F","I_E_Offroad_01_covered_F","I_E_Truck_02_transport_F","I_E_Truck_02_F","I_C_Van_01_transport_F","I_E_Van_02_transport_F"]};
        case ["standard", "csat"]: {["O_LSV_02_AT_F","O_LSV_02_armed_F"]};
        case ["supply",   "csat"]: {["O_Truck_03_ammo_F","O_Truck_03_fuel_F","O_Truck_03_medical_F","O_Truck_03_repair_F"]};
        case ["mrap",     "csat"]: {["O_MRAP_02_F","O_MRAP_02_gmg_F","O_MRAP_02_hmg_F"]};
        case ["apc",      "csat"]: {["O_APC_Wheeled_02_rcws_v2_F"]};
        case ["ifv",      "csat"]: {["O_APC_Tracked_02_cannon_F"]};
        case ["mbt",      "csat"]: {["O_MBT_02_cannon_F","O_MBT_04_cannon_F","O_MBT_04_command_F"]};
        case ["aa",       "csat"]: {["O_APC_Tracked_02_AA_F"]};
        case ["standard", "csat_pacific"]: {["O_T_LSV_02_AT_F","O_T_LSV_02_armed_F"]};
        case ["supply",   "csat_pacific"]: {["O_T_Truck_03_ammo_ghex_F","O_T_Truck_03_fuel_ghex_F","O_T_Truck_03_medical_ghex_F","O_T_Truck_03_repair_ghex_F"]};
        case ["mrap",     "csat_pacific"]: {["O_T_MRAP_02_ghex_F","O_T_MRAP_02_gmg_ghex_F","O_T_MRAP_02_hmg_ghex_F"]};
        case ["apc",      "csat_pacific"]: {["O_T_APC_Wheeled_02_rcws_v2_ghex_F"]};
        case ["ifv",      "csat_pacific"]: {["O_T_APC_Tracked_02_cannon_ghex_F"]};
        case ["mbt",      "csat_pacific"]: {["O_T_MBT_02_cannon_ghex_F","O_T_MBT_04_cannon_F","O_T_MBT_04_command_F"]};
        case ["aa",       "csat_pacific"]: {["O_T_APC_Tracked_02_AA_ghex_F"]};
        case ["standard", "aaf"]: {["I_G_Offroad_01_F","I_G_Offroad_01_AT_F","I_G_Offroad_01_armed_F","I_C_Offroad_02_unarmed_F","I_C_Offroad_02_AT_F","I_C_Offroad_02_LMG_F"]};
        case ["supply",   "aaf"]: {["I_Truck_02_ammo_F","I_Truck_02_fuel_F","I_Truck_02_medical_F","I_Truck_02_box_F"]};
        case ["mrap",     "aaf"]: {["I_MRAP_03_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F"]};
        case ["apc",      "aaf"]: {["I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F"]};
        case ["ifv",      "aaf"]: {["I_LT_01_AT_F","I_LT_01_cannon_F"]};
        case ["mbt",      "aaf"]: {["I_MBT_03_cannon_F"]};
        case ["aa",       "aaf"]: {["I_LT_01_AA_F"]};
        case ["standard", "ldf"]: {["I_E_Offroad_01_F","I_E_Offroad_01_comms_F","I_E_Offroad_01_covered_F","I_E_Van_02_transport_F"]};
        case ["supply",   "ldf"]: {["I_E_Truck_02_Ammo_F","I_E_Truck_02_fuel_F","I_E_Truck_02_Medical_F","I_E_Truck_02_Box_F"]};
        case ["mrap",     "ldf"]: {["I_E_Truck_02_transport_F","I_E_Truck_02_F"]};
        case ["apc",      "ldf"]: {["I_E_APC_tracked_03_cannon_F"]};
        case ["ifv",      "ldf"]: {["I_E_APC_tracked_03_cannon_F"]};
        case ["mbt",      "ldf"]: {["I_MBT_03_cannon_F"]};
        case ["aa",       "ldf"]: {["I_LT_01_AA_F"]};
        case ["standard", "ws_sfia"]: {["O_SFIA_Offroad_lxWS","O_SFIA_Offroad_AT_lxWS","O_SFIA_Offroad_armed_lxWS"]};
        case ["supply",   "ws_sfia"]: {["O_SFIA_Truck_02_Ammo_lxWS","O_SFIA_Truck_02_fuel_lxWS","O_SFIA_Truck_02_box_lxWS"]};
        case ["mrap",     "ws_sfia"]: {["O_SFIA_Offroad_lxWS","O_SFIA_Offroad_AT_lxWS","O_SFIA_Offroad_armed_lxWS"]};
        case ["apc",      "ws_sfia"]: {["O_SFIA_APC_Wheeled_02_hmg_lxWS"]};
        case ["ifv",      "ws_sfia"]: {["O_SFIA_APC_Tracked_02_cannon_lxWS","O_SFIA_APC_Tracked_02_30mm_lxWS"]};
        case ["mbt",      "ws_sfia"]: {["O_SFIA_MBT_02_cannon_lxWS"]};
        case ["aa",       "ws_sfia"]: {["O_SFIA_Truck_02_aa_lxWS","O_SFIA_APC_Tracked_02_AA_lxWS"]};
        case ["standard", "ws_tura"]: {["O_Tura_Offroad_armor_lxWS","O_Tura_Offroad_armor_AT_lxWS","O_Tura_Offroad_armor_armed_lxWS","O_Tura_Pickup_01_RF","O_Tura_Pickup_01_fuel_RF","O_Tura_Pickup_01_hmg_RF","O_Tura_Pickup_01_Rocket_rf"]};
        case ["supply",   "ws_tura"]: {["O_Truck_02_Ammo_F","O_Truck_02_fuel_F","O_Truck_02_medical_F","O_Truck_02_box_F"]};
        case ["mrap",     "ws_tura"]: {["O_Tura_Offroad_armor_lxWS","O_Tura_Offroad_armor_AT_lxWS","O_Tura_Offroad_armor_armed_lxWS","O_Tura_Pickup_01_RF","O_Tura_Pickup_01_fuel_RF","O_Tura_Pickup_01_hmg_RF","O_Tura_Pickup_01_Rocket_rf"]};
        case ["apc",      "ws_tura"]: {["O_APC_Wheeled_02_hmg_lxWS"]};
        case ["ifv",      "ws_tura"]: {["O_APC_Tracked_02_30mm_lxWS"]};
        case ["mbt",      "ws_tura"]: {["O_MBT_02_cannon_F"]};
        case ["aa",       "ws_tura"]: {["O_Tura_Truck_02_aa_lxWS"]};
        case ["standard", "rhsafrf"]: {["rhs_tigr_sts_vdv","rhs_uaz_vdv","rhs_uaz_open_vdv"]};
        case ["supply",   "rhsafrf"]: {["rhs_ural_vdv_01","rhs_ural_open_vdv_01"]};
        case ["apc",      "rhsafrf"]: {["rhs_btr60_vdv","rhs_btr70_vdv","rhs_btr80_vdv","rhs_btr80a_vdv"]};
        case ["ifv",      "rhsafrf"]: {["rhs_bmd1pk","rhs_bmd2k","rhs_bmd4m_vdv","rhs_bmp1k_vdv","rhs_bmp2k_vdv","rhs_prp3_vdv"]};
        case ["mbt",      "rhsafrf"]: {["rhs_t80","rhs_t80a","rhs_t80um","rhs_t90_tv","rhs_t90a_tv","rhs_t90sab_tv","rhs_t90sm_tv"]};
        case ["aa",       "rhsafrf"]: {["rhs_zsu234_aa"]};
        case ["standard", "cup_afrf"]: {["CUP_O_UAZ_AGS30_RU","CUP_O_UAZ_METIS_RU","CUP_O_UAZ_MG_RU","CUP_O_UAZ_SPG9_RU"]};
        case ["supply",   "cup_afrf"]: {["CUP_O_Ural_Reammo_RU","CUP_O_Ural_Refuel_RU","CUP_O_Ural_Repair_RU"]};
        case ["mrap",     "cup_afrf"]: {["CUP_O_GAZ_Vodnik_Unarmed_RU","CUP_O_GAZ_Vodnik_PK_RU","CUP_O_GAZ_Vodnik_AGS_RU","CUP_O_GAZ_Vodnik_BPPU_RU","CUP_O_GAZ_Vodnik_KPVT_RU"]};
        case ["apc",      "cup_afrf"]: {["CUP_O_BRDM2_RUS","CUP_O_BRDM2_ATGM_RUS","CUP_O_BTR60_Green_RU","CUP_O_BTR80_GREEN_RU","CUP_O_BTR80A_GREEN_RU","CUP_O_BTR90_RU","CUP_O_MTLB_pk_Green_RU"]};
        case ["ifv",      "cup_afrf"]: {["CUP_O_BMP2_RU","CUP_O_BMP_HQ_RU","CUP_O_BMP3_RU"]};
        case ["mbt",      "cup_afrf"]: {["CUP_O_T72_RU","CUP_O_T90_RU"]};
        case ["aa",       "cup_afrf"]: {["CUP_O_2S6_RU","CUP_O_2S6M_RU","CUP_O_UAZ_AA_RU","CUP_O_Ural_ZU23_RU"]};
        case ["standard", "cup_afrf_modern"]: {["CUP_O_Tigr_233014_GREEN_PK_RU","CUP_O_Tigr_M_233114_GREEN_KORD_RU"]};
        case ["supply",   "cup_afrf_modern"]: {["CUP_O_Kamaz_6396_ammo_RUS_M","CUP_O_Kamaz_6396_fuel_RUS_M","CUP_O_Kamaz_6396_medical_RUS_M","CUP_O_Kamaz_6396_repair_RUS_M"]};
        case ["mrap",     "cup_afrf_modern"]: {["CUP_O_Tigr_233014_GREEN_PK_RU","CUP_O_Tigr_M_233114_GREEN_KORD_RU"]};
        case ["apc",      "cup_afrf_modern"]: {["CUP_O_BTR80_GREEN_RU","CUP_O_BTR80A_GREEN_RU"]};
        case ["ifv",      "cup_afrf_modern"]: {["CUP_O_BTR80_GREEN_RU","CUP_O_BTR80A_GREEN_RU"]};
        case ["mbt",      "cup_afrf_modern"]: {["CUP_O_T90M_RU"]};
        case ["aa",       "cup_afrf_modern"]: {["CUP_O_2S6_RU","CUP_O_2S6M_RU"]};
        case ["standard", "cup_npc"]: {["CUP_I_Datsun_AA_Random","CUP_I_Datsun_PK_Random","CUP_I_Hilux_AGS30_NAPA","CUP_I_Hilux_BMP1_NAPA","CUP_I_Hilux_btr60_NAPA","CUP_I_Hilux_DSHKM_NAPA","CUP_I_Hilux_igla_NAPA","CUP_I_Hilux_metis_NAPA","CUP_I_Hilux_MLRS_NAPA","CUP_I_Hilux_podnos_NAPA","CUP_I_Hilux_SPG9_NAPA","CUP_I_Hilux_zu23_NAPA"]};
        case ["supply",   "cup_npc"]: {["CUP_I_MTVR_Ammo_RACS","CUP_I_MTVR_Refuel_RACS","CUP_I_MTVR_Repair_RACS"]};
        case ["mrap",     "cup_npc"]: {["CUP_I_BRDM2_NAPA","CUP_I_BRDM2_ATGM_NAPA","CUP_I_MTLB_pk_NAPA"]};
        case ["apc",      "cup_npc"]: {["CUP_I_BRDM2_NAPA","CUP_I_BRDM2_ATGM_NAPA","CUP_I_MTLB_pk_NAPA"]};
        case ["ifv",      "cup_npc"]: {["CUP_I_BMP2_NAPA","CUP_I_BMP_HQ_NAPA"]};
        case ["mbt",      "cup_npc"]: {["CUP_I_M60A3_RACS","CUP_I_M60A3_TTS_RACS","CUP_B_M1A2SEP_RACS","CUP_B_M1A2SEP_TUSK_RACS","CUP_I_T72_RACS"]};
        case ["aa",       "cup_npc"]: {["CUP_I_Datsun_AA_Random","CUP_I_Ural_ZU23_NAPA"]};
        case ["standard", "cup_tk"]: {["CUP_O_LR_MG_TKA","CUP_O_LR_SPG9_TKA","CUP_O_LR_Transport_TKA","CUP_O_SUV_TKA","CUP_O_UAZ_Unarmed_TKA","CUP_O_UAZ_AGS30_TKA","CUP_O_UAZ_MG_TKA","CUP_O_UAZ_METIS_TKA","CUP_O_UAZ_Open_TKA","CUP_O_UAZ_SPG9_TKA"]};
        case ["supply",   "cup_tk"]: {["CUP_O_V3S_Rearm_TKA","CUP_O_V3S_Refuel_TKA","CUP_O_V3S_Repair_TKA","CUP_O_Ural_Reammo_TKA","CUP_O_Ural_Refuel_TKA","CUP_O_Ural_Repair_TKA"]};
        case ["mrap",     "cup_tk"]: {["CUP_O_BTR40_MG_TKA","CUP_O_Tigr_233014_PK_TKA","CUP_O_Tigr_M_233114_KORD_TKA"]};
        case ["apc",      "cup_tk"]: {["CUP_O_BRDM2_TKA","CUP_O_BRDM2_ATGM_TKA","CUP_O_BTR60_TK","CUP_O_BTR80_TK","CUP_O_BTR80A_TK","CUP_O_M113A3_TKA","CUP_O_MTLB_pk_TKA"]};
        case ["ifv",      "cup_tk"]: {["CUP_O_BMP1_TKA","CUP_O_BMP1P_TKA","CUP_O_BMP2_TKA","CUP_O_BMP_HQ_TKA"]};
        case ["mbt",      "cup_tk"]: {["CUP_O_T34_TKA","CUP_O_T55_TK","CUP_O_T72_TKA"]};
        case ["aa",       "cup_tk"]: {["CUP_O_LR_AA_TKA","CUP_O_UAZ_AA_TKA","CUP_O_Ural_ZU23_TKA","CUP_O_ZSU23_TK","CUP_O_ZSU23_Afghan_TK","CUP_O_BMP2_ZU_TKA"]};
        case ["standard", "cup_tk_ins"]: {["CUP_O_Hilux_unarmed_TK_INS","CUP_O_Hilux_AGS30_TK_INS","CUP_O_Hilux_BMP1_TK_INS","CUP_O_Hilux_btr60_TK_INS","CUP_O_Hilux_DSHKM_TK_INS","CUP_O_Hilux_M2_TK_INS","CUP_O_Hilux_metis_TK_INS","CUP_O_Hilux_MLRS_TK_INS","CUP_O_Hilux_podnos_TK_INS","CUP_O_Hilux_SPG9_TK_INS","CUP_O_LR_MG_TKM","CUP_O_LR_SPG9_TKM","CUP_O_LR_Transport_TKM"]};
        case ["supply",   "cup_tk_ins"]: {["CUP_O_V3S_Rearm_TKM","CUP_O_V3S_Refuel_TKM","CUP_O_V3S_Repair_TKM"]};
        case ["mrap",     "cup_tk_ins"]: {["CUP_O_Hilux_armored_AGS30_TK_INS","CUP_O_Hilux_armored_BMP1_TK_INS","CUP_O_Hilux_armored_BTR60_TK_INS","CUP_O_Hilux_armored_DSHKM_TK_INS","CUP_O_Hilux_armored_M2_TK_INS","CUP_O_Hilux_armored_metis_TK_INS","CUP_O_Hilux_armored_MLRS_TK_INS","CUP_O_Hilux_armored_podnos_TK_INS","CUP_O_Hilux_armored_SPG9_TK_INS","CUP_O_Hilux_armored_unarmed_TK_INS"]};
        case ["apc",      "cup_tk_ins"]: {["CUP_O_BTR40_MG_TKM","CUP_O_MTLB_pk_TK_MILITIA"]};
        case ["ifv",      "cup_tk_ins"]: {["CUP_O_BTR40_MG_TKM","CUP_O_MTLB_pk_TK_MILITIA"]};
        case ["mbt",      "cup_tk_ins"]: {["CUP_O_T34_TKA","CUP_O_T55_TK","CUP_O_T72_TKA"]};
        case ["aa",       "cup_tk_ins"]: {["CUP_O_LR_AA_TKM","CUP_O_Ural_ZU23_TKM","CUP_O_Hilux_igla_TK_INS","CUP_O_Hilux_zu23_TK_INS"]};
        case ["standard", "nato"]: {["B_LSV_01_unarmed_F","B_LSV_01_armed_F","B_LSV_01_AT_F"]};
        case ["supply",   "nato"]: {["B_Truck_01_ammo_F","B_Truck_01_fuel_F","B_Truck_01_medical_F","B_Truck_01_Repair_F"]};
        case ["mrap",     "nato"]: {["B_MRAP_01_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F"]};
        case ["apc",      "nato"]: {["B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F"]};
        case ["ifv",      "nato"]: {["B_AFV_Wheeled_01_cannon_F","B_AFV_Wheeled_01_up_cannon_F"]};
        case ["mbt",      "nato"]: {["B_MBT_01_cannon_F","B_MBT_01_TUSK_F"]};
        case ["aa",       "nato"]: {["B_APC_Tracked_01_AA_F"]};
        case ["standard", "nato_pacific"]: {["B_T_LSV_01_unarmed_F","B_T_LSV_01_armed_F","B_T_LSV_01_AT_F"]};
        case ["supply",   "nato_pacific"]: {["B_T_Truck_01_ammo_F","B_T_Truck_01_fuel_F","B_T_Truck_01_medical_F","B_T_Truck_01_Repair_F"]};
        case ["mrap",     "nato_pacific"]: {["B_T_MRAP_01_F","B_T_MRAP_01_gmg_F","B_T_MRAP_01_hmg_F"]};
        case ["apc",      "nato_pacific"]: {["B_T_APC_Wheeled_01_cannon_F","B_T_APC_Tracked_01_rcws_F"]};
        case ["ifv",      "nato_pacific"]: {["B_T_AFV_Wheeled_01_cannon_F","B_T_AFV_Wheeled_01_up_cannon_F"]};
        case ["mbt",      "nato_pacific"]: {["B_T_MBT_01_cannon_F","B_T_MBT_01_TUSK_F"]};
        case ["aa",       "nato_pacific"]: {["B_T_APC_Tracked_01_AA_F"]};
        case ["standard", "ef_mjtf_desert"]: {["EF_B_Pickup_MJTF_Des","EF_B_Pickup_Comms_MJTF_Des","EF_B_Pickup_mmg_MJTF_Des","EF_B_Quadbike_01_MJTF_Des"]};
        case ["supply",   "ef_mjtf_desert"]: {["EF_B_Truck_01_ammo_MJTF_Des","EF_B_Truck_01_fuel_MJTF_Des","EF_B_Truck_01_medical_MJTF_Des","EF_B_Truck_01_Repair_MJTF_Des"]};
        case ["mrap",     "ef_mjtf_desert"]: {["EF_B_MRAP_01_MJTF_Des","EF_B_MRAP_01_AT_MJTF_Des","EF_B_MRAP_01_FSV_MJTF_Des","EF_B_MRAP_01_gmg_MJTF_Des","EF_B_MRAP_01_hmg_MJTF_Des"]};
        case ["apc",      "ef_mjtf_desert"]: {["EF_B_AAV9_MJTF_Des","EF_B_AAV9_50mm_MJTF_Des"]};
        case ["ifv",      "ef_mjtf_desert"]: {["EF_B_AAV9_MJTF_Des","EF_B_AAV9_50mm_MJTF_Des"]};
        case ["mbt",      "ef_mjtf_desert"]: {["EF_B_MBT_01_cannon_MJTF_Des","EF_B_MBT_01_TUSK_MJTF_Des"]};
        case ["aa",       "ef_mjtf_desert"]: {["EF_B_MRAP_01_LAAD_MJTF_Des"]};
        case ["standard", "ef_mjtf_woodland"]: {["EF_B_Pickup_MJTF_Wdl","EF_B_Pickup_Comms_MJTF_Wdl","EF_B_Pickup_mmg_MJTF_Wdl","EF_B_Quadbike_01_MJTF_Wdl"]};
        case ["supply",   "ef_mjtf_woodland"]: {["EF_B_Truck_01_ammo_MJTF_Wdl","EF_B_Truck_01_fuel_MJTF_Wdl","EF_B_Truck_01_medical_MJTF_Wdl","EF_B_Truck_01_Repair_MJTF_Wdl"]};
        case ["mrap",     "ef_mjtf_woodland"]: {["EF_B_MRAP_01_MJTF_Wdl","EF_B_MRAP_01_AT_MJTF_Wdl","EF_B_MRAP_01_FSV_MJTF_Wdl","EF_B_MRAP_01_gmg_MJTF_Wdl","EF_B_MRAP_01_hmg_MJTF_Wdl"]};
        case ["apc",      "ef_mjtf_woodland"]: {["EF_B_AAV9_MJTF_Wdl","EF_B_AAV9_50mm_MJTF_Wdl"]};
        case ["ifv",      "ef_mjtf_woodland"]: {["EF_B_AAV9_MJTF_Wdl","EF_B_AAV9_50mm_MJTF_Wdl"]};
        case ["mbt",      "ef_mjtf_woodland"]: {["EF_B_MBT_01_cannon_MJTF_Wdl","EF_B_MBT_01_TUSK_MJTF_Wdl"]};
        case ["aa",       "ef_mjtf_woodland"]: {["EF_B_MRAP_01_LAAD_MJTF_Wdl"]};
        case ["standard", "ws_ion"]: {["B_ION_Offroad_lxWS","B_ION_Offroad_armed_lxWS"]};
        case ["supply",   "ws_ion"]: {["B_D_Truck_01_ammo_lxWS","B_D_Truck_01_fuel_lxWS","B_D_Truck_01_medical_lxWS","B_D_Truck_01_Repair_lxWS"]};
        case ["mrap",     "ws_ion"]: {["B_D_MRAP_01_lxWS","B_D_MRAP_01_gmg_lxWS","B_D_MRAP_01_hmg_lxWS"]};
        case ["apc",      "ws_ion"]: {["B_ION_APC_Wheeled_01_command_lxWS","B_ION_APC_Wheeled_02_hmg_lxWS"]};
        case ["ifv",      "ws_ion"]: {["B_D_APC_Wheeled_01_cannon_lxWS","B_D_APC_Wheeled_01_atgm_lxWS"]};
        case ["mbt",      "ws_ion"]: {["B_D_MBT_01_cannon_lxWS","B_D_MBT_01_TUSK_lxWS"]};
        case ["aa",       "ws_ion"]: {["B_D_APC_Tracked_01_aa_lxWS"]};
        case ["standard", "cup_usa_woodland"]: {["CUP_B_nM1025_M2_USA_WDL","CUP_B_nM1025_M240_USA_WDL","CUP_B_nM1025_Mk19_USA_WDL","CUP_B_nM1025_Unarmed_USA_WDL","CUP_B_nM1025_SOV_M2_USA_WDL","CUP_B_nM1025_SOV_Mk19_USA_WDL","CUP_B_nM1036_TOW_USA_WDL","CUP_B_nM1038_4s_USA_WDL","CUP_B_nM1151_ogpk_m2_USA_WDL","CUP_B_nM1151_ogpk_m240_DF_USA_WDL","CUP_B_nM1151_ogpk_mk19_USA_WDL","CUP_B_nM1151_Unarmed_USA_WDL"]};
        case ["supply",   "cup_usa_woodland"]: {["CUP_B_MTVR_Ammo_USMC","CUP_B_MTVR_Refuel_USMC","CUP_B_MTVR_Repair_USMC","CUP_B_nM997_USMC_WDL"]};
        case ["mrap",     "cup_usa_woodland"]: {["CUP_B_RG31_Mk19_OD_USA","CUP_B_RG31E_M2_OD_USA","CUP_B_RG31_M2_OD_USA"]};
        case ["apc",      "cup_usa_woodland"]: {["CUP_B_M1126_ICV_M2_Woodland","CUP_B_M1126_ICV_MK19_Woodland","CUP_B_M113A1_USA","CUP_B_M113A3_USA"]};
        case ["ifv",      "cup_usa_woodland"]: {["CUP_B_M2Bradley_USA_W","CUP_B_M2A3Bradley_USA_W","CUP_B_M7Bradley_USA_W"]};
        case ["mbt",      "cup_usa_woodland"]: {["CUP_B_M1A1SA_Woodland_US_Army","CUP_B_M1A1SA_TUSK_Woodland_US_Army","CUP_B_M1A2SEP_Woodland_US_Army","CUP_B_M1A2SEP_TUSK_II_Woodland_US_Army","CUP_B_M1A2SEP_TUSK_Woodland_US_Army","CUP_B_M1A2C_Woodland_US_Army","CUP_B_M1A2C_TUSK_II_Woodland_US_Army","CUP_B_M1A2C_TUSK_Woodland_US_Army"]};
        case ["aa",       "cup_usa_woodland"]: {["CUP_B_nM1097_AVENGER_USA_WDL","CUP_B_M6LineBacker_USA_W"]};
        case ["standard", "cup_usmc_woodland"]: {["CUP_B_nM1025_M2_USMC_WDL","CUP_B_nM1025_M240_USMC_WDL","CUP_B_nM1025_Mk19_USMC_WDL","CUP_B_nM1025_Unarmed_USMC_WDL","CUP_B_nM1025_SOV_M2_USMC_WDL","CUP_B_nM1025_SOV_Mk19_USMC_WDL","CUP_B_nM1036_TOW_USMC_WDL","CUP_B_nM1038_4s_USMC_WDL","CUP_B_nM1151_mctags_m2_USMC_WDL","CUP_B_nM1151_mctags_m240_USMC_WDL","CUP_B_nM1151_mctags_mk19_USMC_WDL","CUP_B_nM1151_Unarmed_USMC_WDL"]};
        case ["supply",   "cup_usmc_woodland"]: {["CUP_B_MTVR_Ammo_USMC","CUP_B_MTVR_Refuel_USMC","CUP_B_MTVR_Repair_USMC","CUP_B_nM997_USMC_WDL"]};
        case ["mrap",     "cup_usmc_woodland"]: {["CUP_B_RG31_Mk19_OD_USMC","CUP_B_RG31E_M2_OD_USMC","CUP_B_RG31_M2_OD_USMC"]};
        case ["apc",      "cup_usmc_woodland"]: {["CUP_B_AAV_USMC","CUP_B_LAV25_USMC","CUP_B_LAV25_HQ_USMC"]};
        case ["ifv",      "cup_usmc_woodland"]: {["CUP_B_M2Bradley_USA_W","CUP_B_M2A3Bradley_USA_W","CUP_B_M7Bradley_USA_W"]};
        case ["mbt",      "cup_usmc_woodland"]: {["CUP_B_M1A1FEP_OD_USMC","CUP_B_M1A1EP_TUSK_OD_USMC","CUP_B_M1A1FEP_Woodland_USMC","CUP_B_M1A1EP_TUSK_Woodland_USMC"]};
        case ["aa",       "cup_usmc_woodland"]: {["CUP_B_nM1097_AVENGER_USMC_WDL"]};
        default {
            if !(_x # 0 in ["civilians", "standard"]) exitWith {[["standard", _x # 1]] call WHF_fnc_getVehicleTypes};
            if (_x # 1 isNotEqualTo "base") exitWith {[[_x # 0, "base"]] call WHF_fnc_getVehicleTypes};
            []
        };
    };
};
_resolvedTypes = flatten _resolvedTypes;
_resolvedTypes = _resolvedTypes arrayIntersect _resolvedTypes;
_resolvedTypes
