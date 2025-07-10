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
    Array sides:
        An array of sides to count threats from.
    Number cost:
        The threat value required for one aircraft to be dispatched.
        Each threat is assigned a value based on their type:
            Infantry    => 1
            LandVehicle => 3
            Ship        => 3
            Tank        => 5
            Air         => 5
        For example, 5 infantry and 2 tanks will have a combined threat value
        of 15. If the cost is set to 5, then up to 3 aircraft can be dispatched.
        UAVs will have their threat value reduced by half.
    Number threshold:
        The maximum number of aircraft before reinforcements are paused.
    Array types:
        One or more group types to spawn aircraft from.
        See WHF_fnc_getAircraftTypes for allowed values.

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

private _shouldRefreshTargetAreas = {
    count _aircraftGroups > 0
    || {count (_types call WHF_fnc_getAircraftTypes) > 0}
};

private _refreshTargetAreas = {
    private _targetGroups = call _getKnownTargets;
    private _targetPositions = [_targetGroups] call _getKnownTargetPositions;
    private _aggregatedTargets = [_targetPositions] call _aggregateTargetPositions;
    _targetAreas = [_aggregatedTargets] call _generateTargetAreas;
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
        Get every known target and one group they're known to.
        Return a HashMap of netId to [Object, Group].
    */
    private _groups = flatten (_sides apply {groups _x}) select {local _x};
    private _targetGroups = createHashMap;
    {
        private _group = _x;
        private _targets =
            _group targets [true, 3000, [], 600]
            select {leader _group knowsAbout _x >= 2.5};

        {
            private _key = netId _x;
            if (_key isEqualTo "0:0") then {continue};
            _targetGroups getOrDefault [_key, [_x, _group], true];
        } forEach _targets;
    } forEach _groups;
    _targetGroups
};

private _getKnownTargetPositions = {
    /*
        Get every target's closest known position from their groups.
        Return an Array of [Object, PositionATL].
    */
    params ["_targetGroups"];
    private _targetPositions = [];
    {
        _y params ["_target", "_group"];

        leader _group
            targetKnowledge _target
            params ["", "", "", "", "", "", "_position", "_ignored"];

        if (_ignored) then {continue};
        _targetPositions pushBack [_target, _position];
    } forEach _targetGroups;
    _targetPositions
};

private _aggregateTargetPositions = {
    /*
        Group targets by proximity.
        Return an Array of [[Object, PositionATL], ...].
    */
    params ["_targetPositions"];
    private _aggregatedTargets = [];
    {
        _x params ["_target", "_position"];

        private _area = [_position, 500, 500];
        private _index = -1;
        {
            private _positions = _x apply {_x # 1};
            if !([_positions, _area] call WHF_fnc_anyInArea) then {continue};
            _index = _forEachIndex;
            break;
        } forEach _aggregatedTargets;

        if (_index >= 0) then {
            _aggregatedTargets # _index pushBack _x;
        } else {
            _aggregatedTargets pushBack [_x];
        };
    } forEach _targetPositions;
    _aggregatedTargets
};

private _generateTargetAreas = {
    /*
        Create area arrays based on the grouped targets.
        Return an Array of [area, targets].
    */
    params ["_aggregatedTargets"];
    private _targetAreas = [];
    {
        private _targets = _x apply {_x # 0};
        private _positions = _x apply {_x # 1};

        private _center = [0,0,0];
        private _minX = _positions # 0 # 0;
        private _minY = _positions # 0 # 1;
        private _maxX = _positions # 0 # 0;
        private _maxY = _positions # 0 # 1;
        {
            _center = _center vectorAdd _x;
            _minX = _minX min _x # 0;
            _minY = _minY min _x # 1;
            _maxX = _maxX max _x # 0;
            _maxY = _maxY max _x # 1;
        } forEach _positions;
        _center = _center vectorMultiply (1 / count _positions);

        private _diameter = [_minX, _minY] distance2D [_maxX, _maxY];
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

    private _targets = _targetArea # 1;
    {_group reveal _x} forEach _targets;

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
private _gcDistance = 3000;

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
        "_sides",
        "_cost",
        "_threshold",
        "_types"
    ];

    sleep 1;
    private _time = time;

    if (_time >= _targetAt) then {
        _targetAt = _time + _targetDelay;

        call _cleanupAircraftGroups;
        if (!call _shouldRefreshTargetAreas) exitWith {};

        call _refreshTargetAreas;
        {
            private _targetArea = [_cost, _x] call _findTargetArea;
            if (count _targetArea < 1) exitWith {};
            [_targetArea, _cost, _x] call _assignTargetArea;
            sleep 0.125;
        } forEach _aircraftGroups;
    };

    if (_time >= _reinforceAt) then {
        _reinforceAt = call _nextReinforceAt;
        call _cleanupAircraftGroups;
        if (count _aircraftGroups >= _threshold) exitWith {};

        private _targetArea = [_cost] call _findTargetArea;
        if (count _targetArea < 1) exitWith {};

        // FIXME: may spawn aircraft in plain sight
        private _pos = [worldSize / 2, worldSize / 2] getPos [worldSize / 2, random 360];
        _pos = _pos vectorAdd [0, 0, 300 + random 500];
        private _group = [_sides # 0, _types, 1, _pos, 100] call WHF_fnc_spawnAircraft;
        if (isNull _group) exitWith {};

        [_targetArea, _cost, _group] call _assignTargetArea;
        _aircraftGroups pushBack _group;
    };
};

{_x call _gcAircraftGroup} forEach _aircraftGroups;
