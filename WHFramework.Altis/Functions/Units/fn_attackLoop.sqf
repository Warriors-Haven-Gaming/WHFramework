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

    Function must be executed in scheduled environment.

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
        if (!simulationEnabled _leader) then {continue};
        if !(_leader checkAIFeature "PATH") then {continue};

        private _leadVehicle = objectParent _leader;
        if (!isNull _leadVehicle && {!canFire _leadVehicle}) then {continue};
        if (_leadVehicle isKindOf "Ship") then {continue};

        private _waypoints = waypoints _x;
        if (
            count _waypoints > 0
            && {!(waypointType (_waypoints # 0) in ["MOVE", "SAD"])}
        ) then {continue};

        private _targets =
            _leader targets [true, 0, [], 180]
            apply {_leader targetKnowledge _x}
            select {_x # 4 isNotEqualTo sideUnknown}
            apply {_x # 6 vectorMultiply [1,1,0]};
        if (!isNil "_area") then {_targets = _targets inAreaArray _area};

        if (count _targets < 1) then {sleep 0.125; continue};

        [_x] call WHF_fnc_clearWaypoints;
        private _position = [_leader, _targets] call WHF_fnc_nearestPosition;
        private _waypoint = _x addWaypoint [_position, 50];
        _waypoint setWaypointType "SAD";
        _waypoint setWaypointCompletionRadius 20;

        if (combatBehaviour _x isEqualTo "SAFE") then {_x setBehaviourStrong "AWARE"};
        _x setSpeedMode "FULL";
    } forEach _groups;

    _groups = [_inputGroups] call WHF_fnc_coerceGroups;
    sleep (20 + random 20);
};
