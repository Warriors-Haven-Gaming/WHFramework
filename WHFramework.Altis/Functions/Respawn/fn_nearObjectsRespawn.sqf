/*
Function: WHF_fnc_nearObjectsRespawn

Description:
    Return an array of objects near a respawn position.

Parameters:
    PositionATL pos:
        The position to find objects around.
    Number radius:
        The radius to search around for objects.
    Array ignore:
        (Optional, default [])
        An array of objects to ignore, such as the vehicle being registered for respawn.

Author:
    thegamecracks

*/
params ["_pos", "_radius", ["_ignore", []]];
private _objects = _pos nearObjects ["All", _radius];
_objects = _objects select {
    private _obj = _x;
    boundingBoxReal [_obj, "Geometry"] select 2 > 0
    && {["Animal", "WeaponHolder", "WeaponHolderSimulated"] findIf {_obj isKindOf _x} < 0}
};
_objects = _objects - _ignore;
_objects
