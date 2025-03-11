/*
Function: WHF_fnc_createRoadblocks

Description:
    Create random roadblocks in a given area.

Parameters:
    Side side:
        The group's side.
    Number quantity:
        The number of roadblocks to spawn.
    PositionATL center:
        The position at which vehicles will spawn around.
    Number radius:
        The radius around the position at which vehicles will spawn around.

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

// TODO: full-fledged roadblock compositions
private _turretTypes = [
    "O_HMG_01_high_F",
    "O_HMG_02_high_F",
    "O_GMG_01_high_F",
    "B_T_static_AT_F",
    "O_HMG_02_high_F",
    "CUP_O_AGS_RUS_M_Summer",
    "CUP_O_KORD_high_RUS_M_Summer",
    "CUP_O_KORD_RUS_M_Summer",
    "CUP_O_Kornet_RUS_M_Summer",
    "CUP_O_Metis_RUS_M_Summer",
    "CUP_I_DSHKM_NAPA",
    "CUP_B_DSHkM_MiniTriPod_NAPA",
    "CUP_I_SPG9_NAPA"
] select {isClass (configFile >> "CfgVehicles" >> _x)};

// NOTE: little bit slow, 0.1ms for 500m radius
private _roads = _center nearRoads _radius apply {getRoadInfo _x} select {
    _x # 0 in ["ROAD", "MAIN ROAD", "TRACK"] && {!(_x # 2)}
};
_quantity = _quantity min count _roads;

private _selectedRoads = [];
private _turrets = [];
for "_i" from 1 to _quantity * 2 do {
    if (count _turrets >= _quantity) exitWith {};

    private _road = selectRandom _roads;
    if (_road in _selectedRoads) then {continue};

    private _type = selectRandom _turretTypes;
    private _offset = 0.5 + random 0.4;
    if (random 1 < 0.5) then {_offset = -_offset};
    private _pos = ASLToATL ([_road, random 1, _offset] call WHF_fnc_getRoadPos);
    _pos = _pos findEmptyPosition [0, 10, _type];
    if (_pos isEqualTo []) then {continue};

    private _dir = _road # 6 getDir _road # 7;
    private _dirAwayDiff = (_center getDir _pos) - _dir;
    if (abs _dirAwayDiff > 120) then {_dir = (_dir + 180) % 360};

    private _turret = createVehicle [_type, [-random 500, -random 500, 0], [], 0, "CAN_COLLIDE"];
    _turret setDir _dir;
    _turret setVectorUp surfaceNormal _pos;
    _turret setPosATL _pos;
    _turrets pushBack _turret;
};

private _group = [_side, _turrets] call WHF_fnc_spawnGunners;
[_turrets, [], [_group]]
