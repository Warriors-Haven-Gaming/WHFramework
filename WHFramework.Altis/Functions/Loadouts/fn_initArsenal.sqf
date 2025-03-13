/*
Function: WHF_fnc_initArsenal

Description:
    Initialize an object as an arsenal.

Parameters:
    Object arsenal:
        The object to set up as an arsenal.

Author:
    thegamecracks

*/
params ["_arsenal"];

if (isClass (configFile >> "CfgPatches" >> "ace_arsenal")) then {
    [_arsenal, true] call ace_arsenal_fnc_initBox;

    _arsenal addAction [
        localize "$STR_A3_Arsenal",
        {
            params ["_target", "_caller"];
            [_target, _caller] call ace_arsenal_fnc_openBox;
        },
        nil,
        6,
        true,
        true,
        "",
        "true",
        5
    ];
} else {
    ["AmmoboxInit", [_arsenal, true]] spawn BIS_fnc_arsenal;
};

_arsenal addAction [
    localize "$STR_WHF_initArsenal_loadLastLoadout",
    {
        params ["", "_caller"];
        private _loadout = [] call WHF_fnc_getLastLoadout;
        if (_loadout isEqualTo []) exitWith {};
        _caller setUnitLoadout _loadout;

        private _weapon = configFile >> "CfgWeapons" >> currentWeapon _caller;
        private _sound = getArray (_weapon >> "reloadMagazineSound") # 0;
        if !("." in _sound) then {_sound = _sound + ".wss"};
        playSoundUI [_sound, 0.75, 1, true];
    },
    nil,
    1.5,
    true,
    true,
    "",
    "true",
    5
];
