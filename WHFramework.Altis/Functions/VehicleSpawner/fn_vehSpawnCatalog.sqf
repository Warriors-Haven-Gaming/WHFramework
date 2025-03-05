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
    ["cup_c_octavia_civ",               [-1, []]],
    ["c_offroad_02_unarmed_f",          [-1, []]],
    ["cup_i_hilux_unarmed_napa",        [-1, []]],
    ["cup_b_nm1038_4s_df_usa_wdl",      [-1, []]],
    ["cup_b_lr_special_m2_gb_w",        [-1, []]],
    ["cup_b_lr_special_gmg_gb_w",       [-1, []]],
    ["cup_b_nm1025_sov_m2_usa_wdl",     [-1, []]],
    ["cup_b_nm1036_tow_df_usa_wdl",     [-1, []]],
    ["cup_b_nm1151_ogpk_m2_df_usa_wdl", [-1, []]],
    ["cup_b_nm1151_ogpk_m2_usa_wdl",    [-1, []]],
    ["cup_b_m1165_gmv_wdl_usa",         [-1, []]],
    ["", []] // Dummy element to assist with VCS tooling, may be removed
];

private _motorcyclesCooldown = 300;
private _motorcycles = [
    ["cup_b_m1030_usa",  [-1, []]],
    ["cup_i_tt650_napa", [-1, []]],
    ["", []]
];

private _trucksCooldown = 300;
private _trucks = [
    ["c_van_01_transport_f",         [-1, []]],
    ["c_van_01_box_f",               [-1, []]],
    ["c_van_01_fuel_f",              [-1, []]],
    ["cup_b_t810_refuel_cz_wdl",     [-1, []]],
    ["cup_b_t810_reammo_cz_wdl",     [-1, []]],
    ["cup_b_nm1038_ammo_df_usa_wdl", [-1, []]],
    ["b_truck_01_ammo_f",            [-1, []]],
    ["b_truck_01_fuel_f",            [-1, []]],
    ["", []]
];

private _MRAPsCooldown = 300;
private _MRAPs = [
    ["cup_b_rg31e_m2_od_usa",   [-1, []]],
    ["cup_b_rg31_m2_od_usa",    [-1, []]],
    ["cup_b_dingo_ger_wdl",     [-1, []]],
    ["cup_b_ridgback_hmg_gb_w", [-1, []]],
    ["cup_b_mastiff_gmg_gb_w",  [-1, []]],
    ["", []]
];

private _APCsCooldown = 900;
private _APCs = [
    ["cup_b_m1130_cv_m2_woodland",    [-1, []]],
    ["cup_b_m1135_atgmv_woodland",    [-1, []]],
    ["cup_b_m1128_mgs_woodland",      [-1, []]],
    ["cup_b_m1126_icv_mk19_woodland", [-1, []]],
    ["", []]
];

private _IFVsCooldown = 900;
private _IFVs = [
    ["cup_b_lav25m240_usmc",    [-1,  []]],
    ["cup_b_m7bradley_usa_w",   [-1,  []]],
    ["cup_b_m2bradley_usa_w",   [-1,  []]],
    ["cup_b_m2a3bradley_usa_w", [-1,  []]],
    ["cup_b_fv510_gb_w",        [-1,  []]],
    ["cup_b_fv510_gb_w_slat",   [-1,  []]],
    ["cup_b_mcv80_gb_w",        [-1,  []]],
    ["cup_b_mcv80_gb_w_slat",   [-1,  []]],
    ["cup_b_aav_usmc_tts",      [-1,  []]],
    ["cup_b_boxer_gmg_ger_wdl", [300, []]],
    ["cup_b_boxer_hmg_ger_wdl", [300, []]],
    ["", []]
];

private _utilityCooldown = 300;
private _utility = [
    ["cup_b_t810_repair_cz_wdl",       [-1, ["engineer"]]],
    ["cup_b_nm1038_repair_df_usa_wdl", [-1, ["engineer"]]],
    ["b_truck_01_repair_f",            [-1, ["engineer"]]],
    ["cup_b_nm997_df_usa_wdl",         [-1, ["medic"]]],
    ["cup_b_m1133_mev_woodland",       [-1, ["medic"]]],
    ["cup_b_fv432_gb_ambulance",       [-1, ["medic"]]],
    ["", []]
];

private _artilleryCooldown = 1800;
private _artillery = [
    ["cup_b_fv432_mortar",           [-1,   ["artillery"]]],
    ["cup_b_m1129_mc_mk19_woodland", [-1,   ["artillery"]]],
    ["cup_b_m270_he_baf_wood",       [2500, ["artillery"]]],
    ["cup_b_m270_dpicm_baf_wood",    [2500, ["artillery"]]],
    ["", []]
];

private _airdefenseCooldown = 1000;
private _airdefense = [
    ["cup_b_m6linebacker_usa_w",     [-1,  []]],
    ["cup_b_m163_vulcan_usa",        [500, []]],
    ["cup_b_nm1097_avenger_usa_wdl", [-1,  []]],
    ["", []]
];

private _tanksCooldown = 1500;
private _tanks = [
    ["b_w_abramsx",                          [-1, ["engineer"]]],
    ["cup_b_m1a2c_tusk_II_woodland_us_army", [-1, ["engineer"]]],
    ["cup_b_challenger2_woodland_baf",       [-1, ["engineer"]]],
    ["", []]
];

private _helicoptersCooldown = 300;
private _helicopters = [
    ["cup_b_ah6m_usa",                   [-1, ["pilot_cas"]]],
    ["cup_b_ah64d_dl_usa",               [-1, ["pilot_cas"]]],
    ["cup_i_ah1z_dynamic_aaf",           [-1, ["pilot_cas"]]],
    ["cup_b_mi35_dynamic_cz_tiger",      [-1, ["pilot_cas"]]],
    ["cup_b_aw159_rn_blackcat",          [-1, ["pilot_cas"]]],
    ["cup_b_mh6m_usa",                   [-1, ["pilot_transport"]]],
    ["cup_b_mh60l_dap_2x_us",            [-1, ["pilot_transport"]]],
    ["cup_b_mh47e_usa",                  [-1, ["pilot_transport"]]],
    ["cup_b_ch53e_usmc",                 [-1, ["pilot_transport"]]],
    ["valor_turret_transport_crewgun_f", [-1, ["pilot_transport"]]],
    ["", []]
];

private _planesCooldown = 300;
private _planes = [
    ["peral_f16v",                      [-1, ["pilot_cas"]]],
    ["f_35c",                           [-1, ["pilot_cas"]]],
    ["fa_emb312_at27m35_nato",          [-1, ["pilot_cas"]]],
    ["cup_b_gr9_dyn_gb",                [-1, ["pilot_cas"]]],
    ["b_plane_cas_01_dynamicloadout_f", [-1, ["pilot_cas"]]],
    ["cup_b_mv22_viv_usmc",             [-1, ["pilot_transport"]]],
    ["cup_b_c130j_gb",                  [-1, ["pilot_transport"]]],
    ["cup_b_c130j_cargo_gb",            [-1, ["pilot_transport"]]],
    ["", []]
];

private _dronesCooldown = 300;
private _drones = [
    ["qav_b_ripsaw_mk44",     [-1, ["uav"]]],
    ["qav_ripsaw_c",          [-1, ["uav"]]],
    ["cup_b_usmc_dyn_mq9",    [-1, ["uav"]]],
    ["cup_b_ah6x_usa"    ,    [-1, ["uav"]]],
    ["cup_b_seafox_usv_usmc", [-1, ["uav"]]],
    ["", []]
];

private _shipsCooldown = 300;
private _ships = [
    ["cup_b_rhib_usmc",   [-1, []]],
    ["cup_b_zodiac_usmc", [-1, []]],
    ["bae_fic",           [-1, []]],
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
            ["_locks", [["driver", "role", ["artillery"]], ["gunner", "role", ["artillery"]]]],
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
