/*
Function: WHF_fnc_attackLoop

Description:
    Given an array of groups, periodically clear their waypoints and assign them
    Seek and Destroy waypoints to nearby threats.

    Groups will be skipped if:
        1. their first waypoint is neither a Move or SAD waypoint, or;
        2. their leader has pathfinding disabled.

    The caller can append new groups to the array at a later time. However,
    this function automatically terminates itself once all current groups
    are killed.

    Function must be ran in scheduled environment.

Parameters:
    Array inputGroups:
        An array of groups to assign waypoints to.
    Array | Nothing area:
        (Optional, default nil)
        If provided, units will only consider targets within the given area.
        Should be in a format suitable for inArea.

Author:
    thegamecracks

*/
params ["_inputGroups", "_area"];

sleep (20 + random 20);
private _groups = [_inputGroups] call WHF_fnc_coerceGroups;
while {_groups findIf {units _x findIf {alive _x} >= 0} >= 0} do {
    {
        private _leader = leader _x;
        if (!alive _leader) then {continue};
        if (!local _leader) then {continue};
        if !(_leader checkAIFeature "PATH") then {continue};

        private _leadVehicle = objectParent _leader;
        if (!isNull _leadVehicle && {!canFire _leadVehicle}) then {continue};

        private _waypoints = waypoints _x;
        if (
            count _waypoints > 0
            && {!(waypointType (_waypoints # 0) in ["MOVE", "SAD"])}
        ) then {continue};

        private _targets =
            _leader targetsQuery [objNull, blufor, "", [], 180]
            select {
                _x # 2 isEqualTo blufor
                && {isNil "_area"
                || {_x # 4 vectorMultiply [1,1,0] inArea _area}}
            };

        sleep 0.125;
        if (count _targets < 1) then {continue};

        {deleteWaypoint _x} forEachReversed _waypoints;
        _targets # 0 params ["", "", "", "", "_position"];
        private _waypoint = _x addWaypoint [_position vectorMultiply [1,1,0], 50];
        _waypoint setWaypointType "SAD";
        _waypoint setWaypointCompletionRadius 20;

        if (combatBehaviour _x isEqualTo "SAFE") then {_x setBehaviourStrong "AWARE"};
        _x setSpeedMode "FULL";
    } forEach _groups;

    _groups = [_inputGroups] call WHF_fnc_coerceGroups;
    sleep (20 + random 20);
};
