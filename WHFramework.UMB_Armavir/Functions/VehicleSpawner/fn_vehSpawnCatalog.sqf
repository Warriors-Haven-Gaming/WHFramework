private _VERSION_NUMBER = 1;
// The version number for the vehicle catalog.
//
// Should be incremented only if the mission introduces a backwards-incompatible
// change to the structure and instructions have been followed to migrate
// this configuration to the new version.

private _carsCooldown = 300;
private _cars = [
    // Classname                         cooldown (-1 to use category cooldown)
    // |                                 |    whitelisted roles (see roles.sqf)
    ["cup_c_octavia_civ",               [60,  []]],
    ["c_offroad_02_unarmed_f",          [60,  []]],
    ["cup_i_hilux_unarmed_napa",        [60,  []]],
    ["cup_b_nm1038_4s_df_usa_wdl",      [-1,  []]],
    ["cup_b_lr_special_m2_gb_w",        [-1,  []]],
    ["cup_b_lr_special_gmg_gb_w",       [-1,  []]],
    ["cup_b_nm1025_sov_m2_usa_wdl",     [-1,  []]],
    ["cup_b_nm1036_tow_df_usa_wdl",     [-1,  []]],
    ["cup_b_nm1151_ogpk_m2_df_usa_wdl", [-1,  []]],
    ["cup_b_nm1151_ogpk_m2_usa_wdl",    [-1,  []]],
    ["cup_b_m1165_gmv_wdl_usa",         [-1,  []]],
    ["ef_b_pickup_mjtf_des",            [120, []]],
    ["ef_b_pickup_comms_mjtf_des",      [120, []]],
    ["ef_b_pickup_mmg_mjtf_des",        [180, []]],
    ["b_lsv_01_unarmed_f",              [120, []]],
    ["b_lsv_01_armed_f",                [-1,  []]],
    ["b_lsv_01_at_f",                   [-1,  []]],
    ["e22_b_jtf_lsv_02_unarmed_f",      [60,  []]],
    ["e22_b_jtf_d_lsv_02_unarmed_f",    [-1,  []]],
    ["e22_b_jtf_lsv_02_armed_f",        [-1,  []]],
    ["e22_b_jtf_d_lsv_02_armed_f",      [-1,  []]],
    ["e22_b_jtf_lsv_01_unarmed_f",      [-1,  []]],
    ["e22_b_jtf_d_lsv_01_unarmed_f",    [-1,  []]],
    ["e22_b_jtf_lsv_01_light_f",        [-1,  []]],
    ["e22_b_jtf_d_lsv_01_light_f",      [-1,  []]],
    ["e22_b_jtf_lsv_01_at_f",           [-1,  []]],
    ["e22_b_jtf_d_lsv_01_at_f",         [-1,  []]],
    ["", []] // Dummy element to assist with VCS tooling, may be removed
];

private _motorcyclesCooldown = 120;
private _motorcycles = [
    ["cup_b_m1030_usa",              [-1, []]],
    ["cup_i_tt650_napa",             [-1, []]],
    ["ef_b_quadbike_01_mjtf_des",    [-1, []]],
    ["e22_b_jtf_quadbike_01_f",      [-1, []]],
    ["e22_b_jtf_d_quadbike_01_f",    [-1, []]],
    ["nds_6x6_atv_mil",              [-1, []]],
    ["nds_6x6_atv_mil2",             [-1, []]],
    ["nds_6x6_atv_mil_empty",        [-1, []]],
    ["nds_6x6_atv_mil_lr",           [-1, []]],
    ["nds_6x6_atv_mil2_lr",          [-1, []]],
    ["nds_6x6_atv_civ",              [-1, []]],
    ["v12_yzf_vo",                   [-1, []]],
    ["v12_yzf_rouge",                [-1, []]],
    ["v12_yzf_noir",                 [-1, []]],
    ["v12_yzf_brosserg",             [-1, []]],
    ["v12_yzf_bc",                   [-1, []]],
    ["v12_tmax2017",                 [-1, []]],
    ["v12_yfz450_noir",              [-1, []]],
    ["v12_yfz450_gris",              [-1, []]],
    ["v12_yfz450_bleu",              [-1, []]],
    ["v12_yfz450_rouge",             [-1, []]],
    ["v12_kawasakih2_2017_vo",       [-1, []]],
    ["v12_kawasakih2_2017_rouge",    [-1, []]],
    ["v12_kawasakih2_2017_or",       [-1, []]],
    ["v12_kawasakih2_2017_noir",     [-1, []]],
    ["v12_kawaskaih2_2017_brosserd", [-1, []]],
    ["v12_kawasakih2_2017_brosserg", [-1, []]],
    ["v12_kawasakih2_2017_bc",       [-1, []]],
    ["v12_monkey_vo",                [-1, []]],
    ["v12_monkey_rouge",             [-1, []]],
    ["v12_monkey_or",                [-1, []]],
    ["v12_monkey_noir",              [-1, []]],
    ["v12_monkey_bc",                [-1, []]],
    ["v12_harleyknucklehead_VO",     [-1, []]],
    ["v12_harleyknucklehead_rouge",  [-1, []]],
    ["v12_harleyknucklehead_or",     [-1, []]],
    ["v12_harleyknucklehead_noir",   [-1, []]],
    ["v12_harleybobber_vo",          [-1, []]],
    ["v12_harleybobber_rouge",       [-1, []]],
    ["v12_harleybobber_mat",         [-1, []]],
    ["v12_harleybobber_brosserg",    [-1, []]],
    ["v12_harleybobber_bc",          [-1, []]],
    ["v12_diavel_nr",                [-1, []]],
    ["v12_diavel_br",                [-1, []]],
    ["v12_s1000rrstreet_vo",         [-1, []]],
    ["v12_s1000rrstreet_rouge",      [-1, []]],
    ["v12_s1000rrstreet_or",         [-1, []]],
    ["v12_s1000rrstreet_noir",       [-1, []]],
    ["v12_s1000rrstreet_brosserg",   [-1, []]],
    ["v12_s1000rrstreet_bc",         [-1, []]],
    ["v12_s1000rr2018_vo",           [-1, []]],
    ["v12_s1000rr2018_rouge",        [-1, []]],
    ["v12_s1000rr2018_or",           [-1, []]],
    ["v12_s1000rr2018_origine",      [-1, []]],
    ["v12_apriliarsv4_vo",           [-1, []]],
    ["v12_apriliarsv4_rouge",        [-1, []]],
    ["v12_apriliarsv4_or",           [-1, []]],
    ["v12_apriliarsv4_noir",         [-1, []]],
    ["v12_apriliarsv4_carbone",      [-1, []]],
    ["v12_ktm50cco",                 [-1, []]],
    ["v12_ktm50ccn",                 [-1, []]],
    ["v12_ktm50ccb",                 [-1, []]],
    ["v12_apriliamxv4504",           [-1, []]],
    ["v12_apriliamxv4503",           [-1, []]],
    ["v12_apriliamxv4502",           [-1, []]],
    ["v12_apriliamxv450",            [-1, []]],
    ["", []]
];

private _trucksCooldown = 300;
private _trucks = [
    ["c_van_01_transport_f",              [60, []]],
    ["c_van_01_box_f",                    [60, []]],
    ["c_van_01_fuel_f",                   [-1, []]],
    ["cup_b_t810_refuel_cz_wdl",          [-1, []]],
    ["cup_b_t810_reammo_cz_wdl",          [-1, []]],
    ["cup_b_nm1038_ammo_df_usa_wdl",      [-1, []]],
    ["b_truck_01_ammo_f",                 [-1, []]],
    ["b_truck_01_fuel_f",                 [-1, []]],
    ["b_truck_01_fft_rf",                 [-1, []]],
    ["b_truck_01_cargo_f",                [-1, []]],
    ["b_truck_01_flatbed_f",              [-1, []]],
    ["b_truck_01_transport_f",            [-1, []]],
    ["b_truck_01_covered_f",              [-1, []]],
    ["b_truck_01_box_f",                  [-1, []]],
    ["eug_hemtt_2",                       [-1, []]],
    ["eug_hemtt_1",                       [-1, []]],
    ["eug_hemtt_3",                       [-1, []]],
    ["eug_hemtt_4",                       [-1, []]],
    ["e22_b_jtf_truck_01_mover_f",        [-1, []]],
    ["e22_b_jtf_d_truck_01_mover_f",      [-1, []]],
    ["e22_b_jtf_truck_01_ammo_f",         [-1, []]],
    ["e22_b_jtf_d_truck_01_ammo_f",       [-1, []]],
    ["e22_b_jtf_truck_01_box_f",          [-1, []]],
    ["e22_b_jtf_d_truck_01_box_f",        [-1, []]],
    ["e22_b_jtf_truck_01_cargo_f",        [-1, []]],
    ["e22_b_jtf_d_truck_01_cargo_f",      [-1, []]],
    ["e22_b_jtf_truck_01_flatbed_f",      [-1, []]],
    ["e22_b_jtf_d_truck_01_flatbed_f",    [-1, []]],
    ["e22_b_jtf_truck_01_fuel_f",         [-1, []]],
    ["e22_b_jtf_d_truck_01_fuel_f",       [-1, []]],
    ["e22_b_jtf_truck_01_transport_f",    [-1, []]],
    ["e22_b_jtf_d_truck_01_transport_f",  [-1, []]],
    ["e22_b_jtf_truck_01_covered_f",      [-1, []]],
    ["e22_b_jtf_d_truck_01_covered_f",    [-1, []]],
    ["", []]
];

private _MRAPsCooldown = 300;
private _MRAPs = [
    ["b_mrap_01_f",               [-1,  []]],
    ["b_mrap_01_gmg_f",           [-1,  []]],
    ["b_mrap_01_hmg_f",           [-1,  []]],
    ["cup_b_rg31e_m2_od_usa",     [-1,  []]],
    ["cup_b_rg31_m2_od_usa",      [-1,  []]],
    ["cup_b_dingo_ger_wdl",       [-1,  []]],
    ["cup_b_ridgback_hmg_gb_w",   [-1,  []]],
    ["cup_b_mastiff_gmg_gb_w",    [600, []]],
    ["ef_b_mrap_01_mjtf_des",     [-1,  []]],
    ["ef_b_mrap_01_hmg_mjtf_des", [-1,  []]],
    ["ef_b_mrap_01_gmg_mjtf_des", [600, []]],
    ["ef_b_mrap_01_fsv_mjtf_des", [900, []]],
    ["ef_b_mrap_01_at_mjtf_des",  [900, []]],
    ["e22_b_jtf_mrap_01_f",       [-1, []]],
    ["e22_b_jtf_d_mrap_01_f",     [-1, []]],
    ["e22_b_jtf_mrap_01_hmg_f",   [-1, []]],
    ["e22_b_jtf_d_mrap_01_hmg_f", [-1, []]],
    ["e22_b_jtf_mrap_01_gmg_f",   [-1, []]],
    ["e22_b_jtf_d_mrap_01_gmg_f", [-1, []]],
    ["e22_b_jtf_mrap_01_at_f",    [-1, []]],
    ["e22_b_jtf_d_mrap_01_at_f",  [-1, []]],
    ["e22_b_jtf_mrap_01_fsv_f",   [-1, []]],
    ["e22_b_jtf_d_mrap_01_fsv_f", [-1, []]],
    ["e22_b_jtf_mrap_03_f",       [-1, []]],
    ["e22_b_jtf_d_mrap_03_f",     [-1, []]],
    ["e22_b_jtf_mrap_03_hmg_f",   [-1, []]],
    ["e22_b_jtf_d_mrap_03_hmg_f", [-1, []]],
    ["e22_b_jtf_mrap_03_gmg_f",   [-1, []]],
    ["e22_b_jtf_d_mrap_03_gmg_f", [-1, []]],
    ["", []]
];

private _APCsCooldown = 900;
private _APCs = [
    ["cup_b_m1130_cv_m2_woodland",           [600, []]],
    ["cup_b_m1135_atgmv_woodland",           [-1,  []]],
    ["cup_b_m1128_mgs_woodland",             [-1,  []]],
    ["cup_b_m1126_icv_mk19_woodland",        [600, []]],
    ["b_apc_wheeled_01_atgm_lxws",           [-1,  []]],
    ["b_d_apc_wheeled_01_cannon_lxws",       [-1,  []]],
    ["b_apc_wheeled_01_command_lxws",        [-1,  []]],
    ["b_apc_wheeled_01_cannon_f",            [-1,  []]],
    ["b_apc_tracked_01_rcws_f",              [-1,  []]],
    ["i_apc_wheeled_03_cannon_f",            [-1,  []]],
    ["i_apc_tracked_03_cannon_f",            [-1,  []]],
    ["e22_b_jtf_apc_wheeled_03_unarmed_f",   [600, []]],
    ["e22_b_jtf_d_apc_wheeled_03_unarmed_f", [600, []]],
    ["", []]
];

private _IFVsCooldown = 900;
private _IFVs = [
    ["cup_b_lav25m240_usmc",                 [600, []]],
    ["cup_b_m7bradley_usa_w",                [-1,  []]],
    ["cup_b_m2bradley_usa_w",                [-1,  []]],
    ["cup_b_m2a3bradley_usa_w",              [-1,  []]],
    ["cup_b_fv510_gb_w",                     [-1,  []]],
    ["cup_b_fv510_gb_w_slat",                [-1,  []]],
    ["cup_b_mcv80_gb_w",                     [-1,  []]],
    ["cup_b_mcv80_gb_w_slat",                [-1,  []]],
    ["cup_b_aav_usmc_tts",                   [600, []]],
    ["cup_b_boxer_gmg_ger_wdl",              [600, []]],
    ["cup_b_boxer_hmg_ger_wdl",              [600, []]],
    ["ef_b_aav9_mjtf_des",                   [-1,  []]],
    ["ef_b_aav9_50mm_mjtf_des",              [-1,  []]],
    ["e22_b_jtf_apc_wheeled_03_cannon_f",    [-1,  []]],
    ["e22_b_jtf_d_apc_wheeled_03_cannon_f",  [-1,  []]],
    ["", []]
];

private _utilityCooldown = 300;
private _utility = [
    ["cup_b_t810_repair_cz_wdl",       [-1,  ["engineer"]]],
    ["cup_b_nm1038_repair_df_usa_wdl", [-1,  ["engineer"]]],
    ["b_truck_01_repair_f",            [-1,  ["engineer"]]],
    ["b_apc_tracked_01_crv_f",         [600, ["engineer"]]],
    ["cup_b_nm997_df_usa_wdl",         [-1,  ["medic"]]],
    ["cup_b_m1133_mev_woodland",       [-1,  ["medic"]]],
    ["cup_b_fv432_gb_ambulance",       [-1,  ["medic"]]],
    ["b_truck_01_medical_f",           [-1,  ["medic"]]],
    ["e22_b_jtf_truck_01_medical_f",   [-1,  ["medic"]]],
    ["e22_b_jtf_d_truck_01_medical_f", [-1,  ["medic"]]],
    ["", []]
];

private _artilleryCooldown = 1800;
private _artillery = [
    ["cup_b_fv432_mortar",             [1200, ["arty"]]],
    ["cup_b_m1129_mc_mk19_woodland",   [1200, ["arty"]]],
    ["b_mbt_01_arty_f",                [-1,   ["arty"]]],
    ["cup_b_m270_he_baf_wood",         [-1,   ["arty"]]],
    ["cup_b_m270_dpicm_baf_wood",      [-1,   ["arty"]]],
    ["b_d_apc_wheeled_01_mortar_lxws", [1200, ["arty"]]],
    ["b_twinmortar_rf",                [2100, ["arty"]]],
    ["b_mbt_01_mlrs_f",                [-1,   ["arty"]]],
    ["b_mbt_01_mlrs_cluster",          [-1,   ["arty"]]],
    ["", []]
];

private _airdefenseCooldown = 900;
private _airdefense = [
    ["cup_b_m6linebacker_usa_w",               [-1,   ["aa"]]],
    ["cup_b_m163_vulcan_usa",                  [300,  ["aa"]]],
    ["cup_b_nm1097_avenger_usa_wdl",           [-1,   ["aa"]]],
    ["b_pickup_aat_rf",                        [300,  ["aa"]]],
    ["ef_b_mrap_01_laad_mjtf_des",             [-1,   ["aa"]]],
    ["b_apc_tracked_01_aa_f",                  [1200, ["aa"]]],
    ["b_t_pickup_aat_rf",                      [-1,   ["aa"]]],
    ["e22_b_jtf_mrap_01_laad_f",               [-1,   ["aa"]]],
    ["e22_b_jtf_d_mrap_01_laad_f",             [-1,   ["aa"]]],
    ["e22_b_jtf_apc_wheeled_03_cannon_aa_f",   [-1,   ["aa"]]],
    ["e22_b_jtf_d_apc_wheeled_03_cannon_aa_f", [-1,   ["aa"]]],
    ["b_apc_tracked_01_aa_f",                  [-1,   ["aa"]]],
    ["b_t_apc_tracked_01_aa_f",                [-1,   ["aa"]]],
    ["e22_b_jtf_truck_01_mover_f",             [-1,   ["aa"]]],
    ["e22_b_jtf_d_truck_01_mover_f",           [-1,   ["aa"]]],
    ["e22_b_jtf_radar_system_01_f",            [-1,   ["aa"]]],
    ["e22_b_jtf_d_radar_system_01_f",          [-1,   ["aa"]]],
    ["e22_b_jtf_sam_system_03_f",              [-1,   ["aa"]]],
    ["e22_b_jtf_d_sam_system_03_f",            [-1,   ["aa"]]],
    ["b_truck_02_camm_f",                      [-1,   ["aa"]]],
    ["b_truck_02_camm_er_f",                   [-1,   ["aa"]]],
    ["", []]
];

private _tanksCooldown = 1500;
private _tanks = [
    ["qav_abramsx",                          [-1,   ["engineer"]]],
    ["qav_abramsx_tusk",                     [-1,   ["engineer"]]],
    ["qav_abramsx_templar",                  [-1,   ["engineer"]]],
    ["cup_b_m1a2c_tusk_ii_woodland_us_army", [-1,   ["engineer"]]],
    ["cup_b_challenger2_woodland_baf",       [-1,   ["engineer"]]],
    ["cup_o_t90m_ru",                        [-1,   ["engineer"]]],
    ["b_d_mbt_01_tusk_lxws",                 [1000, ["engineer"]]],
    ["b_mbt_01_cannon_f",                    [-1,   ["engineer"]]],
    ["b_mbt_01_tusk_f",                      [-1,   ["engineer"]]],
    ["o_mbt_02_cannon_f",                    [-1,   ["engineer"]]],
    ["i_mbt_03_cannon_f",                    [-1,   ["engineer"]]],
    ["b_afv_wheeled_01_up_cannon_f",         [900,  ["engineer"]]],
    ["ef_b_mbt_01_tusk_mjtf_wdl",            [-1,   ["engineer"]]],
    ["ef_b_mbt_01_tusk_mjtf_des",            [-1,   ["engineer"]]],
    ["e22_b_jtf_mbt_03_cannon_f",            [-1,   ["engineer"]]],
    ["e22_b_jtf_d_mbt_03_cannon_f",          [-1,   ["engineer"]]],
    ["e22_b_jtf_mbt_03_cannon_up_f",         [-1,   ["engineer"]]],
    ["e22_b_jtf_d_mbt_03_cannon_up_f",       [-1,   ["engineer"]]],
    ["", []]
];

private _helicoptersCooldown = 300;
private _helicopters = [
    ["cup_b_ah6m_usa",                              [-1,  ["pilot_cas_heli"]]],
    ["cup_b_ah64d_dl_usa",                          [-1,  ["pilot_cas_heli"]]],
    ["cup_i_ah1z_dynamic_aaf",                      [-1,  ["pilot_cas_heli"]]],
    ["cup_i_mi24_mk4_aaf",                          [-1,  ["pilot_cas_heli"]]],
    ["cup_b_mi35_dynamic_cz_tiger",                 [-1,  ["pilot_cas_heli"]]],
    ["cup_b_aw159_rn_blackcat",                     [-1,  ["pilot_cas_heli"]]],
    ["b_heli_light_01_dynamicloadout_f",            [-1,  ["pilot_cas_heli"]]],
    ["b_heli_light_03_dynamicloadout_rf",           [-1,  ["pilot_cas_heli"]]],
    ["b_heli_attack_01_dynamicloadout_f",           [-1,  ["pilot_cas_heli"]]],
    ["b_heli_attack_01_pylons_dynamicloadout_f",    [-1,  ["pilot_cas_heli"]]],
    ["b_d_heli_light_01_dynamicloadout_lxws",       [-1,  ["pilot_cas_heli"]]],
    ["b_d_heli_attack_01_dynamicloadout_lxws",      [-1,  ["pilot_cas_heli"]]],
    ["ef_b_ah99j_nato",                             [-1,  ["pilot_cas_heli"]]],
    ["valor_attack_f",                              [-1,  ["pilot_cas_plane"]]],
    ["b_t_vtol_01_armed_f",                         [-1,  ["pilot_cas_plane"]]],
    ["o_heli_attack_02_dynamicloadout_f",           [-1,  ["pilot_cas_heli"]]],
    ["i_heli_light_03_dynamicloadout_f",            [-1,  ["pilot_cas_heli"]]],
    ["ef_b_heli_attack_01_dynamicLoadout_mjtf_wdl", [-1,  ["pilot_cas_heli"]]],
    ["ef_b_ah99j_nato",                             [-1,  ["pilot_cas_heli"]]],
    ["ef_b_ah99j_mjtf_wdl",                         [-1,  ["pilot_cas_heli"]]],
    ["ef_b_ah99j_nato_des",                         [-1,  ["pilot_cas_heli"]]],
    ["e22_b_jtf_heli_attack_03_f",                  [-1,  ["pilot_cas_heli"]]],
    ["e22_b_jtf_d_heli_attack_03_f",                [-1,  ["pilot_cas_heli"]]],
    ["ej_ah1z",                                     [-1,  ["pilot_cas_heli"]]],
    ["cup_b_mh6m_usa",                              [-1,  []]],
    ["b_d_heli_light_01_lxws",                      [-1,  []]],
    ["cup_b_mh60l_dap_2x_us",                       [-1,  ["pilot_transport"]]],
    ["cup_b_mh47e_usa",                             [-1,  ["pilot_transport"]]],
    ["cup_b_ch53e_usmc",                            [-1,  ["pilot_transport"]]],
    ["valor_turret_transport_crewgun_f",            [600, ["pilot_transport"]]],
    ["valor_transport_armed_f",                     [600, ["pilot_transport"]]],
    ["valor_transport_armed_hmg_f",                 [600, ["pilot_transport"]]],
    ["valor_transport_unarmed_f",                   [600, ["pilot_transport"]]],
    ["b_t_vtol_01_infantry_f",                      [600, ["pilot_transport"]]],
    ["b_t_vtol_01_vehicle_f",                       [600, ["pilot_transport"]]],
    ["o_t_vtol_02_infantry_dynamicloadout_f",       [900, ["pilot_transport"]]],
    ["o_t_vtol_02_vehicle_dynamicloadout_f",        [900, ["pilot_transport", "pilot_cas_plane"]]],
    ["b_d_heli_transport_01_lxws",                  [-1,  ["pilot_transport"]]],
    ["b_heli_light_03_unarmed_rf",                  [-1,  ["pilot_transport"]]],
    ["b_heli_ec_04_military_rf",                    [-1,  ["pilot_transport"]]],
    ["b_heli_transport_01_f",                       [-1,  ["pilot_transport"]]],
    ["b_heli_transport_01_pylons_f",                [600, ["pilot_transport"]]],
    ["b_heli_transport_03_f",                       [-1,  ["pilot_transport"]]],
    ["b_heli_ec_03_rf",                             [-1,  ["pilot_transport"]]],
    ["jj_uh1h_doorgunner_ov",                       [-1,  ["pilot_transport"]]],
    ["i_heli_transport_02_f",                       [-1,  ["pilot_transport"]]],
    ["e22_b_jtf_heli_transport_01_f",               [-1,  ["pilot_transport"]]],
    ["e22_b_jtf_n_heli_transport_01_f",             [-1,  ["pilot_transport"]]],
    ["e22_b_jtf_d_heli_transport_01_f",             [-1,  ["pilot_transport"]]],
    ["ef_b_heli_transport_01_mjtf_wdl",             [-1,  ["pilot_transport"]]],
    ["ef_b_heli_transport_01_pylons_02_mjtf_wdl",   [-1,  ["pilot_transport"]]],
    ["ef_b_heli_transport_01_pylons_mjtf_wdl",      [-1,  ["pilot_transport"]]],
    ["ef_b_heli_transport_01_unarmed_mjtf_wdl",     [-1,  ["pilot_transport"]]],
    ["e22_b_jtf_heli_transport_03_unarmed_f",       [-1,  ["pilot_transport"]]],
    ["e22_b_jtf_n_heli_transport_03_unarmed_f",     [-1,  ["pilot_transport"]]],
    ["e22_b_jtf_d_heli_transport_03_unarmed_f",     [-1,  ["pilot_transport"]]],
    ["e22_b_jtf_heli_transport_03_f",               [-1,  ["pilot_transport"]]],
    ["e22_b_jtf_n_heli_transport_03_f",             [-1,  ["pilot_transport"]]],
    ["e22_b_jtf_d_heli_transport_03_f",             [-1,  ["pilot_transport"]]],
    ["e22_b_jtf_vtol_01_infantry_f",                [-1,  ["pilot_transport"]]],
    ["e22_b_jtf_d_vtol_01_infantry_f",              [-1,  ["pilot_transport"]]],
    ["e22_b_jtf_n_vtol_01_infantry_f",              [-1,  ["pilot_transport"]]],
    ["e22_b_jtf_vtol_01_vehicle_f",                 [-1,  ["pilot_transport"]]],
    ["e22_b_jtf_d_vtol_01_vehicle_f",               [-1,  ["pilot_transport"]]],
    ["e22_b_jtf_n_vtol_01_vehicle_f",               [-1,  ["pilot_transport"]]],
    ["", []]
];

private _planesCooldown = 300;
private _planes = [
    ["usaf_ac130u",                           [-1, ["pilot_cas_plane"]]],
    ["usaf_a10",                              [-1, ["pilot_cas_plane"]]],
    ["usaf_f22",                              [-1, ["pilot_cas_plane"]]],
    ["usaf_f22_ewp_aa",                       [-1, ["pilot_cas_plane"]]],
    ["usaf_f22_ewp_ag",                       [-1, ["pilot_cas_plane"]]],
    ["usaf_f22_heavy",                        [-1, ["pilot_cas_plane"]]],
    ["usaf_f35a",                             [-1, ["pilot_cas_plane"]]],
    ["usaf_f35a_light",                       [-1, ["pilot_cas_plane"]]],
    ["usaf_f35a_stealth",                     [-1, ["pilot_cas_plane"]]],
    ["peral_f16v",                            [-1, ["pilot_cas_plane"]]],
    ["f_35c",                                 [-1, ["pilot_cas_plane"]]],
    ["fa_emb312_at27m35_nato",                [-1, ["pilot_cas_plane"]]],
    ["cup_b_gr9_dyn_gb",                      [-1, ["pilot_cas_plane"]]],
    ["b_plane_cas_01_dynamicloadout_f",       [-1, ["pilot_cas_plane"]]],
    ["b_plane_fighter_01_f",                  [-1, ["pilot_cas_plane"]]],
    ["o_plane_cas_02_dynamicloadout_f",       [-1, ["pilot_cas_plane"]]],
    ["o_plane_fighter_02_f",                  [-1, ["pilot_cas_plane"]]],
    ["i_plane_fighter_03_dynamicloadout_f",   [-1, ["pilot_cas_plane"]]],
    ["i_plane_fighter_04_f",                  [-1, ["pilot_cas_plane"]]],
    ["e22_b_jtf_plane_fighter_01_f",          [-1, ["pilot_cas_plane"]]],
    ["e22_b_jtf_plane_fighter_01_light_f",    [-1, ["pilot_cas_plane"]]],
    ["e22_b_jtf_plane_fighter_01_stealth_f",  [-1, ["pilot_cas_plane"]]],
    ["b_plane_cas_01_dynamicLoadout_f",       [-1, ["pilot_cas_plane"]]],
    ["b_d_plane_cas_01_dynamicLoadout_lxws",  [-1, ["pilot_cas_plane"]]],
    ["e22_b_jtf_vtol_01_armed_f",             [-1, ["pilot_cas_plane"]]],
    ["e22_b_jtf_d_vtol_01_armed_f",           [-1, ["pilot_cas_plane"]]],
    ["e22_b_jtf_n_vtol_01_armed_f",           [-1, ["pilot_cas_plane"]]],
    ["fir_a10c",                              [-1, ["pilot_cas_plane"]]],
    ["fir_a10c_os",                           [-1, ["pilot_cas_plane"]]],
    ["fir_aV8b",                              [-1, ["pilot_cas_plane"]]],
    ["fir_f14b",                              [-1, ["pilot_cas_plane"]]],
    ["fir_f14d",                              [-1, ["pilot_cas_plane"]]],
    ["fir_f15c",                              [-1, ["pilot_cas_plane"]]],
    ["fir_f15ex",                             [-1, ["pilot_cas_plane"]]],
    ["fir_f15se",                             [-1, ["pilot_cas_plane"]]],
    ["fir_f16c",                              [-1, ["pilot_cas_plane"]]],
    ["fir_f16d",                              [-1, ["pilot_cas_plane"]]],
    ["fir_ea18g_na",                          [-1, ["pilot_cas_plane"]]],
    ["fir_fa18f_vfa2cag_2020",                [-1, ["pilot_cas_plane"]]],
    ["fir_f18d_rmaf",                         [-1, ["pilot_cas_plane"]]],
    ["fir_f18c_scar",                         [-1, ["pilot_cas_plane"]]],
    ["fir_f35b_darkgrey",                     [-1, ["pilot_cas_plane"]]],
    ["tornado_aws_uk_617",                    [-1, ["pilot_cas_plane"]]],
    ["tornado_aws_camo_uk",                   [-1, ["pilot_cas_plane"]]],
    ["tornado_aws_ecr_ger",                   [-1, ["pilot_cas_plane"]]],
    ["fir_f22_blank2",                        [-1, ["pilot_cas_plane"]]],
    ["fir_f23A_black",                        [-1, ["pilot_cas_plane"]]],
    ["f117a_nighthawk",                       [-1, ["pilot_cas_plane"]]],
    ["jk_b_us_u2s_f",                         [600, ["pilot_transport"]]],
    ["jk_b_us_mc130h_f",                      [600, ["pilot_transport"]]],
    ["jk_b_us_mc130j_f",                      [600, ["pilot_transport"]]],
    ["jk_b_us_c130j_30_cargo_f",              [600, ["pilot_transport"]]],
    ["jk_b_us_ec130j_f",                      [600, ["pilot_transport"]]],
    ["jk_b_us_hc130j_ii_f",                   [600, ["pilot_transport"]]],
    ["jk_b_us_kc130j_f",                      [600, ["pilot_transport"]]],
    ["jk_b_plane_transport_01_f",             [600, ["pilot_transport"]]],
    ["jk_b_wolves_pmc_c130tjk_f",             [600, ["pilot_transport"]]],
    ["c_plane_civil_01_f",                    [-1, ["pilot_transport"]]],
    ["usaf_kc135",                            [600, ["pilot_transport"]]],
    ["usaf_c130j",                            [600, ["pilot_transport"]]],
    ["usaf_c130j_cargo",                      [600, ["pilot_transport"]]],
    ["cup_b_mv22_viv_usmc",                   [600, ["pilot_transport"]]],
    ["cup_b_c130j_gb",                        [600, ["pilot_transport"]]],
    ["cup_b_c130j_cargo_gb",                  [600, ["pilot_transport"]]],
    ["", []]
];

private _dronesCooldown = 300;
private _drones = [
    ["usaf_mq9",                            [-1, ["uav"]]],
    ["usaf_rq4a",                           [-1, ["uav"]]],
    ["qav_b_ripsaw_mk44",                   [-1, ["uav"]]],
    ["qav_ripsaw_c",                        [-1, ["uav"]]],
    ["cup_b_usmc_dyn_mq9",                  [-1, ["uav"]]],
    ["cup_b_ah6x_usa",                      [-1, ["uav"]]],
    ["cup_b_seafox_usv_usmc",               [-1, ["uav"]]],
    ["fir_A10u_blank2",                     [-1, ["uav"]]],
    ["b_t_uav_03_dynamicloadout_f",         [-1, ["uav"]]],
    ["b_t_ugv_01_olive_f",                  [-1, ["uav"]]],
    ["b_t_ugv_01_rcws_olive_f",             [-1, ["uav"]]],
    ["ef_b_ugv_01_mjtf_des",                [-1, ["uav"]]],
    ["ef_b_ugv_01_rcws_mjtf_des",           [-1, ["uav"]]],
    ["e22_b_jtf_uav_06_antimine_f",         [-1, ["uav"]]],
    ["e22_b_jtf_uav_06_medical_f",          [-1, ["uav"]]],
    ["e22_b_jtf_uav_06_f",                  [-1, ["uav"]]],
    ["e22_b_jtf_uav_01_f",                  [-1, ["uav"]]],
    ["e22_b_jtf_ugv_02_demining_f",         [-1, ["uav"]]],
    ["e22_b_jtf_ugv_02_science_f",          [-1, ["uav"]]],
    ["e22_b_jtf_ugv_01_f",                  [-1, ["uav"]]],
    ["e22_b_jtf_ugv_01_rcws_f",             [-1, ["uav"]]],
    ["e22_b_jtf_d_ugv_01_f",                [-1, ["uav"]]],
    ["e22_b_jtf_d_ugv_01_rcws_f",           [-1, ["uav"]]],
    ["ef_b_uav_01_mjtf_wdl",                [-1, ["uav"]]],
    ["ef_b_uav_02_dynamicLoadout_mjtf_wdl", [-1, ["uav"]]],
    ["b_uav_05_f",                          [-1, ["uav"]]],
    ["b_uav_02_dynamicloadout_f",           [-1, ["uav"]]],
    ["", []]
];

private _shipsCooldown = 300;
private _ships = [
    ["b_boat_transport_01_f",               [-1,  []]],
    ["b_lifeboat",                          [-1,  []]],
    ["b_boat_armed_01_minigun_f",           [-1,  []]],
    ["o_boat_armed_01_hmg_f",               [-1,  []]],
    ["c_boat_civil_01_f",                   [-1,  []]],
    ["c_boat_transport_02_f",               [-1,  []]],
    ["c_scooter_transport_01_f",            [-1,  []]],
    ["cup_b_rhib_usmc",                     [-1,  []]],
    ["cup_b_zodiac_usmc",                   [-1,  []]],
    ["bae_fic",                             [-1,  []]],
    ["rhicc_green",                         [600, []]],
    ["ef_b_combatboat_unarmed_mjtf_des",    [-1,  []]],
    ["ef_b_combatboat_hmg_mjtf_des",        [600, []]],
    ["ef_b_combatboat_at_mjtf_des",         [600, []]],
    ["ef_b_boat_armed_01_minigun_mjtf_des", [-1,  []]],
    ["ef_b_lcc_mjtf_des",                   [-1,  []]],
    ["ef_b_lcc_sideload_mjtf_des",          [-1,  []]],
    ["ef_b_boat_transport_01_mjtf_des",     [120, []]],
    ["e22_b_jtf_boat_transport_01_f",       [-1,  []]],
    ["e22_b_jtf_boat_transport_02_f",       [-1,  []]],
    ["e22_b_jtf_boat_armed_01_minigun_f",   [-1,  []]],
    ["e22_b_jtf_boat_combat_01_unarmed_f",  [-1,  []]],
    ["e22_b_jtf_boat_combat_01_hmg_f",      [-1,  []]],
    ["e22_b_jtf_boat_combat_01_at_f",       [-1,  []]],
    ["e22_b_jtf_lcc_01_f",                  [-1,  []]],
    ["e22_b_jtf_lcc_01_sideLoad_f",         [-1,  []]],
    ["", []]
];










// Final output where the categories and vehicle classes are combined into
// a single data structure. New categories can be introduced here.
[
    _VERSION_NUMBER,
    createHashMapFromArray [
        // Category name
        ["Cars", createHashMapFromArray [
            ["_order", 12],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\iconcar_ca.paa"],
            ["_cooldown", _carsCooldown],
            ["_locks", []],
            ["_vehicles", createHashMapFromArray _cars]
        ]],
        ["Motorcycles", createHashMapFromArray [
            ["_order", 11],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\iconmotorcycle_ca.paa"],
            ["_cooldown", _motorcyclesCooldown],
            ["_locks", []],
            ["_vehicles", createHashMapFromArray _motorcycles]
        ]],
        ["Trucks", createHashMapFromArray [
            ["_order", 10],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\icontruck_ca.paa"],
            ["_cooldown", _trucksCooldown],
            ["_locks", []],
            ["_vehicles", createHashMapFromArray _trucks]
        ]],
        ["MRAPs", createHashMapFromArray [
            ["_order", 9],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\iconapc_ca.paa"],
            ["_cooldown", _MRAPsCooldown],
            ["_locks", []],
            ["_vehicles", createHashMapFromArray _MRAPs]
        ]],
        ["APCs", createHashMapFromArray [
            ["_order", 8],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\iconapc_ca.paa"],
            ["_cooldown", _APCsCooldown],
            ["_locks", []],
            ["_vehicles", createHashMapFromArray _APCs]
        ]],
        ["IFVs", createHashMapFromArray [
            ["_order", 7],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\iconapc_ca.paa"],
            ["_cooldown", _IFVsCooldown],
            ["_locks", []],
            ["_vehicles", createHashMapFromArray _IFVs]
        ]],
        ["Utilities", createHashMapFromArray [
            ["_order", 5],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\iconapc_ca.paa"],
            ["_cooldown", _utilityCooldown],
            ["_locks", []],
            ["_vehicles", createHashMapFromArray _utility]
        ]],
        ["Artillery", createHashMapFromArray [
            ["_order", 3],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\icontank_ca.paa"],
            ["_cooldown", _artilleryCooldown],
            ["_locks", [["driver", "role", ["arty"]], ["gunner", "role", ["arty"]]]],
            ["_vehicles", createHashMapFromArray _artillery]
        ]],
        ["Air Defense", createHashMapFromArray [
            ["_order", 6],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\icontank_ca.paa"],
            ["_cooldown", _airdefenseCooldown],
            ["_locks", []],
            ["_vehicles", createHashMapFromArray _airdefense]
        ]],
        ["Tanks", createHashMapFromArray [
            ["_order", 4],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\icontank_ca.paa"],
            ["_cooldown", _tanksCooldown],
            ["_locks", [["driver", "role", ["engineer"]]]],
            ["_vehicles", createHashMapFromArray _tanks]
        ]],
        ["Helicopters", createHashMapFromArray [
            ["_order", 1],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\iconhelicopter_ca.paa"],
            ["_cooldown", _helicoptersCooldown],
            ["_locks", [["driver", "uid"]]],
            ["_vehicles", createHashMapFromArray _helicopters]
        ]],
        ["Planes", createHashMapFromArray [
            ["_order", 0],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\iconplane_ca.paa"],
            ["_cooldown", _planesCooldown],
            ["_locks", [["driver", "uid"]]],
            ["_vehicles", createHashMapFromArray _planes]
        ]],
        ["Drones", createHashMapFromArray [
            ["_order", 2],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\iconplane_ca.paa"],
            ["_cooldown", _dronesCooldown],
            ["_locks", [["driver", "uid"]]],
            ["_vehicles", createHashMapFromArray _drones]
        ]],
        ["Ships", createHashMapFromArray [
            ["_order", 13],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\iconship_ca.paa"],
            ["_cooldown", _shipsCooldown],
            ["_locks", []],
            ["_vehicles", createHashMapFromArray _ships]
        ]],
        ["", createHashMap]
    ]
]
