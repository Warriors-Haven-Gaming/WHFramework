/*
Function: WHF_fnc_msnMainAnnexRegionCommand

Description:
    Players must capture or kill the region's commander.
    Function must be ran in scheduled environment.

Parameters:
    Position2D center:
        The center of the mission.
    Number radius:
        The radius of the mission.
    String parent:
        The parent task ID.
    Array objects:
        An array to append composition objects to.
        Useful for garbage collection.
    Array terrain:
        An array to append hidden terrain to.
        Useful for garbage collection.
    Array groups:
        An array to append groups to.
        Useful for garbage collection.
    Array vehicles:
        An array to individually append vehicles to.
        Useful for garbage collection.

Author:
    thegamecracks

*/
params ["_center", "_radius", "_parent", "_objects", "_terrain", "_groups", "_vehicles"];

private _isPosSuitable = {
    params ["_pos"];
    _pos isFlatEmpty [-1, -1, 1, 20] isNotEqualTo []
};

private _pos = [_center, [30, _radius], [0, _isPosSuitable]] call WHF_fnc_randomPos;
if (_pos isEqualTo [0,0]) exitWith {};

// TODO: vanilla composition
private _compProps = [["Land_BagFence_01_long_green_F",[-2.7002,-0.599609,0.602],0],["Land_Cargo_HQ_V4_F",[0.0380859,0.000976563,0],0],["CUP_vojenska_palanda",[-0.200195,3.90039,0.602],270],["Land_CampingChair_V2_F",[4.01367,0.871094,0.601674],255],["Land_BagFence_01_long_green_F",[2.2998,-3.59961,0.601674],270],["Land_BagFence_01_long_green_F",[-2.7002,-3.59961,0.601674],0],["CUP_vojenska_palanda",[-2.7002,3.90039,0.601674],270],["Land_Pallet_F",[-4.69531,0.78418,0.722],90],["Land_CampingChair_V2_F",[3.7998,2.90039,0.601674],255],["Land_PortableDesk_01_black_F",[4.7998,0.400391,0.601674],90],["Land_Camping_Light_F",[4.69727,-0.630859,1.489],0],["Land_Laptop_device_F",[4.53418,2.93066,1.498],255],["Land_PortableDesk_01_black_F",[4.7998,2.90039,0.601674],90],["Land_CampingChair_V2_F",[5.61719,0.825195,0.602],120],["Land_TripodScreen_01_large_F",[2.7998,5.40039,0.722],135],["Land_CampingChair_V2_F",[5.78809,2.52246,0.602],120],["Land_PortableServer_01_black_F",[3.92285,5.94336,0.722],0],["CUP_fridge",[7.2998,0.400391,0.602],270],["Land_OfficeChair_01_F",[5.2998,4.90039,0.722],150],["Land_PCSet_01_keyboard_F",[5.03711,5.66211,1.609],0],["Land_PCSet_01_mouse_F",[5.31445,5.64941,1.609],0],["Land_PCSet_Intel_01_F",[5.08496,6.03906,1.609],0],["Land_PortableDesk_01_black_F",[5.7998,5.90039,0.722087],0],["Land_WaterCooler_01_new_F",[8.2998,-1.09961,0.722092],90],["Land_Microwave_01_F",[8.15625,-2.08203,1.535],90],["Land_CampingTable_small_F",[8.24023,-2.09277,0.722],0],["Land_PortableCabinet_01_bookcase_black_F",[8.08105,3.00781,0.722],90],["Land_PCSet_01_case_F",[6.73535,5.83691,0.722],0],["Land_PortableCabinet_01_7drawers_black_F",[8.03516,3.89648,0.722],90],["SatelliteAntenna_01_Mounted_Black_F",[4.7998,-5.59961,4.28],180],["OmniDirectionalAntenna_01_black_F",[2.7998,-4.09961,5.75552],0]];
private _compVehicles = [["CUP_VABox_RU",[0.799805,1.40039,0.602],90],["Land_PortableLight_02_double_olive_F",[-0.700195,-3.59961,0.601674],135],["CUP_O_Kornet_RU",[-2.7002,0.900391,3.12652],270],["CUP_O_KORD_high_RU",[-4.7002,0.900391,0.926089],270],["Land_Laptop_Intel_02_F",[5.00586,1.1084,1.489],120],["CUP_O_KORD_high_RU",[-2.7002,-4.59961,3.12652],210],["CUP_O_Kornet_RU",[6.2998,0.400391,3.12652],90],["CUP_O_KORD_high_RU",[6.00879,4.95703,3.09916],30]];
if (_compProps findIf {!isClass (configFile >> "CfgVehicles" >> _x # 0)} >= 0) exitWith {};
if (_compVehicles findIf {!isClass (configFile >> "CfgVehicles" >> _x # 0)} >= 0) exitWith {};

private _dir = random 360;
_compProps = [_compProps, _pos, _dir, ["normal", "path", "simple"], _objects] call WHF_fnc_objectsMapper;
_compVehicles = [_compVehicles, _pos, _dir, ["normal"], _objects] call WHF_fnc_objectsMapper;
_objects append _compProps;
_vehicles append _compVehicles;

private _turretsGroup = [opfor, _compVehicles] call WHF_fnc_spawnGunners;
private _garrisonGroup = [opfor, "standard", selectRandom [16, 24, 32], _pos, 25] call WHF_fnc_spawnUnits;
private _commanderGroup = [opfor, "officer", 1, _pos, 10] call WHF_fnc_spawnUnits;
private _commander = units _commanderGroup # 0;
[[_commander] + units _garrisonGroup, _pos, 30, true] call WHF_fnc_garrisonUnits;
_groups append [_turretsGroup, _garrisonGroup, _commanderGroup];

private _taskID = [
    blufor,
    ["", _parent],
    "mainAnnexRegionCommand",
    _pos getPos [75 + random 75, random 360],
    "CREATED",
    -1,
    false,
    "kill"
] call WHF_fnc_taskCreate;

while {true} do {
    sleep 3;
    if (!alive _commander || {captive _commander}) exitWith {
        [_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
    };
};
