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
            if (!simulationEnabled _x) then {continue};
            if (_x checkAIFeature "PATH") then {continue};

            private _targets = _x targets [true, 100, [], 180];
            sleep 0.125;
            if (count _targets < 1) then {continue};

            private _target = selectRandom _targets;
            private _position = _x getHideFrom _target;

            _x setUnitPos "AUTO";
            _x enableAIFeature ["COVER", true];
            _x enableAIFeature ["PATH", true];

            private _dynamicSimulation = dynamicSimulationEnabled group _x;
            private _lasersOn = _x isIRLaserOn currentWeapon _x;
            private _lightsOn = _x isFlashlightOn currentWeapon _x;

            private _group = createGroup [side group _x, true];
            _group setVariable ["WHF_siren_disabled", true];
            [_x] joinSilent _group;

            _group allowFleeing 0;
            _group setBehaviourStrong "AWARE";
            _group setSpeedMode "FULL";
            _group enableIRLasers _lasersOn;
            _group enableGunLights (["Auto", "ForceOn"] select _lightsOn);

            private _waypoint = _group addWaypoint [_position vectorMultiply [1,1,0], 5];
            _waypoint setWaypointType "SAD";
            _waypoint setWaypointCompletionRadius 5;

            if (_dynamicSimulation) then {_group spawn {
                sleep 1;
                [_this, true] remoteExec ["enableDynamicSimulation"];
            }};

            if (!isNil "_outputGroups") then {_outputGroups pushBack _group};
        } forEach units _x;
    } forEach _groups;

    _groups = [_inputGroups] call WHF_fnc_coerceGroups;
    sleep (5 + random 10);
};
