/*
Function: WHF_fnc_setPhysicsCollisions

Description:
    Enable/disable collisions on an array of objects.
    Function should be remote executed on server and all clients.
    This supports JIP execution, and will automatically remove itself
    from JIP queue if all objects are deleted.

Parameters:
    Array objects:
        An array of objects to set collisions on.
    Boolean flag:
        Whether to enable or disable collisions.

Author:
    thegamecracks

*/
params ["_objects", "_flag"];
_objects = _objects select {!isNull _x};
if (count _objects < 1) exitWith {
    if (isRemoteExecutedJIP) then {remoteExec ["", remoteExecutedJIPID]};
};
{_x setPhysicsCollisionFlag _flag} forEach _objects;
