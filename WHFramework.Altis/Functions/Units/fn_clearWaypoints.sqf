/*
Function: WHF_fnc_clearWaypoints

Description:
    Clear waypoints from a group.
    Function must be executed in scheduled environment.

Parameters:
    Group group:
        The group to clear waypoints.

Author:
    thegamecracks

*/
params ["_group"];
[_group, currentWaypoint _group] setWaypointPosition [getPosASL leader _group, -1];
sleep 0.1;
{deleteWaypoint _x} forEachReversed waypoints _group;
