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

private _resolvedTypes = _this apply {
    switch (_x) do {
        case ["civilians", "base"]: {["C_Van_01_fuel_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Offroad_02_unarmed_F","C_Offroad_01_F","C_Offroad_01_comms_F","C_Offroad_01_covered_F","C_Offroad_01_repair_F","C_Quadbike_01_F","C_SUV_01_F","C_Tractor_01_F","C_Van_01_transport_F","C_Van_01_box_F","C_Van_02_medevac_F","C_Van_02_vehicle_F","C_Van_02_service_F","C_Van_02_transport_F","C_Truck_02_fuel_F","C_Truck_02_box_F","C_Truck_02_transport_F","C_Truck_02_covered_F"]};
        case ["standard", "base"]: {["I_G_Offroad_01_AT_F","I_G_Offroad_01_armed_F","I_C_Offroad_02_AT_F","I_C_Offroad_02_LMG_F"]};
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
        case ["standard", "nato"]: {["B_LSV_01_unarmed_F","B_LSV_01_armed_F","B_LSV_01_AT_F"]};
        case ["supply",   "nato"]: {["B_Truck_01_ammo_F","B_Truck_01_fuel_F","B_Truck_01_medical_F","B_Truck_01_Repair_F"]};
        case ["mrap",     "nato"]: {["B_MRAP_01_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F"]};
        case ["apc",      "nato"]: {["B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F"]};
        case ["ifv",      "nato"]: {["B_AFV_Wheeled_01_cannon_F","B_AFV_Wheeled_01_up_cannon_F"]};
        case ["mbt",      "nato"]: {["B_MBT_01_cannon_F","B_MBT_01_TUSK_F"]};
        case ["aa",       "nato"]: {["B_APC_Tracked_01_AA_F"]};
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
