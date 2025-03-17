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
            "ASL": Use Z heights as offset from the center without considering
                   terrain height. Useful for objects in the air.
            "frozen": Disable object damage and simulation.
            "normal": Orient objects to match the surface of the terrain under them.
            "path": When combined with "simple", don't create simple objects for
                    types that allow AI pathfinding, or has an openable door.
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
if (count _composition < 1) exitWith {[]};

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
    // params ["_type"];
    private _lods = allLODs getText (_config >> "model");
    private _pathsIndex = _lods findIf {_x # 2 isEqualTo 4e+15};
    if (_pathsIndex < 0) then {0} else {_lods # _pathsIndex # 3}
};

private _isStatic = {
    // params ["_type"];
    if (isNil "WHF_objectsMapper_static") then {WHF_objectsMapper_static = createHashMap};
    private _cached = WHF_objectsMapper_static get toLowerANSI _type;
    if (!isNil "_cached") exitWith {_cached};

    private _config = configFile >> "CfgVehicles" >> _type;
    private _ret = call {
        if (call _countPathLODs > 0) exitWith {false};

        private _actions = "true" configClasses (_config >> "UserActions");
        private _keywords = ["door", "gate"];
        if (
            _actions findIf {
                private _name = configName _x;
                _keywords findIf {_x in toLowerANSI _name} >= 0
            } >= 0
        ) exitWith {false};

        true
    };

    WHF_objectsMapper_static set [toLowerANSI _type, _ret];
    _ret
};

private _ASL = "ASL" in _flags;
private _frozen = "frozen" in _flags;
private _normal = "normal" in _flags;
private _path = "path" in _flags;
private _simple = "simple" in _flags;

if (_ASL) then {_center = ATLToASL _center};

private _objects = _composition apply {
    _x params ["_type", "_pos", "_dir"];

    _pos = call _rotateFromCenter vectorAdd _center;

    private _randPos = [-random 500, -random 500, 500];
    private _obj = switch (true) do {
        case (_simple && {!_path || {call _isStatic}}): {
            createSimpleObject [_type, _randPos]
        };
        case (_frozen): {
            private _obj = createVehicle [_type, _randPos, [], 0, "NONE"];
            _obj allowDamage false;
            _obj enableSimulationGlobal false;
            _obj
        };
        default {createVehicle [_type, _randPos, [], 0, "NONE"]};
    };

    _obj setDir (_dir + _direction);
    if (_normal) then {_obj setVectorUp surfaceNormal _pos};
    if (_ASL) then {_obj setPosASL _pos} else {_obj setPosATL _pos};

    if (_ruins isEqualType [] && {!isSimpleObject _obj && {_obj isKindOf "Building"}}) then {
        _obj setVariable ["WHF_ruins", _ruins];
    };

    _obj
};

private _index = _objects findIf {!isNull _x};
if (_index >= 0) then {
    if (isNil "WHF_usedPositions") then {WHF_usedPositions = []};
    private _obj = _objects # _index;
    WHF_usedPositions pushBack _obj;
};

_objects
