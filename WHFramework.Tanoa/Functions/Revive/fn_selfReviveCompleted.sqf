/*
Function: WHF_fnc_selfReviveCompleted

Description:
    Self-revives the player.
    See WHF_fnc_selfReviveAdd for more details.

Author:
    thegamecracks

*/
params ["", "_caller"];

private _FAKs = [items _caller] call WHF_fnc_filterFAKs;
{_caller removeItem _x} forEach (_FAKs select [0, WHF_selfRevive_FAKs]);
[_caller] call WHF_fnc_reviveUnit;

private _consumed = WHF_selfRevive_FAKs min count _FAKs;
50 cutText [
    format [
        localize "$STR_WHF_selfReviveCompleted",
        _consumed,
        count _FAKs - _consumed
    ],
    "PLAIN DOWN",
    0.3
];
