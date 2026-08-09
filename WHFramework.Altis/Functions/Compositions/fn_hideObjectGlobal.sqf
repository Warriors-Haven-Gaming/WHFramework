/*
Function: WHF_fnc_hideObjectGlobal

Description:
    Hide one or more objects globally.
    Must be executed on server or a headless client.

Parameters:
    Array | Object objects:
        An object or array of objects.
    Boolean hidden:
        Whether the objects should be hidden or not.

Author:
    thegamecracks

*/
params ["_objects", "_hidden"];
if (!isServer) exitWith {_this remoteExec [_fnc_scriptName, 2]};
if (isRemoteExecuted && {!(remoteExecutedOwner in [0, 2])}) exitWith {};
if !(_objects isEqualType []) then {_objects = [_objects]};

{
    _x hideObjectGlobal _hidden;

    // Prevent hidden objects from taking damage
    // FIXME: may be used on non-local objects not suitable for allowDamage
    // FIXME: may allow damage on an object with damage disabled before hiding
    _x allowDamage !_hidden;
} forEach _objects;
