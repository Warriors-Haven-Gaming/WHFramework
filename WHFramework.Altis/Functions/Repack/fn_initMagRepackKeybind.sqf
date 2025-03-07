/*
Function: WHF_fnc_initMagRepackKeybind

Description:
    Set up a keybind to repack magazines.

Author:
    thegamecracks

*/
#include "\a3\ui_f\hpp\definedikcodes.inc"
if (isClass (configFile >> "CfgPatches" >> "cba_keybinding")) then {
    [
        "$STR_WHF_settings",
        "WHF_keybind_repack",
        ["$STR_WHF_repack_keybind", "$STR_WHF_repack_keybind_tooltip"],
        {
            if !([focusOn] call WHF_fnc_canMagRepack) exitWith {};
            [focusOn] spawn WHF_fnc_magRepack;
        },
        {},
        [DIK_R, [false, true, false]]
    ] call CBA_fnc_addKeybind;
} else {
    findDisplay 46 displayAddEventHandler ["KeyDown", {
        params ["", "_key", "", "_ctrl"];
        if (!_ctrl) exitWith {};
        if (_key isNotEqualTo DIK_R) exitWith {};
        if !([focusOn] call WHF_fnc_canMagRepack) exitWith {};
        [focusOn] spawn WHF_fnc_magRepack;
    }];
};
