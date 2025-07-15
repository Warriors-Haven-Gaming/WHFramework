/*
Function: WHF_fnc_initSafezoneAction

Description:
    Add safezone actions to the player.
    Function must be executed on client.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) exitWith {};
if (!isNil "WHF_safezone_actionIDs") then {{_x # 0 removeAction _x # 1} forEach WHF_safezone_actionIDs};

private _friendlyID = player addAction [
    localize "$STR_WHF_damage_safezone_friendly",
    {},
    nil,
    0,
    false,
    true,
    "",
    "_target getVariable ['WHF_safezone_friendly', false] isEqualTo true"
];

WHF_safezone_actionIDs = [[player, _friendlyID]];
