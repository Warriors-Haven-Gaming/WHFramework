/*
Function: WHF_fnc_createEmplacements

Description:
    Create random emplacements in a given area.

Parameters:
    Side side:
        The emplacement groups' side.
    Array unitTypes:
        One or more group types to spawn units from.
        See WHF_fnc_getUnitTypes for allowed values.
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
            "arty"
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
params ["_side", "_unitTypes", "_quantity", "_center", "_radius", "_types", ["_ruins", -1]];

private _availableCompositions = [];
for "_i" from 0 to count _types - 1 step 2 do {
    private _type = _types # _i;
    private _weight = _types # (_i + 1);
    private _comps = WHF_emplacements get _type;
    if (isNil "_comps") then {continue};
    {_availableCompositions append [_x, _weight]} forEach _comps;
};
if (count _availableCompositions < 2) exitWith {[[], [], []]};

private _compositions = [];
for "_i" from 1 to _quantity do {
    _compositions pushBack selectRandomWeighted _availableCompositions;
};

private _isPosSuitable = {
    params ["_pos", "_clearRadius"];
    _pos nearRoads _clearRadius isEqualTo []
    && {_pos isFlatEmpty [-1, -1, 0.5, 20] isNotEqualTo []}
};

private _clearRadius = 20;
private _compositionObjects = [];
private _compositionTerrain = [];
private _compositionGroups = [];
{
    private _compData = _x;

    private _pos = [_center, [30, _radius], [_clearRadius, _isPosSuitable]] call WHF_fnc_randomPos;
    if (_pos isEqualTo [0,0]) then {break};
    _pos = _pos vectorAdd [0,0,0];

    private _terrain = nearestTerrainObjects [_pos, [], _clearRadius, false, true];
    {hideObjectGlobal _x; _x allowDamage false} forEach _terrain;

    private _objects = [];
    private _direction = random 360;
    {
        _x params ["_flags", "_parts"];
        _parts = [_parts, _pos, _direction, _flags, _ruins] call WHF_fnc_objectsMapper;
        _objects append _parts;
    } forEach _compData;

    private _group = [_side, _unitTypes, _objects] call WHF_fnc_spawnGunners;
    if (_group isNotEqualTo grpNull) then {_compositionGroups pushBack _group};

    _compositionObjects pushBack _objects;
    _compositionTerrain pushBack _terrain;
} forEach _compositions;

[_compositionObjects, _compositionTerrain, _compositionGroups]
