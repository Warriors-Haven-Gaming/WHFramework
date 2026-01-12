/*
Function: WHF_fnc_initEarplugsKeybind

Description:
    Set up a keybind to toggle earplugs.

Author:
    thegamecracks

*/
#include "\a3\ui_f\hpp\definedikcodes.inc"
if (isClass (configFile >> "CfgPatches" >> "cba_keybinding")) then {
    [
        "$STR_WHF_settings",
        "WHF_keybind_earplugs",
        ["$STR_WHF_earplugs_keybind", "$STR_WHF_earplugs_keybind_tooltip"],
        {
            params ["", "_key", "_shift", "_ctrl", "_alt"];
            private _isDefault = {_key isEqualTo DIK_END && !_shift && !_ctrl && !_alt};
            if (!isNull curatorCamera && _isDefault) exitWith {};
            [nil, true] call WHF_fnc_toggleEarplugs;
        },
        {},
        [DIK_END, [false, false, false]]
    ] call CBA_fnc_addKeybind;
} else {
    findDisplay 46 displayAddEventHandler ["KeyDown", {
        params ["", "_key"];
        if (_key isNotEqualTo DIK_END) exitWith {};
        if (!isNull curatorCamera) exitWith {};
        [nil, true] call WHF_fnc_toggleEarplugs;
        nil
    }];
};
