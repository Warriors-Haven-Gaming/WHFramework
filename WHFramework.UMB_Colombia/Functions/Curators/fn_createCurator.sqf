/*
Function: WHF_fnc_createCurator

Description:
    Create and assign a curator module for a player.
    Function must be executed on server.

Parameters:
    Object player:
        The player to assign the curator module to.

Author:
    thegamecracks

*/
params ["_player"];
if (!isServer) exitWith {};
if (isRemoteExecuted) exitWith {};
if (canSuspend) exitWith {isNil WHF_fnc_createCurator};

private _uid = getPlayerUID _player;
if (_uid isEqualTo "") exitWith {};

private _modules = allCurators;
private _index = _modules findIf {_x getVariable "WHF_curators_owner" isEqualTo _uid};
if (_index >= 0) exitWith {
    private _module = _modules # _index;
    private _current = getAssignedCuratorLogic _player;
    if (_module isEqualTo _current) exitWith {};

    diag_log text format [
        "%1: reassigning %2 to %3 (%4)",
        _fnc_scriptName,
        _module,
        name _player,
        _uid
    ];

    unassignCurator _module;
    unassignCurator _current;
    _player assignCurator _module;
    [_module] remoteExec ["WHF_fnc_initCuratorModule", _player];
};

private _module = createGroup [sideLogic, true] createUnit ["ModuleCurator_F", [-1000, -1000, 0], [], 0, "CAN_COLLIDE"];
_module setVariable ["addons", 3, true];
_module setVariable ["birdType", "", true];
_module setVariable ["forced", 0, true];
_module setVariable ["name", "", true];
_module setVariable ["owner", _uid];
_module setVariable ["WHF_curators_owner", _uid];
_module setVariable ["showNotification", false, true];
_module setVariable ["BIS_fnc_initModules_disableAutoActivation", false, true];

diag_log text format [
    "%1: creating and assigning %2 to %3 (%4)",
    _fnc_scriptName,
    _module,
    name _player,
    _uid
];

unassignCurator getAssignedCuratorLogic _player;
_player assignCurator _module;
[_module] remoteExec ["WHF_fnc_initCuratorModule", _player];

_module spawn {
    scriptName "WHF_fnc_createCurator_addCuratorEditableObjects";
    private _objects = allMissionObjects "" select {!(_x isKindOf "Logic")};
    _this addCuratorEditableObjects [_objects, true];
};
