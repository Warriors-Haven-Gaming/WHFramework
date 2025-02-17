/*
Function: WHF_fnc_getLastLoadout

Description:
    Get the player's last loadout.
    If no last loadout could be found, an empty array is returned.

Returns:
    Array

Author:
    thegamecracks

*/
private _loadouts = missionProfileNamespace getVariable ["WHF_last_loadouts", createHashMap];
private _role = "rifleman";
private _key = [WHF_loadout_collection, _role];
_loadouts getOrDefault [_key, []]
