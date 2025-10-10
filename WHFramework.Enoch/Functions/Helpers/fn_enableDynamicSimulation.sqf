/*
Function: WHF_fnc_enableDynamicSimulation

Description:
    Toggle dynamic simulation on one or more groups or objects.
    If executed client-side, this function automatically remote executes
    itself on the server in scheduled environment.

Parameters:
    Array | Group | Object objects:
        A group, object, or an array of groups/objects.
    Boolean enabled:
        Whether dynamic simulation should be enabled or disabled.
    Number delay:
        (Optional, default 0)
        An optional delay to wait before changing dynamic simulation.
        Function must be executed in scheduled environment.

Author:
    thegamecracks

*/
params ["_objects", "_enabled", ["_delay", 0]];
if (!isServer) exitWith {_this remoteExec [_fnc_scriptName, 2]};
if !(_objects isEqualType []) then {_objects = [_objects]};
if (_delay > 0) then {sleep _delay};
{_x enableDynamicSimulation _enabled} forEach _objects;
