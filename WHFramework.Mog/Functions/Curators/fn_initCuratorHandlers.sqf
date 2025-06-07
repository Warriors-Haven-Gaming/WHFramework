/*
Function: WHF_fnc_initCuratorHandlers

Description:
    Set up curator mission event handlers.
    Function must be executed on server.

Author:
    thegamecracks

*/
if (isRemoteExecuted) exitWith {};
if (!isNil "WHF_initCuratorHandlers") exitWith {};
WHF_initCuratorHandlers = true;

// Initialize pre-placed curator modules
{[_x] call WHF_fnc_initCuratorModule} forEach allCurators;

if (!isServer) exitWith {};

// Ensure curators can edit mission objects
private _objects = allMissionObjects "" select {!(_x isKindOf "Logic")};
{_x addCuratorEditableObjects [_objects, true]} forEach allCurators;

addMissionEventHandler ["EntityCreated", {
    params ["_entity"];
    if (_entity isKindOf "Logic") exitWith {};
    {_x addCuratorEditableObjects [[_entity], true]} forEach allCurators;
}];

// Add/remove curators based on CBA settings
addMissionEventHandler ["OnUserSelectedPlayer", {
    params ["", "_player"];
    _player addEventHandler ["Local", {
        params ["_player"];
        _player removeEventHandler ["Local", _thisEventHandler];
        if !(getPlayerUID _player in WHF_curators_uids) exitWith {};
        [_player] call WHF_fnc_createCurator;
    }];
}];

addMissionEventHandler ["PlayerDisconnected", {
    params ["", "_uid"];
    [_uid] call WHF_fnc_deleteCurator;
}];

addMissionEventHandler ["EntityRespawned", {
    params ["_entity"];
    if (!isPlayer _entity) exitWith {};
    if !(getPlayerUID _entity in WHF_curators_uids) exitWith {};
    [_entity] call WHF_fnc_createCurator;
}];

WHF_refreshCurators_script = 0 spawn {while {true} do {
    sleep (25 + random 10);
    call WHF_fnc_refreshCurators;
}};
