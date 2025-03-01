/*
Function: WHF_fnc_createMortars

Description:
    Create mortar emplacements in a given area.

Parameters:
    Side side:
        The mortar group's side.
    Number quantity:
        The number of emplacements to attempt spawning.
    Position2D center:
        The center of the area.
    Number radius:
        The radius of the area.

Returns:
    Array
        An array containing three elements:
            1. A nested array of compositions that were spawned in.
            2. A nested array of terrain objects that were hidden.
            3. An array of groups that were spawned in.

Author:
    thegamecracks

*/
params ["_side", "_quantity", "_center", "_radius"];

private _compositions = [];
for "_i" from 1 to _quantity do {
    _compositions pushBack selectRandom [
        [
            [["Land_BagFence_01_round_green_F",[0.000976563,-0.0078125,0],105],["Land_BagFence_01_round_green_F",[1.84082,1.05469,0],195],["Land_BagFence_01_round_green_F",[2.90332,-0.787109,0],285],["Land_BagFence_01_round_green_F",[-3.97461,-4.18359,0],150],["Land_BagFence_01_round_green_F",[-2.47168,-6.78711,0],330],["Land_BagFence_01_round_green_F",[-4.52441,-6.23633,-0.000900269],60.0001],["Land_BagFence_01_round_green_F",[4.77832,-6.28711,0],225],["Land_BagFence_01_long_green_F",[3.00195,8.15039,0],195],["Land_BagFence_01_round_green_F",[2.65332,-8.41016,0],45],["Land_BagFence_01_long_green_F",[-2.97168,8.33789,0],345],["Land_BagFence_01_long_green_F",[5.65332,7.08789,0],30],["Land_BagFence_01_long_green_F",[-5.59668,7.21484,0],150],["Land_BagFence_01_long_green_F",[-8.97168,3.08789,0],300],["Land_BagBunker_01_small_green_F",[0.15332,9.46289,0],180],["Land_BagFence_01_round_green_F",[4.77832,-8.41016,0],315],["Land_BagFence_01_long_green_F",[-10.0322,0.4375,0],105],["Land_BagFence_01_long_green_F",[9.65332,3.96484,0],240],["Land_BagFence_01_round_green_F",[-9.29688,4.78711,0],30],["Land_BagFence_01_round_green_F",[7.22559,7.66406,0],120],["Land_BagFence_01_round_green_F",[-7.79395,7.38867,0],210],["Land_BagFence_01_long_green_F",[10.7783,1.33789,0],75],["Land_BagFence_01_round_green_F",[9.82813,6.16211,0],300],["Land_BagFence_01_long_green_F",[-10.3467,-5.41016,-0.00757217],255],["Land_BagFence_01_long_green_F",[11.0283,-4.66016,0],285],["Land_BagFence_01_round_green_F",[-9.84668,6.83984,0],120],["Land_BagBunker_01_small_green_F",[-11.7217,-2.41016,-0.00611305],90.0001],["Land_BagFence_01_long_green_F",[-9.22168,-8.03711,-0.00951195],60.0001],["Land_BagFence_01_round_green_F",[9.27832,8.21289,0],210],["Land_BagBunker_01_small_green_F",[12.2793,-1.53516,0],270],["Land_BagFence_01_round_green_F",[-6.66895,-11.7363,-0.0100002],300],["Land_BagFence_01_round_green_F",[11.8535,-6.48438,0],210],["Land_BagFence_01_round_green_F",[10.3506,-9.08398,0],30],["Land_BagFence_01_round_green_F",[-9.27148,-10.2324,-0.0100002],120],["Land_BagFence_01_round_green_F",[12.4033,-8.53711,0],300],["Land_BagFence_01_round_green_F",[-8.72168,-12.2852,-0.0100002],30]],
            [["O_G_Mortar_01_F",[1.28418,-0.839844,0],5.92522],["O_G_Mortar_01_F",[-2.83105,-5.39648,0],235.782],["O_G_Mortar_01_F",[3.46582,-7.05273,0],133.757]]
        ],
        [
            [["Land_PaperBox_open_empty_F",[-2.25195,-0.740234,0],120],["Land_PaperBox_closed_F",[-2.75293,1.00977,0],75],["Land_WoodenCrate_01_stack_x5_F",[-4.12793,0.134766,0],75],["Land_BagFence_01_round_green_F",[2.62207,-3.48828,0],45],["Land_BagFence_01_round_green_F",[4.74707,-1.36719,0],225],["Land_BagFence_01_round_green_F",[1.03223,4.94531,0],105],["Land_BagFence_01_round_green_F",[3.93457,4.16992,0],285],["Land_BagFence_01_round_green_F",[4.74707,-3.49023,0],315],["Land_BagFence_01_round_green_F",[2.87305,6.00977,0],195],["Land_FieldToilet_F",[-4.63086,-4.73047,0],254.891],["Land_FieldToilet_F",[-6.00293,-3.36523,0],224.998],["Land_WoodenCrate_01_stack_x3_F",[-4.25293,-5.99023,0],150],["Land_HBarrier_01_big_4_green_F",[9.12207,0.00976563,0],270],["Land_HBarrier_01_big_4_green_F",[6.37207,-6.61523,0],315],["Land_HBarrier_01_big_4_green_F",[6.49707,6.63477,0],45],["Land_HBarrier_01_big_4_green_F",[-6.62793,-6.61523,0],45],["Land_HBarrier_01_big_4_green_F",[-9.37793,0.00976563,0],270],["Land_HBarrier_01_big_4_green_F",[-0.12793,9.38477,0],0],["Land_HBarrier_01_big_4_green_F",[-6.62793,6.75977,0],315],["Land_Razorwire_F",[11.1211,0.382813,0.00147438],90.0001],["Land_Razorwire_F",[7.99707,-7.74219,0],135],["Land_Razorwire_F",[-8.25293,-7.74023,0],225],["Land_Razorwire_F",[-8.00293,8.01172,0],315],["Land_Razorwire_F",[-11.3779,0.00976563,0],270],["Land_Razorwire_F",[7.74707,8.38477,0],45],["Land_Razorwire_F",[-0.25293,11.5117,0],0],["Land_HBarrier_01_big_4_green_F",[-0.62793,-14.1152,0],0],["Land_Razorwire_F",[-0.50293,-16.1133,0],0]],
            [["O_G_Mortar_01_F",[3.44629,-2.03125,0],131.12],["O_G_Mortar_01_F",[2.31641,4.06641,0],15.1606]]
        ],
        [
            [["Land_HBarrier_01_line_5_green_F",[-2.13184,-1.47266,-0.00200081],260],["Land_HBarrier_01_line_3_green_F",[1.24219,-3.47266,0.00166512],185],["Land_HBarrier_01_line_3_green_F",[-1.88184,-3.59766,-0.00200081],350],["Land_BagFence_01_long_green_F",[-3.8457,1.95313,-0.00200081],30],["Land_BagFence_01_round_green_F",[3.36719,4.02734,0.00486374],179.483],["Land_HBarrier_01_line_3_green_F",[-1.75684,5.27539,-2.28882e-05],95],["Land_BagFence_01_long_green_F",[5.36816,2.40039,0.00716972],60],["Land_BagFence_01_long_green_F",[2.27637,-5.66602,0.000385284],275],["Land_HBarrier_01_line_3_green_F",[6.61816,-0.472656,0.00799751],100],["Land_BagFence_01_round_green_F",[-6.3916,2.70313,-0.00200081],167.47],["Land_HBarrier_01_line_5_green_F",[-0.882813,7.27539,0.00348854],180],["Land_HBarrier_01_line_5_green_F",[5.86719,-4.59961,0.00660133],280],["Land_HBarrier_01_line_5_green_F",[-5.38184,-5.59766,-0.00200081],140],["Land_BagFence_01_round_green_F",[1.63184,-8.22656,-0.00200081],308.146],["Land_HBarrier_01_line_3_green_F",[2.61816,8.15234,0.00799751],140],["Land_HBarrier_01_line_3_green_F",[4.86816,8.90234,0.00799751],5.00003],["Land_HBarrier_01_line_3_green_F",[-7.50781,7.15234,0.00248528],225],["Land_HBarrier_01_line_3_green_F",[6.24219,-8.34766,0.00209045],65.0001],["Land_HBarrier_01_line_5_green_F",[10.4551,-0.482422,0.00799751],282.196],["Land_HBarrier_01_line_3_green_F",[7.61816,7.65234,0.00799751],215],["Land_HBarrier_01_line_5_green_F",[9.99316,4.40234,0.00799751],65],["Land_HBarrier_01_line_3_green_F",[-11.2568,2.02734,-0.00200081],4.99999],["Land_HBarrier_01_line_5_green_F",[-8.49219,-7.8418,-0.00200081],53.6472],["Land_HBarrier_01_line_3_green_F",[-10.9131,-4.55664,-0.00200081],53.6472],["Land_HBarrier_01_line_3_green_F",[-4.25684,11.1523,0.00779152],65],["Land_HBarrier_01_line_5_green_F",[-8.88184,9.02539,0.00494576],315],["Land_HBarrier_01_line_5_green_F",[5.49316,-11.4746,-0.00200081],150],["Land_HBarrier_01_line_3_green_F",[-12.6416,-2.19141,-0.00200081],233.647],["Land_HBarrier_01_line_3_green_F",[-5.63184,11.5293,0.00799751],335],["Land_HBarrier_01_line_5_green_F",[-13.0068,1.40039,-0.00200081],280],["Land_HBarrier_01_line_3_green_F",[-6.09766,-11.5938,-0.00200081],242.577],["Land_HBarrier_01_line_5_green_F",[-3.13184,-13.0977,-0.00200081],185],["Land_BagBunker_01_small_green_F",[-12.5986,6.08203,-0.00200081],120],["Land_BagBunker_01_small_green_F",[1.52539,-14.293,-0.00200081],350]],
            [["O_G_Mortar_01_F",[2.41602,0.855469,0.00322151],55.4984],["O_G_Mortar_01_F",[-6.54297,-1.35742,-0.00200081],269.209],["O_G_Mortar_01_F",[-1.98145,-7.48633,-0.00200081],184.373]]
        ]
    ];
};

private _clearRadius = 40;
private _compositionObjects = [];
private _compositionTerrain = [];
private _compositionGroups = [];
{

    private _pos = [0,0];
    for "_i" from 1 to 5 do {
        _pos = [_center, 0, _radius, 20, 0, 0.3, 0, [], [[0,0], [0,0]]] call BIS_fnc_findSafePos;
        if (_pos isEqualTo [0,0]) then {continue};
        if (_pos nearRoads _clearRadius isNotEqualTo []) then {continue};
        break;
    };
    if (_pos isEqualTo [0,0]) then {continue};
    _pos = _pos vectorAdd [0,0,0];

    _x params ["_fortifications", "_mortars"];

    private _terrain = nearestTerrainObjects [_pos, [], _clearRadius, false];
    {hideObjectGlobal _x} forEach _terrain;

    private _direction = random 360;
    _fortifications = [_fortifications, _pos, _direction, ["normal", "path", "simple"]] call WHF_fnc_objectsMapper;
    _mortars = [_mortars, _pos, _direction, ["normal"]] call WHF_fnc_objectsMapper;

    private _group = [_side, "standard", count _mortars, [random -500, random -500, 500], 0] call WHF_fnc_spawnUnits;
    {
        private _mortar = _mortars # _forEachIndex;
        _group addVehicle _mortar;
        _x moveInGunner _mortar;
    } forEach units _group;

    // TODO: add scripts for automatic targeting in vanilla
    if (!isNil "lambs_wp_fnc_taskartilleryregister") then {
        [_group] call lambs_wp_fnc_taskartilleryregister;
    };

    _compositionObjects pushBack (_fortifications + _mortars);
    _compositionTerrain pushBack _terrain;
    _compositionGroups pushBack _group;
} forEach _compositions;

[_compositionObjects, _compositionTerrain, _compositionGroups]
