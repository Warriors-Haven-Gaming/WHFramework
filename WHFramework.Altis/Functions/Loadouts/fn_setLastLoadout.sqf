/*
Function: WHF_fnc_setLastLoadout

Description:
    Save the given loadout as the player's last loadout.
    saveMissionProfileNamespace should be called after this to persist the loadout.

Parameters:
    Array loadout:
        The loadout to be saved.
        Should follow the format returned by the getUnitLoadout command.

Author:
    thegamecracks

*/
params ["_loadout"];
private _loadouts = missionProfileNamespace getVariable ["WHF_last_loadouts", createHashMap];
private _role = "rifleman";
private _key = [WHF_loadout_collection, _role];
_loadouts set [_key, _loadout];
missionProfileNamespace setVariable ["WHF_last_loadouts", _loadouts];
