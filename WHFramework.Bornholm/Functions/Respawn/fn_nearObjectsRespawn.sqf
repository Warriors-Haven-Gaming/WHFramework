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
private _exceptions = ["Animal", "ThingEffect", "WeaponHolder", "WeaponHolderSimulated"];
private _objects = ASLToAGL ATLToASL _pos nearObjects ["All", _radius];
_objects = _objects select {
    private _obj = _x;
    switch (true) do {
        case (boundingBoxReal [_obj, "Geometry"] select 2 <= 0): {false};
        case (_exceptions findIf {_obj isKindOf _x} >= 0): {false};
        case (_obj isKindOf "Man"): {alive _obj || {isAwake _obj}};
        default {true};
    }
};
_objects = _objects - _ignore;
_objects
