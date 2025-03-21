/*
Function: WHF_fnc_nearAPSTargets

Description:
    Return an array of all projectiles near a position that can be intercepted.
    Results are not sorted by distance.

Parameters:
    PositionAGL center:
        The position to return projectiles around.
    Number radius:
        The maximum distance from the center.

Returns:
    Array

Author:
    thegamecracks

*/
params ["_position", "_radius"];
private _ret = [];
{
    _ret append (_position nearObjects [_x, _radius]);
} forEach ["RocketCore", "MissileCore", "SubmunitionCore", "ammo_Penetrator_Base"];
_ret
