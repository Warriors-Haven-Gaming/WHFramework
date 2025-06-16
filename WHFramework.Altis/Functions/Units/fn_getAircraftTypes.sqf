/*
Function: WHF_fnc_getAircraftTypes

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
if !(_this isEqualType []) then {throw format [
    "Expected [[type, faction], ...] array, got %1",
    _this
]};

private _factions = call WHF_fnc_allFactions;
{
    if !(_x isEqualType [] || {count _x < 2}) then {throw format [
        "Expected [type, faction] at index %1, got %2",
        _forEachIndex,
        _x
    ]};

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
        case ["civilians",    "base"]: {["C_Heli_Light_01_civil_F"]};
        case ["heli_attack",  "base"]: {[]};
        case ["heli_gunship", "base"]: {[]};
        case ["heli_light",   "base"]: {[]};
        case ["heli_medium",  "base"]: {[]};
        case ["jet_cap",      "base"]: {[]};
        case ["jet_cas",      "base"]: {[]};
        case ["heli_attack",  "csat"]: {["O_Heli_Light_02_dynamicLoadout_F"]};
        case ["heli_gunship", "csat"]: {["O_Heli_Attack_02_dynamicLoadout_F"]};
        case ["heli_light",   "csat"]: {["O_Heli_Light_02_unarmed_F"]};
        case ["heli_medium",  "csat"]: {["O_Heli_Transport_04_covered_F"]};
        case ["jet_cap",      "csat"]: {["O_Plane_Fighter_02_F"]};
        case ["jet_cas",      "csat"]: {["O_Plane_CAS_02_dynamicLoadout_F"]};
        case ["heli_attack",  "csat_pacific"]: {["O_Heli_Light_02_dynamicLoadout_F"]};
        case ["heli_gunship", "csat_pacific"]: {["O_Heli_Attack_02_dynamicLoadout_F"]};
        case ["heli_light",   "csat_pacific"]: {["O_Heli_Light_02_unarmed_F"]};
        case ["heli_medium",  "csat_pacific"]: {["O_Heli_Transport_04_covered_F"]};
        case ["jet_cap",      "csat_pacific"]: {["O_Plane_Fighter_02_F"]};
        case ["jet_cas",      "csat_pacific"]: {["O_Plane_CAS_02_dynamicLoadout_F"]};
        case ["heli_attack",  "aaf"]: {["I_Heli_light_03_dynamicLoadout_F"]};
        case ["heli_gunship", "aaf"]: {[]};
        case ["heli_light",   "aaf"]: {["I_Heli_light_03_unarmed_F"]};
        case ["heli_medium",  "aaf"]: {["I_Heli_Transport_02_F"]};
        case ["jet_cap",      "aaf"]: {["I_Plane_Fighter_04_F"]};
        case ["jet_cas",      "aaf"]: {["I_Plane_Fighter_03_dynamicLoadout_F"]};
        case ["heli_attack",  "ldf"]: {["I_E_Heli_light_03_dynamicLoadout_F"]};
        case ["heli_gunship", "ldf"]: {[]};
        case ["heli_light",   "ldf"]: {["I_E_Heli_light_03_unarmed_F"]};
        case ["heli_medium",  "ldf"]: {[]};
        case ["jet_cap",      "ldf"]: {[]};
        case ["jet_cas",      "ldf"]: {[]};
        case ["heli_attack",  "ws_sfia"]: {[]};
        case ["heli_gunship", "ws_sfia"]: {[]};
        case ["heli_light",   "ws_sfia"]: {[]};
        case ["heli_medium",  "ws_sfia"]: {[]};
        case ["jet_cap",      "ws_sfia"]: {[]};
        case ["jet_cas",      "ws_sfia"]: {[]};
        case ["heli_attack",  "ws_tura"]: {["O_Heli_Light_02_dynamicLoadout_F"]};
        case ["heli_gunship", "ws_tura"]: {["O_SFIA_Heli_Attack_02_dynamicLoadout_lxWS"]};
        case ["heli_light",   "ws_tura"]: {["O_Heli_Light_02_unarmed_F"]};
        case ["heli_medium",  "ws_tura"]: {[]};
        case ["jet_cap",      "ws_tura"]: {["O_Plane_Fighter_02_F"]};
        case ["jet_cas",      "ws_tura"]: {["O_Plane_CAS_02_dynamicLoadout_F"]};
        case ["heli_attack",  "rhsafrf"]: {["RHS_Mi8MTV3_vdv","RHS_Mi8AMTSh_vvsc"]};
        case ["heli_gunship", "rhsafrf"]: {["RHS_Ka52_vvsc","RHS_Mi24V_vvsc","rhs_mi28n_vvsc"]};
        case ["heli_light",   "rhsafrf"]: {[]};
        case ["heli_medium",  "rhsafrf"]: {["RHS_Mi8T_vdv","RHS_Mi8AMT_vdv"]};
        case ["jet_cap",      "rhsafrf"]: {["rhs_mig29sm_vvs","RHS_T50_vvs_generic_ext"]};
        case ["jet_cas",      "rhsafrf"]: {["RHS_Su25SM_vvs"]};
        case ["heli_attack",  "cup_afrf"]: {["CUP_O_Ka60_Grey_RU","CUP_O_Mi8_RU"]};
        case ["heli_gunship", "cup_afrf"]: {["CUP_O_Ka50_DL_RU","CUP_O_Ka52_RU","CUP_O_Mi24_P_Dynamic_RU","CUP_O_Mi24_V_Dynamic_RU"]};
        case ["heli_light",   "cup_afrf"]: {[]};
        case ["heli_medium",  "cup_afrf"]: {["CUP_O_Mi8AMT_RU"]};
        case ["jet_cap",      "cup_afrf"]: {["CUP_O_SU34_RU"]};
        case ["jet_cas",      "cup_afrf"]: {["CUP_O_Su25_Dyn_RU"]};
        case ["heli_attack",  "cup_afrf_modern"]: {["CUP_O_Ka60_Grey_RU","CUP_O_Mi8_RU"]};
        case ["heli_gunship", "cup_afrf_modern"]: {["CUP_O_Ka50_DL_RU","CUP_O_Ka52_RU","CUP_O_Mi24_P_Dynamic_RU","CUP_O_Mi24_V_Dynamic_RU"]};
        case ["heli_light",   "cup_afrf_modern"]: {[]};
        case ["heli_medium",  "cup_afrf_modern"]: {["CUP_O_Mi8AMT_RU"]};
        case ["jet_cap",      "cup_afrf_modern"]: {["CUP_O_SU34_RU"]};
        case ["jet_cas",      "cup_afrf_modern"]: {["CUP_O_Su25_Dyn_RU"]};
        case ["heli_attack",  "cup_npc"]: {[]};
        case ["heli_gunship", "cup_npc"]: {[]};
        case ["heli_light",   "cup_npc"]: {[]};
        case ["heli_medium",  "cup_npc"]: {[]};
        case ["jet_cap",      "cup_npc"]: {[]};
        case ["jet_cas",      "cup_npc"]: {[]};
        case ["heli_attack",  "cup_tk"]: {["CUP_O_UH1H_gunship_TKA"]};
        case ["heli_gunship", "cup_tk"]: {["CUP_O_Mi24_D_Dynamic_TK"]};
        case ["heli_light",   "cup_tk"]: {["CUP_O_UH1H_TKA"]};
        case ["heli_medium",  "cup_tk"]: {["CUP_O_MI6T_TKA"]};
        case ["jet_cap",      "cup_tk"]: {[]};
        case ["jet_cas",      "cup_tk"]: {["CUP_O_Su25_Dyn_TKA","CUP_O_L39_TK"]};
        case ["heli_attack",  "cup_tk_ins"]: {["CUP_O_UH1H_gunship_TKA"]};
        case ["heli_gunship", "cup_tk_ins"]: {["CUP_O_Mi24_D_Dynamic_TK"]};
        case ["heli_light",   "cup_tk_ins"]: {["CUP_O_UH1H_TKA"]};
        case ["heli_medium",  "cup_tk_ins"]: {["CUP_O_MI6T_TKA"]};
        case ["jet_cap",      "cup_tk_ins"]: {[]};
        case ["jet_cas",      "cup_tk_ins"]: {["CUP_O_Su25_Dyn_TKA","CUP_O_L39_TK"]};
        case ["heli_attack",  "gendarmerie"]: {[]};
        case ["heli_gunship", "gendarmerie"]: {[]};
        case ["heli_light",   "gendarmerie"]: {["B_Heli_Light_01_F"]};
        case ["heli_medium",  "gendarmerie"]: {["B_Heli_Transport_01_F","B_Heli_Transport_03_F"]};
        case ["jet_cap",      "gendarmerie"]: {[]};
        case ["jet_cas",      "gendarmerie"]: {[]};
        case ["heli_attack",  "nato"]: {["B_Heli_Light_01_dynamicLoadout_F"]};
        case ["heli_gunship", "nato"]: {["B_Heli_Attack_01_dynamicLoadout_F"]};
        case ["heli_light",   "nato"]: {["B_Heli_Light_01_F"]};
        case ["heli_medium",  "nato"]: {["B_Heli_Transport_01_F","B_Heli_Transport_03_F"]};
        case ["jet_cap",      "nato"]: {["B_Plane_Fighter_01_F"]};
        case ["jet_cas",      "nato"]: {["B_Plane_CAS_01_dynamicLoadout_F"]};
        case ["heli_attack",  "nato_pacific"]: {["B_Heli_Light_01_dynamicLoadout_F"]};
        case ["heli_gunship", "nato_pacific"]: {["B_Heli_Attack_01_dynamicLoadout_F"]};
        case ["heli_light",   "nato_pacific"]: {["B_Heli_Light_01_F"]};
        case ["heli_medium",  "nato_pacific"]: {["B_Heli_Transport_01_F","B_Heli_Transport_03_F"]};
        case ["jet_cap",      "nato_pacific"]: {["B_Plane_Fighter_01_F"]};
        case ["jet_cas",      "nato_pacific"]: {["B_Plane_CAS_01_dynamicLoadout_F"]};
        case ["heli_attack",  "ef_mjtf_desert"]: {["B_Heli_Light_01_dynamicLoadout_F"]};
        case ["heli_gunship", "ef_mjtf_desert"]: {["EF_B_Heli_Attack_01_dynamicLoadout_MJTF_Des","EF_B_AH99J_MJTF_Des"]};
        case ["heli_light",   "ef_mjtf_desert"]: {["B_Heli_Light_01_F"]};
        case ["heli_medium",  "ef_mjtf_desert"]: {["EF_B_Heli_Transport_01_MJTF_Des"]};
        case ["jet_cap",      "ef_mjtf_desert"]: {["B_Plane_Fighter_01_F"]};
        case ["jet_cas",      "ef_mjtf_desert"]: {["B_Plane_CAS_01_dynamicLoadout_F"]};
        case ["heli_attack",  "ef_mjtf_woodland"]: {["B_Heli_Light_01_dynamicLoadout_F"]};
        case ["heli_gunship", "ef_mjtf_woodland"]: {["EF_B_Heli_Attack_01_dynamicLoadout_MJTF_Wdl","EF_B_AH99J_MJTF_Wdl"]};
        case ["heli_light",   "ef_mjtf_woodland"]: {["B_Heli_Light_01_F"]};
        case ["heli_medium",  "ef_mjtf_woodland"]: {["EF_B_Heli_Transport_01_MJTF_Wdl"]};
        case ["jet_cap",      "ef_mjtf_woodland"]: {["B_Plane_Fighter_01_F"]};
        case ["jet_cas",      "ef_mjtf_woodland"]: {["B_Plane_CAS_01_dynamicLoadout_F"]};
        case ["heli_attack",  "ws_ion"]: {["B_ION_Heli_Light_02_dynamicLoadout_lxWS"]};
        case ["heli_gunship", "ws_ion"]: {[]};
        case ["heli_light",   "ws_ion"]: {["B_ION_Heli_Light_02_unarmed_lxWS"]};
        case ["heli_medium",  "ws_ion"]: {[]};
        case ["jet_cap",      "ws_ion"]: {[]};
        case ["jet_cas",      "ws_ion"]: {[]};
        case ["heli_attack",  "ws_una"]: {[]};
        case ["heli_gunship", "ws_una"]: {[]};
        case ["heli_light",   "ws_una"]: {[]};
        case ["heli_medium",  "ws_una"]: {["B_UN_Heli_Transport_02_lxWS"]};
        case ["jet_cap",      "ws_una"]: {[]};
        case ["jet_cas",      "ws_una"]: {[]};
        case ["heli_attack",  "cup_usa_woodland"]: {["CUP_B_AH6M_USA","CUP_B_MH60L_DAP_2x_US","CUP_B_MH60L_DAP_4x_US"]};
        case ["heli_gunship", "cup_usa_woodland"]: {["CUP_B_AH64D_DL_USA"]};
        case ["heli_light",   "cup_usa_woodland"]: {["CUP_B_MH6M_USA"]};
        case ["heli_medium",  "cup_usa_woodland"]: {["CUP_B_CH47F_USA","CUP_B_MH47E_USA"]};
        case ["jet_cap",      "cup_usa_woodland"]: {["CUP_B_F35B_USMC"]};
        case ["jet_cas",      "cup_usa_woodland"]: {["CUP_B_A10_DYN_USA"]};
        case ["heli_attack",  "cup_usmc_woodland"]: {["CUP_B_UH1Y_Gunship_Dynamic_USMC"]};
        case ["heli_gunship", "cup_usmc_woodland"]: {["CUP_B_AH1Z_Dynamic_USMC"]};
        case ["heli_light",   "cup_usmc_woodland"]: {["CUP_B_MH60S_USMC","CUP_B_UH1Y_UNA_USMC"]};
        case ["heli_medium",  "cup_usmc_woodland"]: {["CUP_B_CH53E_USMC"]};
        case ["jet_cap",      "cup_usmc_woodland"]: {["CUP_B_F35B_USMC"]};
        case ["jet_cas",      "cup_usmc_woodland"]: {["CUP_B_AV8B_DYN_USMC"]};
        default {
            // Unlike the other type functions, we don't want fallbacks
            // since some factions are intended to have limited aircraft.
            []
        };
    };
};
_resolvedTypes = flatten _resolvedTypes;
_resolvedTypes = _resolvedTypes arrayIntersect _resolvedTypes;
_resolvedTypes
