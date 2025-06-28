/*
Function: WHF_fnc_onArsenalOpened

Description:
    Handle the arsenal being opened for a given unit.

Parameters:
    Object center:
        The unit whose arsenal was opened.

Author:
    thegamecracks

*/
params ["_center"];

WHF_loadout_center = _center;
private _isACEArsenal = !isNil "ace_arsenal_currentBox";

if (WHF_loadout_blacklist isNotEqualTo []) then {
    if (_isACEArsenal) then {
        // https://ace3.acemod.org/wiki/framework/arsenal-framework#102-blacklist-items-from-all-arsenals
        [
            {call ace_arsenal_fnc_removeVirtualItems},
            [ace_arsenal_currentBox, WHF_loadout_blacklist]
        ] call CBA_fnc_execNextFrame;
    } else {
        call WHF_fnc_preloadArsenal;
    };
};

private _role = WHF_loadout_center getVariable "WHF_role";
if (!isNil "_role" && {WHF_loadout_center isNotEqualTo player}) then {
    50 cutText [
        format [
            localize "$STR_WHF_initArsenalLoadoutHandlers_role",
            _role call WHF_fnc_localizeRole
        ],
        "PLAIN DOWN",
        0.5
    ];
};

if (!_isACEArsenal) then {WHF_loadout_center call WHF_fnc_lowerWeapon};
