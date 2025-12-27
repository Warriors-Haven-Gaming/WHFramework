/*
Function: WHF_fnc_setupVehicle

Description:
    Apply custom modifications to a vehicle.

Parameters:
    Object vehicle:
        The vehicle to configure.

Author:
    thegamecracks

*/
params ["_vehicle"];
if !(_vehicle isNil "WHF_setupVehicle_called") exitWith {};
if !(_vehicle isKindOf "AllVehicles") exitWith {};
if (_vehicle isKindOf "Man") exitWith {};

_vehicle setVariable ["WHF_setupVehicle_called", true];
_vehicle call WHF_fnc_addVehicleDamageHandlers;

if (_vehicle isKindOf "ReammoBox_F") exitWith {};
if (!local _vehicle) exitWith {};

_vehicle setVehicleReceiveRemoteTargets true;
_vehicle setVehicleReportOwnPosition true;
_vehicle setVehicleReportRemoteTargets true;

switch (true) do {
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
    case (_vehicle isKindOf "Heli_Attack_01_dynamicLoadout_base_F"): {
        _vehicle setPylonLoadout [1, "PylonRack_12Rnd_missiles",       false, [-1]];
        _vehicle setPylonLoadout [2, "PylonMissile_1Rnd_AAA_missiles", false, [-1]];
        _vehicle setPylonLoadout [3, "PylonRack_12Rnd_PG_missiles",    false, [-1]];
        _vehicle setPylonLoadout [4, "PylonRack_12Rnd_PG_missiles",    false, [-1]];
        _vehicle setPylonLoadout [5, "PylonMissile_1Rnd_AAA_missiles", false, [-1]];
        _vehicle setPylonLoadout [6, "PylonRack_12Rnd_missiles",       false, [-1]];
        switch (true) do {
            case (_vehicle isKindOf "EF_AH99J_dynamicLoadout_base"): {
                _vehicle setPylonLoadout [7,  "EF_PylonMissile_Missile_Sidearm_x1", false, [-1]];
                _vehicle setPylonLoadout [8,  "EF_PylonMissile_Titan_NLOS_2Rnd",    false, [-1]];
                _vehicle setPylonLoadout [9,  "EF_PylonMissile_Titan_NLOS_2Rnd",    false, [-1]];
                _vehicle setPylonLoadout [10, "EF_PylonMissile_Missile_Sidearm_x1", false, [-1]];
            };
            case (_vehicle isKindOf "Heli_Attack_01_pylons_dynamicLoadout_base_F"): {
                _vehicle setPylonLoadout [7, "PylonRack_4Rnd_LG_scalpel", false, [-1]];
                _vehicle setPylonLoadout [8, "PylonRack_4Rnd_LG_scalpel", false, [-1]];
            };
        };
    };
    case (_vehicle isKindOf "Heli_Attack_02_dynamicLoadout_base_F"): {
        _vehicle setPylonLoadout [1, "PylonRack_4Rnd_LG_scalpel",      false, [-1]];
        _vehicle setPylonLoadout [2, "PylonRack_19Rnd_Rocket_Skyfire", false, [-1]];
        _vehicle setPylonLoadout [3, "PylonRack_19Rnd_Rocket_Skyfire", false, [-1]];
        _vehicle setPylonLoadout [4, "PylonRack_4Rnd_LG_scalpel",      false, [-1]];
    };
    case (_vehicle isKindOf "Heli_Light_02_dynamicLoadout_base_F"): {
        _vehicle setPylonLoadout [1, selectRandom ["PylonWeapon_2000Rnd_65x39_belt", "PylonWeapon_300Rnd_20mm_shells"]];
        _vehicle setPylonLoadout [2, selectRandom ["PylonRack_12Rnd_PG_missiles", "PylonRack_20Rnd_Rocket_03_HE_F"]];
    };
    case (_vehicle isKindOf "Heli_light_03_dynamicLoadout_base_F"): {
        private _magazines = ["PylonWeapon_300Rnd_20mm_shells", "PylonRack_12Rnd_missiles", "PylonRack_12Rnd_PG_missiles", "PylonRack_4Rnd_LG_scalpel"];
        _vehicle setPylonLoadout [1, selectRandom _magazines];
        _vehicle setPylonLoadout [2, selectRandom _magazines];
    };
    case (_vehicle isKindOf "Heli_Transport_01_DAP_base_F"): {
        // FIXME: pylons do not take precedence over respawning vehicles
        _vehicle setPylonLoadout [6, "PylonECMPod_01_DIRCM_R"];
        _vehicle setPylonLoadout [7, "PylonECMPod_01_DIRCM_L"];
        // _vehicle animateSource ["Hide_BenchesBack", 0, true];
        // _vehicle animateSource ["Hide_BenchesFront", 0, true];
        // _vehicle animateSource ["Hide_Door_L", 0, true];
        // _vehicle animateSource ["Hide_Door_R", 0, true];
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
    case (_vehicle isKindOf "Plane_Fighter_01_Base_F"): {
        _vehicle setPylonLoadout [1,  "PylonRack_Missile_AMRAAM_D_x2"   ];
        _vehicle setPylonLoadout [2,  "PylonRack_Missile_AMRAAM_D_x2"   ];
        _vehicle setPylonLoadout [3,  "PylonRack_Missile_AGM_02_x2"     ];
        _vehicle setPylonLoadout [4,  "PylonRack_Missile_AGM_02_x2"     ];
        _vehicle setPylonLoadout [5,  "PylonMissile_Missile_BIM9X_x1"   ];
        _vehicle setPylonLoadout [6,  "PylonMissile_Missile_BIM9X_x1"   ];
        _vehicle setPylonLoadout [7,  "PylonMissile_Missile_HARM_INT_x1"];
        _vehicle setPylonLoadout [8,  "PylonMissile_Missile_HARM_INT_x1"];
        _vehicle setPylonLoadout [9,  "PylonRack_Bomb_SDB_x4"           ];
        _vehicle setPylonLoadout [10, "PylonRack_Bomb_SDB_x4"           ];
        _vehicle setPylonLoadout [11, "PylonMissile_Bomb_GBU12_x1"      ];
        _vehicle setPylonLoadout [12, "PylonMissile_Bomb_GBU12_x1"      ];
    };
    case (_vehicle isKindOf "VTOL_02_infantry_dynamicLoadout_base_F");
    case (_vehicle isKindOf "VTOL_02_vehicle_dynamicLoadout_base_F"): {
        _vehicle setPylonLoadout [1, "PylonRack_4Rnd_LG_scalpel",      false, [-1]];
        _vehicle setPylonLoadout [2, "PylonRack_19Rnd_Rocket_Skyfire", false, [-1]];
        _vehicle setPylonLoadout [3, "PylonRack_19Rnd_Rocket_Skyfire", false, [-1]];
        _vehicle setPylonLoadout [4, "PylonRack_4Rnd_LG_scalpel",      false, [-1]];
    };
};
