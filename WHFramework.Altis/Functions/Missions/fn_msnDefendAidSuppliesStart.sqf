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

// TODO: spawn script to mark crates and let attackers steal them

private _reinforceGroups = [];
private _reinforceVehicles = [];
private _reinforceScript =
    [_signal, _center, _supplies, _factionRaid, _reinforceGroups, _reinforceVehicles]
    spawn WHF_fnc_msnDefendAidSuppliesReinforcements;
_scripts pushBack _reinforceScript;

private _area = [_center, _radius * 2, _radius * 2, 0, false];
private _areaMarker = [["WHF_msnDefendAidSupplies_"], _area, true] call WHF_fnc_createAreaMarker;
_areaMarker setMarkerBrushLocal "FDiagonal";
_areaMarker setMarkerColorLocal "ColorBlue";
_areaMarker setMarkerAlpha 0.7;

while {true} do {
    sleep 3;

    if (scriptDone _statusScript) exitWith {
        sleep 3;
        [_parent, "FAILED"] spawn WHF_fnc_taskEnd;
    };

    // TODO: add message on first contact by guards
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

deleteMarker _areaMarker;
_groups append _reinforceGroups;
_vehicles append _reinforceVehicles;

_signal set [0, false];
waitUntil {sleep 1; _scripts findIf {!scriptDone _x} < 0};
