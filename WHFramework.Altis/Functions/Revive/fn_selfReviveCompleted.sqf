/*
Function: WHF_fnc_selfReviveCompleted

Description:
    Self-revives the player.
    See WHF_fnc_selfReviveAdd for more details.

Author:
    thegamecracks

*/
params ["", "_caller"];

private _firstAidKits = items _caller select {
    _x call BIS_fnc_itemType select 1 isEqualTo "FirstAidKit"
};

{
    if (_forEachIndex + 1 > WHF_selfRevive_FAKs) exitWith {};
    _caller removeItem _x;
} forEach _firstAidKits;

[_caller] call WHF_fnc_reviveUnit;

50 cutText [
    format [
        localize "$STR_WHF_selfReviveCompleted",
        WHF_selfRevive_FAKs min count _firstAidKits
    ],
    "PLAIN DOWN",
    0.3
];
