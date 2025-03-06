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
        case ["standard", "csat"]: {["O_LSV_02_AT_F","O_LSV_02_armed_F","O_Truck_03_ammo_F","O_Truck_03_fuel_F","O_Truck_03_medical_F","O_Truck_03_repair_F"]};
        case ["standard", "csat_pacific"]: {["O_T_LSV_02_AT_F","O_T_LSV_02_armed_F","O_T_Truck_03_ammo_ghex_F","O_T_Truck_03_fuel_ghex_F","O_T_Truck_03_medical_ghex_F","O_T_Truck_03_repair_ghex_F"]};
        case ["standard", "rhsafrf"]: {["rhs_tigr_sts_vdv","rhs_uaz_vdv","rhs_uaz_open_vdv","rhs_ural_vdv_01","rhs_ural_open_vdv_01"]};
        case ["standard", "cup_afrf"]: {["CUP_O_UAZ_AGS30_RU","CUP_O_UAZ_METIS_RU","CUP_O_UAZ_MG_RU","CUP_O_UAZ_SPG9_RU","CUP_O_Ural_Reammo_RU","CUP_O_Ural_Refuel_RU","CUP_O_Ural_Repair_RU"]};
        case ["standard", "cup_afrf_modern"]: {["CUP_O_Kamaz_6396_ammo_RUS_M","CUP_O_Kamaz_6396_fuel_RUS_M","CUP_O_Kamaz_6396_medical_RUS_M","CUP_O_Kamaz_6396_repair_RUS_M","CUP_O_Tigr_233014_GREEN_PK_RU","CUP_O_Tigr_M_233114_GREEN_KORD_RU"]};
        case ["standard", "cup_npc"]: {["CUP_I_Datsun_AA_Random","CUP_I_Datsun_PK_Random","CUP_I_Hilux_AGS30_NAPA","CUP_I_Hilux_BMP1_NAPA","CUP_I_Hilux_btr60_NAPA","CUP_I_Hilux_DSHKM_NAPA","CUP_I_Hilux_igla_NAPA","CUP_I_Hilux_metis_NAPA","CUP_I_Hilux_MLRS_NAPA","CUP_I_Hilux_podnos_NAPA","CUP_I_Hilux_SPG9_NAPA","CUP_I_Hilux_UB32_NAPA","CUP_I_Hilux_zu23_NAPA","CUP_I_Ural_ZU23_NAPA"]};
        default {
            if (_x # 0 isNotEqualTo "standard") exitWith {["standard", _x # 1] call WHF_fnc_getVehicleTypes};
            if (_x # 1 isNotEqualTo "base") exitWith {[_x # 0, "base"] call WHF_fnc_getVehicleTypes};
            []
        };
    };
};
_resolvedTypes = flatten _resolvedTypes;
_resolvedTypes = _resolvedTypes arrayIntersect _resolvedTypes;
_resolvedTypes
