/*
Function: WHF_fnc_aircraftLoop

Description:
    Periodically spawn aircraft reinforcements across the map.
    Unlike other functions, the arguments array can be modified in-place
    to change behaviour mid-execution.
    Function must be executed in scheduled environment.

Parameters:
    Boolean running:
        Whether the function should run. By setting this to false,
        the function can be safely terminated during execution.
    Array | Number frequency:
        How often this function should spawn reinforcements.
        If an array is passed, it is treated as the minimum and maximum time.
    Array types:
        One or more group types to spawn aircraft from.
        See WHF_fnc_getAircraftTypes for allowed values.
    Number threshold:
        The maximum number of aircraft before reinforcements are paused.
    Array sides:
        An array of sides to count threats from.

Author:
    thegamecracks

*/
private _nextReinforceAt = {
    _this # 1 params ["_min", "_max"];
    if (isNil "_max" || {_min > _max}) exitWith {time + _min};
    time + _min + random (_max - _min)
};

private _cleanupAircraftGroups = {
    private _toRemove = [];
    {
        if (_x call _isActiveAircraftGroup) then {continue};
        _x call _gcAircraftGroup;
        _toRemove pushBack _forEachIndex;
    } forEach _aircraftGroups;

    {_aircraftGroups deleteAt _x} forEachReversed _toRemove;
};

private _isActiveAircraftGroup = {
    params ["_group"];
    private _leader = leader _group;
    alive _leader && {currentPilot objectParent _leader isEqualTo _leader}
};

private _gcAircraftGroup = {
    params ["_group"];
    [units _group, _gcDistance] remoteExec ["WHF_fnc_queueGCDeletion", 2];
    {
        [_x, _gcDistance] remoteExec ["WHF_fnc_queueGCDeletion", 2];
    } forEach assignedVehicles _group;
};

private _refreshTargetAreas = {
    private _targetGroups = call _getKnownTargets;
    private _targetPositions = [_targetGroups] call _getKnownTargetPositions;
    private _aggregatedTargets = [_targetPositions, _targetGroups] call _aggregateTargetPositions;
    _targetAreas = [_aggregatedTargets, _targetPositions] call _generateTargetAreas;
    [_targetAreas] call _appendTargetAreaPriorities;

    if (_debug) then {
        WHF_targetGroups = _targetGroups;
        WHF_targetPositions = _targetPositions;
        WHF_aggregatedTargets = _aggregatedTargets;
        WHF_targetAreas = _targetAreas;

        if (!isNil "WHF_targetAreas_markers") then {
            {deleteMarker _x} forEach WHF_targetAreas_markers;
        };

        WHF_targetAreas_markers = [];
        {
            _x params ["_area", "_targets", "_priority"];
            private _id = ["WHF_targetAreas_"];

            private _areaMarker = [_id, _area, true] call WHF_fnc_createAreaMarker;
            _areaMarker setMarkerBrushLocal "SolidBorder";
            _areaMarker setMarkerColorLocal "ColorRed";
            _areaMarker setMarkerAlpha 0.7;
            WHF_targetAreas_markers pushBack _areaMarker;

            private _marker = [_id, _area # 0 vectorAdd [_area # 1]] call WHF_fnc_createLocalMarker;
            _marker setMarkerTypeLocal "mil_dot";
            _marker setMarkerColorLocal "ColorRed";
            _marker setMarkerTextLocal format ["Targets: %1, Priority: %2", count _targets, _priority];
            _marker setMarkerAlpha 0.7;
            WHF_targetAreas_markers pushBack _marker;
        } forEach _targetAreas;
    };
};

private _getKnownTargets = {
    /*
        Get every known target and the groups they're known to.
        Return a HashMap of netId to [Object, [Group, ...]].
    */
    private _groups = flatten (_sides apply {groups _x}) select {local _x};
    private _targetGroups = createHashMap;
    {
        private _group = _x;
        private _targets =
            _group targets [true, 750, [], 600]
            apply {[_x, leader _group targetKnowledge _x]}
            select {[side _group, _x # 1 # 4] call BIS_fnc_sideIsEnemy}
            apply {_x # 0};

        {
            private _key = netId _x;
            if (_key isEqualTo "0:0") then {continue};

            _targetGroups getOrDefault [_key, [_x, []], true] params ["", "_groups"];
            _groups pushBackUnique _group;
        } forEach _targets;
    } forEach _groups;
    _targetGroups
};

private _getKnownTargetPositions = {
    /*
        Get every target's closest known position from their groups.
        Return a HashMap of netId to PositionATL.
    */
    params ["_targetGroups"];
    private _targetPositions = createHashMap;
    {
        _y params ["_target", "_groups"];

        // Get known positions from each group and select the lowest error margin
        private _margins = [];
        private _positions = [];
        {
            leader _x
                targetKnowledge _target
                params ["_knownByGroup", "", "", "", "", "_margin", "_position", "_ignored"];
            if (!_knownByGroup) then {continue};
            if (_ignored) then {continue};

            _margins pushBack _margin;
            _positions pushBack _position;
        } forEach _groups;
        if (count _positions < 1) then {continue};

        private _nearestPos = _positions select (_margins find selectMin _margins);
        _targetPositions set [netId _target, _nearestPos];
    } forEach _targetGroups;
    _targetPositions
};

private _aggregateTargetPositions = {
    /*
        Group targets by proximity.
        Return an Array of Objects.
    */
    params ["_targetPositions", "_targetGroups"];
    private _aggregatedTargets = [];
    {
        private _target = _targetGroups get _x select 0;
        private _position = _y;

        private _area = [_position, 500, 500];
        private _index = -1;
        {
            if !([_x, _area] call WHF_fnc_anyInArea) then {continue};
            _index = _forEachIndex;
            break;
        } forEach _aggregatedTargets;

        if (_index >= 0) then {
            _aggregatedTargets # _index pushBack _target;
        } else {
            _aggregatedTargets pushBack [_target];
        };
    } forEach _targetPositions;
    _aggregatedTargets
};

private _generateTargetAreas = {
    /*
        Create area arrays based on the grouped targets.
        Return an Array of [area, targets].
    */
    params ["_aggregatedTargets", "_targetPositions"];
    private _targetAreas = [];
    {
        private _targets = _x;
        private _positions = _targets apply {_targetPositions get netId _x};

        private _center = [0,0,0];
        {_center = _center vectorAdd _x} forEach _positions;
        _center = _center vectorMultiply (1 / count _positions);

        private _diameter = 0;
        {
            private _y = _x;
            {
                private _distance = _x distance2D _y;
                _diameter = _distance max _diameter;
            } forEach _positions;
        } forEach _positions;

        private _area = [_center, _diameter / 2, _diameter / 2];
        _targetAreas pushBack [_area, _targets];
    } forEach _aggregatedTargets;
    _targetAreas
};

private _appendTargetAreaPriorities = {
    /*
        Calculate each target area's priority based on targets present.
        Push the priority value at the end of each target area in-place.
    */
    params ["_targetAreas"];
    {
        _x params ["_area", "_targets"];
        private _priority = 0;
        {
            private _value = switch (true) do {
                case (_x isKindOf "Tank"): {5};
                case (_x isKindOf "Air"): {5};
                case (_x isKindOf "LandVehicle"): {3};
                case (_x isKindOf "Ship"): {3};
                default {1};
            };
            if (unitIsUAV _x) then {_value = _value / 2};
            _priority = _priority + _value;
        } forEach _targets;
        _x pushBack _priority;
    } forEach _targetAreas;
};

private _assignTargetArea = {
    /*
        Assign a group to the given target area.
    */
    params ["_targetArea", "_desiredPriority", "_group"];

    private _pos = [[_targetArea # 0], []] call BIS_fnc_randomPos;
    if (_pos isEqualTo [0,0]) exitWith {};
    _pos = AGLToASL _pos vectorMultiply [1,1,0];

    [_group] call WHF_fnc_clearWaypoints;
    private _waypoint = _group addWaypoint [_pos, -1];
    _waypoint setWaypointType "SAD";
    _waypoint setWaypointCompletionRadius 20;

    _targetArea set [2, _targetArea # 2 - _desiredPriority];
};

private _findTargetArea = {
    /*
        Find a target area suitable for the given group, or any
        target area if no group is provided.
        If no target area is suitable, return an empty array.
    */
    params ["_desiredPriority", ["_group", grpNull]];
    private _sortedAreas = [];
    {
        _x params ["_area", "", "_priority"];
        _area params ["_center"];
        if (_desiredPriority > _priority) then {continue};

        private _adjustedPriority = _priority;
        if (!isNull _group) then {
            private _distanceFactor = (leader _group distance2D _center) / 500;
            _adjustedPriority = _adjustedPriority - _distanceFactor;
        };

        _sortedAreas pushBack [_adjustedPriority, _forEachIndex];
    } forEach _targetAreas;
    if (count _sortedAreas < 1) exitWith {[]};

    _sortedAreas sort false;
    _targetAreas select _sortedAreas # 0 # 1
};

private _debug = false;
private _gcDistance = 5000;
private _priorityPerAircraft = 10;

private _targetAreas = [];
private _aircraftGroups = [];

// NOTE: updating waypoints too frequently can cause aircraft to not move
// NOTE: priorities don't reset until each refresh, so target areas get
//       a limited number of aircraft regardless of frequency
private _targetDelay = 60;
private _targetAt = time + _targetDelay;
private _reinforceAt = call _nextReinforceAt;

while {_this # 0} do {
    params [
        "",
        "",
        "_types",
        "_threshold",
        "_sides"
    ];

    sleep 1;
    private _time = time;

    if (_time >= _targetAt) then {
        _targetAt = _time + _targetDelay;
        call _refreshTargetAreas;
        call _cleanupAircraftGroups;
        {
            private _targetArea = [_priorityPerAircraft, _x] call _findTargetArea;
            if (count _targetArea < 1) exitWith {};
            [_targetArea, _priorityPerAircraft, _x] call _assignTargetArea;
            sleep 0.125;
        } forEach _aircraftGroups;
    };

    if (_time >= _reinforceAt) then {
        _reinforceAt = call _nextReinforceAt;
        call _cleanupAircraftGroups;
        if (count _aircraftGroups >= _threshold) exitWith {};

        private _targetArea = [_priorityPerAircraft] call _findTargetArea;
        if (count _targetArea < 1) exitWith {};

        // FIXME: may spawn aircraft in plain sight
        private _pos = [worldSize / 2, worldSize / 2] getPos [worldSize / 2, random 360];
        _pos = _pos vectorAdd [0, 0, 300 + random 500];
        private _group = [_sides # 0, _types, 1, _pos, 100] call WHF_fnc_spawnAircraft;
        [_targetArea, _priorityPerAircraft, _group] call _assignTargetArea;
        _aircraftGroups pushBack _group;
    };
};

{_x call _gcAircraftGroup} forEach _aircraftGroups;
