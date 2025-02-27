/*
Function: WHF_fnc_createEmplacements

Description:
    Create random emplacements in a given area.

Parameters:
    Number quantity:
        The number of emplacements to attempt spawning.
    Position2D center:
        The center of the area.
    Number radius:
        The radius of the area.
    Array types:
        (Optional, default [])
        An optional array of emplacement types to randomly select from.
        Must be one of the following:
            "camp"
    Boolean simple:
        (Optional, default false)
        If true, spawn simple objects for compositions.

Returns:
    Array
        An array containing two elements:
            1. A nested array of compositions that were spawned in.
            2. A nested array of terrain objects that were hidden.

Author:
    thegamecracks

*/
params ["_quantity", "_center", "_radius", ["_types", []], ["_simple", false]];

if (_types isEqualTo []) then {_types = ["camp"]};

private _compositions = [];
for "_i" from 1 to _quantity do {
    private _type = selectRandom _types;
    switch (_type) do {
        case "camp": {
            _compositions pushBack selectRandom [
                [["Land_Cargo_Patrol_V2_F",[0.380371,0.438965,0.00333595],180,1,0,[],"","",true,false],["Land_WoodenCrate_01_stack_x5_F",[-4.85986,2.94287,0],131.998,1,0,[],"","",true,false],["Land_GarbageBags_F",[-3.74463,0.688477,0],0,1,0,[],"","",true,false],["Land_WoodenCrate_01_stack_x5_F",[-6.1792,1.50879,0],175.519,1,0,[],"","",true,false],["Land_BagFence_01_round_green_F",[2.86865,6.02197,0.314117],225.21,1,0,[],"","",true,false],["Land_BagFence_01_long_green_F",[0.496094,6.6499,0.31024],180,1,0,[],"","",true,false],["Land_BagFence_01_round_green_F",[-1.87744,6.0293,0.196842],134.952,1,0,[],"","",true,false],["Land_BagFence_01_round_green_F",[5.36719,2.65381,0.0921497],225.16,1,0,[],"","",true,false],["Land_BagFence_01_round_green_F",[5.38037,-2.06152,0],315,1,0,[],"","",true,false],["Land_BagFence_01_long_green_F",[6.00293,0.30957,0.0159206],270.004,1,0,[],"","",true,false]],
                [["Land_Cargo_Patrol_V4_F",[3.59863,4.65771,0],180,1,0,[],"","",true,false],["CamoNet_BLUFOR_open_F",[-0.776367,-2.71777,-9.53674e-07],0,1,0,[],"","",true,false],["Land_WoodenCrate_01_stack_x5_F",[-0.775879,6.28271,0],242.345,1,0,[],"","",true,false],["Land_PaperBox_open_empty_F",[-2.65137,5.53223,0],251.154,1,0,[],"","",true,false],["Land_PaperBox_open_full_F",[6.31006,0.185059,0],272.987,1,0,[],"","",true,false],["Land_PaperBox_open_full_F",[6.22363,-1.34277,0],92.926,1,0,[],"","",true,false],["Land_Pallets_F",[3.72363,-5.46777,0],267.491,1,0,[],"","",true,false],["Land_Pallets_stack_F",[5.84863,-5.21777,0],274.231,1,0,[],"","",true,false],["Land_Pallets_F",[4.59863,8.28174,0],169.016,1,0,[],"","",true,false]],
                [["CamoNet_INDP_open_F",[0.0566406,0.305664,-9.53674e-07],180,1,0,[],"","",true,false],["Land_TentDome_F",[2.82275,2.71924,0],300,1,0,[],"","",true,false],["Land_TentDome_F",[-2.67773,3.46924,0],255,1,0,[],"","",true,false],["Land_CratesWooden_F",[-5.17725,-0.905762,0],1.00179e-05,1,0,[],"","",true,false],["Land_WoodenCrate_01_F",[-4.17725,-2.40576,0],60.0002,1,0,[],"","",true,false],["Land_Sacks_heap_F",[-5.80225,-2.40576,0],195,1,0,[],"","",true,false],["Land_BagFence_01_long_green_F",[5.69727,-2.90576,0],135,1,0,[],"","",true,false],["Land_BagFence_01_long_green_F",[6.69775,-0.530762,0],90,1,0,[],"","",true,false],["Land_BagFence_01_long_green_F",[-6.80225,-0.780762,0],90,1,0,[],"","",true,false],["Land_BagFence_01_long_green_F",[6.69775,2.21924,0],90,1,0,[],"","",true,false],["Land_BagFence_01_long_green_F",[-6.80225,1.96924,0],90,1,0,[],"","",true,false],["Land_WoodenCrate_01_stack_x3_F",[7.69727,-2.28076,0],105,1,0,[],"","",true,false]],
                [["Land_WoodenShelter_01_F",[-2.49365,0.514648,9.53674e-07],90,1,0,[],"","",true,false],["Land_WaterTank_03_F",[-3.22559,-1.42139,0],0,1,0,[],"","",true,false],["Land_BagFence_01_long_green_F",[2.82227,-0.635254,0],90,1,0,[],"","",true,false],["CamoNet_INDP_F",[-0.600586,-5.92188,0],180,1,0,[],"","",true,false],["Land_Pallets_F",[-2.85059,0.953125,0],330,1,0,[],"","",true,false],["Land_BagFence_01_long_green_F",[4.229,0.764648,0],180,1,0,[],"","",true,false],["Land_BagFence_01_round_green_F",[3.61377,-2.62305,0],225,1,0,[],"","",true,false],["Land_BagFence_01_round_green_F",[1.8584,4.4126,0],315,1,0,[],"","",true,false],["Land_BagFence_01_long_green_F",[-4.80078,-0.89209,0],270,1,0,[],"","",true,false],["Land_BagFence_01_long_green_F",[-4.83008,1.84375,0],270,1,0,[],"","",true,false],["Land_BagFence_01_long_green_F",[-4.82373,-3.76318,0],270,1,0,[],"","",true,false],["Land_BagFence_01_short_green_F",[4.23926,-4.49805,0],270,1,0,[],"","",true,false],["Land_BagFence_01_round_green_F",[6.8584,1.4126,0],315,1,0,[],"","",true,false],["Land_BagFence_01_long_green_F",[1.11377,-6.99805,0],1.00179e-05,1,0,[],"","",true,false],["Land_BagFence_01_round_green_F",[3.2334,6.4126,0],135,1,0,[],"","",true,false],["Land_BagFence_01_long_green_F",[-1.6792,-7.01758,0],1.00179e-05,1,0,[],"","",true,false],["Land_BagFence_01_round_green_F",[3.625,-6.42578,0],315,1,0,[],"","",true,false],["Land_BagFence_01_round_green_F",[-4.17578,-6.39258,0],45,1,0,[],"","",true,false],["Land_BagFence_01_long_green_F",[7.6084,3.9126,0],270,1,0,[],"","",true,false],["Land_BagFence_01_short_green_F",[5.1084,7.03711,0],180,1,0,[],"","",true,false],["Land_BagFence_01_round_green_F",[7.03613,6.42334,0],225,1,0,[],"","",true,false]],
                [["CamoNet_INDP_open_F",[0.000976563,0.000976563,-9.53674e-07],270,1,0,[],"","",true,false],["Land_PicnicTable_01_F",[1.18408,3.03418,0],202.14,1,0,[],"","",true,false],["Land_PicnicTable_01_F",[1.74121,-3.2749,0],332.959,1,0,[],"","",true,false],["Land_PicnicTable_01_F",[-3.85352,-2.65771,0],90,1,0,[],"","",true,false]],
                [["Land_TTowerSmall_2_F",[2.20068,6.06787,0],267.701,1,0,[],"","",true,false],["Land_BagBunker_01_large_green_F",[-0.00390625,-0.00244141,0],0,1,0,[],"","",true,false],["Land_PowerGenerator_F",[2.23096,5.31836,0],177.701,1,0,[],"","",true,false],["Land_HBarrier_01_line_3_green_F",[3.74854,5.65381,0],270,1,0,[],"","",true,false],["Land_HBarrier_01_line_3_green_F",[-3.90039,5.66699,0],88.545,1,0,[],"","",true,false],["Land_TripodScreen_01_dual_v2_F",[-1.84521,8.06104,0],152.439,1,0,[],"","",true,false],["Land_PortableGenerator_01_F",[-2.74023,7.47705,0],272.439,1,0,[],"","",true,false],["Land_CratesWooden_F",[2.97705,8.26709,0],179.93,1,0,[],"","",true,false]]
            ];
        };
        case "hq": {
            _compositions pushBack selectRandom [
                [["Land_Cargo_HQ_V4_F",[0.869141,-6.25977,0],0,1,0,[],"","",true,false],["Land_Cargo10_grey_F",[2.86914,3.74072,0],60.0012,1,0,[],"","",true,false],["Land_Pallets_stack_F",[3.07471,6.45313,0],165.72,1,0,[],"","",true,false],["Land_HBarrier_01_line_5_green_F",[7.74365,1.36572,0],0,1,0,[],"","",true,false],["Land_PaperBox_closed_F",[2.85889,8.00635,0],0,1,0,[],"","",true,false],["Land_PaperBox_open_full_F",[2.84424,9.48047,0],90,1,0,[],"","",true,false],["Land_Cargo_House_V4_F",[-8.25537,6.74072,0],345,1,0,[],"","",true,false],["Land_HBarrier_01_line_5_green_F",[11.1191,-0.634277,0],90,1,0,[],"","",true,false],["Land_HBarrier_01_line_1_green_F",[-11.7339,1.70947,0],0,1,0,[],"","",true,false],["Land_HBarrier_01_line_1_green_F",[-11.7554,-3.13428,0],270,1,0,[],"","",true,false],["Land_WoodenCrate_01_stack_x5_F",[-0.00585938,12.7407,0],165,1,0,[],"","",true,false],["Land_WoodenCrate_01_stack_x3_F",[12.7441,-3.63428,0],105,1,0,[],"","",true,false],["Land_HBarrier_01_big_4_green_F",[-11.7559,-7.88428,-9.53674e-07],90,1,0,[],"","",true,false],["Land_HBarrier_01_big_4_green_F",[-12.7559,6.24072,-9.53674e-07],255,1,0,[],"","",true,false],["Land_HBarrier_01_big_4_green_F",[-2.88086,14.1157,-9.53674e-07],345,1,0,[],"","",true,false],["Land_HBarrier_01_line_3_green_F",[3.24414,-13.7593,0],150,1,0,[],"","",true,false],["Land_HBarrier_01_line_3_green_F",[5.86914,-13.1343,0],0,1,0,[],"","",true,false],["Land_HBarrier_01_line_3_green_F",[0.619141,-14.3843,0],0,1,0,[],"","",true,false],["Land_HBarrier_01_big_4_green_F",[-10.7559,12.1157,-9.53674e-07],345,1,0,[],"","",true,false],["Land_Cargo20_grey_F",[11.3691,-12.7593,0],285,1,0,[],"","",true,false],["Land_HBarrier_01_line_3_green_F",[-11.1309,-13.1343,0],240,1,0,[],"","",true,false],["Land_BagFence_01_long_green_F",[-6.13086,-15.7593,0],0,1,0,[],"","",true,false],["Land_HBarrier_01_line_3_green_F",[-9.13086,-15.1343,0],210,1,0,[],"","",true,false]],
                [["Land_HBarrier_01_tower_green_F",[-5.84229,1.05664,0],90,1,0,[],"","",true,false],["Land_HBarrier_01_line_5_green_F",[1.40771,-1.19336,0],0,1,0,[],"","",true,false],["CamoNet_ghex_open_F",[5.03271,2.68115,-9.53674e-07],90,1,0,[],"","",true,false],["CamoNet_ghex_F",[-3.84229,-5.56836,0],180,1,0,[],"","",true,false],["Land_HBarrier_01_big_4_green_F",[3.65771,-8.69336,-9.53674e-07],180,1,0,[],"","",true,false],["Land_BagFence_01_long_green_F",[-0.0922852,8.30615,0],180,1,0,[],"","",true,false],["Land_HBarrier_01_big_4_green_F",[-4.59229,-8.56885,-9.53674e-07],0,1,0,[],"","",true,false],["Land_BagFence_01_long_green_F",[-2.84229,8.30615,0],180,1,0,[],"","",true,false],["Land_HBarrier_01_big_4_green_F",[10.3359,0.42627,-9.53674e-07],90,1,0,[],"","",true,false],["Land_BagFence_01_round_green_F",[-5.34229,7.68164,0],135,1,0,[],"","",true,false],["Land_HBarrier_01_line_5_green_F",[3.21045,9.80176,0],315,1,0,[],"","",true,false],["Land_HBarrier_01_big_4_green_F",[7.96045,7.55176,-9.53674e-07],45,1,0,[],"","",true,false],["Land_HBarrier_01_big_tower_green_F",[10.2104,-6.82324,0],285,1,0,[],"","",true,false],["Land_HBarrier_01_big_4_green_F",[-9.71729,-5.44336,-9.53674e-07],270,1,0,[],"","",true,false]],
                [["Land_Slum_03_F",[0,0,0],0,1,0,[],"","",true,false]]
            ];
        };
        default {diag_log text format ["Unknown emplacement type: %1", _type]};
    };
};

private _minSize = 10;
private _maxSize = 50;
private _maxGrad = 0.25;
private _compositionObjects = [];
private _compositionTerrain = [];
{
    private _size = selectMax (_x apply {sqrt (_x#1#0 ^ 2 + _x#1#1 ^ 2)}) max _minSize min _maxSize;
    private _safeSize = _size / 2;
    private _pos = [_center, 0, _radius, _safeSize, 0, _maxGrad, 0, [], [[0,0], [0,0]]] call BIS_fnc_findSafePos;
    if (_pos isEqualTo [0,0]) then {continue};
    _pos = _pos vectorAdd [0,0,0];

    private _terrain = nearestTerrainObjects [_pos, [], _size, false];
    {hideObjectGlobal _x} forEach _terrain;
    private _objects = [_pos, random 360, _x, 0, _simple] call WHF_fnc_objectsMapper;

    _compositionObjects pushBack _objects;
    _compositionTerrain pushBack _terrain;
} forEach _compositions;

[_compositionObjects, _compositionTerrain]
