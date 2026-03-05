/*
Function: WHF_fnc_setupVehicle

Description:
    Apply custom modifications to a vehicle.
    Function must be executed where vehicle is local.

Parameters:
    Object vehicle:
        The vehicle to configure.

Author:
    thegamecracks

*/
params ["_vehicle"];
if (!isNil {_vehicle getVariable "WHF_setupVehicle_called"}) exitWith {};
if !(_vehicle isKindOf "AllVehicles") exitWith {};
if (_vehicle isKindOf "Man") exitWith {};

_vehicle setVariable ["WHF_setupVehicle_called", true];
_vehicle call WHF_fnc_addVehicleDamageHandlers;

if (_vehicle isKindOf "ReammoBox_F") exitWith {};
if (!local _vehicle) exitWith {};

switch (true) do {
    // bornholm-wh
    case (_vehicle isKindOf "E22_O_RAF_Heli_Attack_02_dynamicLoadout_F"): {
        _vehicle setPylonLoadout [1, "PylonRack_4Rnd_LG_scalpel", true, [0]];
        _vehicle setPylonLoadout [2, "PylonRack_19Rnd_Rocket_Skyfire", true, [0]];
        _vehicle setPylonLoadout [3, "PylonRack_19Rnd_Rocket_Skyfire", true, [0]];
        _vehicle setPylonLoadout [4, "PylonRack_4Rnd_LG_scalpel", true, [0]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "E22_O_RAF_Heli_Light_02_dynamicLoadout_F"): {
        _vehicle setPylonLoadout [1, "rksla3_mag_hmp400_127x99_x400", true, [-1]];
        _vehicle setPylonLoadout [2, "rksla3_mag_chi_57mm_HE_rocket_pod_x18", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "E22_O_RAF_Plane_CAS_02_dynamicLoadout_F"): {
        _vehicle setPylonLoadout [1, "rksla3_mag_python3_directx1", true, [-1]];
        _vehicle setPylonLoadout [2, "rksla3_mag_ba21_rack_x4", true, [-1]];
        _vehicle setPylonLoadout [3, "PylonRack_20Rnd_Rocket_03_HE_F", true, [-1]];
        _vehicle setPylonLoadout [4, "PylonMissile_LK_LS6_100KG_X6", true, [-1]];
        _vehicle setPylonLoadout [5, "PylonMissile_1Rnd_BombCluster_02_F", true, [-1]];
        _vehicle setPylonLoadout [6, "PylonMissile_1Rnd_BombCluster_02_F", true, [-1]];
        _vehicle setPylonLoadout [7, "PylonMissile_LK_LS6_100KG_X6", true, [-1]];
        _vehicle setPylonLoadout [8, "PylonRack_20Rnd_Rocket_03_HE_F", true, [-1]];
        _vehicle setPylonLoadout [9, "rksla3_mag_ba21_rack_x4", true, [-1]];
        _vehicle setPylonLoadout [10, "rksla3_mag_python3_directx1", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "E22_O_RAF_Plane_Fighter_02_F"): {
        _vehicle setPylonLoadout [1, "PylonMissile_LK_PL10_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [2, "PylonMissile_LK_PL10_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [3, "PylonMissile_LK_PL15_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [4, "PylonMissile_LK_PL15_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [5, "rksla3_mag_kab500l_directx1", true, [-1]];
        _vehicle setPylonLoadout [6, "rksla3_mag_kab500l_directx1", true, [-1]];
        _vehicle setPylonLoadout [7, "rksla3_mag_pl10_directx1", true, [-1]];
        _vehicle setPylonLoadout [8, "rksla3_mag_pl10_directx1", true, [-1]];
        _vehicle setPylonLoadout [9, "rksla3_mag_pl12_directx1", true, [-1]];
        _vehicle setPylonLoadout [10, "rksla3_mag_pl12_directx1", true, [-1]];
        _vehicle setPylonLoadout [11, "rksla3_mag_pl12_directx1", true, [-1]];
        _vehicle setPylonLoadout [12, "rksla3_mag_pl12_directx1", true, [-1]];
        _vehicle setPylonLoadout [13, "rksla3_mag_kab500l_directx1", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "E22_O_RAF_Plane_Fighter_02_Stealth_F"): {
        _vehicle setPylonLoadout [1, "", true, [-1]];
        _vehicle setPylonLoadout [2, "", true, [-1]];
        _vehicle setPylonLoadout [3, "", true, [-1]];
        _vehicle setPylonLoadout [4, "", true, [-1]];
        _vehicle setPylonLoadout [5, "", true, [-1]];
        _vehicle setPylonLoadout [6, "", true, [-1]];
        _vehicle setPylonLoadout [7, "rksla3_mag_pl9_direct", true, [-1]];
        _vehicle setPylonLoadout [8, "rksla3_mag_pl9_direct", true, [-1]];
        _vehicle setPylonLoadout [9, "rksla3_mag_pl12_directx1", true, [-1]];
        _vehicle setPylonLoadout [10, "rksla3_mag_pl12_directx1", true, [-1]];
        _vehicle setPylonLoadout [11, "PylonMissile_LK_PL15_AAM_X1", true, [-1]];
        _vehicle setPylonLoadout [12, "PylonMissile_LK_PL15_AAM_X1", true, [-1]];
        _vehicle setPylonLoadout [13, "PylonMissile_LK_PL15_AAM_X2", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "FA_Mig29_AAF"): {
        _vehicle setPylonLoadout [1, "PV_PylonMissile_B_Bomb_LizardII_x1", true, [-1]];
        _vehicle setPylonLoadout [2, "PV_PylonMissile_B_Bomb_LizardII_x1", true, [-1]];
        _vehicle setPylonLoadout [3, "rksla3_mag_agm88_lau118", true, [-1]];
        _vehicle setPylonLoadout [4, "PV_PylonRack_B_BRU55_Missile_AGM65E2_x2", true, [-1]];
        _vehicle setPylonLoadout [5, "rksla3_mag_matra530_directx1", true, [-1]];
        _vehicle setPylonLoadout [6, "rksla3_mag_matra530_directx1", true, [-1]];
        _vehicle setPylonLoadout [7, "rksla3_mag_irist_directx1", true, [-1]];
        _vehicle setPylonLoadout [8, "rksla3_mag_irist_directx1", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "FA_Mig29_CSAT_Trop"): {
        _vehicle setPylonLoadout [1, "sab_milavi_3rnd_fab250_mag", true, [-1]];
        _vehicle setPylonLoadout [2, "sab_milavi_3rnd_fab250_mag", true, [-1]];
        _vehicle setPylonLoadout [3, "PylonMissile_Missile_AGM_KH25_x1", true, [-1]];
        _vehicle setPylonLoadout [4, "PylonMissile_Missile_AGM_KH25_x1", true, [-1]];
        _vehicle setPylonLoadout [5, "rksla3_mag_derbyer_lau127x1", true, [-1]];
        _vehicle setPylonLoadout [6, "rksla3_mag_derbyer_lau7x1", true, [-1]];
        _vehicle setPylonLoadout [7, "rksla3_mag_R73_directx1", true, [-1]];
        _vehicle setPylonLoadout [8, "rksla3_mag_R73_directx1", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "I_Heli_light_03_dynamicLoadout_F"): {
        _vehicle setPylonLoadout [1, "rksla3_mag_crv7_M264_lau5003_Domed_x19", true, [-1]];
        _vehicle setPylonLoadout [2, "rksla3_mag_crv7_M264_lau5003_Domed_x19", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "I_Plane_Fighter_03_dynamicLoadout_F"): {
        _vehicle setPylonLoadout [1, "PV_PylonRack_B_LAU139_Missile_AIM9M_x2", true, [-1]];
        _vehicle setPylonLoadout [2, "rksla3_mag_sneb_68mm_short_x16", true, [-1]];
        _vehicle setPylonLoadout [3, "PV_PylonMissile_B_Bomb_LizardII_x1", true, [-1]];
        _vehicle setPylonLoadout [4, "PV_PylonWeapon_A_GunPod_Fus_20mm_1x", true, [-1]];
        _vehicle setPylonLoadout [5, "PV_PylonMissile_B_Bomb_LizardII_x1", true, [-1]];
        _vehicle setPylonLoadout [6, "rksla3_mag_sneb_68mm_short_x16", true, [-1]];
        _vehicle setPylonLoadout [7, "PV_PylonRack_B_LAU139_Missile_AIM9M_x2", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "I_Plane_Fighter_04_F"): {
        _vehicle setPylonLoadout [1, "rksla3_mag_aim132_directx1", true, [-1]];
        _vehicle setPylonLoadout [2, "rksla3_mag_aim132_directx1", true, [-1]];
        _vehicle setPylonLoadout [3, "rksla3_mag_brimstone_3_x3", true, [-1]];
        _vehicle setPylonLoadout [4, "PV_PylonRack_B_CLB30_Bomb_GBU12_x2", true, [-1]];
        _vehicle setPylonLoadout [5, "rksla3_mag_meteor_directx1", true, [-1]];
        _vehicle setPylonLoadout [6, "rksla3_mag_meteor_directx1", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "JS_JC_SU35"): {
        _vehicle setPylonLoadout [1, "rksla3_mag_R73_directx1", true, [-1]];
        _vehicle setPylonLoadout [2, "rksla3_mag_R73_directx1", true, [-1]];
        _vehicle setPylonLoadout [3, "PylonMissile_LK_PL15_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [4, "PylonMissile_LK_PL15_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [5, "rksla3_mag_r77_direct", true, [-1]];
        _vehicle setPylonLoadout [6, "rksla3_mag_r77_direct", true, [-1]];
        _vehicle setPylonLoadout [7, "PylonMissile_Missile_AGM_KH25_x1", true, [-1]];
        _vehicle setPylonLoadout [8, "PylonMissile_Missile_AGM_KH25_x1", true, [-1]];
        _vehicle setPylonLoadout [9, "PylonMissile_LK_LS6_500KG_X1", true, [-1]];
        _vehicle setPylonLoadout [10, "PylonMissile_LK_LS6_500KG_X1", true, [-1]];
        _vehicle setPylonLoadout [11, "rksla3_mag_as30l_x1", true, [-1]];
        _vehicle setPylonLoadout [12, "rksla3_mag_as30l_x1", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "PLAAF_Fighter_J10"): {
        _vehicle setPylonLoadout [1, "PylonMissile_LK_PL10_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [2, "PylonMissile_LK_PL15_AAM_X1", true, [-1]];
        _vehicle setPylonLoadout [3, "PylonMissile_LK_LS6_100KG_X3", true, [-1]];
        _vehicle setPylonLoadout [4, "PylonMissile_LK_LS6_100KG_X3", true, [-1]];
        _vehicle setPylonLoadout [5, "PylonMissile_LK_PL15_AAM_X1", true, [-1]];
        _vehicle setPylonLoadout [6, "PylonMissile_LK_PL10_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [7, "PylonMissile_LK_LS6_500KG_X1", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "PLAAF_Fighter_J11"): {
        _vehicle setPylonLoadout [1, "PylonMissile_LK_PL10_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [2, "rksla3_mag_pl12_aku470x1", true, [-1]];
        _vehicle setPylonLoadout [3, "rksla3_mag_pl12_aku470x1", true, [-1]];
        _vehicle setPylonLoadout [4, "rksla3_mag_pl12_aku470x1", true, [-1]];
        _vehicle setPylonLoadout [5, "rksla3_mag_pl12_aku470x1", true, [-1]];
        _vehicle setPylonLoadout [6, "PylonMissile_LK_PL10_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [7, "PylonMissile_LK_PL15_AAM_X1", true, [-1]];
        _vehicle setPylonLoadout [8, "PylonMissile_LK_PL15_AAM_X1", true, [-1]];
        _vehicle setPylonLoadout [9, "PylonMissile_LK_PL15_AAM_X1", true, [-1]];
        _vehicle setPylonLoadout [10, "PylonMissile_LK_PL15_AAM_X1", true, [-1]];
        _vehicle setPylonLoadout [11, "rksla3_mag_pl9_apu68x1", true, [-1]];
        _vehicle setPylonLoadout [12, "rksla3_mag_pl9_apu68x1", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "PLAAF_Fighter_J15"): {
        _vehicle setPylonLoadout [1, "PylonMissile_LK_PL10_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [2, "rksla3_mag_pl12_directx1", true, [-1]];
        _vehicle setPylonLoadout [3, "PylonMissile_LK_PL15_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [4, "PylonMissile_LK_PL15_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [5, "rksla3_mag_pl12_directx1", true, [-1]];
        _vehicle setPylonLoadout [6, "PylonMissile_LK_PL10_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [7, "PylonMissile_LK_YJ9E_AGM_X2", true, [-1]];
        _vehicle setPylonLoadout [8, "PylonMissile_LK_YJ9E_AGM_X2", true, [-1]];
        _vehicle setPylonLoadout [9, "PylonMissile_LK_YJ91_AGM_X1", true, [-1]];
        _vehicle setPylonLoadout [10, "PylonMissile_LK_YJ91_AGM_X1", true, [-1]];
        _vehicle setPylonLoadout [11, "rksla3_mag_pl9_direct", true, [-1]];
        _vehicle setPylonLoadout [12, "rksla3_mag_pl9_direct", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "PLAAF_Fighter_J16"): {
        _vehicle setPylonLoadout [1, "PylonMissile_LK_PL15_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [2, "rksla3_mag_kh25mp_direct", true, [-1]];
        _vehicle setPylonLoadout [3, "rksla3_mag_kh59mk2_directx1", true, [-1]];
        _vehicle setPylonLoadout [4, "rksla3_mag_kh59mk2_directx1", true, [-1]];
        _vehicle setPylonLoadout [5, "rksla3_mag_kh25mp_direct", true, [-1]];
        _vehicle setPylonLoadout [6, "PylonMissile_LK_PL15_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [7, "PylonMissile_LK_YJ91_AGM_X1", true, [-1]];
        _vehicle setPylonLoadout [8, "PylonMissile_LK_YJ91_AGM_X1", true, [-1]];
        _vehicle setPylonLoadout [9, "PylonMissile_LK_LS6_500KG_X1", true, [-1]];
        _vehicle setPylonLoadout [10, "rksla3_mag_practice_14kg_cbls_x4", true, [-1]];
        _vehicle setPylonLoadout [11, "PylonMissile_LK_PL10_AAM_X1", true, [-1]];
        _vehicle setPylonLoadout [12, "PylonMissile_LK_PL10_AAM_X1", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "PLAAF_Fighter_J20"): {
        _vehicle setPylonLoadout [1, "PylonMissile_LK_PL10_AAM_X1", true, [-1]];
        _vehicle setPylonLoadout [2, "PylonMissile_LK_PL10_AAM_X1", true, [-1]];
        _vehicle setPylonLoadout [3, "PylonMissile_LK_PL15_AAM_X1", true, [-1]];
        _vehicle setPylonLoadout [4, "PylonMissile_LK_PL15_AAM_X1", true, [-1]];
        _vehicle setPylonLoadout [5, "PylonMissile_LK_PL15_AAM_X1", true, [-1]];
        _vehicle setPylonLoadout [6, "PylonMissile_LK_PL15_AAM_X1", true, [-1]];
        _vehicle setPylonLoadout [7, "PylonMissile_LK_PL15_AAM_X1", true, [-1]];
        _vehicle setPylonLoadout [8, "PylonMissile_LK_PL15_AAM_X1", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "sab_etendard_o"): {
        _vehicle setPylonLoadout [1, "rksla3_mag_k13_aku470x1", true, [-1]];
        _vehicle setPylonLoadout [2, "rksla3_mag_ba21_rack_x4", true, [-1]];
        _vehicle setPylonLoadout [3, "sab_milavi_3rnd_fab250_mag", true, [-1]];
        _vehicle setPylonLoadout [4, "rksla3_mag_k13_aku470x1", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "sab_magister_o"): {
        _vehicle setPylonLoadout [1, "PV_PylonWeapon_A_GunPod_Fus_20mm_1x", true, [-1]];
        _vehicle setPylonLoadout [2, "LK_57mmRocketX40_HE", true, [-1]];
        _vehicle setPylonLoadout [3, "PV_PylonRack_B_CLB30_Bomb_Mk82_x2", true, [-1]];
        _vehicle setPylonLoadout [4, "PV_PylonWeapon_A_GunPod_Fus_20mm_1x", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "sab_mirageiv_o"): {
        _vehicle setPylonLoadout [1, "rksla3_mag_pl10_apu68x1", true, [-1]];
        _vehicle setPylonLoadout [2, "rksla3_mag_us_pw2_gbu12_bru57_x2", true, [-1]];
        _vehicle setPylonLoadout [3, "rksla3_mag_us_pw2_gbu12_bru57_x2", true, [-1]];
        _vehicle setPylonLoadout [4, "sab_milavi_3rnd_fab250_mag", true, [-1]];
        _vehicle setPylonLoadout [5, "rksla3_mag_uk_pw2_1000_bru57_x2", true, [-1]];
        _vehicle setPylonLoadout [6, "sab_milavi_3rnd_fab250_mag", true, [-1]];
        _vehicle setPylonLoadout [7, "rksla3_mag_us_pw2_gbu12_bru57_x2", true, [-1]];
        _vehicle setPylonLoadout [8, "rksla3_mag_us_pw2_gbu12_bru57_x2", true, [-1]];
        _vehicle setPylonLoadout [9, "rksla3_mag_pl10_apu68x1", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "sab_mystere_o"): {
        _vehicle setPylonLoadout [1, "rksla3_mag_r60_apu13mtx1", true, [-1]];
        _vehicle setPylonLoadout [2, "rksla3_mag_pl10_apu68x1", true, [-1]];
        _vehicle setPylonLoadout [3, "rksla3_mag_pl10_apu68x1", true, [-1]];
        _vehicle setPylonLoadout [4, "rksla3_mag_r60_apu13mtx1", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "sab_su34_I"): {
        _vehicle setPylonLoadout [1, "rksla3_mag_python5_directx1", true, [-1]];
        _vehicle setPylonLoadout [2, "rksla3_mag_matra530_directx1", true, [-1]];
        _vehicle setPylonLoadout [3, "rksla3_mag_alarm_rail", true, [-1]];
        _vehicle setPylonLoadout [4, "rksla3_mag_kepd350_directx1", true, [-1]];
        _vehicle setPylonLoadout [5, "rksla3_mag_gbu54_bru57_x2", true, [-1]];
        _vehicle setPylonLoadout [6, "rksla3_mag_uk_pw4_500_directx1", true, [-1]];
        _vehicle setPylonLoadout [7, "rksla3_mag_durandal_ter3", true, [-1]];
        _vehicle setPylonLoadout [8, "rksla3_mag_gbu54_bru57_x2", true, [-1]];
        _vehicle setPylonLoadout [9, "rksla3_mag_kepd350_directx1", true, [-1]];
        _vehicle setPylonLoadout [10, "rksla3_mag_alarm_rail", true, [-1]];
        _vehicle setPylonLoadout [11, "rksla3_mag_matra530_directx1", true, [-1]];
        _vehicle setPylonLoadout [12, "rksla3_mag_python5_directx1", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "sab_su34_O"): {
        _vehicle setPylonLoadout [1, "rksla3_mag_python5_directx1", true, [-1]];
        _vehicle setPylonLoadout [2, "rksla3_mag_pl12_directx1", true, [-1]];
        _vehicle setPylonLoadout [3, "Su_KH31_magazine", true, [-1]];
        _vehicle setPylonLoadout [4, "PylonMissile_Missile_KH58_x1", true, [-1]];
        _vehicle setPylonLoadout [5, "sab_milavi_2rnd_fab250_mag", true, [-1]];
        _vehicle setPylonLoadout [6, "rksla3_mag_pab100_x18", true, [-1]];
        _vehicle setPylonLoadout [7, "rksla3_mag_us_pw2_gbu10_directx1", true, [-1]];
        _vehicle setPylonLoadout [8, "sab_milavi_2rnd_fab250_mag", true, [-1]];
        _vehicle setPylonLoadout [9, "PylonMissile_Missile_KH58_x1", true, [-1]];
        _vehicle setPylonLoadout [10, "Su_KH31_magazine", true, [-1]];
        _vehicle setPylonLoadout [11, "rksla3_mag_pl12_directx1", true, [-1]];
        _vehicle setPylonLoadout [12, "rksla3_mag_python5_directx1", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "Su33_Protatype_PT_2"): {
        _vehicle setPylonLoadout [1, "PylonMissile_LK_PL10_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [2, "PylonMissile_LK_PL10_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [3, "Su_KH31_magazine", true, [-1]];
        _vehicle setPylonLoadout [4, "Su_KH31_magazine", true, [-1]];
        _vehicle setPylonLoadout [5, "PylonMissile_Bomb_KAB250_x1", true, [-1]];
        _vehicle setPylonLoadout [6, "PylonMissile_Bomb_KAB250_x1", true, [-1]];
        _vehicle setPylonLoadout [7, "PylonMissile_Bomb_KAB250_x1", true, [-1]];
        _vehicle setPylonLoadout [8, "PylonMissile_Bomb_KAB250_x1", true, [-1]];
        _vehicle setPylonLoadout [9, "PylonMissile_LK_PL15_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [10, "PylonMissile_LK_PL15_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [11, "rksla3_mag_k13_directx1", true, [-1]];
        _vehicle setPylonLoadout [12, "rksla3_mag_k13_directx1", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "TEC_VH_WD_Helicopter_Kajman"): {
        _vehicle setPylonLoadout [1, "PylonRack_4Rnd_LG_scalpel", true, [0]];
        _vehicle setPylonLoadout [2, "PylonRack_19Rnd_Rocket_Skyfire", true, [0]];
        _vehicle setPylonLoadout [3, "PylonRack_19Rnd_Rocket_Skyfire", true, [0]];
        _vehicle setPylonLoadout [4, "PylonRack_4Rnd_LG_scalpel", true, [0]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "TEC_VH_WD_Helicopter_Keftar"): {
        _vehicle setPylonLoadout [1, "PylonRack_4Rnd_LG_scalpel", true, [-1]];
        _vehicle setPylonLoadout [2, "PylonRack_19Rnd_Rocket_Skyfire", true, [-1]];
        _vehicle setPylonLoadout [3, "PylonWeapon_300Rnd_20mm_shells", true, [-1]];
        _vehicle setPylonLoadout [4, "PylonRack_4Rnd_LG_scalpel", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "TEC_VH_WD_Helicopter_Orca_Armed"): {
        _vehicle setPylonLoadout [1, "PV_PylonWeapon_A_GunPod_Fus_20mm_1x", true, [-1]];
        _vehicle setPylonLoadout [2, "rksla3_mag_sneb_68mm_long_x16", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "TEC_VH_WD_Jet_Neophron"): {
        _vehicle setPylonLoadout [1, "rksla3_mag_r60_aku470x1", true, [-1]];
        _vehicle setPylonLoadout [2, "rksla3_mag_kh25mp_direct", true, [-1]];
        _vehicle setPylonLoadout [3, "rksla3_mag_sneb_68mm_long_x16", true, [-1]];
        _vehicle setPylonLoadout [4, "PylonMissile_Missile_AGM_KH25_x1", true, [-1]];
        _vehicle setPylonLoadout [5, "PylonMissile_LK_LS6_100KG_X3", true, [-1]];
        _vehicle setPylonLoadout [6, "PylonMissile_LK_LS6_100KG_X3", true, [-1]];
        _vehicle setPylonLoadout [7, "PylonRack_1Rnd_Missile_AGM_01_F", true, [-1]];
        _vehicle setPylonLoadout [8, "rksla3_mag_sneb_68mm_long_x16", true, [-1]];
        _vehicle setPylonLoadout [9, "rksla3_mag_kh25mp_direct", true, [-1]];
        _vehicle setPylonLoadout [10, "rksla3_mag_r60_aku470x1", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "TEC_VH_WD_Jet_Shikra"): {
        _vehicle setPylonLoadout [1, "PylonMissile_LK_PL10_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [2, "PylonMissile_LK_PL10_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [3, "rksla3_mag_kh25ml_directx1", true, [-1]];
        _vehicle setPylonLoadout [4, "rksla3_mag_kh25ml_directx1", true, [-1]];
        _vehicle setPylonLoadout [5, "rksla3_mag_kh25ml_directx1", true, [-1]];
        _vehicle setPylonLoadout [6, "rksla3_mag_kh25ml_directx1", true, [-1]];
        _vehicle setPylonLoadout [7, "PylonMissile_Missile_AA_R73_x1", true, [-1]];
        _vehicle setPylonLoadout [8, "PylonMissile_Missile_AA_R73_x1", true, [-1]];
        _vehicle setPylonLoadout [9, "PylonMissile_Missile_AA_R77_x1", true, [-1]];
        _vehicle setPylonLoadout [10, "PylonMissile_Missile_AA_R77_x1", true, [-1]];
        _vehicle setPylonLoadout [11, "PylonMissile_Missile_AA_R77_INT_x1", true, [-1]];
        _vehicle setPylonLoadout [12, "PylonMissile_Missile_AA_R77_INT_x1", true, [-1]];
        _vehicle setPylonLoadout [13, "rksla3_mag_bgl1000_direct", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "TEC_VH_WD_Jet_Shikra_Stealth"): {
        _vehicle setPylonLoadout [1, "", true, [-1]];
        _vehicle setPylonLoadout [2, "", true, [-1]];
        _vehicle setPylonLoadout [3, "", true, [-1]];
        _vehicle setPylonLoadout [4, "", true, [-1]];
        _vehicle setPylonLoadout [5, "", true, [-1]];
        _vehicle setPylonLoadout [6, "", true, [-1]];
        _vehicle setPylonLoadout [7, "PylonMissile_LK_PL10_AAM_X1", true, [-1]];
        _vehicle setPylonLoadout [8, "PylonMissile_LK_PL10_AAM_X1", true, [-1]];
        _vehicle setPylonLoadout [9, "PylonMissile_LK_PL10_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [10, "PylonMissile_LK_PL10_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [11, "PylonMissile_LK_PL15_AAM_X1", true, [-1]];
        _vehicle setPylonLoadout [12, "PylonMissile_LK_PL15_AAM_X1", true, [-1]];
        _vehicle setPylonLoadout [13, "PylonMissile_LK_LS6_500KG_X1", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "TEC_VH_WD_Plane_Shahan"): {
        _vehicle setPylonLoadout [1, "PylonMissile_LK_PL10_AAM_X2", true, [-1]];
        _vehicle setPylonLoadout [2, "rksla3_mag_pl12_aku470x1", true, [-1]];
        _vehicle setPylonLoadout [3, "PylonMissile_LK_YJ9E_AGM_X2", true, [-1]];
        _vehicle setPylonLoadout [4, "PylonMissile_1Rnd_Bomb_03_F", true, [-1]];
        _vehicle setPylonLoadout [5, "PylonMissile_1Rnd_Bomb_03_F", true, [-1]];
        _vehicle setPylonLoadout [6, "PylonMissile_LK_YJ9E_AGM_X2", true, [-1]];
        _vehicle setPylonLoadout [7, "rksla3_mag_pl12_aku470x1", true, [-1]];
        _vehicle setPylonLoadout [8, "PylonMissile_LK_PL10_AAM_X2", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "Z10"): {
        _vehicle setPylonLoadout [1, "rksla3_mag_ty90_x4_rack", true, [-1]];
        _vehicle setPylonLoadout [2, "LK_AKD10X4_AG", true, [0]];
        _vehicle setPylonLoadout [3, "LK_AKD10X4_AG", true, [0]];
        _vehicle setPylonLoadout [4, "LK_57mmRocketX19_HE", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    case (_vehicle isKindOf "Z11WA"): {
        _vehicle setPylonLoadout [1, "rksla3_mag_furypgm_x2l", true, [-1]];
        _vehicle setPylonLoadout [2, "rksla3_mag_qjk99_127x108_Ball_x250", true, [-1]];
        _vehicle setPylonLoadout [3, "LK_57mmRocketX19_HE", true, [-1]];
        _vehicle setPylonLoadout [4, "LK_57mmRocketX19_HE", true, [-1]];
        _vehicle setPylonLoadout [5, "rksla3_mag_qjk99_127x108_Ball_x250", true, [-1]];
        _vehicle setPylonLoadout [6, "rksla3_mag_furypgm_x2l", true, [-1]];
        {_vehicle removeWeapon _x} forEach (weapons _vehicle select {_vehicle ammo _x < 1});
    };
    // QAV - AbramsX
    case (_vehicle isKindOf "qav_abramsx_base"): {
        [_vehicle, WHF_aps_ammoMBT] call WHF_fnc_addAPS;
        _vehicle addMagazineTurret ["16Rnd_120mm_HE_shells_Tracer_Red", [0]];
    };
    // BWMod
    case (_vehicle isKindOf "BWA3_Dingo2_base"): {
        [_vehicle, WHF_aps_ammoMRAP] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "BWA3_Eagle_base"): {
        [_vehicle, WHF_aps_ammoMRAP] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "BWA3_Leopard_base"): {
        [_vehicle, WHF_aps_ammoMBT] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "BWA3_Puma_base"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    // CUP
    case (_vehicle isKindOf "CUP_AAV_Base"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_Boxer_Base"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_Challenger2_base"): {
        [_vehicle, WHF_aps_ammoMBT] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_Dingo_Base"): {
        [_vehicle, WHF_aps_ammoMRAP] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_FV510_Base"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_LAV25_Base"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_M1A2Abrams_Base"): {
        [_vehicle, WHF_aps_ammoMBT] call WHF_fnc_addAPS;
        private _AP = "CUP_1Rnd_TE1_Red_Tracer_120mm_M829A4_M256_Cannon_M";
        private _HT = "CUP_1Rnd_TE1_Red_Tracer_120mm_M830A1_M256_Cannon_M";
        private _HE = "CUP_1Rnd_TE1_Red_Tracer_120mm_M908_M256_Cannon_M";
        _vehicle removeMagazinesTurret [_AP, [0]];
        _vehicle removeMagazinesTurret [_HT, [0]];
        _vehicle addMagazinesTurret [_AP, [0], 15];
        _vehicle addMagazinesTurret [_HT, [0], 20];
        _vehicle addMagazinesTurret [_HE, [0], 10];
    };
    case (_vehicle isKindOf "CUP_M2Bradley_Base"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_Mastiff_Base"): {
        [_vehicle, WHF_aps_ammoMRAP] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_MCV80_Base"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_RG31_BASE"): {
        [_vehicle, WHF_aps_ammoMRAP] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_Ridgback_Base"): {
        [_vehicle, WHF_aps_ammoMRAP] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_StrykerBase"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_T90M_Base"): {
        [_vehicle, WHF_aps_ammoMBT] call WHF_fnc_addAPS;
    };
    // Expeditionary Forces
    case (_vehicle isKindOf "EF_AAV9_Base"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    // Vanilla
    case (_vehicle isKindOf "AFV_Wheeled_01_base_F"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "APC_Tracked_01_base_F"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "APC_Tracked_02_base_F"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "APC_Tracked_03_base_F"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "APC_Wheeled_01_base_F"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "APC_Wheeled_02_base_F"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "APC_Wheeled_03_base_F"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "MBT_01_mlrs_base_F"): {
        [_vehicle, WHF_aps_ammoMBT] call WHF_fnc_addAPS;
        _vehicle addMagazinesTurret ["12Rnd_230mm_rockets_cluster", [0], 1];
    };
    case (_vehicle isKindOf "MBT_01_base_F"): {
        [_vehicle, WHF_aps_ammoMBT] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "MBT_02_base_F"): {
        [_vehicle, WHF_aps_ammoMBT] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "MBT_03_base_F"): {
        [_vehicle, WHF_aps_ammoMBT] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "MBT_04_base_F"): {
        [_vehicle, WHF_aps_ammoMBT] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "MRAP_01_base_F"): {
        [_vehicle, WHF_aps_ammoMRAP] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "MRAP_02_base_F"): {
        [_vehicle, WHF_aps_ammoMRAP] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "MRAP_03_base_F"): {
        [_vehicle, WHF_aps_ammoMRAP] call WHF_fnc_addAPS;
    };
};
