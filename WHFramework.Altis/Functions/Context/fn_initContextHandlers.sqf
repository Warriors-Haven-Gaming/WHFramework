/*
Function: WHF_fnc_initContextHandlers

Description:
    Sets up context menu handlers.

Author:
    thegamecracks

*/
#include "\a3\ui_f\hpp\definedikcodes.inc"
if (isClass (configFile >> "CfgPatches" >> "cba_keybinding")) then {
    [
        "$STR_WHF_settings",
        "WHF_keybind_context_menu",
        ["$STR_WHF_context_keybind", "$STR_WHF_context_keybind_tooltip"],
        WHF_fnc_contextMenuShow,
        WHF_fnc_contextMenuHide,
        [DIK_LWIN, [false, false, false]]
    ] call CBA_fnc_addKeybind;
} else {
    findDisplay 46 displayAddEventHandler ["KeyDown", {
        params ["", "_key"];
        if (_key isEqualTo DIK_LWIN) then {call WHF_fnc_contextMenuShow};
    }];
    findDisplay 46 displayAddEventHandler ["KeyUp", {
        params ["", "_key"];
        if (_key isEqualTo DIK_LWIN) then {call WHF_fnc_contextMenuHide};
    }];
};
