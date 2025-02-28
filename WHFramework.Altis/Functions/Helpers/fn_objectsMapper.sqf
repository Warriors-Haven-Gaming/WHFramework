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
    Boolean normal:
        (Optional, default true)
        If true, orient objects to match the surface of the terrain under them.
    Boolean simple:
        (Optional, default false)
        If true, create simple objects instead of regular objects.

Returns:
    Array

Author:
    thegamecracks

*/
params ["_composition", "_center", "_direction", ["_normal", true], ["_simple", false]];

private _rotateFromCenter = {
    params ["_pos", "_dir"];
    [
         cos _dir * _pos # 0 + sin _dir * _pos # 1,
        -sin _dir * _pos # 0 + cos _dir * _pos # 1,
        _pos # 2
    ]
};

_composition apply {
    _x params ["_type", "_pos", "_dir"];

    _pos = [_pos, _direction] call _rotateFromCenter vectorAdd _center;

    private _obj = if (_simple) then {
        createSimpleObject [_type, AGLToASL _pos]
    } else {
        createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"]
    };

    _obj setDir (_dir + _direction);
    if (_normal) then {_obj setVectorUp surfaceNormal _pos};

    _obj
}
