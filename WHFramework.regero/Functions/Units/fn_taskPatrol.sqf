/*
Function: WHF_fnc_taskPatrol

Description:
    Create a random patrol around a given position.
    Unlike BIS_fnc_taskPatrol, this function does not set the group's
    behaviour, formation, or speed.

Parameters:
    Group group:
        The group to add waypoints to.
    PositionASL center:
        The position to base the patrol around.
    Number distance:
        The maximum distance between waypoints.

Author:
    thegamecracks, adapted from Joris-Jan van 't Land

*/
params ["_group", "_center", "_distance"];

private _lastPos = _center;
for "_i" from 0 to 2 + floor random 3 do {
    private _pos = [_lastPos, 50, _distance, 1, 0, 0, 0, [], [[0,0], [0,0]]] call BIS_fnc_findSafePos;
    if (_pos isEqualTo [0,0]) then {break};
    _lastPos = _pos;

    private _waypoint = _group addWaypoint [_pos, 0];
    _waypoint setWaypointType "MOVE";
    _waypoint setWaypointCompletionRadius 20;
};

if (_lastPos isEqualTo _center) exitWith {};
private _waypoint = _group addWaypoint [_center, -1];
_waypoint setWaypointType "CYCLE";
_waypoint setWaypointCompletionRadius 20;
