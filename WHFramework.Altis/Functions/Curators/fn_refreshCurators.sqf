/*
Function: WHF_fnc_refreshCurators

Description:
    Delete and recreate curator modules.
    Function must be executed on server.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
if (isRemoteExecuted) exitWith {};
if (!isMultiplayer) exitWith {[player] call WHF_fnc_createCurator};

{
    private _uid = _x getVariable ["WHF_curators_owner", -1];
    if (_uid isEqualTo -1) then {continue};

    private _player = getAssignedCuratorUnit _x;
    if (isNull _player) then {deleteVehicle _x; continue};

    if (getPlayerUID _player isNotEqualTo _uid) then {deleteVehicle _x; continue};
} forEach allCurators;

{
    private _player = _x call BIS_fnc_getUnitByUID;
    if (isNull _player) then {continue};
    [_player] call WHF_fnc_createCurator;
} forEach WHF_curators_uids;
