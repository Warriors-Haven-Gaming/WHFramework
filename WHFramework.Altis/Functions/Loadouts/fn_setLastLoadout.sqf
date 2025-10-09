/*
Function: WHF_fnc_setLastLoadout

Description:
    Save the given loadout as the player's last loadout.
    saveMissionProfileNamespace should be called after this to persist the loadout.

Parameters:
    Array loadout:
        The loadout to be saved. Can be a CBA extended loadout
        or a loadout returned by getUnitLoadout.
    String role:
        (Optional, default player getVariable ["WHF_role", ""])
        The role to set the player's last loadout for.

Author:
    thegamecracks

*/
params ["_loadout", ["_role", player getVariable ["WHF_role", ""]]];
if (WHF_loadout_collection in ["", "default"]) exitWith {};
if (_role isEqualTo "") exitWith {};

private _loadouts = missionProfileNamespace getVariable ["WHF_last_loadouts", createHashMap];
private _key = [WHF_loadout_collection, _role];
_loadouts set [_key, _loadout];
missionProfileNamespace setVariable ["WHF_last_loadouts", _loadouts];
