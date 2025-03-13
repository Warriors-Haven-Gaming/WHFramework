/*
Function: WHF_fnc_getLastLoadout

Description:
    Get the player's last loadout.
    If no last loadout could be found, an empty array is returned.

Parameters:
    String role:
        (Optional, default player getVariable ["WHF_role", ""])
        The role to get the player's last loadout for.

Returns:
    Array

Author:
    thegamecracks

*/
params [["_role", player getVariable ["WHF_role", ""]]];
if (_role isEqualTo "") exitWith {[]};

private _loadouts = missionProfileNamespace getVariable ["WHF_last_loadouts", createHashMap];
private _key = [WHF_loadout_collection, _role];
_loadouts getOrDefault [_key, []]
