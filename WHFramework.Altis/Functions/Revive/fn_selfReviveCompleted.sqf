#include "\a3\functions_f_mp_mark\revive\defines.inc"
/*
Function: WHF_fnc_selfReviveCompleted

Description:
    Self-revives the player.
    See WHF_fnc_selfReviveLoop for more details.

Author:
    thegamecracks

*/
params ["", "_caller"];

// See \a3\functions_f_mp_mark\revive\_addAction_revive.inc
// (unpacked from Mark\functions_f_mp_mark.pbo)
SET_STATE(_caller, STATE_REVIVED);

private _firstAidKits = items _caller select {
    _x call BIS_fnc_itemType select 1 isEqualTo "FirstAidKit"
};

{
    if (_forEachIndex + 1 > WHF_selfRevive_FAKs) exitWith {};
    _caller removeItem _x;
} forEach _firstAidKits;

50 cutText [
    format [
        localize "$STR_WHF_selfReviveCompleted",
        WHF_selfRevive_FAKs min count _firstAidKits
    ],
    "PLAIN DOWN",
    0.3
];
