/*
Function: WHF_fnc_msnDestroyRoadblock

Description:
    Players must clear out enemies from a roadblock.
    Function must be executed in scheduled environment.

Parameters:
    PositionATL center:
        (Optional, default [])
        If specified, the given position is used instead of attempting
        to find a suitable location.
    Number direction:
        (Optional, default 0)
        If specified, the given direction is used for the roadblock.
        Has no effect if center is left unspecified.
    String faction:
        (Optional, default "")
        The faction to spawn units from.
        If not provided, a random OPFOR faction is selected from WHF_factions_pool.

Author:
    thegamecracks

*/
params [["_center", []], ["_direction", 0], ["_faction", ""]];

private _radius = 100;

if (_center isEqualTo []) then {
    private _options = ["houses + meadow - forest - sea - trees"] call WHF_fnc_selectBestPlaces;
    {
        private _pos = _x;
        if ([_pos, _radius + 1000] call WHF_fnc_isNearRespawn) then {continue};
        if (_pos isFlatEmpty [-1, -1, 1, 12] isEqualTo []) then {continue};
        if ([_pos, _radius + 200] call WHF_fnc_isNearUsedPosition) then {continue};

        private _roads = _pos nearRoads 200 apply {getRoadInfo _x} select {
            _x # 0 in ["ROAD", "MAIN ROAD", "TRACK"] && {!(_x # 2)}
        };
        if (count _roads < 1) then {continue};

        private _road = selectRandom _roads;
        _road params ["", "", "", "", "", "", "_begPos", "_endPos"];

        _center = [_road, random 1, 0] call WHF_fnc_getRoadPos;
        _direction = _begPos getDir _endPos;
        if (random 1 < 0.5) then {_direction = (_direction + 180) % 360};

        break;
    } forEach _options;
};
if (_center isEqualTo []) exitWith {
    diag_log text format ["%1: No center found", _fnc_scriptName];
};

if (_faction isEqualTo "") then {_faction = selectRandom (WHF_factions_pool get opfor)};
private _standard = ["standard", _faction];

private _area = [_center, _radius, _radius];
private _ruins = [];

private _terrain = nearestTerrainObjects [_center, [], 25, false, true];
_terrain apply {hideObjectGlobal _x};

private _objects = [
    [["RoadCone_F",[4.19336,-5.92969,0],240],["Land_HBarrier_01_big_4_green_F",[-7.18164,-0.429688,0],270],["RoadCone_F",[-4.30664,-6.05469,0],90],["Land_HBarrier_01_big_4_green_F",[6.69336,3.07031,0],270],["Land_BarGate_F",[-0.431641,6.82031,0],180],["Land_PaperBox_closed_F",[9.06738,-0.0546875,0],180],["Land_LampShabby_F",[-7.18164,4.44531,0],90],["Land_WoodenCrate_01_stack_x5_F",[9.06836,-1.80469,0],90],["RoadCone_F",[4.19336,-8.80469,0],45],["Land_BagFence_01_short_green_F",[-6.64941,-7.22656,0],270],["RoadCone_F",[-4.30664,-8.92969,0],270],["Land_BagFence_01_end_green_F",[-5.18164,8.81836,0],90],["Land_HBarrier_01_line_3_green_F",[7.81836,-6.92969,0],180],["Land_HBarrier_01_line_3_green_F",[-9.68164,-4.05469,0],0],["CamoNet_ghex_open_F",[11.1934,-0.0546875,0],270],["Land_HBarrier_01_big_4_green_F",[-10.6816,4.32031,0],0],["Land_BagFence_01_round_green_F",[-5.80664,10.3184,0],225],["Land_BagBunker_01_small_green_F",[-8.52148,-8.67969,0],0],["Land_BagBunker_01_small_green_F",[9.31836,7.94531,0],180],["Land_Cargo_Patrol_V4_F",[-11.4316,0.0703125,0],180],["RoadCone_F",[4.19336,-11.9297,0],180],["RoadCone_F",[-4.30664,-12.0547,0],315],["RoadCone_F",[-4.18164,12.1953,0],270],["RoadCone_F",[4.31836,12.3203,0],45],["Land_PaperBox_closed_F",[-13.5576,-0.929688,0],180],["Land_HBarrier_01_line_3_green_F",[-13.0566,-4.05469,0],0],["Land_HBarrier_01_big_4_green_F",[7,-11.8516,0],270],["Land_WoodPile_large_F",[8.81836,-11.6797,0],180],["Land_WaterTank_F",[13.9434,-4.42969,0],135],["Land_Sacks_heap_F",[-9.30664,11.5703,0],60],["Land_HBarrier_01_line_5_green_F",[13.6934,6.32031,0],180],["Land_WoodenCrate_01_stack_x5_F",[-15.3066,-0.429688,0],90],["CamoNet_ghex_F",[10.0684,-11.5547,0],270],["Land_HBarrier_01_line_5_green_F",[-7.55664,13.4453,0],90],["Land_JunkPile_F",[12.3184,9.44531,0],300],["Land_Sacks_heap_F",[-9.05664,12.6953,0],270],["RoadCone_F",[-4.18164,15.0703,0],90],["Land_HBarrier_01_line_3_green_F",[-15.4316,-3.17969,0],90],["RoadCone_F",[4.31836,15.1953,0],240],["Land_HBarrier_01_line_3_green_F",[15.1934,-5.43164,0],315],["CamoNet_ghex_open_F",[-11.8066,11.0703,0],270],["Land_HBarrier_01_line_3_green_F",[15.8184,3.94531,0],90],["Land_BagFence_01_short_green_F",[16.6934,3.19531,0],0],["Land_BagFence_01_short_green_F",[17.0684,-3.67969,0],165],["Land_BagFence_01_end_green_F",[-17.1816,4.94531,0],45],["Land_Pallet_vertical_F",[9.51074,-15.5879,0],180],["Land_BagFence_01_round_green_F",[18.4434,2.44336,0],225],["Land_BagFence_01_short_green_F",[-18.0078,5.55273,0],30],["Land_BagFence_01_round_green_F",[18.6934,-2.67969,0],300],["Land_BagFence_01_short_green_F",[-8.18164,17.0703,0],75],["Land_Pallets_F",[11.8174,-14.8047,0],255],["Land_BagFence_01_long_green_F",[19.0684,-0.0546875,0],270],["Land_PaperBox_closed_F",[-13.8076,13.5703,0],180],["Land_HBarrier_01_big_4_green_F",[10.375,-16.9766,0],180],["Land_PaperBox_open_full_F",[-20.0566,1.57031,0],180],["Land_BagFence_01_short_green_F",[-16.8809,11.2031,0],0],["Land_Cargo_House_V4_F",[16.0684,-12.4297,0],90],["Land_HBarrier_01_line_5_green_F",[-15.4316,13.4453,0],90],["Land_BagFence_01_round_green_F",[-19.4717,6.85156,0],60],["Land_BagFence_01_round_green_F",[-9.18262,18.6953,0],210],["Land_BagFence_01_short_green_F",[-19.5576,8.94531,0],285],["Land_BagFence_01_round_green_F",[-18.71,10.6602,0],135],["Land_HBarrier_01_big_4_green_F",[-22.0566,0.570313,0],270],["Land_BagFence_01_long_green_F",[-11.8066,19.0703,0],180],["Land_BagFence_01_short_green_F",[-15.1816,16.6953,0],105],["Land_BagFence_01_round_green_F",[-14.3066,18.4453,0],135],["Land_HBarrier_01_big_4_green_F",[16.75,-16.7266,0],180],["Land_HBarrier_01_big_4_green_F",[21.8184,-13.1797,0],270]],
    _center,
    _direction,
    ["normal", "path", "simple"],
    _ruins
] call WHF_fnc_objectsMapper;
private _turrets = [
    [["O_HMG_02_high_F",[-8.71387,-8.60547,0],180],["O_HMG_02_high_F",[9.53125,7.93945,0],0],["O_HMG_02_high_F",[-11.1709,15.3457,0],0]],
    _center,
    _direction,
    ["normal"]
] call WHF_fnc_objectsMapper;
_objects append _turrets;

private _groups = [
    opfor,
    [
        [[["standard", _faction]], 2, 8, 0], 0.80,
        [[[   "recon", _faction]], 2, 8, 1], 0.10,
        [[[   "elite", _faction]], 4, 6, 2], 0.05,
        [[[  "sniper", _faction]], 2, 2, 3], 0.05
    ],
    [24, 64] call WHF_fnc_scaleUnitsSide,
    _center,
    _radius
] call WHF_fnc_spawnUnitGroups;
{[_x, getPosATL leader _x, 50] call BIS_fnc_taskPatrol} forEach _groups;

private _turretGroup = [opfor, [_standard], _turrets] call WHF_fnc_spawnGunners;
_groups pushBack _turretGroup;

private _garrisonCount = [10, 30] call WHF_fnc_scaleUnitsSide;
private _garrisonGroup = [opfor, [_standard], _garrisonCount, _center, 50] call WHF_fnc_spawnUnits;
[_garrisonGroup, _center, 50, true] call WHF_fnc_garrisonUnits;
[[_garrisonGroup], _groups] spawn WHF_fnc_ungarrisonLoop;
_groups pushBack _garrisonGroup;

private _vehicleCount = [4, 8] call WHF_fnc_scaleUnitsSide;
private _vehicleGroup =
    [opfor, [_standard], [_standard], _vehicleCount, _center, _radius]
    call WHF_fnc_spawnVehicles;
private _vehicles = assignedVehicles _vehicleGroup;
[_vehicleGroup, _center, _radius] call BIS_fnc_taskPatrol;
_groups pushBack _vehicleGroup;

[_groups, _area] spawn WHF_fnc_attackLoop;

private _taskID = [
    blufor,
    "",
    "destroyRoadblock",
    _center getPos [40 + random 40, random 360],
    "CREATED",
    -1,
    true,
    "rifle"
] call WHF_fnc_taskCreate;

private _initialUnitCount = 0;
{_initialUnitCount = _initialUnitCount + count units _x} forEach _groups;
private _threshold = _initialUnitCount * 0.3;

while {true} do {
    sleep 10;

    private _allThreats = units opfor + units independent inAreaArray _area;
    private _current = {lifeState _x in ["HEALTHY", "INJURED"]} count _allThreats;

    if (_current <= _threshold) exitWith {
        private _message = "$STR_WHF_destroyRoadblock_success";
        [[blufor, "HQ"], _message] remoteExec ["WHF_fnc_localizedSideChat", blufor];
        [_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
    };
};

[_ruins] call WHF_fnc_queueGCDeletion;
[_objects] call WHF_fnc_queueGCDeletion;
[_terrain] call WHF_fnc_queueGCUnhide;
{[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
{[_x] call WHF_fnc_queueGCDeletion} forEach _vehicles;
