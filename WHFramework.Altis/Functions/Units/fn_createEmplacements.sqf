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

Returns:
    Array
        An array containing two elements:
            1. A nested array of compositions that were spawned in.
            2. A nested array of terrain objects that were hidden.

Author:
    thegamecracks

*/
params ["_quantity", "_center", "_radius", ["_types", []]];

if (_types isEqualTo []) then {_types = ["camp"]};

private _compositions = [];
for "_i" from 1 to _quantity do {
    private _type = selectRandom _types;
    switch (_type) do {
        case "camp": {
            _compositions pushBack selectRandom [
                [["Land_WoodenCrate_01_stack_x5_F",[-2.9873,0.671875,0],131.998],["Land_WoodenCrate_01_stack_x5_F",[-4.30859,-0.761719,0],175.519],["Land_Cargo_Patrol_V2_F",[0.197266,-0.943359,0],180],["Land_BagFence_01_round_green_F",[-2.05273,4.68164,0],135],["Land_BagFence_01_long_green_F",[0.322266,5.30664,0],180],["Land_BagFence_01_round_green_F",[5.19727,1.30469,0],225],["Land_BagFence_01_round_green_F",[2.69727,4.67969,0],225],["Land_BagFence_01_long_green_F",[5.82227,-1.06836,0],270],["Land_BagFence_01_round_green_F",[5.19727,-3.44336,0],315]],
                [["CamoNet_BLUFOR_open_F",[-0.0410156,-0.0410156,0],0],["Land_Pallets_F",[4.45801,-2.78906,0],267.491],["Land_Pallets_stack_F",[6.58398,-2.54102,0],274.231],["Land_PaperBox_open_full_F",[6.95898,1.33398,0],92.926],["Land_PaperBox_open_full_F",[7.0459,2.86133,0],272.987],["Land_PaperBox_open_empty_F",[-1.91602,8.20898,0],251.154],["Land_WoodenCrate_01_stack_x5_F",[-0.0410156,8.95898,0],242.345],["Land_Cargo_Patrol_V4_F",[4.33398,7.33398,0],180]],
                [["CamoNet_INDP_open_F",[-0.0283203,-0.00585938,0],180],["Land_TentDome_F",[2.73633,2.41016,0],300],["Land_TentDome_F",[-2.76172,3.1582,0],255],["Land_WoodenCrate_01_F",[-4.2627,-2.7168,0],60.0002],["Land_CratesWooden_F",[-5.2627,-1.2168,0],1.00179e-05],["Land_BagFence_01_long_green_F",[5.6123,-3.2168,0],135],["Land_BagFence_01_long_green_F",[6.6123,-0.841797,0],90],["Land_BagFence_01_long_green_F",[6.6123,1.9082,0],90],["Land_BagFence_01_long_green_F",[-6.8877,-1.0918,0],90],["Land_BagFence_01_long_green_F",[-6.8877,1.6582,0],90],["Land_WoodenCrate_01_stack_x3_F",[7.61328,-2.5918,0],105]],
                [["CamoNet_INDP_open_F",[-0.0380859,-0.0214844,0],270],["Land_PicnicTable_01_F",[-0.761719,-3.34961,0],17.293],["Land_PicnicTable_01_F",[-1.87109,3.01172,0],132.327],["Land_PicnicTable_01_F",[3.07227,2.31055,0],273.73]],
                [["Land_BagBunker_01_large_green_F",[-0.0195313,0.0214844,0],0],["Land_TripodScreen_01_dual_v1_F",[-2.39355,5.13477,0],75.004],["Land_PowerGenerator_F",[2.48047,5.42578,0],359.381],["Land_PortableGenerator_01_F",[-2.01855,6.38477,0],180.002],["Land_HBarrier_01_line_3_green_F",[-3.89355,5.63477,0],270],["Land_HBarrier_01_line_3_green_F",[3.79004,5.78125,0],270],["Land_HBarrier_01_line_3_green_F",[-3.01855,7.88477,0],180],["Land_TTowerSmall_2_F",[3.29297,5.03516,0],239.381]]
            ];
        };
        case "hq": {
            _compositions pushBack selectRandom [
                [["Land_Pallet_MilBoxes_F",[1.98926,3.95508,-0.00135994],120],["Land_Cargo10_grey_F",[4.01953,1.97852,-0.00415802],60.0012],["Land_Cargo_HQ_V4_F",[1.54688,-6.99609,0],0],["Land_PaperBox_open_full_F",[-7.13379,-3.96875,0.000724792],90],["Land_PaperBox_closed_F",[-7.04102,-5.63477,0.000593185],0],["Land_PaperBox_closed_F",[3.20215,8.96289,-0.00308418],120],["Land_Cargo_House_V4_F",[-7.57813,6.00391,0.00164032],345],["Land_PaperBox_closed_F",[1.71875,10.3984,-0.0010891],0],["Land_WoodenCrate_01_stack_x5_F",[0.671875,12.0039,0],165],["Land_HBarrier_01_big_4_green_F",[-12.0762,5.50195,0.00729561],255],["Land_HBarrier_01_big_4_green_F",[-2.20313,13.3789,0],345],["Land_HBarrier_01_big_4_green_F",[-11.0762,-8.61914,0.00946999],90.0001],["Land_HBarrier_01_line_3_green_F",[3.92285,-14.4961,0],150],["Land_HBarrier_01_line_3_green_F",[1.29688,-15.1211,0],0],["Land_HBarrier_01_big_4_green_F",[-10.0762,11.3789,0.00452614],345],["Land_HBarrier_01_line_3_green_F",[6.54688,-13.8711,0],0],["Land_BagFence_01_long_green_F",[-5.45215,-16.4961,0.00848007],0],["Land_HBarrier_01_line_3_green_F",[-10.4521,-13.8711,0.0100002],240],["Land_HBarrier_01_line_3_green_F",[-8.45313,-15.8711,0.0100002],210],["Land_Cargo20_grey_F",[12.0469,-13.4961,0],285]],
                [["Land_HBarrier_01_line_5_green_F",[-0.0224609,-0.046875,0],0],["CamoNet_INDP_open_F",[-2.52246,0.328125,0],90],["Land_HBarrier_01_line_3_green_F",[-1.89648,4.82813,0],90],["Land_HBarrier_01_tower_green_F",[6.97754,1.07617,0],90],["Land_HBarrier_01_big_4_green_F",[-1.50391,7.36914,0],180],["Land_HBarrier_01_big_4_green_F",[-6.52148,3.82813,0],270],["Land_HBarrier_01_big_4_green_F",[-1.39746,-7.67383,0],0],["Land_HBarrier_01_big_4_green_F",[-6.51953,-4.54492,0.000753403],270],["Land_HBarrier_01_big_tower_green_F",[6.35254,-8.42383,0],0],["Land_HBarrier_01_big_4_green_F",[10.7285,-4.04688,0],285],["Land_HBarrier_01_big_4_green_F",[11.9775,3.95313,0],90]]
            ];
        };
        default {diag_log text format ["Unknown emplacement type: %1", _type]};
    };
};

private _clearRadius = 30;
private _compositionObjects = [];
private _compositionTerrain = [];
{

    private _pos = [0,0];
    for "_i" from 1 to 5 do {
        _pos = [_center, 0, _radius, 10, 0, 0.3, 0, [], [[0,0], [0,0]]] call BIS_fnc_findSafePos;
        if (_pos isEqualTo [0,0]) then {continue};
        if (_pos nearRoads _clearRadius isNotEqualTo []) then {continue};
        break;
    };
    if (_pos isEqualTo [0,0]) then {continue};
    _pos = _pos vectorAdd [0,0,0];

    private _terrain = nearestTerrainObjects [_pos, [], _clearRadius, false];
    {hideObjectGlobal _x} forEach _terrain;
    private _objects = [_x, _pos, random 360, ["normal", "simple"]] call WHF_fnc_objectsMapper;

    _compositionObjects pushBack _objects;
    _compositionTerrain pushBack _terrain;
} forEach _compositions;

[_compositionObjects, _compositionTerrain]
