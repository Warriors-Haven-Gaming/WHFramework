/*
Function: WHF_fnc_nearAPSTargets

Description:
    Return an array of all projectiles near a position that can be intercepted.
    Results are not sorted by distance. Only projectiles local to the client
    are returned.

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
    private _projectiles = _position nearObjects [_x, _radius];
    {if (local _x) then {_ret pushBack _x}} forEach _projectiles;
} forEach ["RocketCore", "MissileCore", "SubmunitionCore", "ammo_Penetrator_Base"];
// Have fun with these:
// - "BombCore"
// - "BulletCore"
// - "GrenadeCore"
// - "ShellCore"
_ret
