/*
Function: WHF_fnc_queueGCDeletion

Description:
    Schedules an array of objects to be deleted discreetly.

Parameters:
    Array objects:
        The array of objects to be deleted. The first object is used
        as the center to determine if players are present.
    Number minDistance:
        (Optional, default -1)
        The first object's minimum distance to other players before
        objects can be deleted. If negative, the deletion distance
        setting is used.

Examples:
    (begin example)
        [[_object1, _object2]] call WHF_fnc_queueGCDeletion;
    (end)
    (begin example)
        [[_object1, _object2], 1000] call WHF_fnc_queueGCDeletion;
    (end)

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
params ["_objects", ["_minDistance", -1]];
if !(_objects isEqualType []) then {_objects = [_objects]};
if (_minDistance < 0) then {_minDistance = WHF_gcDeletionDistance};
WHF_gcDeletionQueue pushBack [_objects, _minDistance];
