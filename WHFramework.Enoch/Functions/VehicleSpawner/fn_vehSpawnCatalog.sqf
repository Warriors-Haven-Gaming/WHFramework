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
    ["c_offroad_02_unarmed_f",            [60,  []]],
    ["c_van_01_transport_f",              [60,  []]],
    ["c_van_02_vehicle_f",                [60,  []]],
    ["c_van_02_transport_f",              [60,  []]],
    ["ef_b_pickup_mjtf_wdl",              [120, []]],
    ["ef_b_pickup_mjtf_des",              [120, []]],
    ["ef_b_pickup_comms_mjtf_wdl",        [120, []]],
    ["ef_b_pickup_comms_mjtf_des",        [120, []]],
    ["ef_b_pickup_mmg_mjtf_wdl",          [180, []]],
    ["ef_b_pickup_mmg_mjtf_des",          [180, []]],
    ["e22_b_jtf_lsv_02_unarmed_f",        [60,  []]],
    ["e22_b_jtf_d_lsv_02_unarmed_f",      [-1,  []]],
    ["e22_b_jtf_lsv_02_armed_f",          [-1,  []]],
    ["e22_b_jtf_d_lsv_02_armed_f",        [-1,  []]],
    ["e22_b_jtf_lsv_01_unarmed_f",        [-1,  []]],
    ["e22_b_jtf_d_lsv_01_unarmed_f",      [-1,  []]],
    ["e22_b_jtf_lsv_01_light_f",          [-1,  []]],
    ["e22_b_jtf_d_lsv_01_light_f",        [-1,  []]],
    ["e22_b_jtf_lsv_01_at_f",             [-1,  []]],
    ["e22_b_jtf_d_lsv_01_at_f",           [-1,  []]],
    ["", []] // Dummy element to assist with VCS tooling, may be removed
];

private _motorcyclesCooldown = 120;
private _motorcycles = [
    ["e22_b_jtf_quadbike_01_f",           [-1, []]],
    ["e22_b_jtf_d_quadbike_01_f",         [-1, []]],
    ["", []]
];

private _trucksCooldown = 300;
private _trucks = [
    ["c_van_01_transport_f",              [60, []]],
    ["c_van_01_box_f",                    [60, []]],
    ["c_van_01_fuel_f",                   [-1, []]],
    ["b_truck_01_box_f",                  [-1, []]],
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
    ["b_truck_01_fft_rf",                 [-1, []]],
    ["b_t_truck_01_fft_rf",               [-1, []]],
    ["", []]
];

private _MRAPsCooldown = 300;
private _MRAPs = [
    ["e22_b_jtf_mrap_01_f",               [-1, []]],
    ["e22_b_jtf_d_mrap_01_f",             [-1, []]],
    ["e22_b_jtf_mrap_01_hmg_f",           [-1, []]],
    ["e22_b_jtf_d_mrap_01_hmg_f",         [-1, []]],
    ["e22_b_jtf_mrap_01_gmg_f",           [-1, []]],
    ["e22_b_jtf_d_mrap_01_gmg_f",         [-1, []]],
    ["e22_b_jtf_mrap_01_at_f",            [-1, []]],
    ["e22_b_jtf_d_mrap_01_at_f",          [-1, []]],
    ["e22_b_jtf_mrap_01_fsv_f",           [-1, []]],
    ["e22_b_jtf_d_mrap_01_fsv_f",         [-1, []]],
    ["e22_b_jtf_mrap_03_f",               [-1, []]],
    ["e22_b_jtf_d_mrap_03_f",             [-1, []]],
    ["e22_b_jtf_mrap_03_hmg_f",           [-1, []]],
    ["e22_b_jtf_d_mrap_03_hmg_f",         [-1, []]],
    ["e22_b_jtf_mrap_03_gmg_f",           [-1, []]],
    ["e22_b_jtf_d_mrap_03_gmg_f",         [-1, []]],
    ["", []]
];

private _APCsCooldown = 900;
private _APCs = [
    ["e22_b_jtf_apc_wheeled_03_unarmed_f",   [600, []]],
    ["e22_b_jtf_d_apc_wheeled_03_unarmed_f", [600, []]],
    ["b_apc_tracked_01_rcws_f",              [-1,  []]],
    ["b_t_apc_tracked_01_rcws_f",            [-1,  []]],
    ["b_apc_wheeled_01_command_lxws",        [-1,  []]],
    ["b_t_apc_wheeled_01_command_lxws",      [-1,  []]],
    ["", []]
];

private _IFVsCooldown = 900;
private _IFVs = [
    ["e22_b_jtf_apc_wheeled_03_cannon_f",    [-1,  []]],
    ["e22_b_jtf_d_apc_wheeled_03_cannon_f",  [-1,  []]],
    ["b_apc_wheeled_01_cannon_f",            [-1,  []]],
    ["b_t_apc_wheeled_01_cannon_f",          [-1,  []]],
    ["b_apc_wheeled_01_atgm_lxws",           [-1,  []]],
    ["b_t_apc_wheeled_01_atgm_lxws",         [-1,  []]],
    ["b_afv_wheeled_01_up_cannon_f",         [-1,  []]],
    ["b_t_afv_wheeled_01_up_cannon_f",       [-1,  []]],
    ["ef_b_aav9_mjtf_wdl",                   [-1,  []]],
    ["ef_b_aav9_mjtf_des",                   [-1,  []]],
    ["ef_b_aav9_50mm_mjtf_wdl",              [-1,  []]],
    ["ef_b_aav9_50mm_mjtf_des",              [-1,  []]],
    ["", []]
];

private _utilityCooldown = 300;
private _utility = [
    ["c_truck_02_box_f",                  [-1,  ["engineer"]]],
    ["e22_b_jtf_truck_01_repair_f",       [-1,  ["engineer"]]],
    ["e22_b_jtf_d_truck_01_repair_f",     [-1,  ["engineer"]]],
    ["b_apc_tracked_01_crv_f",            [-1,  ["engineer"]]],
    ["b_t_apc_tracked_01_crv_f",          [-1,  ["engineer"]]],
    ["c_van_02_medevac_f",                [-1,  ["medic"]]],
    ["e22_b_jtf_truck_01_medical_f",      [-1,  ["medic"]]],
    ["e22_b_jtf_d_truck_01_medical_f",    [-1,  ["medic"]]],
    ["", []]
];

private _artilleryCooldown = 1800;
private _artillery = [
    ["b_g_pickup_mrl_rf",                [1200, ["arty"]]],
    ["b_apc_wheeled_01_mortar_lxws",     [-1,   ["arty"]]],
    ["b_t_apc_wheeled_01_mortar_lxws",   [-1,   ["arty"]]],
    ["b_mbt_01_arty_f",                  [-1,   ["arty"]]],
    ["b_t_mbt_01_arty_f",                [-1,   ["arty"]]],
    ["b_t_mbt_01_mlrs_f",                [2100, ["arty"]]],
    ["b_mbt_01_mlrs_f",                  [2100, ["arty"]]],
    ["", []]
];

private _airdefenseCooldown = 900;
private _airdefense = [
    ["b_pickup_aat_rf",                        [-1,   ["aa"]]],
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
    ["", []]
];

private _tanksCooldown = 1500;
private _tanks = [
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
    ["b_heli_light_01_f",                           [-1,  []]],
    ["b_d_heli_light_01_lxws",                      [-1,  []]],
    ["b_heli_light_01_dynamicloadout_f",            [-1,  ["pilot_cas_heli"]]],
    ["b_d_heli_light_01_dynamicloadout_lxws",       [-1,  ["pilot_cas_heli"]]],
    ["b_heli_light_03_dynamicloadout_rf",           [-1,  ["pilot_cas_heli"]]],
    ["b_heli_attack_01_dynamicloadout_f",           [-1,  ["pilot_cas_heli"]]],
    ["b_d_heli_attack_01_dynamicloadout_lxws",      [-1,  ["pilot_cas_heli"]]],
    ["b_heli_attack_01_pylons_dynamicloadout_f",    [-1,  ["pilot_cas_heli"]]],
    ["ef_b_heli_attack_01_dynamicLoadout_mjtf_wdl", [-1,  ["pilot_cas_heli"]]],
    ["ef_b_ah99j_nato",                             [-1,  ["pilot_cas_heli"]]],
    ["ef_b_ah99j_mjtf_wdl",                         [-1,  ["pilot_cas_heli"]]],
    ["ef_b_ah99j_nato_des",                         [-1,  ["pilot_cas_heli"]]],
    ["e22_b_jtf_heli_attack_03_f",                  [-1,  ["pilot_cas_heli"]]],
    ["e22_b_jtf_d_heli_attack_03_f",                [-1,  ["pilot_cas_heli"]]],
    ["e22_b_jtf_heli_transport_01_f",               [-1,  ["pilot_transport"]]],
    ["e22_b_jtf_n_heli_transport_01_f",             [-1,  ["pilot_transport"]]],
    ["e22_b_jtf_d_heli_transport_01_f",             [-1,  ["pilot_transport"]]],
    ["ef_b_heli_transport_01_mjtf_wdl",             [-1,  ["pilot_transport"]]],
    ["ef_b_heli_transport_01_pylons_02_mjtf_wdl",   [-1,  ["pilot_transport"]]],
    ["ef_b_heli_transport_01_pylons_mjtf_wdl",      [-1,  ["pilot_transport"]]],
    ["ef_b_heli_transport_01_unarmed_mjtf_wdl",     [-1,  ["pilot_transport"]]],
    ["b_t_heli_transport_01_f",                     [-1,  ["pilot_transport"]]],
    ["b_t_heli_transport_01_pylons_02_f",           [-1,  ["pilot_transport"]]],
    ["b_t_heli_transport_01_pylons_f",              [-1,  ["pilot_transport"]]],
    ["b_t_heli_transport_01_unarmed_f",             [-1,  ["pilot_transport"]]],
    ["b_heli_ec_03_rf",                             [-1,  ["pilot_transport"]]],
    ["b_heli_ec_04_military_rf",                    [-1,  ["pilot_transport"]]],
    ["b_heli_light_03_unarmed_rf",                  [-1,  ["pilot_transport"]]],
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
    ["e22_b_jtf_plane_fighter_01_f",          [-1, ["pilot_cas_plane"]]],
    ["e22_b_jtf_plane_fighter_01_light_f",    [-1, ["pilot_cas_plane"]]],
    ["e22_b_jtf_plane_fighter_01_stealth_f",  [-1, ["pilot_cas_plane"]]],
    ["b_plane_cas_01_dynamicLoadout_f",       [-1, ["pilot_cas_plane"]]],
    ["b_d_plane_cas_01_dynamicLoadout_lxws",  [-1, ["pilot_cas_plane"]]],
    ["e22_b_jtf_vtol_01_armed_f",             [-1, ["pilot_cas_plane"]]],
    ["e22_b_jtf_d_vtol_01_armed_f",           [-1, ["pilot_cas_plane"]]],
    ["e22_b_jtf_n_vtol_01_armed_f",           [-1, ["pilot_cas_plane"]]],
    ["", []]
];

private _dronesCooldown = 300;
private _drones = [
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
    ["b_t_uav_03_dynamicLoadout_f",         [-1, ["uav"]]],
    ["", []]
];

private _shipsCooldown = 300;
private _ships = [
    ["b_lifeboat",                          [-1,  []]],
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
