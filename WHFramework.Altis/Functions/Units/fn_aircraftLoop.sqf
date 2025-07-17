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
    Number spawnDelay:
        The delay between aircraft spawned during a single wave.
    Number waveDelay:
        The delay between spawn waves.
    Side side:
        The side to count threats and spawn aircraft for.
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
        The maximum number of aircraft to spawn per wave,
        and the maximum aircraft allowed at any given time.
    Array types:
        One or more group types to spawn aircraft from.
        See WHF_fnc_getAircraftTypes for allowed values.

Author:
    thegamecracks

*/
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
    private _targets = call _getKnownTargets;
    private _aggregatedTargets = [_targets] call _aggregateTargets;
    _targetAreas = [_aggregatedTargets] call _generateTargetAreas;
    [_targetAreas] call _appendTargetAreaPriorities;

    if (_debug) then {
        WHF_targets = _targets;
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
        Get every known target from the side.
        Return an array of objects.
    */
    private _groups = groups _side select {local _x};
    private _targets = flatten (_groups apply {_x targets [true, 3000, [], 600]});
    _targets = _targets arrayIntersect _targets;
    _targets select {_side knowsAbout _x >= 2.5}
};

private _aggregateTargets = {
    /*
        Group targets by proximity.
        Return a 2D array in the format [[Object, ...], ...].
    */
    params ["_targets"];
    private _aggregatedTargets = [];
    {
        private _area = [getPosATL _x, 500, 500];
        private _index = _aggregatedTargets findIf {[_x, _area] call WHF_fnc_anyInArea};

        if (_index >= 0) then {
            _aggregatedTargets # _index pushBack _x;
        } else {
            _aggregatedTargets pushBack [_x];
        };
    } forEach _targets;
    _aggregatedTargets
};

private _generateTargetAreas = {
    /*
        Create area arrays based on the grouped targets.
        Return a 2D array in the format [[area, targets], ...].
    */
    params ["_aggregatedTargets"];
    private _targetAreas = [];
    {
        private _targets = _x;
        private _positions = _targets apply {getPosATL _x};

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
//       a limited number of aircraft regardless of spawnDelay.
private _time = time;
private _targetDelay = 60;
private _targetAt = _time + _targetDelay;
private _spawnAt = _time + _this # 1;
private _spawnLast = _time;
private _spawnCount = 0;

while {_this # 0} do {
    params [
        "",
        "_spawnDelay",
        "_waveDelay",
        "_side",
        "_cost",
        "_threshold",
        "_types"
    ];

    sleep 1;
    _time = time;

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

    if (_time >= _spawnAt) then {
        _spawnAt = _time + _spawnDelay;

        call _cleanupAircraftGroups;
        if (count _aircraftGroups >= _threshold) exitWith {};

        private _targetArea = [_cost] call _findTargetArea;
        if (count _targetArea < 1) exitWith {};

        // FIXME: may spawn aircraft in plain sight
        private _pos = [worldSize / 2, worldSize / 2] getPos [worldSize / 2, random 360];
        _pos = _pos vectorAdd [0, 0, 300 + random 500];
        private _group = [_side, _types, 1, _pos, 100] call WHF_fnc_spawnAircraft;
        if (isNull _group) exitWith {};

        [_targetArea, _cost, _group] call _assignTargetArea;
        _aircraftGroups pushBack _group;

        // If we had an in-progress wave that's stagnated, start a new wave
        if (_spawnCount > 0 && {_time >= _spawnLast + _waveDelay}) then {
            _spawnCount = 0;
        };

        _spawnLast = _time;
        _spawnCount = _spawnCount + 1;

        if (_spawnCount >= _threshold) then {
            // All aircraft spawned for current wave, schedule next wave
            _spawnAt = _time + _waveDelay;
            _spawnCount = 0;
        };
    };
};

{_x call _gcAircraftGroup} forEach _aircraftGroups;
