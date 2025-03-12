/*
Function: WHF_fnc_msnMainAnnexRegionRepair

Description:
    Players must destroy the repair station.
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
private _compProps = [["Land_BagFence_01_long_green_F",[-3.2002,-0.700195,0],90],["Land_BagFence_01_long_green_F",[-3.2002,2.2998,0],90],["Land_EngineCrane_01_F",[0.299805,4.7998,0],270],["Land_BagFence_01_long_green_F",[-4.7002,-2.2002,0],0],["CamoNet_INDP_F",[-5.2002,2.7998,0.0355334],90],["Land_BagFence_01_long_green_F",[-3.2002,5.2998,0],90],["LayFlatHose_01_SBend_F",[-6.33105,0.37793,0],210],["WaterPump_01_forest_F",[-7.7002,-2.7002,0],180],["Land_BagFence_01_long_green_F",[-4.7002,6.7998,0],0],["Land_ToolTrolley_02_F",[8.7998,0.799805,0],0],["StorageBladder_01_fuel_forest_F",[-8.7002,2.7998,0],0],["Land_FireExtinguisher_F",[9.15527,2.49414,-0],0],["CamoNet_INDP_F",[7.2998,5.7998,0.78],0],["Land_Bucket_EP1",[5.55371,7.99805,0],0],["Land_WeldingTrolley_01_F",[6.89648,7.17773,0],0],["Land_BagFence_01_long_green_F",[-7.7002,6.7998,0],0],["Land_BagFence_01_round_green_F",[-3.2002,10.2998,0],135],["Land_BagFence_01_round_green_F",[9.7998,-4.7002,0],90],["Land_BagFence_01_long_green_F",[-10.7002,6.7998,0],0],["Land_Wreck_BRDM2_F",[5.7998,11.2998,0],0],["Land_Wreck_T72_turret_F",[0.799805,12.7998,0],0],["Land_BagFence_01_round_green_F",[11.2998,-6.2002,0],0],["CamoNet_INDP_F",[-12.7002,2.2998,0.0359998],270],["Land_BagFence_01_round_green_F",[12.7998,-4.7002,0],270],["Land_BagFence_01_long_green_F",[13.7998,1.7998,0],90],["Land_BagFence_01_long_green_F",[-15.2002,-0.700195,0],90],["Land_BagFence_01_long_green_F",[-13.7002,6.7998,0],0],["Land_BagFence_01_long_green_F",[-15.2002,2.2998,0],90],["Land_BagFence_01_long_green_F",[10.7998,11.7998,0],0],["Land_BagFence_01_long_green_F",[-15.2002,5.2998,0],90],["Land_BagFence_01_round_green_F",[-15.7002,-4.2002,0],180],["Land_BagFence_01_long_green_F",[13.7998,8.7998,0],90],["Land_BagFence_01_round_green_F",[-15.7002,-7.2002,0],0],["Land_BagFence_01_round_green_F",[13.2998,11.2998,0],225],["Land_BagFence_01_round_green_F",[-17.2002,-5.7002,0],90]];
private _compVehicles = [["B_Slingload_01_Repair_F",[10.7998,3.7998,0],0],["CUP_O_GAZ_Vodnik_KPVT_RU",[2.7998,1.7998,0],15]];
if (_compProps findIf {!isClass (configFile >> "CfgVehicles" >> _x # 0)} >= 0) exitWith {};
if (_compVehicles findIf {!isClass (configFile >> "CfgVehicles" >> _x # 0)} >= 0) exitWith {};

private _dir = random 360;
_compProps = [_compProps, _pos, _dir, ["normal", "path", "simple"], _objects] call WHF_fnc_objectsMapper;
_compVehicles = [_compVehicles, _pos, _dir, ["normal"], _objects] call WHF_fnc_objectsMapper;
_objects append _compProps;
_vehicles append _compVehicles;

private _group = [opfor, _compVehicles] call WHF_fnc_spawnGunners;
_groups pushBack _group;

private _repair = _compVehicles # 0;
if (!alive _repair) exitWith {};

private _taskID = [
    blufor,
    ["", _parent],
    "mainAnnexRegionRepair",
    _pos getPos [40 + random 40, random 360],
    "CREATED",
    -1,
    false,
    "destroy"
] call WHF_fnc_taskCreate;

waitUntil {sleep 3; !alive _repair};
[_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
