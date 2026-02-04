/*
Function: WHF_fnc_msnMainAnnexRegionCompositions

Description:
    Generate compositions within the mission area.

Parameters:
    Position2D center:
        The center of the mission area.
    Number radius:
        The radius of the mission area.
    String faction:
        The faction to spawn units from.

Returns:
    Array
        An array containing three elements:
            1. A nested array of objects that were created.
            2. A nested array of terrain objects that were hidden.
            3. An array of groups that were created.

Author:
    thegamecracks

*/
params ["_center", "_radius", "_faction"];

private _standard = ["standard", _faction];

private _objects = [];
private _terrain = [];
private _groups = [];

private _fortCount = floor (_radius / 20 * WHF_missions_annex_forts);
private _fortTypes = ["camp", 0.5, "outpost", 0.4, "tower", 0.1];
[opfor, [_standard], _fortCount, _center, _radius, _fortTypes, _objects]
    call WHF_fnc_createEmplacements
    params ["_fortObjects", "_fortTerrain", "_fortGroups"];
_objects append _fortObjects;
_terrain append _fortTerrain;
_groups append _fortGroups;

private _mortarCount = floor (_radius / 350);
private _mortarTypes = ["mortar", 1];
[opfor, [_standard], _mortarCount, _center, _radius, _mortarTypes, _objects]
    call WHF_fnc_createEmplacements
    params ["_mortarObjects", "_mortarTerrain", "_mortarGroups"];
_objects append _mortarObjects;
_terrain append _mortarTerrain;
_groups append _mortarGroups;

private _aaCount = floor (_radius / 400);
private _aaTypes = ["aa_short", 4, "aa_medium", 1];
[opfor, [_standard], _aaCount, _center, _radius, _aaTypes, _objects]
    call WHF_fnc_createEmplacements
    params ["_aaObjects", "_aaTerrain", "_aaGroups"];
_objects append _aaObjects;
_terrain append _aaTerrain;
_groups append _aaGroups;

// NOTE: little bit slow, 0.1ms for 500m radius
private _roads = _center nearRoads _radius apply {getRoadInfo _x} select {
    _x # 0 in ["ROAD", "MAIN ROAD", "TRACK"] && {!(_x # 2)}
};
private _roadblockCount = floor (count _roads / 30 * WHF_missions_annex_vehicles);
[opfor, [_standard], _roadblockCount, _roads, _center] call WHF_fnc_createRoadblocks
    params ["_roadblockObjects", "_roadblockTerrain", "_roadblockGroups"];
_objects append _roadblockObjects;
_terrain append _roadblockTerrain;
_groups append _roadblockGroups;

private _minefieldSpacing = 100 + random 200;
private _minefieldStep = 360 / ceil (2 * pi * _radius / _minefieldSpacing);
for "_i" from 0 to 359 step _minefieldStep do {
    private _distance = _radius * (0.4 + random 0.55);
    private _dir = _i + random _minefieldStep - _minefieldStep / 2;
    private _pos = _center getPos [_distance, _dir];
    private _size = 35 + random 25;
    private _quantity = floor (_size * 0.2);
    private _isNearRoad = _pos nearRoads _size isNotEqualTo [];
    private _type = ["AP", "ATAP"] select _isNearRoad;
    private _mines = [opfor, _quantity, _pos, _size, _type, true] call WHF_fnc_createMinefield;
    _objects pushBack _mines;
};

[_objects, _terrain, _groups]
