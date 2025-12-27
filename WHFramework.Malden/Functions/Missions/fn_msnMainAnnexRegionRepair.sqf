/*
Function: WHF_fnc_msnMainAnnexRegionRepair

Description:
    Players must destroy the repair station.
    Function must be executed in scheduled environment.

Parameters:
    Position2D center:
        The center of the mission.
    Number radius:
        The radius of the mission.
    String faction:
        The faction to spawn units from.
    String parent:
        The parent task ID.
    Array objects:
        An array to append objects to.
        Useful for garbage collection.
    Array terrain:
        An array to append hidden terrain to.
        Useful for garbage collection.
    Array groups:
        An array to append groups to.
        Useful for garbage collection.

Author:
    thegamecracks

*/
params ["_center", "_radius", "_faction", "_parent", "_objects", "_terrain", "_groups"];

private _isPosSuitable = {
    params ["_pos"];
    _pos isFlatEmpty [-1, -1, 0.5, 20] isNotEqualTo []
};

private _pos = [_center, [30, _radius], [0, _isPosSuitable]] call WHF_fnc_randomPos;
if (_pos isEqualTo [0,0]) exitWith {};

private _standard = ["standard", _faction];
private _apc = ["apc", _faction];

private _posTerrain = nearestTerrainObjects [_pos, [], 25, false, true];
{hideObjectGlobal _x} forEach _posTerrain;
_terrain pushBack _posTerrain;

private _centerVehicle = selectRandom ([_apc] call WHF_fnc_getVehicleTypes);
private _compProps = [["Land_BagFence_01_long_green_F",[-3.2002,-0.7,0],90],["Land_BagFence_01_long_green_F",[-3.2,2.3,0],90],["Land_EngineCrane_01_F",[0.3,4.8,0],270],["Land_BagFence_01_long_green_F",[-4.7,-2.2,0],0],["CamoNet_INDP_F",[-5.2,2.8,0],90],["Land_BagFence_01_long_green_F",[-3.2,5.3,0],90],["LayFlatHose_01_SBend_F",[-6.33,0.38,0],210],["WaterPump_01_forest_F",[-7.7,-2.7,0],180],["Land_BagFence_01_long_green_F",[-4.7,6.8,0],0],["StorageBladder_01_fuel_forest_F",[-8.7,2.8,0],0],["CamoNet_INDP_F",[7.3,5.8,0.78],0],["Land_WeldingTrolley_01_F",[6.9,7.18,0],0],["Land_BagFence_01_long_green_F",[-7.7,6.8,0],0],["Land_BagFence_01_round_green_F",[-3.2,10.3,0],135],["Land_BagFence_01_round_green_F",[9.8,-4.7,0],90],["Land_BagFence_01_long_green_F",[-10.7,6.8,0],0],["Land_Wreck_BRDM2_F",[5.8,11.3,0],0],["Land_Wreck_T72_turret_F",[0.8,12.8,0],0],["Land_BagFence_01_round_green_F",[11.3,-6.2,0],0],["CamoNet_INDP_F",[-12.7,2.3,0],270],["Land_BagFence_01_round_green_F",[12.8,-4.7,0],270],["Land_BagFence_01_long_green_F",[13.8,1.8,0],90],["Land_BagFence_01_long_green_F",[-15.2,-0.7,0],90],["Land_BagFence_01_long_green_F",[-13.7,6.8,0],0],["Land_BagFence_01_long_green_F",[-15.2,2.3,0],90],["Land_BagFence_01_long_green_F",[10.8,11.8,0],0],["Land_BagFence_01_long_green_F",[-15.2,5.3,0],90],["Land_BagFence_01_round_green_F",[-15.7,-4.2,0],180],["Land_BagFence_01_long_green_F",[13.8,8.8,0],90],["Land_BagFence_01_round_green_F",[-15.7,-7.2,0],0],["Land_BagFence_01_round_green_F",[13.3,11.3,0],225],["Land_BagFence_01_round_green_F",[-17.2,-5.7,0],90]];
private _compVehicles = [["B_Slingload_01_Repair_F",[9.5,3,0],0],[_centerVehicle,[3,-2,0],15]];

private _dir = random 360;
_compProps = [_compProps, _pos, _dir, ["normal", "path", "simple"], _objects] call WHF_fnc_objectsMapper;
_compVehicles = [_compVehicles, _pos, _dir, ["normal"], _objects] call WHF_fnc_objectsMapper;
_objects pushBack _compProps;
_objects append _compVehicles; // Ensure GC area check happens per vehicle

private _group = [opfor, [_standard], _compVehicles] call WHF_fnc_spawnGunners;
_groups pushBack _group;

private _guardCount = [4, 8] call WHF_fnc_scaleUnitsMain;
private _guardGroup = [opfor, [_standard], _guardCount, _pos, 20] call WHF_fnc_spawnUnits;
[_guardGroup, _pos] call BIS_fnc_taskDefend;
_groups pushBack _guardGroup;

private _repair = _compVehicles # 0;
sleep (1.5 + random 2.5);
if (!alive _repair) exitWith {};

_repair addEventHandler ["Killed", {
    params ["_repair", "_killer", "_instigator"];
    _repair removeEventHandler [_thisEvent, _thisEventHandler];
    if (isNull _instigator) then {_instigator = effectiveCommander _killer};
    if (!isPlayer _instigator) exitWith {};
    [
        [blufor, "BLU"],
        "$STR_WHF_mainAnnexRegionRepair_success",
        [name _instigator]
    ] remoteExec ["WHF_fnc_localizedSideChat", blufor];
}];

private _taskID = [
    blufor,
    ["", _parent],
    "mainAnnexRegionRepair",
    _pos getPos [40 + random 40, random 360],
    "CREATED",
    -1,
    false,
    "repair"
] call WHF_fnc_taskCreate;

waitUntil {sleep 3; !alive _repair};
[_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
