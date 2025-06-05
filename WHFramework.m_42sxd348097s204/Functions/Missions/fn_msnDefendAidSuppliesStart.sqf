/*
Function: WHF_fnc_msnDefendAidSuppliesStart

Description:
    Start the defense for players to protect the supplies.
    Function must be executed in scheduled environment.

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

_radius = _radius * 1.5;

private _scripts = [];
private _signal = [true];

private _duration = 900 + random 300;
private _endAt = time + _duration;
private _statusScript = [_signal, _supplies, _parent, _endAt] spawn WHF_fnc_msnDefendAidSuppliesStatus;
_scripts pushBack _statusScript;

private _contactScript = [_signal, _center, _radius, _groups] spawn WHF_fnc_msnDefendAidSuppliesContact;
_scripts pushBack _contactScript;

private _shelterScript = [_signal, _groups, _parent] spawn WHF_fnc_msnDefendAidSuppliesShelter;
_scripts pushBack _shelterScript;

private _theftScript = [_signal, _radius, _supplies] spawn WHF_fnc_msnDefendAidSuppliesTheft;
_scripts pushBack _theftScript;

private _reinforceGroups = [];
private _reinforceVehicles = [];
private _reinforceScript =
    [_signal, _center, _radius, _supplies, _factionRaid, _reinforceGroups, _reinforceVehicles]
    spawn WHF_fnc_msnDefendAidSuppliesReinforcements;
_scripts pushBack _reinforceScript;

private _area = [_center, _radius, _radius];
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

private _halfAt = _endAt - _duration / 2;
private _closeAt = _endAt - 60;

private _state = while {true} do {
    sleep 3;

    if (scriptDone _statusScript) exitWith {
        [[blufor, "HQ"], "$STR_WHF_defendAidSupplies_failed"] call _sideChat;
        "FAILED"
    };

    private _time = time;
    if (_halfAt >= 0 && {_time >= _halfAt}) then {
        [[blufor, "HQ"], "$STR_WHF_defendAidSupplies_half"] call _sideChat;
        _halfAt = -1;
    };

    if (_closeAt >= 0 && {_time >= _closeAt}) then {
        [[blufor, "HQ"], "$STR_WHF_defendAidSupplies_close"] call _sideChat;
        _closeAt = -1;
    };

    if (_time >= _endAt) exitWith {
        private _message = "$STR_WHF_defendAidSupplies_success";
        [[blufor, "HQ"], _message] remoteExec ["WHF_fnc_localizedSideChat", blufor];
        "SUCCEEDED"
    };
};

_signal set [0, false];
waitUntil {sleep 1; _scripts findIf {!scriptDone _x} < 0};
sleep 3;

deleteMarker _areaMarker;
_groups append _reinforceGroups;
_vehicles append _reinforceVehicles;
[_parent, _state] spawn WHF_fnc_taskEnd;
