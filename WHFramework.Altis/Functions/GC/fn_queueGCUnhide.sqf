/*
Function: WHF_fnc_queueGCUnhide

Description:
    Schedules an array of objects to be unhidden discreetly.

Parameters:
    Array objects:
        The array of objects to be unhidden. The first object is used
        as the center to determine if players are present.
    Number minDistance:
        (Optional, default WHF_gcUnhideDistance)
        The first object's minimum distance to other players before
        objects can be unhidden.

Examples:
    (begin example)
        [[_tree1, _tree2]] call WHF_fnc_queueGCUnhide;
    (end)
    (begin example)
        [[_tree1, _tree2], 1000] call WHF_fnc_queueGCUnhide;
    (end)

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
params ["_objects", ["_minDistance", WHF_gcUnhideDistance]];
if !(_objects isEqualType []) then {_objects = [_objects]};
WHF_gcUnhideQueue pushBack [_objects, _minDistance];
