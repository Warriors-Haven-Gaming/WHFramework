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
            "simple": Create simple objects instead of regular objects.

Returns:
    Array

Author:
    thegamecracks

*/
params ["_composition", "_center", "_direction", ["_flags", ["normal"]]];

private _rotateFromCenter = {
    params ["_pos", "_dir"];
    [
         cos _dir * _pos # 0 + sin _dir * _pos # 1,
        -sin _dir * _pos # 0 + cos _dir * _pos # 1,
        _pos # 2
    ]
};

private _frozen = "frozen" in _flags;
private _normal = "normal" in _flags;
private _simple = "simple" in _flags;

_composition apply {
    _x params ["_type", "_pos", "_dir"];

    _pos = [_pos, _direction] call _rotateFromCenter vectorAdd _center;

    private _obj = switch (true) do {
        case (_simple): {createSimpleObject [_type, AGLToASL _pos]};
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

    _obj
}
