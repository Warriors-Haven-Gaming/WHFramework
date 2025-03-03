/*
Function: WHF_fnc_initCuratorHandlers

Description:
    Set up curator mission event handlers.
    Function must be executed on server.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
if (isRemoteExecuted) exitWith {};

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

// Shoddy attempt at restoring curator modules
addMissionEventHandler ["EntityRespawned", {
    params ["_new", "_old"];
    private _logic = getAssignedCuratorLogic _old;
    if (!isNull _logic) then {
        unassignCurator _logic;
        _new assignCurator _logic;
    };
}];
