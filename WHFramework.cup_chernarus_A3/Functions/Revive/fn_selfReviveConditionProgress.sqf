/*
Function: WHF_fnc_selfReviveConditionProgress

Description:
    Checks if the self-revive action can progress.
    See WHF_fnc_selfReviveAdd for more details.

Author:
    thegamecracks

*/
params ["", "_caller"];

private _nFAKs = count ([items _caller] call WHF_fnc_filterFAKs);
private _nMissing = WHF_selfRevive_FAKs - _nFAKs;

if (_nMissing > 0) exitWith {
    50 cutText [
        format [
            localize "$STR_WHF_selfReviveConditionProgress_noFirstAidKits",
            WHF_selfRevive_FAKs,
            _nMissing
        ],
        "PLAIN",
        0.5
    ];
    false
};
true
