/*
Function: WHF_fnc_msnMainAnnexRegionComms

Description:
    Players must disable the communications station.
    Function must be ran in scheduled environment.

Parameters:
    Position2D center:
        The center of the mission.
    Number radius:
        The radius of the mission.
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
params ["_center", "_radius", "_parent", "_objects", "_terrain", "_groups"];

private _isPosSuitable = {
    params ["_pos"];
    _pos isFlatEmpty [-1, -1, 1, 20] isNotEqualTo []
};

private _pos = [_center, [30, _radius], [0, _isPosSuitable]] call WHF_fnc_randomPos;
if (_pos isEqualTo [0,0]) exitWith {};

private _posTerrain = nearestTerrainObjects [_pos, [], 25, false];
{hideObjectGlobal _x} forEach _posTerrain;
_terrain pushBack _posTerrain;

private _props = [["Land_Cargo_House_V4_F",[-2.09961,1.59961,0],0],["Land_SurvivalRadio_F",[-4.59961,2.09961,1.47975],45],["Land_BagFence_01_round_green_F",[1.90039,-2.40039,0],90],["Land_PCSet_01_screen_F",[-2.89453,1.93848,1.48],180],["Land_PCSet_01_keyboard_F",[-2.85938,2.3252,1.48],180],["Land_PCSet_01_mouse_F",[-3.16992,2.33887,1.48],180],["Land_PortableDesk_01_olive_F",[-3.59961,2.09961,0.592812],0],["Land_DeskChair_01_olive_F",[-3.09961,3.09961,0.592812],0],["Land_Printer_01_F",[-3.59961,2.09961,1.489],180],["Land_PCSet_01_case_F",[-4.09961,2.09961,0.593],180],["Land_BagFence_01_round_green_F",[4.99805,-0.729492,0],180],["Land_CampingTable_F",[-2.09961,5.09961,0.729],0],["OmniDirectionalAntenna_01_black_F",[-0.0361328,2.5459,3.118],0],["PowerCable_01_StraightLong_F",[-5.59961,-1.90039,0],150],["Land_BagFence_01_round_green_F",[3.40039,5.09961,0],45],["Land_BagFence_01_round_green_F",[4.99805,-3.55762,0],3.41509e-05],["Land_Camping_Light_F",[-2.91699,5.29492,1.545],0],["SatelliteAntenna_01_Mounted_Black_F",[0.900391,5.59961,1.78],90],["Land_BagFence_01_round_green_F",[6.41211,-2.14355,0],270],["Land_PowerGenerator_F",[-7.09961,1.09961,0],0],["Land_BagFence_01_round_green_F",[6.40039,6.09961,0],315],["Land_BackAlley_01_l_gate_F",[8.31836,2.65625,0],90],["land_netfence_03_m_9m_f",[4.26074,-7.82617,0],180],["land_netfence_03_m_9m_f",[8.40039,-3.40039,0],90],["land_netfence_03_m_9m_f",[-4.59961,-7.90039,0],180],["Land_BagFence_01_round_green_F",[4.40039,8.09961,0],135],["land_netfence_03_m_9m_f",[-9.02539,-3.76074,0],270],["land_netfence_03_m_3m_f",[8.40039,5.59961,0],90],["Land_BagFence_01_round_green_F",[6.40039,8.09961,0],225],["land_netfence_03_m_9m_f",[3.90039,9.59961,0],0],["land_netfence_03_m_9m_f",[-9.09961,5.09961,0],270],["land_netfence_03_m_9m_f",[-4.95996,9.52539,0],0],["land_netfence_03_m_3m_f",[8.43066,8.5625,0],90],["Land_DragonsTeeth_01_4x2_new_redwhite_F",[11.9004,-5.40039,0],90],["Land_DragonsTeeth_01_4x2_new_redwhite_F",[4.40039,-12.4004,0],0],["Land_DragonsTeeth_01_4x2_new_redwhite_F",[4.40039,13.0996,0],0],["Land_DragonsTeeth_01_4x2_new_redwhite_F",[-6.59961,-12.4004,0],0],["Land_DragonsTeeth_01_4x2_new_redwhite_F",[-6.59961,13.0996,0],0],["Land_DragonsTeeth_01_4x2_new_redwhite_F",[-14.0996,5.09961,0],90],["Land_DragonsTeeth_01_4x2_new_redwhite_F",[-14.0996,-5.90039,0],90],["Land_DragonsTeeth_01_4x2_new_redwhite_F",[12.8867,9.19043,0],90]];
private _tower = [["RuggedTerminal_01_communications_hub_F",[-0.0996094,-5.40039,0],0]];
private _intel = [["Land_PortableServer_01_black_F",[-4,5,0.729],0],["Land_PortableServer_01_black_F",[-4,5,1.076],0],["Land_PortableServer_01_black_F",[0,5,0.729],0],["Land_PortableServer_01_black_F",[0,5,1.076],0]];
if (_props findIf {!isClass (configFile >> "CfgVehicles" >> _x # 0)} >= 0) exitWith {};

private _dir = random 360;
_props = [_props, _pos, _dir, ["normal", "path", "simple"], _objects] call WHF_fnc_objectsMapper;
_tower = [_tower, _pos, _dir, ["frozen", "normal"], _objects] call WHF_fnc_objectsMapper;
_intel = [_intel, _pos, _dir, ["frozen", "normal"], _objects] call WHF_fnc_objectsMapper;
_objects pushBack (_props + _tower + _intel);

private _building = _props # 0;
private _group = [opfor, "officer", 1, _pos, 0] call WHF_fnc_spawnUnits;
private _officer = leader _group;
_groups pushBack _group;
[_group, [_building]] call WHF_fnc_garrisonBuildings;

private _towerFunction = "WHF_fnc_msnMainAnnexRegionCommsTower";
{_x remoteExec [_towerFunction, WHF_globalPlayerTarget, _x]} forEach _tower;
{_x remoteExec ["WHF_fnc_addIntelAction", WHF_globalPlayerTarget, _x]} forEach _intel;
[_officer, "variable"] remoteExec ["WHF_fnc_addIntelAction", WHF_globalPlayerTarget, _officer];

private _taskID = [
    blufor,
    ["", _parent],
    "mainAnnexRegionComms",
    _pos getPos [40 + random 40, random 360],
    "CREATED",
    -1,
    false,
    "documents"
] call WHF_fnc_taskCreate;

private _radio = _props # 1;
private _radioScript = _radio spawn {
    while {!isNull _this} do {
        private _sound = selectRandom [
            "a3\sounds_f\sfx\ui\uav\uav_01.wss",
            "a3\sounds_f\sfx\ui\uav\uav_02.wss",
            "a3\sounds_f\sfx\ui\uav\uav_03.wss",
            "a3\sounds_f\sfx\ui\uav\uav_04.wss",
            "a3\sounds_f\sfx\ui\uav\uav_05.wss",
            "a3\sounds_f\sfx\ui\uav\uav_06.wss",
            "a3\sounds_f\sfx\ui\uav\uav_07.wss",
            "a3\sounds_f\sfx\ui\uav\uav_08.wss",
            "a3\sounds_f\sfx\ui\uav\uav_09.wss"
        ];
        playSound3D [_sound, _this, false, getPosASL _this, 2, 1, 50, 1.5];
        sleep (15 + random 10);
    }
};

while {true} do {
    sleep 3;
    private _towerDisabled = _tower findIf {
        !isNull _x
        && {!(_x getVariable ["WHF_comms_disabled", false])}
    } < 0;
    if (_towerDisabled) then {terminate _radioScript} else {continue};
    if (_intel findIf {!isNull _x} >= 0) then {continue};
    if (!isNull _officer && {!(_officer getVariable ["WHF_intel_collected", false])}) then {continue};
    break;
};
[_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
