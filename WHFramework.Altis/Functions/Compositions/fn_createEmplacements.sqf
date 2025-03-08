/*
Function: WHF_fnc_createEmplacements

Description:
    Create random emplacements in a given area.

Parameters:
    Side side:
        The emplacement groups' side.
    Number quantity:
        The number of emplacements to attempt spawning.
    Position2D center:
        The center of the area.
    Number radius:
        The radius of the area.
    Array types:
        An array of emplacement types and probabilities to select from.
        Should be in a format suitable for selectRandomWeighted.
        Possible values are:
            "aa_short"
            "aa_medium"
            "aa_long"
            "camp"
            "hq"
            "mortar"
            "outpost"
            "tower"
    Array ruins:
        (Optional, default -1)
        An array to append ruins to when buildings change state.
        Useful for garbage collection.

Returns:
    Array
        An array containing three elements:
            1. A nested array of compositions that were spawned in.
            2. A nested array of terrain objects that were hidden.
            3. An array of groups that were spawned in.

Author:
    thegamecracks

*/
params ["_side", "_quantity", "_center", "_radius", "_types", ["_ruins", -1]];

private _compositions = [];
for "_i" from 1 to _quantity do {
    private _type = selectRandomWeighted _types;
    switch (_type) do {
        case "aa_short": {
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
        case "aa_medium": {
            _compositions pushBack selectRandom [
                [
                    [["Land_Missle_Trolley_02_F",[-0.933594,8.125,0.7],225],["Land_HBarrier_01_big_4_green_F",[3.65918,-9.18555,0],90],["Land_HBarrier_01_big_4_green_F",[-1.71582,9.9375,0],315],["Land_HBarrier_01_big_4_green_F",[9.78418,-2.68555,0],90],["Land_BagFence_01_long_green_F",[9.65918,4.31445,0],90],["Land_HBarrier_01_big_4_green_F",[-8.34082,6.93945,0],180],["Land_Missle_Trolley_02_F",[4.18945,10.2188,0.7],270],["Land_Razorwire_F",[-2.59082,11.1914,0],315],["Land_BagFence_01_long_green_F",[9.65918,7.06445,0],90],["Land_HBarrier_01_big_4_green_F",[-1.34082,-12.5605,0],180],["Land_Razorwire_F",[-9.59082,8.68945,0],2.73208e-05],["Land_BagFence_01_end_green_F",[9.53418,8.81445,0],255],["Land_HBarrier_01_big_4_green_F",[12.9092,2.18945,0],180],["Land_HBarrier_01_big_4_green_F",[5.15918,12.3145,0],180],["Land_Missle_Trolley_02_F",[11.7813,7.11914,0.7],0],["CamoNet_ghex_open_F",[12.2842,6.31641,0],90],["Land_HBarrier_01_line_5_green_F",[7.15918,-12.1855,0],0],["Land_HBarrier_01_big_4_green_F",[-13.5898,3.81445,0],285],["Land_Razorwire_F",[3.78418,-14.1875,0],180],["Land_HBarrier_01_big_4_green_F",[-14.4658,-3.18555,0],90],["Land_Razorwire_F",[4.9082,14.0664,0],2.73208e-05],["Land_Razorwire_F",[-4.21582,-14.3125,0],180],["Land_Missle_Trolley_02_F",[13.208,7.20898,0.7],0],["Land_HBarrier_01_line_3_green_F",[10.2842,-11.3105,0],90],["Land_HBarrier_01_big_4_green_F",[-9.59082,-12.6855,0],180],["Land_Razorwire_F",[-15.4521,4.36133,0],285],["Land_Razorwire_F",[-16.4658,-3.18555,0],270],["Land_HBarrier_01_big_4_green_F",[-14.5908,-9.43555,0],90],["Land_HBarrier_01_big_4_green_F",[16.2842,7.31445,0],90],["Land_HBarrier_01_big_4_green_F",[13.1592,12.3145,0],3.41509e-06],["Land_Razorwire_F",[-12.3408,-14.4375,0],180],["Land_Razorwire_F",[13.4092,13.9414,0],2.73208e-05],["Land_Razorwire_F",[-16.5908,-10.3105,0],270],["Land_Razorwire_F",[18.2842,8.81445,0],90]],
                    [["B_SAM_System_02_F",[-2.27051,-6.70313,0],0],["B_SAM_System_02_F",[-8.09668,0.232422,0],0]]
                ]
            ]
        };
        case "aa_long": {
            _compositions pushBack selectRandom [
                [
                    [["Land_HBarrier_01_big_4_green_F",[0.349609,14.5723,-0.00999832],0],["Land_HBarrier_01_big_4_green_F",[-7.83691,12.6191,-0.00504303],332.91],["Land_HBarrier_01_big_4_green_F",[8.46387,12.3691,-0.00999832],32.9099],["Land_HBarrier_01_big_4_green_F",[-13.7939,7.32813,0],300],["Land_HBarrier_01_big_4_green_F",[14.4961,6.68555,-0.00999832],60],["Land_HBarrier_01_big_4_green_F",[-0.649414,-15.9785,0.00383759],180],["Land_HBarrier_01_big_4_green_F",[-14.2246,-7.37891,0.00237274],240],["Land_HBarrier_01_big_4_green_F",[-8.37305,-13.6836,0.0100021],212.91],["Land_HBarrier_01_big_4_green_F",[7.55469,-14.1895,0.0014534],152.91],["Land_HBarrier_01_big_4_green_F",[13.5908,-8.5918,0],120],["Land_HBarrier_01_big_4_green_F",[16.0605,-1.05078,-0.00606537],92.9099],["Land_HBarrier_01_big_4_green_F",[-16.2012,0.216797,0.000400543],272.91]],
                    [["O_Radar_System_02_F",[7.5498,3.70313,-0.00367355],60],["O_Radar_System_02_F",[-0.499023,-8.51563,0],180],["O_Radar_System_02_F",[-8.33008,4.20313,0],300],["O_SAM_System_04_F",[-0.203125,7.60938,-0.00761223],0],["O_SAM_System_04_F",[7.41113,-4.81055,0],120],["O_SAM_System_04_F",[-8.3457,-3.94531,0],240]]
                ]
            ]
        };
        case "camp": {
            _compositions pushBack selectRandom [
                [
                    [["Land_WoodenCrate_01_stack_x5_F",[-2.9873,0.671875,0],131.998],["Land_WoodenCrate_01_stack_x5_F",[-4.30859,-0.761719,0],175.519],["Land_Cargo_Patrol_V2_F",[0.197266,-0.943359,0],180],["Land_BagFence_01_round_green_F",[-2.05273,4.68164,0],135],["Land_BagFence_01_long_green_F",[0.322266,5.30664,0],180],["Land_BagFence_01_round_green_F",[5.19727,1.30469,0],225],["Land_BagFence_01_round_green_F",[2.69727,4.67969,0],225],["Land_BagFence_01_long_green_F",[5.82227,-1.06836,0],270],["Land_BagFence_01_round_green_F",[5.19727,-3.44336,0],315]],
                    []
                ],
                [
                    [["CamoNet_BLUFOR_open_F",[-0.0410156,-0.0410156,0],0],["Land_Pallets_F",[4.45801,-2.78906,0],267.491],["Land_Pallets_stack_F",[6.58398,-2.54102,0],274.231],["Land_PaperBox_open_full_F",[6.95898,1.33398,0],92.926],["Land_PaperBox_open_full_F",[7.0459,2.86133,0],272.987],["Land_PaperBox_open_empty_F",[-1.91602,8.20898,0],251.154],["Land_WoodenCrate_01_stack_x5_F",[-0.0410156,8.95898,0],242.345],["Land_Cargo_Patrol_V4_F",[4.33398,7.33398,0],180]],
                    []
                ],
                [
                    [["CamoNet_INDP_open_F",[-0.0283203,-0.00585938,0],180],["Land_TentDome_F",[2.73633,2.41016,0],300],["Land_TentDome_F",[-2.76172,3.1582,0],255],["Land_WoodenCrate_01_F",[-4.2627,-2.7168,0],60.0002],["Land_CratesWooden_F",[-5.2627,-1.2168,0],1.00179e-05],["Land_BagFence_01_long_green_F",[5.6123,-3.2168,0],135],["Land_BagFence_01_long_green_F",[6.6123,-0.841797,0],90],["Land_BagFence_01_long_green_F",[6.6123,1.9082,0],90],["Land_BagFence_01_long_green_F",[-6.8877,-1.0918,0],90],["Land_BagFence_01_long_green_F",[-6.8877,1.6582,0],90],["Land_WoodenCrate_01_stack_x3_F",[7.61328,-2.5918,0],105]],
                    []
                ],
                [
                    [["CamoNet_INDP_open_F",[-0.0380859,-0.0214844,0],270],["Land_PicnicTable_01_F",[-0.761719,-3.34961,0],17.293],["Land_PicnicTable_01_F",[-1.87109,3.01172,0],132.327],["Land_PicnicTable_01_F",[3.07227,2.31055,0],273.73]],
                    []
                ],
                [
                    [["Land_BagBunker_01_large_green_F",[-0.0195313,0.0214844,0],0],["Land_TripodScreen_01_dual_v1_F",[-2.39355,5.13477,0],75.004],["Land_PowerGenerator_F",[2.48047,5.42578,0],359.381],["Land_PortableGenerator_01_F",[-2.01855,6.38477,0],180.002],["Land_HBarrier_01_line_3_green_F",[-3.89355,5.63477,0],270],["Land_HBarrier_01_line_3_green_F",[3.79004,5.78125,0],270],["Land_HBarrier_01_line_3_green_F",[-3.01855,7.88477,0],180],["Land_TTowerSmall_2_F",[3.29297,5.03516,0],239.381]],
                    []
                ],
                [
                    [["Land_BagFence_01_long_green_F",[0.493164,-1.97656,0],345],["Land_BagFence_01_round_green_F",[2.59473,-0.742188,0],300],["Land_PaperBox_closed_F",[2.21973,1.63281,0],120],["Land_BagFence_01_round_green_F",[-2.15527,-1.99219,0],30],["Land_BagFence_01_long_green_F",[-3.40918,0.363281,0],75],["Land_HBarrier_01_line_5_green_F",[4.4707,2.13281,0],300],["Land_PaperBox_closed_F",[3.46973,3.75977,0],210],["Land_WoodenCrate_01_stack_x5_F",[4.21875,-3.24219,0],30],["Land_HBarrier_01_line_5_green_F",[-4.15527,4.00586,0],255],["Land_Cargo_House_V4_F",[6.21973,-2.74219,0],30],["Land_Cargo_House_V4_F",[-7.15527,-0.367188,0],345],["Land_BagFence_01_round_green_F",[1.96973,-7.36719,0],165],["Land_PaperBox_closed_F",[-8.2793,-1.99219,0],165],["Land_HBarrier_01_line_5_green_F",[8.34473,2.25781,0],30],["Land_HBarrier_01_line_3_green_F",[-6.78027,5.38281,0],345],["Land_BagFence_01_long_green_F",[0.219727,-8.99219,0],120],["Land_BagFence_01_long_green_F",[4.44043,-8.01563,0],30],["Land_WoodenCrate_01_stack_x3_F",[3.96973,-8.99219,0],30],["Land_BagFence_01_long_green_F",[-6.53027,-8.36719,0],345],["Land_BagFence_01_long_green_F",[8.59473,-6.86719,0],300],["Land_BagFence_01_round_green_F",[6.82715,-8.63672,0],345],["Land_HBarrier_01_line_5_green_F",[10.7207,-3.24219,0],300],["Land_BagFence_01_long_green_F",[-11.0303,-3.61719,0],75],["Land_HBarrier_01_line_5_green_F",[-10.9053,4.25781,0],165],["Land_HBarrier_01_line_3_green_F",[11.7197,0.257813,0],30],["Land_BagFence_01_long_green_F",[-10.2803,-6.24219,0],75],["Land_HBarrier_01_line_5_green_F",[-12.0303,0.384766,0],75],["Land_BagFence_01_round_green_F",[-9.03027,-8.36719,0],30]],
                    []
                ],
                [
                    [["Land_BagFence_01_long_green_F",[-3.88672,-1.23828,0],270],["Land_BagFence_01_long_green_F",[-1.26172,3.88672,0],180],["Land_BagFence_01_short_green_F",[3.86328,-1.98828,0],90],["Land_HBarrier_01_line_3_green_F",[1.86328,3.88672,0],0],["Land_HBarrier_01_line_1_green_F",[4.11328,-1.48828,0],30],["Land_BagFence_01_long_green_F",[-0.761719,-4.36328,0],0],["Land_HBarrier_01_line_5_green_F",[4.11328,1.76172,0],90],["Land_BagFence_01_short_green_F",[1.3623,-4.36328,0],180],["Land_WoodenCrate_01_F",[-4.63672,-0.988281,0],179.999],["Land_Cargo_Patrol_V4_F",[-0.0117188,0.0117188,0],0],["Land_BagFence_01_round_green_F",[3.23828,-3.73828,0],315],["Land_BagFence_01_round_green_F",[-3.26172,-3.73633,0],45],["Land_BagFence_01_short_green_F",[-3.51074,3.63672,0],165],["Land_BagFence_01_short_green_F",[-5.01172,3.01367,0],150]],
                    []
                ],
                [
                    [["Land_Cargo_House_V4_F",[-0.0478516,0.0351563,0],0],["Land_WoodenCrate_01_stack_x3_F",[-1.67188,-4.33984,0],345],["Land_HBarrier_01_line_5_green_F",[-4.04785,3.28516,0],90],["Land_HBarrier_01_line_5_green_F",[-0.547852,5.41016,0],0],["Land_BagFence_01_long_green_F",[-0.297852,-5.46484,0],0],["Land_PaperBox_closed_F",[5.2959,2.30664,0],75],["Land_HBarrier_01_line_3_green_F",[3.70215,4.41016,0],90],["Land_HBarrier_01_line_1_green_F",[2.57715,5.41016,0],0],["Land_BagFence_01_long_green_F",[2.57715,-5.46484,0],0],["Land_BagFence_01_short_green_F",[-6.04785,-2.46484,0],90],["Land_BagFence_01_long_green_F",[5.45215,-5.46484,0],0],["Land_BagFence_01_long_green_F",[-7.54785,-1.71484,0],0],["Land_BagFence_01_long_green_F",[6.95215,-4.08984,0],270],["Land_BagFence_01_long_green_F",[-6.17285,5.66016,0],180],["Land_BagFence_01_long_green_F",[-8.92285,-0.214844,0],90],["Land_BagFence_01_long_green_F",[-8.92285,2.66016,0],90],["Land_BagFence_01_short_green_F",[-8.17188,5.66016,0],0],["Land_BagFence_01_short_green_F",[-8.92285,4.91016,0],270]],
                    []
                ],
                [
                    [["Land_HBarrier_01_big_4_green_F",[-0.835938,3.49219,0],0],["Land_HBarrier_01_big_4_green_F",[-0.960938,-3.50781,0],180],["Land_HBarrier_01_big_4_green_F",[3.78906,0.117188,0],90],["Land_Cargo_Patrol_V4_F",[0.0390625,-0.0078125,0],0],["Land_BagFence_01_short_green_F",[-5.71191,3.99219,0],180],["Land_HBarrier_01_line_3_green_F",[-6.96094,-3.38281,0],180],["Land_HBarrier_01_line_3_green_F",[-7.96094,-1.13281,0],270],["Land_BagFence_01_round_green_F",[-7.58594,3.36719,0],135]],
                    []
                ]
            ];
        };
        case "hq": {
            _compositions pushBack selectRandom [
                [
                    [["Land_Pallet_MilBoxes_F",[1.98926,3.95508,-0.00135994],120],["Land_Cargo10_grey_F",[4.01953,1.97852,-0.00415802],60.0012],["Land_Cargo_HQ_V4_F",[1.54688,-6.99609,0],0],["Land_PaperBox_open_full_F",[-7.13379,-3.96875,0.000724792],90],["Land_PaperBox_closed_F",[-7.04102,-5.63477,0.000593185],0],["Land_PaperBox_closed_F",[3.20215,8.96289,-0.00308418],120],["Land_Cargo_House_V4_F",[-7.57813,6.00391,0.00164032],345],["Land_PaperBox_closed_F",[1.71875,10.3984,-0.0010891],0],["Land_WoodenCrate_01_stack_x5_F",[0.671875,12.0039,0],165],["Land_HBarrier_01_big_4_green_F",[-12.0762,5.50195,0.00729561],255],["Land_HBarrier_01_big_4_green_F",[-2.20313,13.3789,0],345],["Land_HBarrier_01_big_4_green_F",[-11.0762,-8.61914,0.00946999],90.0001],["Land_HBarrier_01_line_3_green_F",[3.92285,-14.4961,0],150],["Land_HBarrier_01_line_3_green_F",[1.29688,-15.1211,0],0],["Land_HBarrier_01_big_4_green_F",[-10.0762,11.3789,0.00452614],345],["Land_HBarrier_01_line_3_green_F",[6.54688,-13.8711,0],0],["Land_BagFence_01_long_green_F",[-5.45215,-16.4961,0.00848007],0],["Land_HBarrier_01_line_3_green_F",[-10.4521,-13.8711,0.0100002],240],["Land_HBarrier_01_line_3_green_F",[-8.45313,-15.8711,0.0100002],210],["Land_Cargo20_grey_F",[12.0469,-13.4961,0],285]],
                    []
                ],
                [
                    [["Land_Cargo_HQ_V4_F",[-0.0380859,0.0488281,0],270],["Land_HBarrier_01_line_5_green_F",[8.08691,1.17383,0],90],["Land_HBarrier_01_line_5_green_F",[8.08691,-4.32617,0],90],["Land_BagFence_01_long_green_F",[-6.91309,-6.95117,0],0],["Land_HBarrier_01_line_5_green_F",[0.461914,10.1738,0],0],["Land_HBarrier_01_line_5_green_F",[8.08691,6.79883,0],90],["Land_HBarrier_01_line_5_green_F",[6.33691,-8.70117,0],135],["Land_HBarrier_01_line_3_green_F",[3.21191,-10.4512,0],180],["Land_HBarrier_01_line_5_green_F",[-4.91309,10.1738,0],0],["Land_HBarrier_01_line_5_green_F",[6.08691,10.1738,0],0],["Land_HBarrier_01_line_5_green_F",[-11.4131,4.17383,0],90],["Land_BagFence_01_long_green_F",[2.21191,-12.5762,0],270],["Land_PowerGenerator_F",[-12.7188,-2.13867,0],104.305],["Land_HBarrier_01_line_5_green_F",[-11.0381,-7.07617,0],0],["Land_HBarrier_01_line_5_green_F",[-13.4131,0.798828,0],180],["Land_WoodenCrate_01_stack_x3_F",[-1.66211,-13.4512,0],300],["Land_BagFence_01_long_green_F",[-11.4131,8.42383,0],270],["Land_BagFence_01_short_green_F",[2.21289,-14.8262,0],90],["Land_BagFence_01_long_green_F",[0.836914,-15.5762,0],0],["Land_HBarrier_01_line_5_green_F",[-15.4131,-2.70117,0],90],["Land_HBarrier_01_line_3_green_F",[-14.5391,-6.07617,0],225],["Land_HBarrier_01_line_3_green_F",[-2.41309,-15.5762,0],180],["Land_HBarrier_01_line_3_green_F",[-8.66309,-15.5762,0],180],["Land_BagBunker_01_small_green_F",[-5.66309,-17.0762,0],0],["Land_BagFence_01_long_green_F",[-14.7881,-11.4512,0],270],["Land_BagFence_01_long_green_F",[-11.7881,-15.5762,0],0],["Land_BagFence_01_long_green_F",[-14.7881,-14.2012,0],90],["Land_BagFence_01_short_green_F",[-14.0381,-15.5762,0],180],["Land_Communication_F",[-13.1631,-4.20117,0],0]],
                    []
                ]
            ];
        };
        case "mortar": {
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
        case "outpost": {
            _compositions pushBack selectRandom [
                [
                    [["Land_HBarrier_01_line_5_green_F",[0.415039,1.52734,0],180],["Land_HBarrier_01_line_1_green_F",[-1.83496,0.277344,0],0],["Land_HBarrier_01_line_5_green_F",[3.66504,0.275391,0],90],["Land_HBarrier_01_line_3_green_F",[5.66504,-1.72266,0],0],["Land_HBarrier_01_line_3_green_F",[-5.83496,1.02734,0],90],["Land_HBarrier_01_line_5_green_F",[3.66504,5.52539,0],90],["Land_HBarrier_01_line_3_green_F",[0.416016,-7.09766,0],90],["Land_PaperBox_open_empty_F",[-1.45898,-7.34766,0],75],["Land_Cargo_House_V4_F",[-5.70996,-4.97266,0],270],["Land_HBarrier_01_line_3_green_F",[6.66504,-3.97266,0],90],["Land_HBarrier_01_line_5_green_F",[-7.95996,-0.972656,0],180],["Land_HBarrier_01_line_3_green_F",[-5.70996,7.02734,0],90],["Land_HBarrier_01_big_4_green_F",[0.415039,9.15234,0],180],["Land_HBarrier_01_big_4_green_F",[0.415039,-9.47266,0],0],["Land_HBarrier_01_line_3_green_F",[9.54004,1.15234,0],0],["Land_Cargo_Patrol_V4_F",[7.91406,5.02539,0],270],["Land_HBarrier_01_line_1_green_F",[-11.585,2.27734,0],165],["Land_HBarrier_01_big_4_green_F",[-11.335,-4.47266,0],270],["Land_HBarrier_01_big_4_green_F",[-8.08496,9.15234,0],180],["Land_HBarrier_01_big_4_green_F",[-8.08496,-9.47266,0],0],["Land_HBarrier_01_big_4_green_F",[12.04,-4.22266,0],270],["Land_HBarrier_01_big_4_green_F",[8.91504,9.15234,0],180],["Land_HBarrier_01_line_1_green_F",[-11.585,5.65234,0],180],["Land_HBarrier_01_big_4_green_F",[12.165,4.15234,0],90],["Land_HBarrier_01_big_4_green_F",[8.91504,-9.47266,0],0]],
                    []
                ],
                [
                    [["Land_HBarrier_01_line_3_green_F",[-1.46484,-1.87891,0],90],["Land_PaperBox_open_full_F",[2.90918,0.371094,0],90],["Land_HBarrier_01_line_5_green_F",[1.41016,-3.38086,0],195],["Land_BagFence_01_long_green_F",[-2.71484,-3.00391,0],180],["Land_HBarrier_01_big_4_green_F",[-1.33984,3.87109,0],90],["Land_Cargo_House_V4_F",[4.28516,1.49609,0],0],["Land_HBarrier_01_line_1_green_F",[-5.71387,1.62109,0],90],["Land_BagFence_01_long_green_F",[-7.46484,1.62109,0],1.00179e-05],["Land_BagFence_01_long_green_F",[-3.71484,7.12109,0],180],["Land_HBarrier_01_big_4_green_F",[3.78516,7.24609,0],0],["Land_BagFence_01_long_green_F",[-8.08984,-3.00391,0],1.00179e-05],["Land_HBarrier_01_big_4_green_F",[3.78516,-8.00391,0],180],["Land_HBarrier_01_line_1_green_F",[-5.21582,7.24609,0],270],["Land_HBarrier_01_big_4_green_F",[-4.46484,-7.87891,0],0],["Land_HBarrier_01_big_4_green_F",[8.91016,3.74609,0],90],["Land_HBarrier_01_big_4_green_F",[8.78516,-4.75391,0],90],["Land_HBarrier_01_big_4_green_F",[-9.58984,3.62109,0],270],["Land_HBarrier_01_big_4_green_F",[-9.58984,-4.75391,0],270]],
                    []
                ],
                [
                    [["Land_HBarrier_01_line_1_green_F",[-0.452148,1.81055,0],180],["Land_HBarrier_01_line_5_green_F",[-2.62793,3.19141,0],180],["Land_HBarrier_01_line_5_green_F",[4.12207,0.693359,0],270],["Land_HBarrier_01_line_5_green_F",[3.49707,-2.55859,0],180],["Land_HBarrier_01_line_5_green_F",[-4.25293,-2.93359,0],180],["Land_HBarrier_01_line_3_green_F",[4.12207,-4.80859,0],270],["Land_WoodenCrate_01_stack_x5_F",[6.49805,1.19141,0],0],["Land_HBarrier_01_line_1_green_F",[-6.50293,-1.55859,0],180],["Land_PaperBox_open_full_F",[-4.87695,-4.68359,0],270],["Land_HBarrier_01_line_1_green_F",[-2.75391,6.19141,0],270],["Land_HBarrier_01_line_5_green_F",[-2.12793,-6.43164,0],270],["Land_HBarrier_01_line_1_green_F",[2.99707,6.44141,0],240],["Land_WoodenCrate_01_stack_x5_F",[-4.12695,-6.30859,0],0],["Land_HBarrier_01_line_5_green_F",[-6.00293,5.19336,0],270],["Land_BagFence_01_long_green_F",[-2.75293,8.06641,0],90],["Land_Cargo_House_V4_F",[8.12207,2.69141,0],0],["Land_BagFence_01_long_green_F",[2.99707,8.31641,0],90],["Land_WoodenCrate_01_stack_x5_F",[-3.87793,-8.05859,0],270],["Land_HBarrier_01_big_4_green_F",[0.87207,-10.0586,0],0],["Land_HBarrier_01_line_3_green_F",[10.6221,-2.55859,0],180],["Land_BagFence_01_round_green_F",[-3.37793,10.6895,0],225],["Land_BagFence_01_round_green_F",[3.62207,10.8164,0],135],["Land_PaperBox_open_empty_F",[9.99609,-6.30859,0],255],["Land_BagFence_01_round_green_F",[-5.50293,10.6914,0],135],["Land_BagFence_01_round_green_F",[5.62207,10.8145,0],225],["Land_HBarrier_01_big_4_green_F",[-9.25293,8.69141,0],180],["Land_HBarrier_01_big_4_green_F",[9.37207,8.56641,0],180],["Land_BagFence_01_long_green_F",[-2.25293,-12.5586,0],90],["Land_HBarrier_01_big_4_green_F",[-12.3779,3.44141,0],90],["Land_HBarrier_01_big_4_green_F",[12.6221,3.56641,0],90],["Land_PaperBox_closed_F",[10.498,-8.05664,0],0],["Land_HBarrier_01_big_4_green_F",[12.4971,-4.80859,0],270],["Land_HBarrier_01_big_4_green_F",[-12.5029,-4.93359,0],270],["Land_HBarrier_01_big_4_green_F",[9.37207,-10.0586,0],1.36604e-05],["Land_BagFence_01_round_green_F",[-3.00293,-14.8086,0],315],["Land_BagFence_01_long_green_F",[-9.37793,-12.5586,0],1.00179e-05],["Land_BagFence_01_long_green_F",[-12.5029,-9.55859,0],90],["Land_BagFence_01_long_green_F",[-5.50293,-15.4336,0],180],["Land_BagFence_01_round_green_F",[-11.8779,-11.9316,0],45]],
                    []
                ],
                [
                    [["Land_HBarrier_01_line_5_green_F",[-0.0224609,-0.0292969,0],180],["Land_HBarrier_01_line_5_green_F",[3.35254,-1.1543,0],90],["Land_HBarrier_01_line_3_green_F",[-0.0224609,-5.0293,0],90],["Land_WoodenCrate_01_stack_x5_F",[-5.02148,-1.7793,0],0],["Land_HBarrier_01_line_5_green_F",[-5.39746,-0.0292969,0],180],["Land_HBarrier_01_line_3_green_F",[1.22754,6.3457,0],90],["Land_BagFence_01_round_green_F",[5.10254,4.72266,0],45],["Land_Cargo_Patrol_V4_F",[-4.39746,4.2207,0],180],["Land_BagFence_01_long_green_F",[4.47754,6.8457,0],90],["Land_HBarrier_01_line_3_green_F",[3.22852,-7.6543,0],90],["Land_BagFence_01_long_green_F",[7.47754,3.9707,0],180],["Land_HBarrier_01_big_4_green_F",[-8.39746,3.3457,0],90],["Land_Cargo_House_V4_F",[8.97754,-1.6543,0],90],["Land_HBarrier_01_big_4_green_F",[3.22754,8.5957,0],180],["Land_HBarrier_01_big_4_green_F",[-8.52246,-5.0293,0],270],["Land_HBarrier_01_big_4_green_F",[-5.27246,8.5957,0],180],["Land_HBarrier_01_big_4_green_F",[3.22754,-10.0293,0],0],["Land_BagFence_01_round_green_F",[10.1025,4.5957,0],315],["Land_HBarrier_01_big_4_green_F",[-5.27246,-10.0293,0],1.36604e-05],["Land_HBarrier_01_line_1_green_F",[7.85254,-9.9043,0],180],["Land_BagFence_01_long_green_F",[10.7275,6.8457,0],90],["Land_BagFence_01_long_green_F",[6.35254,11.0957,0],270],["Land_BagFence_01_long_green_F",[9.60254,-9.7793,0],0],["Land_BagFence_01_long_green_F",[10.7275,9.3457,0],90],["Land_BagFence_01_long_green_F",[7.72754,12.5957,0],0],["Land_HBarrier_01_line_1_green_F",[11.4785,-9.7793,0],90],["Land_HBarrier_01_big_4_green_F",[14.8525,-2.9043,0],270],["Land_BagFence_01_round_green_F",[10.1025,11.8438,0],225],["Land_HBarrier_01_big_4_green_F",[14.9775,5.4707,0],90],["Land_BagFence_01_long_green_F",[13.4775,-9.7793,0],180],["Land_BagFence_01_long_green_F",[14.8525,-8.4043,0],90]],
                    []
                ],
                [
                    [["Land_Cargo_House_V4_F",[0.84668,3.46094,0],0],["Land_HBarrier_01_line_3_green_F",[5.97168,-3.16406,0],90],["Land_BagFence_01_end_green_F",[-0.90332,-7.91211,0],270],["Land_HBarrier_01_line_5_green_F",[7.97168,-1.03906,0],0],["Land_BagFence_01_corner_green_F",[-1.1543,-8.79102,0],90],["Land_HBarrier_01_big_4_green_F",[-0.0283203,9.46094,0],180],["Land_BagFence_01_long_green_F",[-3.02832,-9.16406,0],180],["Land_WoodenCrate_01_stack_x5_F",[6.09766,7.45898,0],195],["Land_Cargo_Patrol_V4_F",[-7.52734,-5.16211,0],90],["Land_WoodenCrate_01_stack_x5_F",[7.97168,7.21094,0],90],["Land_HBarrier_01_line_3_green_F",[-9.15332,7.58594,0],0],["Land_WoodenCrate_01_stack_x3_F",[9.59668,-7.03906,0],285],["Land_HBarrier_01_line_1_green_F",[-8.15332,8.96094,0],180],["Land_BagFence_01_round_green_F",[-3.77832,11.584,0],225],["Land_WoodenCrate_01_stack_x5_F",[9.59668,7.58594,0],0],["Land_HBarrier_01_big_4_green_F",[11.5967,-3.91406,0],270],["Land_HBarrier_01_line_1_green_F",[-1.27832,-12.2891,0],105],["Land_HBarrier_01_line_1_green_F",[2.97168,-12.0391,0],60],["Land_HBarrier_01_big_4_green_F",[-11.6533,4.21094,0],90],["Land_HBarrier_01_big_4_green_F",[8.47168,-9.16406,0],1.36604e-05],["Land_HBarrier_01_big_4_green_F",[-11.7783,-4.16406,0],270],["Land_HBarrier_01_big_4_green_F",[-8.52832,-9.16406,0],1.36604e-05],["Land_HBarrier_01_big_4_green_F",[11.7217,4.46094,0],90],["Land_HBarrier_01_big_4_green_F",[8.47168,9.46094,0],180],["Land_HBarrier_01_line_1_green_F",[-8.15332,10.2109,0],180],["Land_BagFence_01_short_green_F",[-5.6543,12.2109,0],180],["Land_BagFence_01_round_green_F",[-7.52832,11.5859,0],135]],
                    []
                ]
            ];
        };
        case "tower": {
            _compositions pushBack selectRandom [
                [
                    [["Land_WoodenCrate_01_stack_x5_F",[-0.861328,0.212891,0],220.979],["Land_WoodenCrate_01_stack_x5_F",[4.24023,-1.06836,0],256.115],["Land_WoodenCrate_01_stack_x5_F",[4.85449,0.720703,0],90],["Land_HBarrier_01_wall_6_green_F",[-0.396484,-5.2793,0],180],["Land_HBarrier_01_wall_6_green_F",[0.728516,6.0957,0],0],["Land_HBarrier_01_line_3_green_F",[6.97852,-1.1543,0],180],["Land_HBarrier_01_line_3_green_F",[4.85352,-6.5293,0],180],["Land_HBarrier_01_line_3_green_F",[-5.27148,-6.6543,0],180],["Land_HBarrier_01_line_3_green_F",[5.60449,6.8457,0],90],["Land_HBarrier_01_line_3_green_F",[-5.02148,7.4707,0],180],["Land_HBarrier_01_line_3_green_F",[-8.77148,2.0957,0],180],["Land_HBarrier_01_wall_corner_green_F",[7.85449,-4.6543,0],90],["Land_HBarrier_01_line_5_green_F",[9.22852,0.595703,0],270],["Land_HBarrier_01_wall_corner_green_F",[-8.27148,5.5957,0],270],["Land_HBarrier_01_wall_corner_green_F",[-9.39648,-5.2793,0],180],["Land_HBarrier_01_line_3_green_F",[-10.5215,-3.0293,0],180],["Land_Cargo_Tower_V4_F",[-0.0205078,-0.0292969,0],0]],
                    []
                ],
                [
                    [["Land_HBarrier_01_line_5_green_F",[-1.91016,-0.845703,0],0],["Land_Pallets_stack_F",[3.71484,0.884766,0],180],["Land_CratesWooden_F",[-2.41016,-3.2207,0],270],["Land_CratesShabby_F",[4.96484,0.529297,0],90],["Land_Pallets_stack_F",[5.31055,1.62891,0],180],["Land_HBarrier_01_line_5_green_F",[5.71484,-0.845703,0],0],["Land_HBarrier_01_line_3_green_F",[-2.66016,7.65625,0],195],["Land_HBarrier_01_line_3_green_F",[4.08984,-7.0957,0],0],["Land_HBarrier_01_line_1_green_F",[7.96484,2.4043,0],45],["Land_HBarrier_01_line_3_green_F",[4.46484,7.15625,0],195],["Land_HBarrier_01_line_5_green_F",[-7.41016,-4.09375,0],75],["Land_HBarrier_01_line_3_green_F",[-2.78516,-8.22266,0],15],["Land_HBarrier_01_line_3_green_F",[-5.03418,7.4043,0],150],["Land_HBarrier_01_line_1_green_F",[8.21484,-4.5957,0],0],["Land_HBarrier_01_line_1_green_F",[7.21484,6.1543,0],300],["Land_HBarrier_01_line_3_green_F",[-8.91016,3.6543,0],285],["Land_HBarrier_01_line_1_green_F",[8.54785,4.58203,0],330],["Land_HBarrier_01_line_1_green_F",[7.46484,-6.5957,0],45],["Land_HBarrier_01_line_1_green_F",[-8.03516,-6.5957,0],150],["Land_HBarrier_01_line_1_green_F",[-9.40918,7.7793,0],225],["Land_Cargo_Tower_V4_F",[-0.0341797,0.0292969,0],0]],
                    []
                ],
                [
                    [["Land_HBarrier_01_big_4_green_F",[2.00488,-7.86914,0],180],["Land_HBarrier_01_big_4_green_F",[1.87988,8.75586,0],180],["Land_HBarrier_01_big_4_green_F",[-9.62012,3.38086,0],90],["Land_HBarrier_01_line_3_green_F",[7.50488,-7.61914,0],0],["Land_HBarrier_01_big_4_green_F",[-6.49512,8.50586,0],180],["Land_HBarrier_01_big_4_green_F",[10.7559,0.380859,0],270],["Land_HBarrier_01_line_3_green_F",[7.50488,8.75586,0],180],["Land_HBarrier_01_line_3_green_F",[10.7549,-4.49414,0],270],["Land_HBarrier_01_line_3_green_F",[9.75488,-6.74609,0],315],["Land_HBarrier_01_line_3_green_F",[10.6299,5.50586,0],270],["Land_HBarrier_01_line_3_green_F",[9.75488,7.75586,0],225],["Land_Cargo_Tower_V4_F",[0.00585938,0.00585938,0],0]],
                    []
                ],
                [
                    [["Land_HBarrier_01_big_4_green_F",[3.8457,-6.47461,0],0],["Land_HBarrier_01_big_4_green_F",[-4.5293,-6.59961,0],0],["Land_Pallet_F",[8.68848,2.4707,0],201.495],["Land_HBarrier_01_big_4_green_F",[3.8457,8.15039,0],0],["Land_HBarrier_01_big_4_green_F",[-4.5293,7.90039,0],0],["Land_HBarrier_01_big_4_green_F",[8.8457,-3.22461,0],90],["Land_Sack_F",[-8.55371,4.625,0],300],["Land_Pallets_stack_F",[-8.22949,5.66992,0],209.811],["Land_HBarrier_01_big_4_green_F",[-9.6543,-3.47461,0],90],["Land_Pallets_F",[10.7227,-0.392578,0],327.234],["Land_Pallets_stack_F",[10.7168,1.72852,0],50.6134],["Land_WoodenCrate_01_stack_x3_F",[8.88965,6.35156,0],220.358],["Land_Pallets_F",[-10.1543,4.90039,0],240],["Land_Pallets_stack_F",[-9.90625,6.91602,0],150.243],["Land_Cargo_Tower_V4_F",[0.22168,-0.0996094,0],0]],
                    []
                ],
                [
                    [["Land_WoodenCrate_01_stack_x3_F",[0.683594,2.13477,0],0],["Land_Pallet_MilBoxes_F",[-1.33496,2.10742,0],0.0150947],["Land_WoodenCrate_01_stack_x5_F",[2.29102,2.23242,0],93.2767],["Land_HBarrier_01_big_4_green_F",[1.79004,-6.51758,0],0],["Land_HBarrier_01_line_5_green_F",[-5.08496,-6.64258,0],180],["Land_HBarrier_01_big_4_green_F",[1.54004,8.23242,0],0],["Land_HBarrier_01_line_5_green_F",[-7.33496,4.48242,0],90],["Land_HBarrier_01_line_5_green_F",[7.54004,-4.64258,0],315],["Land_HBarrier_01_big_4_green_F",[9.16504,0.982422,0],90],["Land_HBarrier_01_line_5_green_F",[-5.33496,7.98242,0],180],["Land_HBarrier_01_line_5_green_F",[-8.58496,-4.64258,0],90],["Land_HBarrier_01_line_5_green_F",[7.28906,6.60938,0],225],["Land_Cargo_Tower_V4_F",[0.0410156,-0.0175781,0],0]],
                    []
                ],
                [
                    [["Land_WoodenCrate_01_stack_x5_F",[-0.311523,1.91602,0],0],["Land_Pallets_stack_F",[1.41699,1.79688,0],181.668],["Land_WoodenCrate_01_stack_x3_F",[5.47656,-0.521484,0],117.271],["Land_HBarrier_01_line_5_green_F",[-4.64844,-5.26953,0],0],["Land_HBarrier_01_line_3_green_F",[-6.77246,-3.01953,0],90],["Land_HBarrier_01_line_5_green_F",[5.22656,-5.89453,0],0],["Land_HBarrier_01_line_5_green_F",[4.85156,6.23047,0],180],["Land_HBarrier_01_line_3_green_F",[6.97656,3.98047,0],270],["Land_HBarrier_01_line_5_green_F",[-5.14844,6.23047,0],180],["Land_HBarrier_01_line_3_green_F",[7.35254,-3.76953,0],90],["Land_HBarrier_01_line_3_green_F",[-7.27344,4.10547,0],270],["Land_Cargo_Tower_V4_F",[-0.0224609,-0.0195313,0],0]],
                    []
                ],
                [
                    [["Land_HBarrier_01_line_5_green_F",[1.84766,-6.27734,0],180],["Land_HBarrier_01_line_5_green_F",[-3.77734,-6.27734,0],180],["Land_HBarrier_01_line_5_green_F",[3.72266,7.22266,0],180],["Land_HBarrier_01_line_5_green_F",[-4.52734,7.22266,0],180],["Land_HBarrier_01_line_3_green_F",[5.97266,-6.27734,0],0],["Land_HBarrier_01_line_5_green_F",[8.22266,2.84766,0],90],["Land_HBarrier_01_line_3_green_F",[-7.15137,-5.27734,0],90],["Land_HBarrier_01_line_3_green_F",[9.09766,-0.527344,0],0],["Land_HBarrier_01_line_5_green_F",[-7.90234,5.09766,0],90],["Land_HBarrier_01_line_3_green_F",[7.22266,6.22266,0],225],["Land_HBarrier_01_line_3_green_F",[8.22266,-5.2793,0],315],["Land_Cargo_Tower_V4_F",[-0.0263672,-0.0273438,0],0]],
                    []
                ],
                [
                    [["Land_HBarrier_01_line_5_green_F",[-3.04004,-2.96289,0],270],["Land_HBarrier_01_line_5_green_F",[0.334961,-5.08789,0],0],["Land_HBarrier_01_line_5_green_F",[-1.24609,6.11328,0],180],["Land_HBarrier_01_line_5_green_F",[4.36035,6.07031,0],180],["Land_HBarrier_01_line_5_green_F",[5.81543,-5.10742,0],0],["Land_HBarrier_01_line_5_green_F",[7.8584,-1.5957,0],90],["Land_HBarrier_01_line_5_green_F",[7.8584,4.01172,0],90],["Land_Cargo_Tower_V4_F",[-0.00390625,0.00390625,0],0]],
                    []
                ],
                [
                    [["Land_WoodenBox_F",[0.0078125,0.0195313,0],345],["Land_WoodenBox_F",[0.114258,1.06445,0],330],["Land_Pallets_stack_F",[0.734375,-1.10938,0],165],["Land_HBarrier_01_line_3_green_F",[2.60938,-1.60938,0],270],["Land_HBarrier_01_line_5_green_F",[3.98438,0.765625,0],0],["Land_HBarrier_01_line_5_green_F",[0.984375,-5.98438,0],180],["Land_HBarrier_01_line_5_green_F",[-3.14063,6.01563,0],180],["Land_HBarrier_01_line_5_green_F",[-4.51563,-5.98438,0],180],["Land_HBarrier_01_line_3_green_F",[-6.64063,-3.60938,0],270],["Land_HBarrier_01_line_5_green_F",[7.35938,2.76563,0],270],["Land_HBarrier_01_line_3_green_F",[5.48438,-5.98438,0],0],["Land_HBarrier_01_line_5_green_F",[5.35938,6.14063,0],0],["Land_HBarrier_01_line_3_green_F",[-6.64063,5.14063,0],270],["Land_HBarrier_01_line_3_green_F",[7.73438,-5.10938,0],270],["Land_Sacks_heap_F",[-8.24121,4.55859,0],180],["Land_WoodenCrate_01_stack_x3_F",[-8.26563,-4.85938,0],171.432],["Land_Pallets_F",[-8.26563,6.01563,0],0],["Land_WoodenBox_F",[-6.99219,7.76953,0],195],["Land_Cargo_Tower_V4_F",[0.110352,-0.234375,0],0]],
                    []
                ]
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

private _initTurrets = {
    params ["_turrets", "_side"];
    {
        private _turret = _x;
        _turret setFuel 0;
        _turret allowCrewInImmobile [true, true];
        _turret setVehicleRadar 1;

        _turret setVariable ["WHF_turret_side", _side];
        _turret addEventHandler ["Fired", {
            params ["_turret"];
            if (someAmmo _turret) exitWith {};

            private _side = _turret getVariable "WHF_turret_side";
            if (isNil "_side") exitWith {};
            if (side group gunner _turret isNotEqualTo _side) exitWith {};
            if (isPlayer gunner _turret) exitWith {};
            _turret spawn {
                sleep (10 + random 20);
                _this setVehicleAmmo 1;
            };
        }];
    } forEach _turrets;
};

private _registerArtillery = {
    params ["_turrets", "_group"];
    if (_turrets findIf {getNumber (configOf _x >> "artilleryScanner") > 0} < 0) exitWith {};
    if (isNil "lambs_wp_fnc_taskartilleryregister") exitWith {};

    // TODO: add scripts for automatic targeting in vanilla
    [_group] call lambs_wp_fnc_taskartilleryregister;
};

private _clearRadius = 40;
private _compositionObjects = [];
private _compositionTerrain = [];
private _compositionGroups = [];
{

    private _pos = [_center, [20, _radius], [_clearRadius, _isPosSuitable]] call WHF_fnc_randomPos;
    if (_pos isEqualTo [0,0]) then {continue};
    _pos = _pos vectorAdd [0,0,0];

    _x params ["_objects", "_turrets"];

    private _terrain = nearestTerrainObjects [_pos, [], _clearRadius, false];
    {hideObjectGlobal _x} forEach _terrain;

    private _direction = random 360;
    _objects = [_objects, _pos, _direction, ["normal", "path", "simple"], _ruins] call WHF_fnc_objectsMapper;
    _turrets = [_turrets, _pos, _direction, ["normal"], _ruins] call WHF_fnc_objectsMapper;
    _objects append _turrets;

    private _group = [_side, "standard", count _turrets, [random -500, random -500, 500], 0, false] call WHF_fnc_spawnUnits;
    {
        private _turret = _turrets # _forEachIndex;
        _group addVehicle _turret;
        _x moveInGunner _turret;
    } forEach units _group;

    [_turrets, _side] call _initTurrets;
    [_turrets, _group] call _registerArtillery;

    _compositionObjects pushBack _objects;
    _compositionTerrain pushBack _terrain;
    _compositionGroups pushBack _group;
} forEach _compositions;

[_compositionObjects, _compositionTerrain, _compositionGroups]
