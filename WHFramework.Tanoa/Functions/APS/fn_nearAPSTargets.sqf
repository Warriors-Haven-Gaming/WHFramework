/*
Function: WHF_fnc_nearAPSTargets

Description:
    Return an array of all projectiles near a position that can be intercepted.
    Results are not sorted by distance. Only projectiles local to the client
    are returned.

Parameters:
    Object vehicle:
        The vehicle to return projectiles around.
    Number radius:
        The maximum distance from the center.

Returns:
    Array

Author:
    thegamecracks

*/
params ["_vehicle", "_radius"];
private _ret = [];
{
    private _projectiles =
        _vehicle nearObjects [_x, _radius]
        select {local _x}
        select {getShotParents _x # 0 isNotEqualTo _vehicle};
    _ret append _projectiles;
} forEach ["RocketCore", "MissileCore", "SubmunitionCore", "ammo_Penetrator_Base"];
// Have fun with these:
// - "BombCore"
// - "BulletCore"
// - "GrenadeCore"
// - "ShellCore"
_ret
