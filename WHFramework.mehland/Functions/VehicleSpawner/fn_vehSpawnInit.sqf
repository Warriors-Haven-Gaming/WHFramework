/*
Function: WHF_fnc_vehSpawnInit

Description:
    Initializes an object as a vehicle spawner.
    Function must be remote executed on all clients.

Parameters:
    Object obj:
        The object to initialize.
    PositionATL pos:
        The position where vehicles will spawn.
    Number dir:
        The direction that spawned vehicles will face.
    Array categories:
        (Optional, default [])
        An array of categories to allow for the spawner.
        If empty, all categories are allowed.
    Array safeArea:
        (Optional, default [10, 50, "O_APC_Tracked_02_AA_F"])
        An array passed to findEmptyPosition to determine where to safely
        spawn vehicles.

Author:
    thegamecracks

*/
params ["_obj", "_pos", "_dir", ["_categories", []], ["_safeArea", [10, 50, "O_APC_Tracked_02_AA_F"]]];
if (!isNil {_obj getVariable "WHF_vehSpawn_pos"}) exitWith {};

// For backwards compatibility, treat Z=0 over water as ASL
_pos = _pos vectorAdd [0,0,0];
if (surfaceIsWater _pos && {_pos # 2 isEqualTo 0}) then {_pos = ASLToATL _pos};

_obj setVariable ["WHF_vehSpawn_pos", _pos];
_obj setVariable ["WHF_vehSpawn_dir", _dir];
_obj setVariable ["WHF_vehSpawn_categories", _categories];
_obj setVariable ["WHF_vehSpawn_safeArea", _safeArea];

if (!hasInterface) exitWith {};
private _actionID = _obj addAction [
    localize "$STR_WHF_vehSpawnInit_action",
    {
        params ["_target"];
        [player, _target] remoteExec ["WHF_fnc_vehSpawnGUIServer", 2];
    },
    nil,
    12,
    true,
    true,
    "",
    "true",
    5
];

_obj setVariable ["WHF_vehSpawn_actionID", _actionID];
