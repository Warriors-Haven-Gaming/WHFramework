/*
Function: WHF_fnc_deleteCurator

Description:
    Unassign and delete a curator module with the given owner.
    Function must be executed on server.

Parameters:
    Object | String owner:
        The player UID to unassign the curator module from.

Author:
    thegamecracks

*/
params ["_uid"];
if (!isServer) exitWith {};
if (isRemoteExecuted) exitWith {};

if (_uid isEqualType objNull) then {_uid = getPlayerUID _uid};
if (_uid isEqualTo "") exitWith {};

private _modules = allCurators;
private _index = _modules findIf {_x getVariable "WHF_curators_owner" isEqualTo _uid};
if (_index < 0) exitWith {};

private _module = _modules # _index;

diag_log text format [
    "%1: unassigning and deleting %2 from %3",
    _fnc_scriptName,
    _module,
    _uid
];

unassignCurator _module;
deleteVehicle _module;
