/*
Function: WHF_fnc_ungarrisonLoop

Description:
    Given an array of groups, periodically ungarrison their units when there
    are nearby threats.

    Units will be skipped if their pathfinding is already enabled.

    The caller can append new groups to the array at a later time. However,
    this function automatically terminates itself once all current groups
    are killed.

    Function must be ran in scheduled environment.

Parameters:
    Array inputGroups:
        An array of groups to ungarrison.
    Array | Nothing outputGroups:
        (Optional, default nil)
        If an array is passed, newly created groups for ungarrisoned units
        will be appended to this array.

Author:
    thegamecracks

*/
params ["_inputGroups", "_outputGroups"];

sleep (5 + random 10);
private _groups = [_inputGroups] call WHF_fnc_coerceGroups;
while {_groups findIf {units _x findIf {alive _x} >= 0} >= 0} do {
    {
        {
            if (!alive _x) then {continue};
            if (!local _x) then {continue};
            if (_x checkAIFeature "PATH") then {continue};

            private _targets = _x targets [true, 100, [], 180];
            sleep 0.125;
            if (count _targets < 1) then {continue};

            private _target = selectRandom _targets;
            private _position = _x getHideFrom _target;

            _x setUnitPos "AUTO";
            _x enableAIFeature ["COVER", true];
            _x enableAIFeature ["PATH", true];

            private _group = createGroup side group _x;
            _group setVariable ["WHF_siren_disabled", true];
            [_x] joinSilent _group;

            _group allowFleeing 0;
            _group setSpeedMode "FULL";

            private _waypoint = _group addWaypoint [_position vectorMultiply [1,1,0], 0];
            _waypoint setWaypointType "SAD";
            _waypoint setWaypointCompletionRadius 5;

            if (!isNil "_outputGroups") then {_outputGroups pushBack _group};
        } forEach units _x;
    } forEach _groups;

    _groups = [_inputGroups] call WHF_fnc_coerceGroups;
    sleep (5 + random 10);
};
