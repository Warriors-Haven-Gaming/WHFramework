/*
Function: WHF_fnc_initHolsterKeybind

Description:
    Set up keybind for holstering weapons.

Author:
    thegamecracks

*/
#include "\a3\ui_f\hpp\definedikcodes.inc"

if (isClass (configFile >> "CfgPatches" >> "cba_keybinding")) then {
    [
        "$STR_WHF_settings",
        "WHF_keybind_holster",
        ["$STR_WHF_holster_keybind", "$STR_WHF_holster_keybind_tooltip"],
        {
            if (isClass (configFile >> "CfgPatches" >> "ace_weaponselect")) exitWith {};
            focusOn call WHF_fnc_holsterWeapon;
        },
        {},
        [DIK_4, [false, false, false]]
    ] call CBA_fnc_addKeybind;
} else {
    findDisplay 46 displayAddEventHandler ["KeyDown", {
        params ["", "_key"];
        if (_key isEqualTo DIK_4) then {focusOn call WHF_fnc_holsterWeapon};
        nil
    }];
};
