/*
Function: WHF_fnc_objectsMapper

Description:
    Create and return objects using a composition from WHF_fnc_objectsGrabber.

Parameters:
    Array composition:
        The template to create objects from.
    PositionATL center:
        The center coordinates of the composition to create.
    Number direction:
        The direction that the composition should face.
    Array flags:
        (Optional, default ["normal"])
        An array containing any of the following flags:
            "frozen": Disable object damage and simulation.
            "normal": Orient objects to match the surface of the terrain under them.
            "path": When combined with "simple", don't create simple objects for
                    types that allow AI pathfinding.
            "simple": Create simple objects instead of regular objects.
    Array ruins:
        (Optional, default -1)
        An array to append ruins to when buildings change state.
        Useful for garbage collection.

Returns:
    Array

Author:
    thegamecracks

*/
params ["_composition", "_center", "_direction", ["_flags", ["normal"]], ["_ruins", -1]];

private _rotateFromCenter = {
    // params ["_pos", "_dir"];
    [
         cos _direction * _pos # 0 + sin _direction * _pos # 1,
        -sin _direction * _pos # 0 + cos _direction * _pos # 1,
        _pos # 2
    ]
};

private _countPathLODs = {
    // If there's a path LOD, the object can probably be garrisoned
    params ["_type"];

    if (isNil "WHF_objectsMapper_paths") then {WHF_objectsMapper_paths = createHashMap};
    private _nPaths = WHF_objectsMapper_paths get toLowerANSI _type;
    if (!isNil "_nPaths") exitWith {_nPaths};

    private _lods = allLODs getText (configFile >> "CfgVehicles" >> _type >> "model");
    private _pathsIndex = _lods findIf {_x # 2 isEqualTo 4e+15};
    _nPaths = if (_pathsIndex < 0) then {0} else {_lods # _pathsIndex # 3};

    WHF_objectsMapper_paths set [toLowerANSI _type, _nPaths];

    _nPaths
};

private _frozen = "frozen" in _flags;
private _normal = "normal" in _flags;
private _path = "path" in _flags;
private _simple = "simple" in _flags;

_composition apply {
    _x params ["_type", "_pos", "_dir"];

    _pos = call _rotateFromCenter vectorAdd _center;

    private _obj = switch (true) do {
        case (_simple && {!_path || {_type call _countPathLODs < 1}}): {
            createSimpleObject [_type, AGLToASL _pos]
        };
        case (_frozen): {
            private _obj = createVehicle [_type, [-random 500, -random 500, 500], [], 0, "NONE"];
            _obj allowDamage false;
            _obj enableSimulationGlobal false;
            _obj setPosATL _pos;
            _obj
        };
        default {createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"]};
    };

    _obj setDir (_dir + _direction);
    if (_normal) then {_obj setVectorUp surfaceNormal _pos};

    if (_ruins isEqualType [] && {!isSimpleObject _obj && {_obj isKindOf "Building"}}) then {
        _obj setVariable ["WHF_ruins", _ruins];
    };

    _obj
}
