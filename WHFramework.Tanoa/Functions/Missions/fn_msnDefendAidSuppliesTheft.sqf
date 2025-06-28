/*
Function: WHF_fnc_msnDefendAidSuppliesTheft

Description:
    Create markers keeping track of supplies and allow OPFOR to steal them.
    Function must be executed in scheduled environment.

Parameters:
    Array signal:
        An array that should contain a single boolean.
        By setting this to false, the function can be safely terminated
        during execution. The status task will count as completed.
    Number radius:
        The radius of the mission area.
    Array supplies:
        The supplies being defended.

Author:
    thegamecracks

*/
params ["_signal", "_radius", "_supplies"];

// We don't expect new supplies to appear during the mission, but just in case
// the array gets modified, we're copying it.
_supplies = _supplies select {alive _x};

private _supplyTheftAt = _supplies apply {-1};
private _markers = _supplies apply {
    private _pos = getPosATL _x;
    private _marker = ["WHF_msnDefendAidSupplies_", _pos] call WHF_fnc_createLocalMarker;
    _marker
};

private _updateMarkerByIndex = {
    params ["_i"];
    private _marker = _markers # _i;
    private _supply = _supplies # _i;
    private _theftAt = _supplyTheftAt # _i;

    private _type = markerType _marker;
    switch (true) do {
        case (markerColor _marker isEqualTo ""): {};
        case (!alive _supply): {
            if (_type isEqualTo "mil_destroy_noShadow") exitWith {};
            _marker setMarkerColorLocal "ColorRed";
            _marker setMarkerDirLocal 45;
            _marker setMarkerType "mil_destroy_noShadow";
        };
        case (_theftAt >= 0): {
            if (_type isEqualTo "mil_warning") exitWith {};
            _marker setMarkerPosLocal getPosATL _supply;
            _marker setMarkerColorLocal "ColorRed";
            _marker setMarkerType "mil_warning";
        };
        default {
            if (_type isEqualTo "mil_box") exitWith {};
            _marker setMarkerPosLocal getPosATL _supply;
            _marker setMarkerColorLocal "ColorGreen";
            _marker setMarkerType "mil_box";
        };
    };
};

{[_forEachIndex] call _updateMarkerByIndex} forEach _markers;

private _playersNearSupply = {
    params ["_supply"];
    allPlayers
        select {side group _x isEqualTo blufor}
        inAreaArray [getPosATL _supply, _radius, _radius]
};

private _sideChat = {
    params ["_supply", "_source", "_message", ["_params", []]];
    private _players = [_supply] call _playersNearSupply;
    [_source, _message, _params] remoteExec ["WHF_fnc_localizedSideChat", _players];
};

private _theftDelay = 30;
private _alertDelay = 90;
private _lastAlert = time - _alertDelay;

while {true} do {
    sleep 5;

    if !(_signal # 0) exitWith {};

    private _units = units opfor select {!unitIsUAV _x};
    private _time = time;
    {
        if (!alive _x) then {continue};

        private _area = [getPosATL _x, 10, 10];
        if !([_units, _area] call WHF_fnc_anyInArea) then {
            _supplyTheftAt set [_forEachIndex, -1];
            continue;
        };

        private _theftAt = _supplyTheftAt # _forEachIndex;
        if (_theftAt < 0) then {_theftAt = _time; _supplyTheftAt set [_forEachIndex, _theftAt]};

        if (_time >= _theftAt + _theftDelay) then {
            [_x, [blufor, "BLU"], "$STR_WHF_defendAidSupplies_stolen"] call _sideChat;
            deleteVehicle _x;
            sleep (0.25 + random 0.5);
            continue;
        };

        if (_time >= _lastAlert + _alertDelay) then {
            [_x, [blufor, "BLU"], "$STR_WHF_defendAidSupplies_theft"] call _sideChat;
            _lastAlert = _time;
        };
    } forEach _supplies;

    {[_forEachIndex] call _updateMarkerByIndex} forEach _markers;
};

{deleteMarker _x} forEach _markers;
