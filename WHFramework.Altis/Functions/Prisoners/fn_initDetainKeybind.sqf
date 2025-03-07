/*
Function: WHF_fnc_initDetainKeybind

Description:
    Set up a keybind to detain units.

Author:
    thegamecracks

*/
#include "\a3\ui_f\hpp\definedikcodes.inc"
if (isClass (configFile >> "CfgPatches" >> "cba_keybinding")) then {
    [
        localize "$STR_WHF_settings",
        "detain",
        [localize "$STR_WHF_detain_keybind", localize "$STR_WHF_detain_keybind_tooltip"],
        WHF_fnc_detainAction,
        {},
        [DIK_T, [false, false, false]]
    ] call CBA_fnc_addKeybind;
} else {
    findDisplay 46 displayAddEventHandler ["KeyDown", {
        params ["", "_key"];
        if (_key isEqualTo DIK_T) then {call WHF_fnc_detainAction};
    }];
};
