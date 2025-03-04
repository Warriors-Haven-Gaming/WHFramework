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
        (Optional, default ["camp", 0.7, "hq", 0.2, "tower", 0.1])
        An array of emplacement types and probabilities to select from.

Returns:
    Array
        An array containing two elements:
            1. A nested array of compositions that were spawned in.
            2. A nested array of terrain objects that were hidden.

Author:
    thegamecracks

*/
params ["_quantity", "_center", "_radius", ["_types", ["camp", 0.6, "hq", 0.3, "tower", 0.1]]];

private _compositions = [];
for "_i" from 1 to _quantity do {
    private _type = selectRandomWeighted _types;
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
        case "tower": {
            _compositions pushBack selectRandom [
                [["Land_WoodenCrate_01_stack_x5_F",[-0.861328,0.212891,0],220.979],["Land_WoodenCrate_01_stack_x5_F",[4.24023,-1.06836,0],256.115],["Land_WoodenCrate_01_stack_x5_F",[4.85449,0.720703,0],90],["Land_HBarrier_01_wall_6_green_F",[-0.396484,-5.2793,0],180],["Land_HBarrier_01_wall_6_green_F",[0.728516,6.0957,0],0],["Land_HBarrier_01_line_3_green_F",[6.97852,-1.1543,0],180],["Land_HBarrier_01_line_3_green_F",[4.85352,-6.5293,0],180],["Land_HBarrier_01_line_3_green_F",[-5.27148,-6.6543,0],180],["Land_HBarrier_01_line_3_green_F",[5.60449,6.8457,0],90],["Land_HBarrier_01_line_3_green_F",[-5.02148,7.4707,0],180],["Land_HBarrier_01_line_3_green_F",[-8.77148,2.0957,0],180],["Land_HBarrier_01_wall_corner_green_F",[7.85449,-4.6543,0],90],["Land_HBarrier_01_line_5_green_F",[9.22852,0.595703,0],270],["Land_HBarrier_01_wall_corner_green_F",[-8.27148,5.5957,0],270],["Land_HBarrier_01_wall_corner_green_F",[-9.39648,-5.2793,0],180],["Land_HBarrier_01_line_3_green_F",[-10.5215,-3.0293,0],180],["Land_Cargo_Tower_V4_F",[-0.0205078,-0.0292969,0],0]],
                [["Land_HBarrier_01_line_5_green_F",[-1.91016,-0.845703,0],0],["Land_Pallets_stack_F",[3.71484,0.884766,0],180],["Land_CratesWooden_F",[-2.41016,-3.2207,0],270],["Land_CratesShabby_F",[4.96484,0.529297,0],90],["Land_Pallets_stack_F",[5.31055,1.62891,0],180],["Land_HBarrier_01_line_5_green_F",[5.71484,-0.845703,0],0],["Land_HBarrier_01_line_3_green_F",[-2.66016,7.65625,0],195],["Land_HBarrier_01_line_3_green_F",[4.08984,-7.0957,0],0],["Land_HBarrier_01_line_1_green_F",[7.96484,2.4043,0],45],["Land_HBarrier_01_line_3_green_F",[4.46484,7.15625,0],195],["Land_HBarrier_01_line_5_green_F",[-7.41016,-4.09375,0],75],["Land_HBarrier_01_line_3_green_F",[-2.78516,-8.22266,0],15],["Land_HBarrier_01_line_3_green_F",[-5.03418,7.4043,0],150],["Land_HBarrier_01_line_1_green_F",[8.21484,-4.5957,0],0],["Land_HBarrier_01_line_1_green_F",[7.21484,6.1543,0],300],["Land_HBarrier_01_line_3_green_F",[-8.91016,3.6543,0],285],["Land_HBarrier_01_line_1_green_F",[8.54785,4.58203,0],330],["Land_HBarrier_01_line_1_green_F",[7.46484,-6.5957,0],45],["Land_HBarrier_01_line_1_green_F",[-8.03516,-6.5957,0],150],["Land_HBarrier_01_line_1_green_F",[-9.40918,7.7793,0],225],["Land_Cargo_Tower_V4_F",[-0.0341797,0.0292969,0],0]],
                [["Land_HBarrier_01_big_4_green_F",[2.00488,-7.86914,0],180],["Land_HBarrier_01_big_4_green_F",[1.87988,8.75586,0],180],["Land_HBarrier_01_big_4_green_F",[-9.62012,3.38086,0],90],["Land_HBarrier_01_line_3_green_F",[7.50488,-7.61914,0],0],["Land_HBarrier_01_big_4_green_F",[-6.49512,8.50586,0],180],["Land_HBarrier_01_big_4_green_F",[10.7559,0.380859,0],270],["Land_HBarrier_01_line_3_green_F",[7.50488,8.75586,0],180],["Land_HBarrier_01_line_3_green_F",[10.7549,-4.49414,0],270],["Land_HBarrier_01_line_3_green_F",[9.75488,-6.74609,0],315],["Land_HBarrier_01_line_3_green_F",[10.6299,5.50586,0],270],["Land_HBarrier_01_line_3_green_F",[9.75488,7.75586,0],225],["Land_Cargo_Tower_V4_F",[0.00585938,0.00585938,0],0]],
                [["Land_HBarrier_01_big_4_green_F",[3.8457,-6.47461,0],0],["Land_HBarrier_01_big_4_green_F",[-4.5293,-6.59961,0],0],["Land_Pallet_F",[8.68848,2.4707,0],201.495],["Land_HBarrier_01_big_4_green_F",[3.8457,8.15039,0],0],["Land_HBarrier_01_big_4_green_F",[-4.5293,7.90039,0],0],["Land_HBarrier_01_big_4_green_F",[8.8457,-3.22461,0],90],["Land_Sack_F",[-8.55371,4.625,0],300],["Land_Pallets_stack_F",[-8.22949,5.66992,0],209.811],["Land_HBarrier_01_big_4_green_F",[-9.6543,-3.47461,0],90],["Land_Pallets_F",[10.7227,-0.392578,0],327.234],["Land_Pallets_stack_F",[10.7168,1.72852,0],50.6134],["Land_WoodenCrate_01_stack_x3_F",[8.88965,6.35156,0],220.358],["Land_Pallets_F",[-10.1543,4.90039,0],240],["Land_Pallets_stack_F",[-9.90625,6.91602,0],150.243],["Land_Cargo_Tower_V4_F",[0.22168,-0.0996094,0],0]],
                [["Land_WoodenCrate_01_stack_x3_F",[0.683594,2.13477,0],0],["Land_Pallet_MilBoxes_F",[-1.33496,2.10742,0],0.0150947],["Land_WoodenCrate_01_stack_x5_F",[2.29102,2.23242,0],93.2767],["Land_HBarrier_01_big_4_green_F",[1.79004,-6.51758,0],0],["Land_HBarrier_01_line_5_green_F",[-5.08496,-6.64258,0],180],["Land_HBarrier_01_big_4_green_F",[1.54004,8.23242,0],0],["Land_HBarrier_01_line_5_green_F",[-7.33496,4.48242,0],90],["Land_HBarrier_01_line_5_green_F",[7.54004,-4.64258,0],315],["Land_HBarrier_01_big_4_green_F",[9.16504,0.982422,0],90],["Land_HBarrier_01_line_5_green_F",[-5.33496,7.98242,0],180],["Land_HBarrier_01_line_5_green_F",[-8.58496,-4.64258,0],90],["Land_HBarrier_01_line_5_green_F",[7.28906,6.60938,0],225],["Land_Cargo_Tower_V4_F",[0.0410156,-0.0175781,0],0]],
                [["Land_WoodenCrate_01_stack_x5_F",[-0.311523,1.91602,0],0],["Land_Pallets_stack_F",[1.41699,1.79688,0],181.668],["Land_WoodenCrate_01_stack_x3_F",[5.47656,-0.521484,0],117.271],["Land_HBarrier_01_line_5_green_F",[-4.64844,-5.26953,0],0],["Land_HBarrier_01_line_3_green_F",[-6.77246,-3.01953,0],90],["Land_HBarrier_01_line_5_green_F",[5.22656,-5.89453,0],0],["Land_HBarrier_01_line_5_green_F",[4.85156,6.23047,0],180],["Land_HBarrier_01_line_3_green_F",[6.97656,3.98047,0],270],["Land_HBarrier_01_line_5_green_F",[-5.14844,6.23047,0],180],["Land_HBarrier_01_line_3_green_F",[7.35254,-3.76953,0],90],["Land_HBarrier_01_line_3_green_F",[-7.27344,4.10547,0],270],["Land_Cargo_Tower_V4_F",[-0.0224609,-0.0195313,0],0]],
                [["Land_HBarrier_01_line_5_green_F",[1.84766,-6.27734,0],180],["Land_HBarrier_01_line_5_green_F",[-3.77734,-6.27734,0],180],["Land_HBarrier_01_line_5_green_F",[3.72266,7.22266,0],180],["Land_HBarrier_01_line_5_green_F",[-4.52734,7.22266,0],180],["Land_HBarrier_01_line_3_green_F",[5.97266,-6.27734,0],0],["Land_HBarrier_01_line_5_green_F",[8.22266,2.84766,0],90],["Land_HBarrier_01_line_3_green_F",[-7.15137,-5.27734,0],90],["Land_HBarrier_01_line_3_green_F",[9.09766,-0.527344,0],0],["Land_HBarrier_01_line_5_green_F",[-7.90234,5.09766,0],90],["Land_HBarrier_01_line_3_green_F",[7.22266,6.22266,0],225],["Land_HBarrier_01_line_3_green_F",[8.22266,-5.2793,0],315],["Land_Cargo_Tower_V4_F",[-0.0263672,-0.0273438,0],0]],
                [["Land_HBarrier_01_line_5_green_F",[-3.04004,-2.96289,0],270],["Land_HBarrier_01_line_5_green_F",[0.334961,-5.08789,0],0],["Land_HBarrier_01_line_5_green_F",[-1.24609,6.11328,0],180],["Land_HBarrier_01_line_5_green_F",[4.36035,6.07031,0],180],["Land_HBarrier_01_line_5_green_F",[5.81543,-5.10742,0],0],["Land_HBarrier_01_line_5_green_F",[7.8584,-1.5957,0],90],["Land_HBarrier_01_line_5_green_F",[7.8584,4.01172,0],90],["Land_Cargo_Tower_V4_F",[-0.00390625,0.00390625,0],0]],
                [["Land_WoodenBox_F",[0.0078125,0.0195313,0],345],["Land_WoodenBox_F",[0.114258,1.06445,0],330],["Land_Pallets_stack_F",[0.734375,-1.10938,0],165],["Land_HBarrier_01_line_3_green_F",[2.60938,-1.60938,0],270],["Land_HBarrier_01_line_5_green_F",[3.98438,0.765625,0],0],["Land_HBarrier_01_line_5_green_F",[0.984375,-5.98438,0],180],["Land_HBarrier_01_line_5_green_F",[-3.14063,6.01563,0],180],["Land_HBarrier_01_line_5_green_F",[-4.51563,-5.98438,0],180],["Land_HBarrier_01_line_3_green_F",[-6.64063,-3.60938,0],270],["Land_HBarrier_01_line_5_green_F",[7.35938,2.76563,0],270],["Land_HBarrier_01_line_3_green_F",[5.48438,-5.98438,0],0],["Land_HBarrier_01_line_5_green_F",[5.35938,6.14063,0],0],["Land_HBarrier_01_line_3_green_F",[-6.64063,5.14063,0],270],["Land_HBarrier_01_line_3_green_F",[7.73438,-5.10938,0],270],["Land_Sacks_heap_F",[-8.24121,4.55859,0],180],["Land_WoodenCrate_01_stack_x3_F",[-8.26563,-4.85938,0],171.432],["Land_Pallets_F",[-8.26563,6.01563,0],0],["Land_WoodenBox_F",[-6.99219,7.76953,0],195],["Land_Cargo_Tower_V4_F",[0.110352,-0.234375,0],0]]
            ];
        };
        default {diag_log text format ["Unknown emplacement type: %1", _type]};
    };
};

private _isPosSuitable = {
    params ["_pos", "_clearRadius"];
    _pos nearRoads _clearRadius isEqualTo []
    && {_pos isFlatEmpty [-1, -1, 1, 20] isNotEqualTo []}
};

private _clearRadius = 30;
private _compositionObjects = [];
private _compositionTerrain = [];
{

    private _pos = [_center, [20, _radius], [_clearRadius, _isPosSuitable]] call WHF_fnc_randomPos;
    if (_pos isEqualTo [0,0]) then {continue};
    _pos = _pos vectorAdd [0,0,0];

    private _terrain = nearestTerrainObjects [_pos, [], _clearRadius, false];
    {hideObjectGlobal _x} forEach _terrain;
    private _objects = [_x, _pos, random 360, ["normal", "path", "simple"]] call WHF_fnc_objectsMapper;

    _compositionObjects pushBack _objects;
    _compositionTerrain pushBack _terrain;
} forEach _compositions;

[_compositionObjects, _compositionTerrain]
