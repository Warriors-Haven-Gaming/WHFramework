/*
Function: WHF_fnc_queueGCUnhide

Description:
    Schedules an array of objects to be unhidden discreetly.

Parameters:
    Array objects:
        The array of objects to be unhidden. The first object is used
        as the center to determine if players are present.
    Number minDistance:
        (Optional, default -1)
        The first object's minimum distance to other players before
        objects can be unhidden. If negative, the unhide distance
        setting is used.
    Number delay:
        (Optional, default 0)
        The duration to wait before objects can be deleted.

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
params ["_objects", ["_minDistance", -1], ["_delay", 0]];
if !(_objects isEqualType []) then {_objects = [_objects]};
if (_minDistance < 0) then {_minDistance = WHF_gcUnhideDistance};
WHF_gcUnhideQueue pushBack [_objects, _minDistance, time + _delay];
