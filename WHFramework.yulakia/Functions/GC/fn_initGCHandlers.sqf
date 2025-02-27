/*
Function: WHF_fnc_initGCHandlers

Description:
    Set up garbage collector handlers.
    Function must be executed on server.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
addMissionEventHandler ["BuildingChanged", {
    params ["_from", "_to"];

    private _ruins = _from getVariable "WHF_ruins";
    if (isNil "_ruins") exitWith {};
    _ruins pushBack _to;
    _to setVariable ["WHF_ruins", _ruins];

    {
        _x params ["_objects"];
        if (_from in _objects) then {
            _objects pushBack _to;
            break;
        };
    } forEach WHF_gcDeletionQueue;
}];

addMissionEventHandler ["PlayerDisconnected", {
    params ["", "_uid"];
    private _vehicle = WHF_vehSpawn_lastVehicles get _uid;
    if (isNil "_vehicle" || {isNull _vehicle}) exitWith {};
    _vehicle call WHF_fnc_queueGCDeletion;
}];

[missionNamespace, "respawn", {
    params ["_new"];

    // Propagate vehicle locks to all clients
    {
        if ([_x, "whf_vehiclelock_"] call WHF_fnc_stringStartsWith) then {
            _new setVariable [_x, _new getVariable _x, true];
        };
    } forEach allVariables _new;
}] call BIS_fnc_addScriptedEventHandler;
