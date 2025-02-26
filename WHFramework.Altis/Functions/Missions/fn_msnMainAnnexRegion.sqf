/*
Function: WHF_fnc_msnMainAnnexRegion

Description:
    Players must clear out enemies from a location.
    Function must be ran in scheduled environment.

Parameters:
    Location location:
        (Optional, default locationNull)
        If specified, the given location is used for the mission instead of
        attempting to find a suitable location.

Author:
    thegamecracks

*/
params [["_location", locationNull]];

if (_location isEqualTo locationNull) then {
    _location = selectRandom nearestLocations [
        [worldSize / 2, worldSize / 2],
        ["NameVillage", "NameCity", "NameCityCapital"],
        sqrt 2 / 2 * worldSize
    ];

};
if (_location isEqualTo locationNull) exitWith {
    diag_log text format ["%1: No location found", _fnc_scriptName];
};

private _center = locationPosition _location vectorMultiply [1, 1, 0];
_center = _center vectorAdd [50 - random 100, 50 - random 100];

private _radius = selectMax size _location * 2 max 500;
private _area = [_center, _radius, _radius, 0, false];

private _areaMarker = [["WHF_mainMission"], _area, true] call WHF_fnc_createAreaMarker;
_areaMarker setMarkerBrushLocal "FDiagonal";
_areaMarker setMarkerColorLocal "ColorRed";
_areaMarker setMarkerAlpha 0.7;

// FIXME: localize description on clients
private _description = getMissionConfig "CfgTaskDescriptions" >> "mainAnnexRegion";
_description = [_description >> "description", _description >> "title"];
_description = _description apply {format [localize getTextRaw _x, text _location]};
private _taskID = [blufor, "", _description, _area # 0, "AUTOASSIGNED", -1, true, "attack"] call WHF_fnc_taskCreate;

private _groups = [];

private _infCount = floor (_radius / 50 + random (count allPlayers / 10));
for "_i" from 1 to _infCount do {
    private _pos = [_center, _radius] call WHF_fnc_randomPos;
    if (_pos isEqualTo [0,0]) then {continue};
    private _group = [opfor, "raiders", selectRandom [2, 4, 8], _pos, 10, ["flashlights"]] call WHF_fnc_spawnUnits;
    _groups pushBack _group;
};

private _garrisonCount = floor (_radius / 15 + random (count allPlayers / 2));
private _garrisonGroup = [opfor, "raiders", _garrisonCount, _center, 0, ["flashlights"]] call WHF_fnc_spawnUnits;
[_garrisonGroup, _center, _radius, true] call WHF_fnc_garrisonUnits;
_groups pushBack _garrisonGroup;

private _vehicleCount = floor (_radius / 100 + random (count allPlayers / 10));
for "_i" from 1 to _vehicleCount do {
    private _pos = [_center, _radius] call WHF_fnc_randomPos;
    if (_pos isEqualTo [0,0]) then {continue};
    private _group = [opfor, "raiders", 1, _pos, 10] call WHF_fnc_spawnVehicles;
    _groups pushBack _group;
};
{[_x, getPosATL leader _x, 200] call BIS_fnc_taskPatrol} forEach _groups;

private _supportTypes = [
    "units",   90,
    "vehicles",10
];
private _supportUnits = [];
private _getSupportUnitCount = {[_supportUnits, {alive _x}] call WHF_fnc_shrinkCount};
private _spawnSupportUnits = {
    params ["_area", "_supportTypes", "_supportUnits", "_groups"];
    scriptName "WHF_fnc_msnMainAnnexRegion_spawnSupportUnits";
    private _supportType = selectRandomWeighted _supportTypes;
    switch (_supportType) do {
        case "units": {
            private _pos = [_area # 0, _area # 1, 100] call WHF_fnc_randomPosHidden;
            if (_pos isEqualTo [0,0]) exitWith {};

            private _quantity = 1 + floor random (3 + count allPlayers / 5);
            private _group = [opfor, "raiders", _quantity, _pos, 50, ["flashlights"]] call WHF_fnc_spawnUnits;
            private _waypoint = _group addWaypoint [_pos, 0];
            _waypoint setWaypointType "SAD";
            _waypoint setWaypointCompletionRadius 20;
            _supportUnits append units _group;
            _groups pushBack _group;
        };
        case "vehicles": {
            private _pos = [_area # 0, _area # 1, 100] call WHF_fnc_randomPosHidden;
            if (_pos isEqualTo [0,0]) exitWith {};

            private _quantity = 1;
            private _group = [opfor, "raiders", _quantity, _pos, 50] call WHF_fnc_spawnVehicles;
            private _waypoint = _group addWaypoint [_pos, 0];
            _waypoint setWaypointType "SAD";
            _waypoint setWaypointCompletionRadius 20;
            _supportUnits append units _group;
            _groups pushBack _group;
        };
        default {throw format ["Unknown support type %1", _supportType]};
    };
};

private _attackScript = [_groups] spawn {
    params ["_groups"];
    scriptName "WHF_fnc_msnMainAnnexRegion_attackScript";
    while {true} do {
        sleep (20 + random 20);
        {
            private _leader = leader _x;
            if (!alive _leader) then {continue};
            if (!local _leader) then {continue};
            if !(_leader checkAIFeature "PATH") then {continue};

            private _waypoints = waypoints _x;
            if (
                count _waypoints > 0
                && {!(waypointType (_waypoints # 0) in ["MOVE", "SAD"])}
            ) then {continue};

            private _targets = _leader targetsQuery [objNull, blufor, "", [], 180];
            sleep 0.125;
            if (count _targets < 1) then {continue};

            {deleteWaypoint _x} forEachReversed _waypoints;
            _targets # 0 params ["", "", "", "", "_position"];
            private _waypoint = _x addWaypoint [_position, 0];
            _waypoint setWaypointType "SAD";
            _waypoint setWaypointCompletionRadius 20;

        } forEach _groups;
    };
};

private _ungarrisonScript = [_groups, _garrisonGroup] spawn {
    params ["_groups", "_garrisonGroup"];
    while {true} do {
        sleep (5 + random 10);
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

            private _waypoint = _group addWaypoint [_position, 0];
            _waypoint setWaypointType "SAD";
            _waypoint setWaypointCompletionRadius 5;

            _groups pushBack _group;
        } forEach units _garrisonGroup;
    };
};

while {true} do {
    sleep 10;

    private _allThreats = units opfor + units independent;
    private _threatsInRange = _allThreats inAreaArray _area;
    private _threshold = 10 + _radius / 25;
    if (count _threatsInRange < _threshold) exitWith {
        [_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
    };

    private _supportLimit = 10 + _radius / 80 + count allPlayers;
    if (
        random 1 < 0.3 + count allPlayers / 50
        && {call _getSupportUnitCount < _supportLimit
        && {[allPlayers, _area] call WHF_fnc_anyInArea}}
    ) then {
        [_area, _supportTypes, _supportUnits, _groups] spawn _spawnSupportUnits;
    };
};

terminate _attackScript;
terminate _ungarrisonScript;
deleteMarker _areaMarker;
{[units _x] call WHF_fnc_queueGCDeletion} forEach _groups;
