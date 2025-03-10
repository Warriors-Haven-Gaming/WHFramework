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
        An array of emplacement types with weights to select from.
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

private _availableCompositions = [];
for "_i" from 0 to count _types - 1 step 2 do {
    private _type = _types # _i;
    private _weight = _types # (_i + 1);
    private _comps = WHF_emplacements get _type;
    if (isNil "_comps") then {continue};
    {_availableCompositions append [_x, _weight]} forEach _comps;
};

private _compositions = [];
for "_i" from 1 to _quantity do {
    _compositions pushBack selectRandomWeighted _availableCompositions;
};

private _isPosSuitable = {
    params ["_pos", "_clearRadius"];
    _pos nearRoads _clearRadius isEqualTo []
    && {_pos isFlatEmpty [-1, -1, 1, 20] isNotEqualTo []}
};

private _createGunners = {
    // params ["_turrets", "_side"];
    private _turrets = _turrets select {alive _x && {count allTurrets _x > 0}};
    private _group = [_side, "standard", count _turrets, [random -500, random -500, 0], 0, false] call WHF_fnc_spawnUnits;
    {
        private _turret = _turrets # _forEachIndex;
        _group addVehicle _turret;
        _x moveInGunner _turret;
    } forEach units _group;

    call _initTurrets;
    call _registerArtillery;
    _group
};

private _initTurrets = {
    // params ["_turrets", "_side"];
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
    // params ["_turrets", "_group"];
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

    _x params ["_buildings", "_turrets"];

    private _terrain = nearestTerrainObjects [_pos, [], _clearRadius, false];
    {hideObjectGlobal _x} forEach _terrain;

    private _objects = [];
    private _direction = random 360;
    _buildings = [_buildings, _pos, _direction, ["normal", "path", "simple"], _ruins] call WHF_fnc_objectsMapper;
    _turrets = [_turrets, _pos, _direction, ["normal"], _ruins] call WHF_fnc_objectsMapper;
    _objects append _buildings;
    _objects append _turrets;

    if (count _turrets > 0) then {
        private _group = call _createGunners;
        _compositionGroups pushBack _group;
    };

    _compositionObjects pushBack _objects;
    _compositionTerrain pushBack _terrain;
} forEach _compositions;

[_compositionObjects, _compositionTerrain, _compositionGroups]
