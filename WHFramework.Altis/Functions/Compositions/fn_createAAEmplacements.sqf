/*
Function: WHF_fnc_createAAEmplacements

Description:
    Create anti-air emplacements in a given area.

Parameters:
    Side side:
        The AA group's side.
    Number quantity:
        The number of emplacements to attempt spawning.
    Position2D center:
        The center of the area.
    Number radius:
        The radius of the area.
    Array types:
        (Optional, default ["short", "medium", "long"])
        An array of emplacement types to select from.

Returns:
    Array
        An array containing three elements:
            1. A nested array of compositions that were spawned in.
            2. A nested array of terrain objects that were hidden.
            3. An array of groups that were spawned in.

Author:
    thegamecracks

*/
params ["_side", "_quantity", "_center", "_radius", ["_types", ["short", "medium", "long"]]];

private _compositions = [];
for "_i" from 1 to _quantity do {
    private _type = selectRandom _types;
    switch (_type) do {
        case "short": {
            _compositions pushBack selectRandom [
                [
                    [["Land_HBarrier_01_line_5_green_F",[-1.28711,3.93945,0],357],["Land_HBarrier_01_big_4_green_F",[-4.78711,0.423828,0],269],["Land_HBarrier_01_line_1_green_F",[2.21289,4.42578,0],330],["Land_HBarrier_01_line_1_green_F",[5.96289,-1.07422,0],90],["CamoNet_ghex_open_F",[6.58887,-0.675781,0],90],["Land_BagFence_01_long_green_F",[2.21289,6.67578,0],270],["Land_HBarrier_01_big_4_green_F",[7.46289,-0.572266,0],89],["CamoNet_ghex_open_F",[-7.50879,-3.24219,0],75],["CamoNet_ghex_F",[-0.259766,-8.24219,0],180],["Land_PaperBox_open_empty_F",[2.63574,-9.08984,0],23.363],["Land_PaperBox_open_empty_F",[-2.97363,-9.02344,0],330.487],["Land_BagFence_01_round_green_F",[2.96289,9.17773,0],135],["Land_HBarrier_01_big_4_green_F",[5.46289,-8.07227,0],119],["Land_HBarrier_01_tower_green_F",[-7.78711,5.67578,0],90],["Land_HBarrier_01_big_4_green_F",[-9.78711,-1.82617,0],269],["Land_BagFence_01_round_green_F",[9.26855,4.18945,0],300],["Land_HBarrier_01_big_4_green_F",[-6.78711,-7.82227,0],59],["Land_BagFence_01_short_green_F",[4.76172,9.86523,0],0],["Land_HBarrier_01_big_4_green_F",[-0.287109,-11.3242,0],179],["Land_BagFence_01_long_green_F",[9.71289,6.67578,0],90],["Land_BagFence_01_long_green_F",[6.46289,9.92578,0],180],["Land_BagFence_01_round_green_F",[8.96289,9.17578,0],225]],
                    [["O_T_APC_Tracked_02_AA_ghex_F",[-0.0400391,0.0332031,0],0]]
                ],
                [
                    [["Land_BagFence_01_long_green_F",[-3.65723,-0.820313,0],270],["Land_HBarrier_01_line_3_green_F",[-3.78223,-3.94531,0],270],["CamoNet_ghex_open_F",[-5.12695,-2.28125,0],90],["Land_WoodenCrate_01_stack_x5_F",[2.21875,-5.44531,0],0],["Land_BagFence_01_long_green_F",[-4.78125,3.55469,0],105],["Land_Sacks_heap_F",[-5.25195,-2.9082,0],0],["Land_WoodenCrate_01_stack_x5_F",[-5.37695,-4.2832,0],270],["Land_HBarrier_01_line_3_green_F",[-2.78223,-6.31836,0],225],["Land_HBarrier_01_line_1_green_F",[-4.28125,5.55469,0],195],["Land_HBarrier_01_line_5_green_F",[-1.65723,7.17969,0],150],["Land_WoodenCrate_01_stack_x3_F",[-7.62695,-0.158203,0],45],["Land_HBarrier_01_big_4_green_F",[1.96875,-7.31836,0],180],["Land_HBarrier_01_line_1_green_F",[0.96875,8.68164,0],90],["Land_HBarrier_01_line_3_green_F",[-9.00293,-2.2832,0],270],["Land_BagFence_01_long_green_F",[3.08887,8.85742,0],0],["Land_HBarrier_01_line_5_green_F",[9.34277,-1.32031,0],91.5163],["Land_BagFence_01_long_green_F",[9.34277,2.80469,0],270],["Land_HBarrier_01_line_5_green_F",[7.46875,6.80469,0],45],["Land_HBarrier_01_line_1_green_F",[-9.75195,2.8418,0],15],["Land_HBarrier_01_line_1_green_F",[5.03418,8.85742,0],195],["Land_HBarrier_01_line_1_green_F",[-5.12695,-9.0332,0],285],["Land_HBarrier_01_line_1_green_F",[9.34375,4.68164,0],90],["Land_BagFence_01_long_green_F",[7.46875,-7.44531,0],180],["Land_BagFence_01_long_green_F",[9.34277,-5.44531,0],270],["Land_HBarrier_01_line_1_green_F",[-9.50293,-7.1582,0],300],["Land_HBarrier_01_line_1_green_F",[9.46777,-7.57031,0],180]],
                    [["O_T_APC_Tracked_02_AA_ghex_F",[2.7168,1.89844,0],0]]
                ],
                [
                    [["Land_CampingTable_F",[0.650391,-4.30859,0],7.98204e-05],["Land_WoodenCrate_01_stack_x5_F",[2.65039,-3.93359,0],90],["Land_Pallets_stack_F",[-4.47461,-1.93359,0],345],["CamoNet_BLUFOR_F",[2.24609,-4.21875,0],180],["Land_HBarrier_01_line_1_green_F",[4.77539,2.81641,0],60],["Land_WoodenCrate_01_stack_x5_F",[4.27637,-4.05859,0],0],["Land_BagFence_01_long_green_F",[6.15039,1.44336,0],225],["Land_HBarrier_01_big_4_green_F",[2.65039,-5.93359,0],180],["Land_BagFence_01_long_green_F",[-6.09961,3.94141,0],180],["Land_HBarrier_01_line_5_green_F",[-3.59961,6.31641,0],276.307],["Land_HBarrier_01_line_5_green_F",[3.90137,6.19141,0],78.738],["Land_HBarrier_01_line_3_green_F",[-7.22461,-2.80859,0],0],["Land_HBarrier_01_line_1_green_F",[7.77539,0.0664063,0],315],["Land_BagFence_01_long_green_F",[-8.34961,-0.808594,0],90],["Land_BagFence_01_long_green_F",[-8.34961,2.06641,0],90],["Land_HBarrier_01_line_1_green_F",[-8.09961,4.06641,0],210],["Land_HBarrier_01_line_1_green_F",[7.27539,-5.68359,0],60],["Land_BagFence_01_long_green_F",[9.16211,-1.3418,0],225],["Land_HBarrier_01_line_5_green_F",[-0.100586,9.31641,0],1.5163],["Land_HBarrier_01_line_1_green_F",[-3.22461,9.19141,0],45],["Land_HBarrier_01_line_1_green_F",[3.27539,9.19141,0],120],["Land_BagFence_01_long_green_F",[8.89844,-4.25977,0],315],["Land_HBarrier_01_line_1_green_F",[10.4004,-2.93359,0],345]],
                    [["O_T_APC_Tracked_02_AA_ghex_F",[-0.00585938,5.56055,0],0]]
                ],
                [
                    [["Land_Sacks_heap_F",[1.91309,-2.68359,0],0],["CamoNet_ghex_open_F",[-0.270508,-4.35352,0],0],["Land_CratesWooden_F",[4.16309,-2.55859,0],180],["Land_HBarrier_01_big_4_green_F",[1.19336,-4.69336,0],180],["Land_WoodenCrate_01_stack_x5_F",[-4.33691,-4.55859,0],270],["Land_WoodenCrate_01_stack_x5_F",[6.19922,-2.7168,0],270],["Land_HBarrier_01_line_5_green_F",[2.16309,7.44141,0],180],["Land_HBarrier_01_line_3_green_F",[-7.58691,1.94336,0],135],["Land_WaterTank_03_F",[8.28809,0.191406,0],0],["Land_HBarrier_01_line_5_green_F",[-6.58691,5.31445,0],90],["Land_BagFence_01_long_green_F",[-8.83691,-0.433594,0],270],["Land_HBarrier_01_line_1_green_F",[3.16309,-8.43359,0],105],["Land_BagFence_01_long_green_F",[-0.586914,9.31641,0],255],["Land_HBarrier_01_line_1_green_F",[-5.33691,7.69141,0],285],["Land_BagFence_01_long_green_F",[-8.83691,-3.30859,0],90],["Land_BagFence_01_long_green_F",[9.66309,1.06641,0],270],["Land_HBarrier_01_line_5_green_F",[9.41309,-3.05859,0],271.516],["Land_BagFence_01_long_green_F",[5.16309,-8.68359,0],180],["Land_BagFence_01_long_green_F",[9.66309,3.56641,0],270],["Land_BagFence_01_long_green_F",[-4.46191,9.44141,0],120],["Land_BagFence_01_long_green_F",[5.91211,8.66016,0],135],["Land_BagFence_01_long_green_F",[-2.33691,10.6914,0],180],["Land_HBarrier_01_line_1_green_F",[9.66309,5.56641,0],90],["Land_BagFence_01_long_green_F",[8.03809,-8.68359,0],0],["Land_BagFence_01_long_green_F",[9.41309,-7.30859,0],90],["Land_BagFence_01_long_green_F",[9.62305,7.53516,0],270],["Land_BagFence_01_long_green_F",[8.28809,9.31641,0],195],["Land_HBarrier_01_line_1_green_F",[13.1631,-4.55859,0],180]],
                    [["O_T_APC_Tracked_02_AA_ghex_F",[-0.37793,3.00586,0],270.469]]
                ],
                [
                    [["CamoNet_ghex_big_F",[-0.0292969,-0.0351563,0],180],["Land_Sacks_heap_F",[-4.5293,1.21289,0],0],["Land_CratesWooden_F",[4.4707,-1.41211,0],270],["Land_PaperBox_closed_F",[-4.40332,2.58984,0],0],["Land_Pallets_stack_F",[3.59473,4.08789,0],359.997],["Land_WoodenCrate_01_stack_x5_F",[6.0957,-1.03711,0],270],["Land_WoodenCrate_01_stack_x5_F",[6.21973,0.462891,0],180],["Land_CratesWooden_F",[5.2207,3.58789,0],105],["Land_HBarrier_01_big_4_green_F",[-6.5293,0.962891,0],270],["Land_PaperBox_closed_F",[1.84668,7.21484,0],0],["Land_HBarrier_01_big_4_green_F",[-0.154297,-7.53711,0],180],["Land_HBarrier_01_line_3_green_F",[-9.1543,1.08789,0],180],["Land_WoodenCrate_01_stack_x5_F",[1.8457,9.46289,0],270],["Land_HBarrier_01_big_4_green_F",[3.8457,9.33789,0],270],["Land_WoodenCrate_01_stack_x5_F",[1.84473,11.3379,0],285],["Land_HBarrier_01_line_3_green_F",[-11.6533,1.96289,0],266.049],["Land_BagFence_01_long_green_F",[-11.9043,5.21289,0],270],["CamoNet_ghex_open_F",[-11.0293,6.96289,0],270],["Land_WaterTank_03_F",[-9.5293,9.96289,0],0],["Land_BagFence_01_short_green_F",[-12.6777,6.68164,0],0],["Land_WoodenCrate_01_F",[-9.7793,11.7129,0],345.001],["Land_HBarrier_01_line_3_green_F",[-11.1533,11.2129,0],266.049],["Land_BagFence_01_round_green_F",[-14.5293,7.33984,0],45],["Land_HBarrier_01_big_4_green_F",[1.84473,16.8379,0],240],["Land_BagFence_01_short_green_F",[-12.6777,11.5566,0],0],["Land_BagFence_01_short_green_F",[-15.1777,9.30664,0],270],["Land_BagFence_01_round_green_F",[-14.5293,10.9629,0],135],["Land_HBarrier_01_line_5_green_F",[-10.5293,15.2129,0],285],["Land_HBarrier_01_line_5_green_F",[-2.7793,20.0879,0],0],["Land_HBarrier_01_line_5_green_F",[-7.6543,18.8379,0],330]],
                    [["O_T_APC_Tracked_02_AA_ghex_F",[-3.88379,14.6914,0],345]]
                ]
            ];
        };
        case "medium": {
            _compositions pushBack selectRandom [
                [
                    [["Land_Missle_Trolley_02_F",[-0.933594,8.125,0],225],["Land_HBarrier_01_big_4_green_F",[3.65918,-9.18555,0],90],["Land_HBarrier_01_big_4_green_F",[-1.71582,9.9375,0],315],["Land_HBarrier_01_big_4_green_F",[9.78418,-2.68555,0],90],["Land_BagFence_01_long_green_F",[9.65918,4.31445,0],90],["Land_HBarrier_01_big_4_green_F",[-8.34082,6.93945,0],180],["Land_Missle_Trolley_02_F",[4.18945,10.2188,0],270],["Land_Razorwire_F",[-2.59082,11.1914,0],315],["Land_BagFence_01_long_green_F",[9.65918,7.06445,0],90],["Land_HBarrier_01_big_4_green_F",[-1.34082,-12.5605,0],180],["Land_Razorwire_F",[-9.59082,8.68945,0],2.73208e-05],["Land_BagFence_01_end_green_F",[9.53418,8.81445,0],255],["Land_HBarrier_01_big_4_green_F",[12.9092,2.18945,0],180],["Land_HBarrier_01_big_4_green_F",[5.15918,12.3145,0],180],["Land_Missle_Trolley_02_F",[11.7813,7.11914,0],0],["CamoNet_ghex_open_F",[12.2842,6.31641,0],90],["Land_HBarrier_01_line_5_green_F",[7.15918,-12.1855,0],0],["Land_HBarrier_01_big_4_green_F",[-13.5898,3.81445,0],285],["Land_Razorwire_F",[3.78418,-14.1875,0],180],["Land_HBarrier_01_big_4_green_F",[-14.4658,-3.18555,0],90],["Land_Razorwire_F",[4.9082,14.0664,0],2.73208e-05],["Land_Razorwire_F",[-4.21582,-14.3125,0],180],["Land_Missle_Trolley_02_F",[13.208,7.20898,0],0],["Land_HBarrier_01_line_3_green_F",[10.2842,-11.3105,0],90],["Land_HBarrier_01_big_4_green_F",[-9.59082,-12.6855,0],180],["Land_Razorwire_F",[-15.4521,4.36133,0],285],["Land_Razorwire_F",[-16.4658,-3.18555,0],270],["Land_HBarrier_01_big_4_green_F",[-14.5908,-9.43555,0],90],["Land_HBarrier_01_big_4_green_F",[16.2842,7.31445,0],90],["Land_HBarrier_01_big_4_green_F",[13.1592,12.3145,0],3.41509e-06],["Land_Razorwire_F",[-12.3408,-14.4375,0],180],["Land_Razorwire_F",[13.4092,13.9414,0],2.73208e-05],["Land_Razorwire_F",[-16.5908,-10.3105,0],270],["Land_Razorwire_F",[18.2842,8.81445,0],90]],
                    [["B_SAM_System_02_F",[-2.27051,-6.70313,0],0],["B_SAM_System_02_F",[-8.09668,0.232422,0],0]]
                ]
            ]
        };
        case "long": {
            _compositions pushBack selectRandom [
                [
                    [["Land_FieldToilet_F",[4.92188,-0.646484,0],150.003],["Land_FieldToilet_F",[6.67188,-0.771484,0],180.002],["Land_HBarrier_01_big_4_green_F",[6.42188,-3.14648,0],180],["Land_HBarrier_01_big_4_green_F",[3.29688,-8.14648,0],90],["Land_BagFence_01_end_green_F",[9.42188,1.47852,0],75],["Land_Razorwire_F",[8.29688,-4.77148,0],180],["Land_HBarrier_01_big_4_green_F",[1.29688,9.60352,0],90],["Land_BagFence_01_long_green_F",[9.29688,3.22852,0],270],["Land_Razorwire_F",[5.42188,-9.27148,0],90],["Land_HBarrier_01_big_4_green_F",[-1.82813,-11.3965,0],180],["Land_HBarrier_01_tower_green_F",[10.1719,7.47852,0],90],["Land_HBarrier_01_big_4_green_F",[13.0469,-0.396484,0],135],["Land_HBarrier_01_line_3_green_F",[6.17188,11.6035,0],270],["Land_Razorwire_F",[2.04688,-13.2695,0],2.73208e-05],["Land_HBarrier_01_big_4_green_F",[-3.82813,12.9785,0],180],["Land_PaperBox_closed_F",[13.6719,3.60352,0],270],["Land_Razorwire_F",[-4.95313,-13.2695,0],2.73208e-05],["Land_Razorwire_F",[14.6709,-1.64844,0],135],["Land_HBarrier_01_big_4_green_F",[-14.8281,-0.0214844,0],90],["Land_HBarrier_01_big_4_green_F",[-9.82813,-11.3965,0],180],["Land_Razorwire_F",[-3.70313,14.8555,0],2.73208e-05],["Land_BagFence_01_long_green_F",[8.29688,12.9785,0],0],["Land_HBarrier_01_big_4_green_F",[-14.8281,7.97852,0],90],["Land_HBarrier_01_big_4_green_F",[-14.8281,-8.02148,0],90],["Land_Razorwire_F",[-16.8281,1.72852,0],270],["Land_HBarrier_01_big_4_green_F",[15.7969,6.22852,0],90],["Land_BagFence_01_long_green_F",[11.0469,12.9785,0],0],["Land_HBarrier_01_big_4_green_F",[-11.8281,12.9785,0],180],["Land_BagFence_01_end_green_F",[12.7979,13.1035,0],345],["Land_Razorwire_F",[-13.0781,-12.8945,0],2.73208e-05],["Land_Razorwire_F",[-16.9531,-8.02148,0],270],["Land_Razorwire_F",[17.9219,5.60352,0],90],["Land_Razorwire_F",[-11.8281,14.7305,0],2.73208e-05],["Land_Razorwire_F",[-16.8281,10.7285,0],270]],
                    [["O_Radar_System_02_F",[-8.72461,-2.95117,-0.00652504],270],["O_Radar_System_02_F",[-2.68555,-6.94727,0],90],["O_SAM_System_04_F",[-11.2168,4.93359,0],0],["O_SAM_System_04_F",[-2.24414,4.73438,0],0]]
                ]
            ]
        };
    };
};

private _isPosSuitable = {
    params ["_pos", "_clearRadius"];
    _pos nearRoads _clearRadius isEqualTo []
    && {_pos isFlatEmpty [-1, -1, 0.5, 20] isNotEqualTo []}
};

private _clearRadius = 40;
private _compositionObjects = [];
private _compositionTerrain = [];
private _compositionGroups = [];
{

    private _pos = [_center, [20, _radius], [_clearRadius, _isPosSuitable]] call WHF_fnc_randomPos;
    if (_pos isEqualTo [0,0]) then {continue};
    _pos = _pos vectorAdd [0,0,0];

    _x params ["_fortifications", "_vehicles"];

    private _terrain = nearestTerrainObjects [_pos, [], _clearRadius, false];
    {hideObjectGlobal _x} forEach _terrain;

    private _direction = random 360;
    _fortifications = [_fortifications, _pos, _direction, ["normal", "path", "simple"]] call WHF_fnc_objectsMapper;
    _vehicles = [_vehicles, _pos, _direction, ["normal"]] call WHF_fnc_objectsMapper;

    private _group = [_side, "standard", count _vehicles, [random -500, random -500, 500], 0] call WHF_fnc_spawnUnits;
    {
        private _vehicle = _vehicles # _forEachIndex;
        _group addVehicle _vehicle;
        _x moveInGunner _vehicle;
    } forEach units _group;

    {
        _x setFuel 0;
        _x allowCrewInImmobile [true, true];
        _x setVehicleRadar 1;
    } forEach _vehicles;

    _compositionObjects pushBack (_fortifications + _vehicles);
    _compositionTerrain pushBack _terrain;
    _compositionGroups pushBack _group;
} forEach _compositions;

[_compositionObjects, _compositionTerrain, _compositionGroups]
