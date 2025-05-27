/*
Function: WHF_fnc_queueGCDeletion

Description:
    Schedules an array of objects to be deleted discreetly.

Parameters:
    Array objects:
        The array of objects to be deleted. The first object is used
        as the center to determine if players are present.
    Number minDistance:
        (Optional, default WHF_gcDeletionDistance)
        The first object's minimum distance to other players before
        objects can be deleted.

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
params ["_objects", ["_minDistance", WHF_gcDeletionDistance]];
if !(_objects isEqualType []) then {_objects = [_objects]};
WHF_gcDeletionQueue pushBack [_objects, _minDistance];
