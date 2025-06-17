/*
Function: WHF_fnc_msnDefendAidSuppliesStart

Description:
    Start the defense for players to protect the supplies.
    Function must be ran in scheduled environment.

Parameters:
    Position2D center:
        The center of the mission area.
    Number radius:
        The radius of the mission area.
    Array supplies:
        The supplies being defended.
    String factionRaid:
        The attacking faction to spawn units from.
    String parent:
        The parent task ID.
    Array groups:
        An array to append groups to.
        Useful for garbage collection.
    Array vehicles:
        An array to append vehicles to.
        Useful for garbage collection.

Author:
    thegamecracks

*/
params ["_center", "_radius", "_supplies", "_factionRaid", "_parent", "_groups", "_vehicles"];

private _scripts = [];
private _signal = [true];

private _endAt = time + 600 + random 300;
private _statusScript = [_signal, _supplies, _parent, _endAt] spawn WHF_fnc_msnDefendAidSuppliesStatus;
_scripts pushBack _statusScript;

private _theftScript = [_signal, _radius, _supplies] spawn WHF_fnc_msnDefendAidSuppliesTheft;
_scripts pushBack _theftScript;

private _reinforceGroups = [];
private _reinforceVehicles = [];
private _reinforceScript =
    [_signal, _center, _supplies, _factionRaid, _reinforceGroups, _reinforceVehicles]
    spawn WHF_fnc_msnDefendAidSuppliesReinforcements;
_scripts pushBack _reinforceScript;

private _area = [_center, _radius * 1.5, _radius * 1.5, 0, false];
private _areaMarker = [["WHF_msnDefendAidSupplies_"], _area, true] call WHF_fnc_createAreaMarker;
_areaMarker setMarkerBrushLocal "FDiagonal";
_areaMarker setMarkerColorLocal "ColorBlue";
_areaMarker setMarkerAlpha 0.7;

private _playersInArea = {
    allPlayers
        select {side group _x isEqualTo blufor}
        inAreaArray _area
};

private _sideChat = {
    params ["_source", "_message", ["_params", []]];
    private _players = call _playersInArea;
    [_source, _message, _params] remoteExec ["WHF_fnc_localizedSideChat", _players];
};

private _guardGroups = _groups select {side _x isEqualTo blufor};
private _firstContact = false;
private _getFirstContact = {
    private _getTargets = {
        leader _this targets [true]
            select {leader _this targetKnowledge _x select 4 isNotEqualTo sideUnknown}
    };

    private _index =
        _guardGroups
        findIf {_x call _getTargets isNotEqualTo []};
    if (_index < 0) exitWith {[grpNull, []]};

    private _group = _guardGroups # _index;
    [_group, _group call _getTargets]
};

while {true} do {
    sleep 3;

    if (scriptDone _statusScript) exitWith {
        // TODO: show message that too many supplies have been stolen
        sleep 3;
        [_parent, "FAILED"] spawn WHF_fnc_taskEnd;
    };

    if (!_firstContact && {!isNull (call _getFirstContact # 0)}) then {
        call _getFirstContact params ["_group", "_targets"];
        private _leader = leader _group;
        if (!alive _leader) exitWith {};

        private _dir = _center getDir _targets # 0;
        _dir = round (_dir / 10) * 10;
        [_leader, "$STR_WHF_defendAidSupplies_contact", [_dir]] call _sideChat;

        {
            private _group = _x;
            {_group reveal _x} forEach _targets;
        } forEach _guardGroups;

        _firstContact = true;
    };

    // TODO: add message when close to completion

    if (time >= _endAt) exitWith {
        _signal set [0, false];
        waitUntil {sleep 1; scriptDone _statusScript};
        // TODO: show message that raiders are retreating
        sleep 10;
        // TODO: show message of gratitude for players
        [_parent, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
    };
};

_signal set [0, false];
waitUntil {sleep 1; _scripts findIf {!scriptDone _x} < 0};

deleteMarker _areaMarker;
_groups append _reinforceGroups;
_vehicles append _reinforceVehicles;
