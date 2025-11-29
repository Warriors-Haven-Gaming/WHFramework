/*
Function: WHF_fnc_msnDestroyArmor

Description:
    Players must destroy an armor staging area.
    Function must be executed in scheduled environment.

Parameters:
    PositionATL ecnter:
        (Optional, default [])
        If specified, the given position is used for the intel instead of
        attempting to find a suitable location.
    String faction:
        (Optional, default "")
        The faction to spawn units from.
        If not provided, a random OPFOR faction is selected from WHF_factions_pool.

Author:
    thegamecracks

*/
params [["_center", []], ["_faction", ""]];

private _radius = 250;

if (_center isEqualTo []) then {
    private _options = ["meadow - forest - sea - trees"] call WHF_fnc_selectBestPlaces;
    {
        private _pos = _x;
        if ([_pos, _radius + 1000] call WHF_fnc_isNearRespawn) then {continue};
        if (_pos nearRoads 100 isNotEqualTo []) then {continue};
        if (_pos isFlatEmpty [-1, -1, 1, 40] isEqualTo []) then {continue};
        if ([_pos, _radius] call WHF_fnc_isNearUsedPosition) then {continue};
        _center = _pos;
        break;
    } forEach _options;
};
if (_center isEqualTo []) exitWith {
    diag_log text format ["%1: No center found", _fnc_scriptName];
};

if (_faction isEqualTo "") then {_faction = selectRandom (WHF_factions_pool get opfor)};
private _standard = ["standard", _faction];
private _infantryTypes = [_standard, ["aa", _faction], ["at", _faction]];

private _area = [_center, _radius * 2, _radius * 2]; // attack radius

private _objects = [];
private _terrain = [];
private _groups = [];
private _vehicles = [];

call {
    private _turretTypes = [
        "O_HMG_01_high_F",
        "O_HMG_02_high_F",
        "CUP_O_KORD_high_RUS_M_Summer"
    ] select {isClass (configFile >> "CfgVehicles" >> _x)};

    // CUP Terrains Core, E22, OPFOR Vehicles Pack, Western Sahara
    private _centerRadius = 65;
    private _centerComp = [["Land_MedicalTent_01_CSAT_greenhex_generic_closed_F",[0.857422,-6.86914,0],90],["Land_MedicalTent_01_CSAT_greenhex_generic_closed_F",[0.703369,9.05859,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[-9.23755,-0.326172,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[-9.26147,-4.25781,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[9.4707,-4.02148,0],270],["Land_Shoot_House_Wall_Long_Stand_F",[9.39063,5.36328,0],270],["Land_Shoot_House_Wall_Long_Stand_F",[-9.12524,6.14844,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[9.44678,-7.95313,0],270],["Land_Shoot_House_Wall_Long_Stand_F",[-9.28564,-8.2207,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[9.41455,9.29492,0],270],["Land_Shoot_House_Wall_Long_Stand_F",[-9.10132,10.0801,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[9.44922,-11.9023,0],270],["Land_Shoot_House_Wall_Long_Stand_F",[-9.30957,-12.1523,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[9.43872,13.2578,0],270],["Land_Shoot_House_Wall_Long_Stand_F",[-9.10376,14.0293,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[9.42529,-15.834,0],270],["Land_MedicalTent_01_CSAT_greenhex_generic_closed_F",[-18.1545,-4.00977,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[-9.30713,-16.1016,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[9.46265,17.1895,0],270],["Land_MedicalTent_01_CSAT_greenhex_generic_closed_F",[1.0481,-19.873,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[-9.07983,17.9609,0],90],["Land_MedicalTent_01_CSAT_greenhex_generic_closed_F",[-17.9463,10.6855,0],90],["Land_MedicalTent_01_greenhex_closed_F",[18.0923,-10.7363,0],0],["Land_MedicalTent_01_CSAT_greenhex_generic_inner_F",[20.9338,2.79492,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[9.40112,-19.7969,0],270],["Land_Shoot_House_Wall_Long_Stand_F",[-9.33105,-20.0332,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[9.46021,21.1387,0],270],["Land_Shoot_House_Wall_Long_Stand_F",[-9.05566,21.9238,0],90],["Land_MedicalTent_01_CSAT_greenhex_generic_closed_F",[0.62085,23.791,0],90],["Land_MedicalTent_01_CSAT_greenhex_generic_closed_F",[-18.2644,-17.3301,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[9.3772,-23.7285,0],270],["OmniDirectionalAntenna_01_olive_F",[22.031,12.8594,1.90735e-06],0],["Land_PowerGenerator_F",[22.2607,14.7988,0],88],["Land_Shoot_House_Wall_Long_Stand_F",[9.48413,25.0703,0],270],["Land_Shoot_House_Wall_Long_Stand_F",[-26.8586,-0.78125,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[-26.8201,3.14258,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[1.36914,-27.0742,0],8.65142e-06],["Land_Shoot_House_Wall_Long_Stand_F",[-2.59375,-27.0508,0],8.65142e-06],["Alex_Laptop5",[18.3931,20.0703,0.816],0],["Land_CampingTable_F",[18.7427,19.875,0],0],["Land_Shoot_House_Wall_Long_Stand_F",[-26.8826,-4.71289,0],90],["Land_PowerGenerator_F",[22.2888,15.9883,0],88],["Land_Shoot_House_Wall_Long_Stand_F",[-9.0437,25.9453,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[5.30078,-27.0977,0],8.65142e-06],["Land_Shoot_House_Wall_Long_Stand_F",[-26.7961,7.07422,0],90],["Land_CampingChair_V2_F",[18.5186,20.7813,0],0],["Land_Shoot_House_Wall_Long_Stand_F",[-6.52539,-27.0254,0],8.65142e-06],["Land_PowerGenerator_F",[22.3333,17.3711,0],88],["Land_Shoot_House_Wall_Long_Stand_F",[-26.9067,-8.67578,0],90],["Land_BagFence_01_long_green_F",[-28.6924,0.599609,0],90],["Land_BagFence_01_long_green_F",[-28.7158,-2.24609,0],90],["Land_Camping_Light_F",[20.8203,19.8906,0.816],0],["Land_BagFence_01_long_green_F",[-28.6707,3.35938,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[-26.7986,11.0234,0],90],["Land_BagFence_01_long_green_F",[-28.6689,-5.10352,0],90],["Land_CampingTable_F",[21.5679,19.8535,0],0],["Land_CampingTable_F",[21.5679,19.8535,0],0],["Land_BagFence_01_long_green_F",[-28.6738,6.12305,0],90],["Land_MedicalTent_01_CSAT_greenhex_generic_closed_F",[-18.9309,22.3887,0],90],["FIR_MP_Laptop",[21.645,20.0645,0.816],0],["Land_Razorwire_F",[-29.5962,0.0800781,0],90],["Land_BagFence_01_long_green_F",[-28.6372,-7.93945,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[-26.9307,-12.6074,0],90],["Land_CampingChair_V2_F",[21.5801,20.8145,0],0],["Land_Shoot_House_Wall_Long_Stand_F",[-13.3755,-26.8828,0],8.65142e-06],["Land_BagFence_01_long_green_F",[-28.7056,8.95898,0],90],["Land_BagFence_01_long_green_F",[-28.634,-10.7031,0],90],["Land_Razorwire_F",[-29.5205,-8.01758,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[-26.7747,14.9551,0],90],["Land_Razorwire_F",[-29.7891,8.46289,0],90],["Land_CampingTable_F",[24.0486,19.6719,0],0],["Land_BagFence_01_long_green_F",[-28.7524,11.8164,0],90],["Land_Laptop_Oldman_F",[23.9749,19.9395,0.816],179],["Land_MedicalTent_01_floor_dark_F",[21.6782,22.7988,0],0],["Land_MedicalTent_01_CSAT_greenhex_generic_inner_F",[21.7402,22.8086,0],90],["Land_CampingChair_V2_F",[23.959,20.5801,0],0],["Land_Shoot_House_Wall_Long_Stand_F",[-26.9282,-16.5566,0],90],["Land_BagFence_01_long_green_F",[-28.6272,-13.5371,0],90],["Land_TripodScreen_01_dual_v1_F",[18.1016,26.0254,0],111],["Land_Shoot_House_Wall_Long_Stand_F",[-1.12183,31.6719,0],180],["Land_Shoot_House_Wall_Long_Stand_F",[2.84106,31.6484,0],180],["Land_Map_unfolded_Malden_F",[20.3025,24.7012,0.816],0],["Land_Shoot_House_Wall_Long_Stand_F",[-17.3071,-26.8594,0],8.65142e-06],["Land_Shoot_House_Wall_Long_Stand_F",[-5.05347,31.6953,0],180],["Land_BagFence_01_long_green_F",[-28.729,14.6621,0],90],["Land_CampingTable_F",[20.7297,24.8223,0],0],["Land_Shoot_House_Wall_Long_Stand_F",[6.77271,31.623,0],180],["Land_Camping_Light_F",[20.9915,24.8125,0.816],0],["Land_Shoot_House_Wall_Long_Stand_F",[-26.7505,18.918,0],90],["Land_BagFence_01_long_green_F",[-28.6506,-16.3828,0],90],["Land_BagFence_01_round_green_F",[-0.436035,-33.0039,0],270],["Land_Map_altis_F",[22.2195,24.8242,0.816],0],["Land_BagFence_01_round_green_F",[3.81958,-33.3164,0],44],["Land_CampingTable_F",[22.665,24.7969,0],0],["Land_Razorwire_F",[-29.4001,-16.3105,0],90],["Land_BagFence_01_long_green_F",[-28.7358,17.4961,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[-12.1653,31.5801,0],180],["Land_Shoot_House_Wall_Long_Stand_F",[-26.9521,-20.4883,0],90],["Land_Camping_Light_F",[23.1226,25.0156,0.816],0],["Land_Razorwire_F",[-29.8052,16.6445,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[-21.27,-26.8359,0],8.65142e-06],["Land_BagFence_01_long_green_F",[-2.14648,-34.3633,0],357],["Land_BagFence_01_long_green_F",[-28.6038,-19.2402,0],90],["Land_BagFence_01_long_green_F",[1.17847,34.4805,0],180],["Land_BagFence_01_long_green_F",[6.21313,-33.9668,0],357],["Land_BagFence_01_long_green_F",[-1.66724,34.5039,0],180],["Land_HBarrier_01_tower_green_F",[31.7131,-13.6055,0],179],["Land_BagFence_01_long_green_F",[3.93823,34.459,0],180],["Land_BagFence_01_long_green_F",[-4.52466,34.457,0],180],["Land_BagFence_01_long_green_F",[34.7305,2.17383,0],267],["Land_BagFence_01_long_green_F",[34.8533,-0.583984,0],267],["Land_BagFence_01_long_green_F",[-4.97705,-34.543,0],357],["Land_BagFence_01_long_green_F",[9.06421,-33.7695,0],357],["Land_BagFence_01_long_green_F",[34.605,5.01563,0],267],["Land_BagFence_01_long_green_F",[6.7019,34.4609,0],180],["Land_BagFence_01_long_green_F",[35.0012,-3.34375,0],267],["Land_BagFence_01_long_green_F",[-28.739,20.2598,0],90],["Land_Shoot_House_Wall_Long_Stand_F",[-26.7266,22.8496,0],90],["Land_BagFence_01_long_green_F",[-7.3606,34.4258,0],180],["Land_BagFence_01_long_green_F",[34.4087,7.86719,0],267],["Land_Razorwire_F",[0.658936,35.3848,0],180],["Land_Shoot_House_Wall_Long_Stand_F",[-16.0969,31.6055,0],180],["Land_BagFence_01_long_green_F",[-7.82813,-34.7402,0],357],["Land_BagFence_01_long_green_F",[11.8948,-33.5918,0],357],["Land_Razorwire_F",[35.606,2.74023,0],267],["Land_BagFence_01_long_green_F",[35.1812,-6.17578,0],267],["Land_BagFence_01_long_green_F",[9.53784,34.4941,0],180],["Land_BagFence_01_long_green_F",[34.2285,10.6973,0],267],["Land_Razorwire_F",[-4.4248,-35.5996,0],357],["Land_BagFence_01_long_green_F",[-10.1243,34.4219,0],180],["Land_Razorwire_F",[-7.43872,35.3086,0],180],["Land_BagFence_01_long_green_F",[-28.572,-22.0762,0],90],["Land_BagFence_01_long_green_F",[-10.6711,-34.8652,0],357],["Land_Razorwire_F",[12.019,-34.4688,0],357],["Land_BagFence_01_long_green_F",[35.3777,-9.02539,0],267],["Land_BagFence_01_long_green_F",[14.6545,-33.4434,0],357],["Land_BagFence_01_long_green_F",[34.0806,13.457,0],267],["Land_Razorwire_F",[36.2371,-5.62109,0],267],["Land_BagFence_01_long_green_F",[12.3953,34.541,0],180],["Land_Razorwire_F",[9.04175,35.5762,0],180],["Land_Razorwire_F",[35.1064,10.8223,0],267],["Land_BagFence_01_long_green_F",[-12.9583,34.416,0],180],["Land_Shoot_House_Wall_Long_Stand_F",[-25.2017,-26.8105,0],8.65142e-06],["Land_BagFence_01_long_green_F",[-28.7708,23.0957,0],90],["Land_Razorwire_F",[-29.4309,-22.5898,0],90],["Land_BagFence_01_long_green_F",[35.5032,-11.8672,0],267],["Land_Shoot_House_Wall_Long_Stand_F",[-20.0598,31.6289,0],180],["Land_BagFence_01_long_green_F",[-13.5007,-35.0215,0],357],["Land_BagFence_01_long_green_F",[17.4841,-33.2891,0],357],["Land_BagFence_01_long_green_F",[33.9255,16.2871,0],267],["Land_BagFence_01_long_green_F",[15.241,34.5176,0],180],["Land_BagFence_01_long_green_F",[-28.5688,-24.8398,0],90],["Land_BagFence_01_long_green_F",[-15.804,34.4395,0],180],["Land_Razorwire_F",[-12.5945,-36.043,0],357],["Land_Razorwire_F",[-15.7317,35.1875,0],180],["Land_BagFence_01_long_green_F",[35.6582,-14.6992,0],267],["Land_BagFence_01_long_green_F",[-16.2607,-35.168,0],357],["Land_BagFence_01_long_green_F",[-28.8176,25.9531,0],90],["Land_BagFence_01_long_green_F",[33.8003,19.1309,0],267],["Land_BagFence_01_long_green_F",[20.3274,-33.1621,0],357],["Land_BagFence_01_long_green_F",[18.075,34.5234,0],180],["Land_BagFence_01_long_green_F",[-18.6614,34.3926,0],180],["Land_Razorwire_F",[36.6816,-13.791,0],267],["Land_Razorwire_F",[-29.9834,25.4648,0],90],["Land_Razorwire_F",[34.5525,19.0977,0],267],["Land_Razorwire_F",[20.2944,-33.916,0],357],["Land_Razorwire_F",[17.2234,35.5938,0],180],["Land_Shoot_House_Wall_Long_Stand_F",[-23.9915,31.6523,0],180],["Land_BagFence_01_long_green_F",[35.8059,-17.457,0],267],["Land_BagFence_01_long_green_F",[33.6038,21.9805,0],267],["Land_BagFence_01_long_green_F",[-19.0908,-35.3477,0],357],["Land_BagFence_01_round_green_F",[-29.1614,-27.7324,0],90],["Land_BagFence_01_long_green_F",[23.1782,-32.9668,0],357],["Land_BagFence_01_long_green_F",[20.8386,34.5273,0],180],["Land_BagFence_01_long_green_F",[-21.4973,34.3594,0],180],["Land_BagFence_01_long_green_F",[-28.7942,28.7988,0],90],["Land_Razorwire_F",[-21.5757,35.1855,0],180],["Land_BagFence_01_long_green_F",[35.9861,-20.2871,0],267],["Land_BagFence_01_long_green_F",[33.4236,24.8105,0],267],["Land_BagFence_01_long_green_F",[-21.9419,-35.5449,0],357],["Land_BagFence_01_long_green_F",[26.0085,-32.7871,0],357],["Land_BagFence_01_long_green_F",[23.6746,34.5586,0],180],["Land_RepairDepot_01_green_F",[-12.9658,39.791,1.90735e-06],92],["Land_BagFence_01_long_green_F",[-24.261,34.3574,0],180],["Land_Razorwire_F",[-21.3933,-36.6836,0],357],["Land_BagFence_01_long_green_F",[36.1824,-23.1387,0],267],["Land_BagFence_01_round_green_F",[-29.7371,31.2207,0],58],["Land_BagFence_01_long_green_F",[33.2759,27.5723,0],267],["Land_BagFence_01_long_green_F",[-24.7852,-35.6699,0],357],["Land_BagFence_01_long_green_F",[28.7683,-32.6367,0],357],["Land_BagFence_01_long_green_F",[26.532,34.6055,0],180],["Land_Razorwire_F",[37.321,-22.5898,0],267],["Land_Razorwire_F",[34.1477,27.2793,0],267],["Land_Razorwire_F",[28.4778,-33.5098,0],357],["Land_BagFence_01_round_green_F",[-26.9714,-34.8398,0],58],["Land_Razorwire_F",[26.0437,35.7715,0],180],["Land_BagFence_01_round_green_F",[-29.3506,33.2832,0],142],["Land_BagFence_01_round_green_F",[32.4463,-30.4473,0],257],["Land_BagFence_01_long_green_F",[36.3081,-25.9824,0],267],["Land_BagFence_01_round_green_F",[31.3323,-32.2773,0],344],["Land_BagFence_01_long_green_F",[29.3777,34.582,0],180],["Land_BagFence_01_round_green_F",[33.3691,32.9941,0],274],["Land_BagFence_01_round_green_F",[31.9756,34.6152,0],186],["Land_IRMaskingCover_01_F",[-4.35107,47.7402,0.8463],0],["Land_IRMaskingCover_01_F",[8.70215,47.7266,0.8463],0],["CamoNet_OPFOR_big_stripe1",[15.4011,-47.4941,0],101]];
    private _centerService = [];
    private _centerTurrets = [["E22_O_Land_Pod_RAF_Heli_Transport_04_medevac_F",[17.1667,-23.3125,0],0],["E22_O_Land_Pod_RAF_Heli_Transport_04_medevac_F",[23.3542,-23.373,0],0],["E22_O_RAF_Truck_03_ammo_F",[-0.612549,39.457,1.90735e-06],91],["E22_O_RAF_Truck_03_ammo_F",[11.2617,39.5352,1.90735e-06],91],["O_APC_Tracked_02_30mm_lxWS",[10.1292,-45.4492,0],243],["E22_O_RAF_MRAP_02_gmg_F",[-3.59888,-47.4336,-1.90735e-06],88],["OPF_F_QAV_BRDM",[49.2158,5.38867,1.90735e-06],275],["O_APC_Tracked_02_cannon_F",[48.3899,11.3594,0],276]];

    private _centerTerrain = nearestTerrainObjects [_center, [], _centerRadius, false, true];
    _centerTerrain apply {hideObjectGlobal _x; _x allowDamage false};
    _terrain append _centerTerrain;

    private _dir = random 360;
    _centerComp = [_centerComp, _center, _dir, ["normal", "path", "simple"], _objects] call WHF_fnc_objectsMapper;
    _centerService = [_centerService, _center, _dir, ["frozen", "normal"], _objects] call WHF_fnc_objectsMapper;
    _centerTurrets = [_centerTurrets, _center, _dir, ["normal"], _objects] call WHF_fnc_objectsMapper;
    _objects append _centerComp;
    _objects append _centerService;
    _objects append _centerTurrets;

    private _quantity = [8, 16] call WHF_fnc_scaleUnitsSide;
    private _group = [opfor, _infantryTypes, _quantity, _center, 20] call WHF_fnc_spawnUnits;
    [_group, _center] call BIS_fnc_taskDefend;
    _groups pushBack _group;

    private _turretGroup = [opfor, [_standard], _centerTurrets] call WHF_fnc_spawnGunners;
    _groups pushBack _turretGroup;
};

{
    _x params ["_vehicleType", "_vehicleQuantity"];
    private _pos = [_center, [30, _radius]] call WHF_fnc_randomPos;
    if (_pos isEqualTo [0,0]) then {break};

    for "_i" from 1 to _vehicleQuantity do {
        private _vehicleArgs = [opfor, [_vehicleType], [_standard], 1, _pos, 30];
        private _vehicleGroup = _vehicleArgs call WHF_fnc_spawnVehicles;
        private _groupVehicles = assignedVehicles _vehicleGroup;
        [_vehicleGroup, _pos, 100] call BIS_fnc_taskPatrol;
        _groups pushBack _vehicleGroup;
        _vehicles append _groupVehicles;

        [_groupVehicles, _pos, 30] call WHF_fnc_setPosOnRoads;

        {if (random 1 < 0.8) then {_vehicleGroup leaveVehicle _x}} forEach _groupVehicles;
        _vehicleGroup setVariable ["WHF_assignedVehicles", _groupVehicles];
        _vehicleGroup addEventHandler ["CombatModeChanged", {
            params ["_vehicleGroup", "_mode"];
            if (_mode isNotEqualTo "COMBAT") exitWith {};
            _vehicleGroup removeEventHandler [_thisEvent, _thisEventHandler];
            private _groupVehicles = _vehicleGroup getVariable ["WHF_assignedVehicles", []];
            {_vehicleGroup addVehicle _x} forEach _groupVehicles;
        }];
    };

    private _infantryQuantity = [8, 16] call WHF_fnc_scaleUnitsSide;
    private _infantryArgs = [opfor, _infantryTypes, _infantryQuantity, _pos, 30];
    private _infantryGroup = _infantryArgs call WHF_fnc_spawnUnits;
    [_infantryGroup, _pos] call BIS_fnc_taskDefend;
    _groups pushBack _infantryGroup;

    private _depotPos = [_pos, [5, 50]] call WHF_fnc_randomPos;
    if (_depotPos isNotEqualTo [0,0]) then {
        private _depotTerrain = nearestTerrainObjects [_depotPos, [], 30, false, true];
        _depotTerrain apply {hideObjectGlobal _x; _x allowDamage false};
        _terrain append _depotTerrain;

        private _depotDir = ((_depotPos getDir _pos) + 90) % 360;
        private _depot = [
            [["StorageBladder_01_fuel_forest_F",[-1,1,0],90],["CamoNet_ghex_open_F",[0,0,1.09],90],["B_Slingload_01_Fuel_F",[-1,-7,0],60],["Box_East_AmmoVeh_F",[-3,7,0],0],["Land_RepairDepot_01_green_F",[-8,3,0],0],["Land_FuelStation_01_pump_F",[-6,7,0],0],["Land_FuelStation_01_pump_F",[-9,7,0],0]],
            _depotPos,
            _depotDir,
            ["normal", "simple"]
        ] call WHF_fnc_objectsMapper;
        _objects append _depot;
    };
} forEach [
    [["standard", _faction], [2, 3] call WHF_fnc_scaleUnitsSide],
    [["supply", _faction],   [2, 3] call WHF_fnc_scaleUnitsSide],
    [["mrap", _faction],     [2, 3] call WHF_fnc_scaleUnitsSide],
    [["apc", _faction],      [2, 3] call WHF_fnc_scaleUnitsSide],
    [["ifv", _faction],      [2, 3] call WHF_fnc_scaleUnitsSide],
    [["mbt", _faction],      [2, 3] call WHF_fnc_scaleUnitsSide],
    [["aa", _faction],       [2, 3] call WHF_fnc_scaleUnitsSide]
];

[_groups, _area] spawn WHF_fnc_attackLoop;

if (count _vehicles < 1) exitWith {
    diag_log text format ["%1: center %2 not clear to spawn vehicles", _fnc_scriptName, _center];
    [_objects] call WHF_fnc_queueGCDeletion;
    [_terrain] call WHF_fnc_queueGCUnhide;
    {[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
};

private _taskCenter = _center getPos [20 + random 20, random 360];
private _taskArea = [_taskCenter, _radius, _radius];
private _areaMarker = [["WHF_msnDestroyArmor_"], _taskArea, true] call WHF_fnc_createAreaMarker;
_areaMarker setMarkerBrushLocal "FDiagonal";
_areaMarker setMarkerColorLocal "ColorRed";
_areaMarker setMarkerAlpha 0.7;

private _activeVehicles = {_vehicles select {alive _x} inAreaArray _area};
private _current = count call _activeVehicles;
private _total = _current;
private _threshold = ceil (_total * 0.2) min (_total - 1);

private _getDescription = {[
    [
        "STR_WHF_destroyArmor_description",
        _current,
        _areaMarker,
        _current - _threshold max 0,
        _total - _threshold
    ],
    "STR_WHF_destroyArmor_title"
]};

private _taskDescription = call _getDescription;
private _taskID = [
    blufor,
    "",
    _taskDescription,
    _taskCenter,
    "CREATED",
    -1,
    true,
    "destroy"
] call WHF_fnc_taskCreate;

while {true} do {
    sleep 10;

    _current = count call _activeVehicles;
    if (_current <= _threshold) exitWith {
        private _message = "$STR_WHF_destroyArmor_success";
        [[blufor, "BLU"], _message] remoteExec ["WHF_fnc_localizedSideChat", blufor];
        [_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
    };

    private _description = call _getDescription;
    if (_taskDescription isNotEqualTo _description) then {
        [_taskID, nil, _description] call BIS_fnc_setTask;
        _taskDescription = _description;
    };
};

deleteMarker _areaMarker;

[_objects] call WHF_fnc_queueGCDeletion;
[_terrain] call WHF_fnc_queueGCUnhide;
{[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
{[_x] call WHF_fnc_queueGCDeletion} forEach _vehicles;
