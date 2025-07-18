/*
Function: WHF_fnc_ungarrisonLoop

Description:
    Given an array of groups, periodically ungarrison their units when there
    are nearby threats.

    Units will be skipped if their pathfinding is already enabled.

    The caller can append new groups to the array at a later time. However,
    this function automatically terminates itself once all current groups
    are killed.

    Function must be executed in scheduled environment.

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
        private _group = _x;
        {
            private _unit = _x;
            if (!alive _unit) then {continue};
            if (!local _unit) then {continue};
            if (!simulationEnabled _unit) then {continue};
            if (_unit checkAIFeature "PATH") then {continue};
            sleep 0.125;

            private _targets =
                _unit targets [true, 100, [], 180]
                apply {_unit targetKnowledge _x}
                select {_x # 4 isNotEqualTo sideUnknown}
                apply {_x # 6 vectorMultiply [1,1,0]};

            if (count _targets < 1) then {continue};

            _unit setUnitPos "AUTO";
            _unit enableAIFeature ["COVER", true];
            _unit enableAIFeature ["PATH", true];

            private _dynamicSimulation = dynamicSimulationEnabled _group;
            private _lasersOn = _unit isIRLaserOn currentWeapon _unit;
            private _lightsOn = _unit isFlashlightOn currentWeapon _unit;

            private _newGroup = createGroup [side _group, true];
            _newGroup setVariable ["WHF_siren_disabled", true];
            [_unit] joinSilent _newGroup;

            _newGroup allowFleeing 0;
            _newGroup setBehaviourStrong "AWARE";
            _newGroup setSpeedMode "FULL";
            _newGroup enableIRLasers _lasersOn;
            _newGroup enableGunLights (["Auto", "ForceOn"] select _lightsOn);

            private _position = [_unit, _targets] call WHF_fnc_nearestPosition;
            private _waypoint = _newGroup addWaypoint [_position, 5];
            _waypoint setWaypointType "SAD";
            _waypoint setWaypointCompletionRadius 5;

            if (_dynamicSimulation) then {
                [_group, true, 1] spawn WHF_fnc_enableDynamicSimulation;
            };

            if (!isNil "_outputGroups") then {_outputGroups pushBack _group};
        } forEach units _group;
    } forEach _groups;

    _groups = [_inputGroups] call WHF_fnc_coerceGroups;
    sleep (5 + random 10);
};
