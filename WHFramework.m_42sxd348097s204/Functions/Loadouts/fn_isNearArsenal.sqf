/*
Function: WHF_fnc_isNearArsenal

Description:
    Check if the given position is near an arsenal.

Parameters:
    Position2D position:
        The position to check.
    Number radius:
        The max distance allowed from an arsenal.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_position", "_radius"];

private _objects = _position nearEntities _radius;
private _arsenalText = localize "$STR_A3_Arsenal";
_objects findIf {
    private _obj = _x;
    private _actionIDs = actionIDs _obj;
    _actionIDs findIf {_obj actionParams _x select 0 isEqualTo _arsenalText} >= 0
} >= 0
