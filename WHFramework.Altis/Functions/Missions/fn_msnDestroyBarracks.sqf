/*
Function: WHF_fnc_msnDestroyBarracks

Description:
    Players must clear out enemies from a fortified barracks.
    Function must be ran in scheduled environment.

Parameters:
    PositionATL ecnter:
        (Optional, default [])
        If specified, the given position is used for the intel instead of
        attempting to find a suitable location.

Author:
    thegamecracks

*/
params [["_center",[]]];

private _turretTypes = [
    "O_HMG_01_high_F",
    "O_HMG_02_high_F",
    "CUP_O_KORD_high_RUS_M_Summer"
] select {isClass (configFile >> "CfgVehicles" >> _x)};

private _barracks = [["Land_CampingChair_V2_F",[-0.00390625,0.046875,0.601674],85.1171],["Land_CampingChair_V2_F",[-0.117188,-1.14844,0.601674],85.1171],["Land_CampingTable_F",[-1.12891,-0.708008,0.601674],90],["CUP_vojenska_palanda",[1.39453,-0.269531,0.601674],0],["Land_CampingTable_F",[-1.12891,1.23047,0.601674],90],["Land_Pillow_grey_F",[1.24121,0.253906,1.806],0],["Land_CampingChair_V2_F",[-0.22168,1.71582,0.601674],85.1171],["Land_CampingChair_V2_F",[-1.88965,0.185547,0.601674],270.736],["Land_CampingChair_V2_F",[-1.86133,-0.995117,0.601674],242.568],["Land_CampingChair_V2_F",[-1.92188,1.23047,0.601674],246.393],["Land_FMradio_F",[-1.12695,-1.25684,2.23259],0],["CUP_vojenska_palanda",[1.33984,2.28809,0.601674],0],["Land_TripodScreen_01_large_F",[-1.14746,2.64941,0.601674],180],["Land_Sun_chair_F",[1.17285,-0.55957,3.12651],0],["Land_Pillow_grey_F",[1.18359,2.77441,1.79874],0],["Land_CampingChair_V2_F",[-3.16797,1.75586,0.601674],85.1171],["Land_Cargo_HQ_V4_F",[-1.26758,-1.0791,0],0],["Land_Sun_chair_F",[2.28711,-0.478516,3.12651],0],["Land_CampingTable_F",[-3.98438,1.57031,0.601674],90],["Land_Sun_chair_F",[3.38184,-0.487305,3.12651],0],["Land_CampingTable_F",[-3.9707,2.91016,0.601674],0],["Land_CampingChair_V2_F",[-4.87305,1.52832,0.601674],248.62],["Vysilacka",[-3.30469,2.88379,2.23259],270],["CUP_vojenska_palanda",[2.43262,4.49316,0.601674],90],["Land_CampingChair_V2_F",[1.36719,-5.19922,0.601674],358.718],["Land_Sun_chair_F",[4.57617,-0.50293,3.12651],0],["CUP_fridge",[-5.26172,-1.61914,0.601674],90],["Land_Microwave_01_F",[-5.17578,-1.63477,1.996],270],["Land_Pillow_grey_F",[2.98633,4.61426,1.931],0],["CUP_fridge",[-5.25684,-2.20703,0.601674],90],["CUP_vojenska_palanda",[5.80859,0.0800781,0.601674],0],["Land_Microwave_01_F",[-5.17773,-2.19141,1.998],270],["Land_CampingChair_V2_F",[2.93945,-5.14258,0.601674],352.627],["Microphone2_ep1",[1.44336,-5.70898,1.489],0],["Land_PortableDesk_01_black_F",[2.19336,-5.88184,0.602],0],["Land_FlatTV_01_F",[1.36523,-6.1543,1.489],180.615],["CUP_sink",[-6.39258,0.322266,1.234],270],["CUP_sink",[-6.38574,-0.800781,1.234],270],["Land_IPPhone_01_black_F",[2.89746,-5.87598,1.48893],182.236],["Land_FoodContainer_01_F",[-5.24707,-4.24609,0.601674],0],["CUP_vojenska_palanda",[5.10742,4.5918,0.722087],90],["Land_FoodContainer_01_F",[-5.22266,-4.73926,0.601674],0],["CUP_case_a",[-0.65625,-6.9707,0.722088],180],["CUP_case_a",[-1.67285,-6.94043,0.722088],180],["Land_Pillow_grey_F",[5.48633,4.62207,1.938],0],["CUP_case_bedroom_a",[6.75293,2.87207,0.722092],0],["Land_FoodContainer_01_F",[-5.22656,-5.18359,0.601674],0],["Land_Camping_Light_F",[6.78418,2.91406,1.283],0],["CUP_case_a",[-2.68262,-6.93457,0.722088],180],["Land_FoodContainer_01_F",[-5.30273,-5.63672,0.602],0],["O_supplyCrate_F",[7.02734,-2.76953,0.722088],271.724],["CUP_case_a",[-3.67969,-6.93652,0.722088],180],["Land_SatelliteAntenna_01_F",[1.22559,-5.58398,5.756],254.237],["Red_Light_Blinking_EP1",[6.52344,-5.10352,2.20061],0.0990526],["CUP_case_a",[-4.7168,-6.91797,0.722088],180]];
private _flags = [["Flag_CSAT_F",[2.1543,-4.5332,5.756],0],["FlagCarrierRU",[5.7373,-5.08691,5.75551],0]];
private _turrets = [[selectRandom _turretTypes,[-4.05664,1.87402,3.12651],310.032],[selectRandom _turretTypes,[4.78809,1.99707,3.12651],88.7127],[selectRandom _turretTypes,[-4.19336,-5.57324,3.12651],216.042]];
private _forts = [["Land_FoodContainer_01_F",[-5.32813,-6.06836,0.602],0],["Land_WoodenTable_02_large_F",[-1.53418,8.08887,0],0],["LayFlatHose_01_CurveLong_F",[-1.35742,-8.33203,0],0],["Land_WoodenTable_02_large_F",[3.05469,8.10156,0],0],["Land_GymBench_01_F",[-9.48242,2.46094,0],0],["Land_ToiletBox_F",[9.81836,0.762695,0.030748],90],["Land_ToiletBox_F",[9.84766,-1.90527,0.030748],90],["LayFlatHose_01_Roll_F",[-1.68555,-10.0234,0],0],["Land_ToiletBox_F",[9.95996,-4.41211,0.030748],90],["StorageBladder_02_water_forest_F",[1.73633,-11.0918,0.035533],0],["Land_Razorwire_F",[-0.833984,11.418,0],0],["WaterPump_01_forest_F",[-2.88086,-11.4023,0],270],["Land_BagFence_01_round_green_F",[8.20215,8.72461,0],113.932],["Land_GymRack_01_F",[-11.8184,2.27344,0],0],["Land_BagFence_01_round_green_F",[6.57031,-10.2266,0],92.7051],["Land_GymRack_03_F",[-12.2695,-0.152344,0],270],["Land_Razorwire_F",[12.6533,-0.349609,0],90],["Land_BagFence_01_round_green_F",[-9.46777,8.61523,0],235.926],["Land_BagFence_01_round_green_F",[9.5293,-8.62695,0],181.508],["Land_BagFence_01_round_green_F",[-11.2549,6.55176,0],38.7142],["Land_BagFence_01_round_green_F",[10.6523,7.52344,0],311.144],["Land_Razorwire_F",[7.52344,11.3809,0],0],["Land_Razorwire_F",[1.69824,-13.6992,0],0],["Land_BagFence_01_round_green_F",[-6.91992,-11.9883,0],328.23],["Land_BagFence_01_round_green_F",[10.2598,9.42871,0],205.736],["Land_Razorwire_F",[-14.0732,-0.805664,0],90],["Land_BagFence_01_round_green_F",[-8.87891,-11.0625,0],75.5955],["Land_BagFence_01_round_green_F",[-11.4102,8.72168,0],130.519],["Land_Razorwire_F",[-9.13281,11.4463,0],0],["Land_Razorwire_F",[12.623,7.94629,0],90],["Land_BagFence_01_round_green_F",[9.30859,-11.8604,0],3.14863],["Land_BagFence_01_round_green_F",[10.9512,-10.4043,0],272.558],["Land_Razorwire_F",[-6.41406,-13.8652,0],0],["Land_Razorwire_F",[12.7031,-8.66309,0],90],["Land_Razorwire_F",[-14.0068,7.64355,0],90],["Land_Razorwire_F",[-14.1006,-9.01172,0],90],["Land_Razorwire_F",[9.92383,-13.6836,0],0],["PlasticBarrier_02_grey_F",[-10.9873,-16.2383,0],140.738],["PlasticBarrier_02_grey_F",[-14.2773,-14.4658,0],267.253],["PlasticBarrier_02_grey_F",[-13.2383,-16.4258,0],200.317]];
_barracks = _barracks select {isClass (configFile >> "CfgVehicles" >> _x # 0)};
_flags = _flags select {isClass (configFile >> "CfgVehicles" >> _x # 0)};
if (!isClass (configFile >> "CfgPatches" >> "CUP_Editor_Structures_Config")) then {
    private _types = ["Land_Pillow_grey_F", "Land_Microwave_01_F", "Land_Camping_Light_F"];
    _barracks = _barracks select {!(_x # 0 in _types)};
};

private _radius = 100;

if (_center isEqualTo []) then {
    private _options = selectBestPlaces [
        [worldSize / 2, worldSize / 2],
        sqrt 2 / 2 * worldSize,
        "houses + forest",
        100,
        200
    ];
    {
        _x params ["_pos"];
        _pos pushBack 0;
        if ([_pos, _radius + 1000] call WHF_fnc_isNearRespawn) then {continue};
        if (_pos nearRoads 100 isNotEqualTo []) then {continue};
        if (_pos isFlatEmpty [-1, -1, 0.5, 12] isEqualTo []) then {continue};
        if ([_pos, _radius] call WHF_fnc_isNearUsedPosition) then {continue};
        _center = _pos;
        break;
    } forEach _options;
};
if (_center isEqualTo []) exitWith {
    diag_log text format ["%1: No center found", _fnc_scriptName];
};

private _area = [_center, _radius, _radius, 0, false];

private _terrainObjects = nearestTerrainObjects [_center, [], 20, false, true];
_terrainObjects apply {hideObjectGlobal _x};

private _objects = [];
private _groups = [];
private _vehicles = [];

private _normal = surfaceNormal _center;
private _dir = if (_normal isEqualTo [0,0,1]) then {random 360} else {
    private _dir = _center getDir (_center vectorAdd _normal);
    _dir = (_dir + 180) % 360;
    _dir
};

private _ASLFlags = ["ASL", "path", "simple"];
private _normalFlags = ["normal", "path", "simple"];
_barracks = [_barracks, _center, _dir, _ASLFlags, _objects] call WHF_fnc_objectsMapper;
_flags = [_flags, _center, _dir, ["ASL"], _objects] call WHF_fnc_objectsMapper;
_turrets = [_turrets, _center, _dir, ["ASL"]] call WHF_fnc_objectsMapper;
_forts = [_forts, _center, _dir, _normalFlags, _objects] call WHF_fnc_objectsMapper;
_objects append _barracks;
_objects append _flags;
_objects append _turrets;
_objects append _forts;

private _infCount = 40 + floor random 41;
while {_infCount > 0} do {
    private _pos = [_center, _radius] call WHF_fnc_randomPos;
    if (_pos isEqualTo [0,0]) then {break};

    private _quantity = selectRandom [2, 4, 6, 8];
    private _group = [opfor, "standard", _quantity, _pos, 10] call WHF_fnc_spawnUnits;
    [_group, getPosATL leader _group, 50] call BIS_fnc_taskPatrol;

    _groups pushBack _group;
    _infCount = _infCount - _quantity;
};

private _turretGroup = [opfor, _turrets] call WHF_fnc_spawnGunners;
_groups pushBack _turretGroup;

private _garrisonCount = 20 + floor random 21;
private _garrisonGroup = [opfor, "standard", _garrisonCount, _center, 50] call WHF_fnc_spawnUnits;
[_garrisonGroup, _center, _radius, true] call WHF_fnc_garrisonUnits;
[[_garrisonGroup], _groups] spawn WHF_fnc_ungarrisonLoop;
_groups pushBack _garrisonGroup;

private _vehicleArgs = [opfor, "standard", 4 + floor random 5, _center, _radius];
private _vehicleGroup = _vehicleArgs call WHF_fnc_spawnVehicles;
_groups pushBack _vehicleGroup;
_vehicles append assignedVehicles _vehicleGroup;

[_groups, _area] spawn WHF_fnc_attackLoop;

private _taskCenter = _center getPos [20 + random 20, random 360];
private _taskArea = [_taskCenter, _radius, _radius, 0, false];
private _areaMarker = [["WHF_msnDestroyBarracks_"], _taskArea, true] call WHF_fnc_createAreaMarker;
_areaMarker setMarkerBrushLocal "FDiagonal";
_areaMarker setMarkerColorLocal "ColorRed";
_areaMarker setMarkerAlpha 0.7;

private _taskID = [
    blufor,
    "",
    "destroyBarracks",
    _taskCenter,
    "CREATED",
    -1,
    true,
    "destroy"
] call WHF_fnc_taskCreate;

private _initialUnitCount = 0;
{_initialUnitCount = _initialUnitCount + count units _x} forEach _groups;
private _threshold = _initialUnitCount * 0.3;

while {true} do {
    sleep 10;

    private _allThreats = units opfor + units independent;
    private _current = count (_allThreats inAreaArray _area);

    if (_current <= _threshold) exitWith {
        [_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
    };
};

deleteMarker _areaMarker;

[_objects] call WHF_fnc_queueGCDeletion;
[_terrainObjects] call WHF_fnc_queueGCUnhide;
{[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
{[_x] call WHF_fnc_queueGCDeletion} forEach _vehicles;
