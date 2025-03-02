private _VERSION_NUMBER = 1;
// The version number for the vehicle catalog.
//
// Should be incremented only if the mission introduces a backwards-incompatible
// change to the structure and instructions have been followed to migrate
// this configuration to the new version.

private _carsCooldown = 300;
private _cars = [
    // Classname            cooldown (-1 to use category cooldown)
    // |                    |    whitelisted roles (see roles.sqf)
    ["b_lsv_01_unarmed_f", [-1, []]],
    ["b_lsv_01_armed_f",   [-1, []]],
    ["b_lsv_01_at_f",      [-1, []]],
    ["", []] // Dummy element to assist with VCS tooling, may be removed
];

private _motorcyclesCooldown = 300;
private _motorcycles = [
    ["", []]
];

private _trucksCooldown = 600;
private _trucks = [
    ["b_truck_01_ammo_f",    [-1, ["engineer"]]],
    ["b_truck_01_fuel_f",    [-1, ["engineer"]]],
    ["b_truck_01_medical_f", [-1, ["medic"]]],
    ["b_truck_01_repair_f",  [-1, ["engineer"]]],
    ["", []]
];

private _MRAPsCooldown = 300;
private _MRAPs = [
    ["b_mrap_01_f",     [-1, []]],
    ["b_mrap_01_hmg_f", [-1, []]],
    ["b_mrap_01_gmg_f", [-1, []]],
    ["", []]
];

private _APCsCooldown = 900;
private _APCs = [
    ["b_apc_wheeled_01_cannon_f", [-1, ["rifleman"]]],
    ["b_apc_tracked_01_rcws_f",   [-1, ["rifleman"]]],
    ["", []]
];

private _artilleryCooldown = 1800;
private _artillery = [
    ["b_mbt_01_arty_f", [-1, ["artillery"]]],
    ["b_mbt_01_mlrs_f", [-1, ["artillery"]]],
    ["", []]
];

private _tanksCooldown = 1500;
private _tanks = [
    ["b_mbt_01_cannon_f", [-1, ["engineer"]]],
    ["b_mbt_01_tusk_f",   [-1, ["engineer"]]],
    ["", []]
];

private _helicoptersCooldown = 300;
private _helicopters = [
    ["b_heli_light_01_dynamicloadout_f",  [-1, ["pilot_cas"]]],
    ["b_heli_attack_01_dynamicloadout_f", [-1, ["pilot_cas"]]],
    ["b_heli_light_01_f",                 [-1, ["pilot_transport"]]],
    ["b_heli_transport_01_f",             [-1, ["pilot_transport"]]],
    ["b_heli_transport_03_f",             [-1, ["pilot_transport"]]],
    ["b_heli_transport_03_unarmed_f",     [-1, ["pilot_transport"]]],
    ["", []]
];

private _planesCooldown = 300;
private _planes = [
    ["b_plane_cas_01_dynamicloadout_f", [-1, ["pilot_cas"]]],
    ["b_plane_fighter_01_f",            [-1, ["pilot_cas"]]],
    ["b_plane_fighter_01_stealth_f",    [-1, ["pilot_cas"]]],
    ["", []]
];

private _dronesCooldown = 300;
private _drones = [
    ["b_ugv_01_f",                [-1, ["uav"]]],
    ["b_ugv_01_rcws_f",           [-1, ["uav"]]],
    ["b_uav_02_dynamicloadout_f", [-1, ["uav"]]],
    ["b_uav_05_f",                [-1, ["uav"]]],
    ["", []]
];

private _shipsCooldown = 300;
private _ships = [
    ["b_boat_armed_01_minigun_f",    [-1, []]],
    ["c_boat_civil_01_f",            [-1, []]],
    ["c_boat_transport_02_f",        [-1, []]],
    ["c_scooter_transport_01_f",     [-1, []]],
    ["", []]
];










// Final output where the categories and vehicle classes are combined into
// a single data structure. New categories can be introduced here.
[
    _VERSION_NUMBER,
    createHashMapFromArray [
        // Category name
        ["Cars", createHashMapFromArray [
            ["_order", 0],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\iconcar_ca.paa"],
            ["_cooldown", _carsCooldown],
            ["_locks", []],
            ["_vehicles", createHashMapFromArray _cars]
        ]],
        ["Motorcycles", createHashMapFromArray [
            ["_order", 1],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\iconmotorcycle_ca.paa"],
            ["_cooldown", _motorcyclesCooldown],
            ["_locks", []],
            ["_vehicles", createHashMapFromArray _motorcycles]
        ]],
        ["Trucks", createHashMapFromArray [
            ["_order", 2],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\icontruck_ca.paa"],
            ["_cooldown", _trucksCooldown],
            ["_locks", []],
            ["_vehicles", createHashMapFromArray _trucks]
        ]],
        ["MRAPs", createHashMapFromArray [
            ["_order", 3],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\iconapc_ca.paa"],
            ["_cooldown", _MRAPsCooldown],
            ["_locks", []],
            ["_vehicles", createHashMapFromArray _MRAPs]
        ]],
        ["APCs", createHashMapFromArray [
            ["_order", 4],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\iconapc_ca.paa"],
            ["_cooldown", _APCsCooldown],
            ["_locks", []],
            ["_vehicles", createHashMapFromArray _APCs]
        ]],
        ["Artillery", createHashMapFromArray [
            ["_order", 5],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\icontank_ca.paa"],
            ["_cooldown", _artilleryCooldown],
            ["_locks", [["driver", "role", ["artillery"]], ["gunner", "role", ["artillery"]]]],
            ["_vehicles", createHashMapFromArray _artillery]
        ]],
        ["Tanks", createHashMapFromArray [
            ["_order", 6],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\icontank_ca.paa"],
            ["_cooldown", _tanksCooldown],
            ["_locks", [["driver", "role", ["engineer"]]]],
            ["_vehicles", createHashMapFromArray _tanks]
        ]],
        ["Helicopters", createHashMapFromArray [
            ["_order", 7],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\iconhelicopter_ca.paa"],
            ["_cooldown", _helicoptersCooldown],
            ["_locks", [["driver", "uid"]]],
            ["_vehicles", createHashMapFromArray _helicopters]
        ]],
        ["Planes", createHashMapFromArray [
            ["_order", 8],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\iconplane_ca.paa"],
            ["_cooldown", _planesCooldown],
            ["_locks", [["driver", "uid"]]],
            ["_vehicles", createHashMapFromArray _planes]
        ]],
        ["Drones", createHashMapFromArray [
            ["_order", 9],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\iconplane_ca.paa"],
            ["_cooldown", _dronesCooldown],
            ["_locks", [["driver", "uid"]]],
            ["_vehicles", createHashMapFromArray _drones]
        ]],
        ["Ships", createHashMapFromArray [
            ["_order", 10],
            ["_icon", "\a3\ui_f\data\map\vehicleicons\iconship_ca.paa"],
            ["_cooldown", _shipsCooldown],
            ["_locks", []],
            ["_vehicles", createHashMapFromArray _ships]
        ]],
        ["", createHashMap]
    ]
]
