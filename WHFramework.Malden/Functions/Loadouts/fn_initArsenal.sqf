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

_arsenal lockInventory true;

if (isClass (configFile >> "CfgPatches" >> "ace_arsenal")) then {
    [_arsenal, true] call ace_arsenal_fnc_initBox;

    _arsenal addAction [
        localize "$STR_A3_Arsenal",
        {
            params ["_target", "_caller"];

            private _reason = [_caller] call WHF_fnc_checkRearmAllowed;
            if (_reason isNotEqualTo "") exitWith {50 cutText [_reason, "PLAIN", 0.5]};

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
    if (!isServer) exitWith {};
    // Would prefer showing rearm reason, not hiding the action outright...
    private _condition = {_this call WHF_fnc_checkRearmAllowed isEqualTo ""};
    ["AmmoboxInit", [_arsenal, true, _condition]] spawn BIS_fnc_arsenal;
};

_arsenal addAction [
    localize "$STR_WHF_initArsenal_loadLastLoadout",
    {
        params ["", "_caller"];

        private _reason = [_caller] call WHF_fnc_checkRearmAllowed;
        if (_reason isNotEqualTo "") exitWith {50 cutText [_reason, "PLAIN", 0.5]};

        if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then {
            _caller call ace_medical_fnc_fullHeal;
        } else {
            _caller setDamage 0;
        };

        private _loadout = [] call WHF_fnc_getLastLoadout;
        if (_loadout isEqualTo []) exitWith {};
        if !([_caller, _loadout] call WHF_fnc_setUnitLoadout) exitWith {};

        private _weapon = configFile >> "CfgWeapons" >> currentWeapon _caller;
        private _sound = getArray (_weapon >> "reloadMagazineSound") # 0;
        if (!isNil "_sound") then {
            if !("." in _sound) then {_sound = _sound + ".wss"};
            playSoundUI [_sound, 0.75, 1, true];
        };
    },
    nil,
    5,
    true,
    true,
    "",
    "true",
    5
];

_arsenal addAction [
    localize "$STR_WHF_roleSelectionGUI_title",
    {
        params ["", "_caller"];

        private _reason = [_caller] call WHF_fnc_checkRearmAllowed;
        if (_reason isNotEqualTo "") exitWith {50 cutText [_reason, "PLAIN", 0.5]};

        call WHF_fnc_roleSelectionGUI;
    },
    nil,
    5,
    true,
    true,
    "",
    "true",
    5
];
