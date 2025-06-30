/*
Function: WHF_fnc_initCruiseKeybind

Description:
    Set up keybinds for cruise control.

Author:
    thegamecracks

*/
#include "\a3\ui_f\hpp\definedikcodes.inc"
#define MOUSE_SCROLL_UP 0xF8
#define MOUSE_SCROLL_DOWN 0xF9

if (isClass (configFile >> "CfgPatches" >> "cba_keybinding")) then {
    [
        "$STR_WHF_settings",
        "WHF_keybind_cruise",
        ["$STR_WHF_cruise_keybind", "$STR_WHF_cruise_keybind_tooltip"],
        WHF_fnc_cruiseAction,
        {},
        [DIK_INSERT, [false, false, false]]
    ] call CBA_fnc_addKeybind;
    [
        "$STR_WHF_settings",
        "WHF_keybind_cruise_up",
        ["$STR_WHF_cruise_up_keybind", "$STR_WHF_cruise_up_keybind_tooltip"],
        {true call WHF_fnc_cruiseActionAdjust},
        {},
        [MOUSE_SCROLL_UP, [false, true, false]]
    ] call CBA_fnc_addKeybind;
    [
        "$STR_WHF_settings",
        "WHF_keybind_cruise_down",
        ["$STR_WHF_cruise_down_keybind", "$STR_WHF_cruise_down_keybind_tooltip"],
        {false call WHF_fnc_cruiseActionAdjust},
        {},
        [MOUSE_SCROLL_DOWN, [false, true, false]]
    ] call CBA_fnc_addKeybind;
} else {
    findDisplay 46 displayAddEventHandler ["KeyDown", {
        params ["", "_key", "", "_ctrl"];
        if (_key isEqualTo DIK_INSERT) then {call WHF_fnc_cruiseAction};
        if (_ctrl && {_key isEqualTo MOUSE_SCROLL_UP}) then {true call WHF_fnc_cruiseActionAdjust};
        if (_ctrl && {_key isEqualTo MOUSE_SCROLL_DOWN}) then {false call WHF_fnc_cruiseActionAdjust};
        nil
    }];
};
