/*
Script: XEH_preInit.sqf

Description:
    Executed globally When CBA is loaded.
    https://github.com/CBATeam/CBA_A3/wiki/CBA-Settings-System

    If CBA is not loaded, this is executed at mission start by init(Server).sqf.
    This is to allow assigning default settings via WH_fnc_addSetting.

Author:
    thegamecracks

*/

// Parameters:
//     _setting     - Unique setting name. Matches resulting variable name <STRING>
//     _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
//     _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
//     _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
//     _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
//     _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
//     _script      - Script to execute when setting is changed. (optional) <CODE>
//     _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>

// Self Revive
[
    "WH_selfRevive_minTime",
    "SLIDER",
    ["STR_WH_settings_selfRevive_minTime", "STR_WH_settings_selfRevive_minTime_tooltip"],
    ["STR_WH_settings", "STR_WH_settings_selfRevive"],
    [0, 180, 30, 0, false],
    true,
    {},
    false
] call WH_fnc_addSetting;
[
    "WH_selfRevive_duration",
    "SLIDER",
    ["STR_WH_settings_selfRevive_duration", "STR_WH_settings_selfRevive_duration_tooltip"],
    ["STR_WH_settings", "STR_WH_settings_selfRevive"],
    [0.5, 30, 10, 1, false],
    true,
    {},
    false
] call WH_fnc_addSetting;
[
    "WH_selfRevive_FAKs",
    "LIST",
    ["STR_WH_settings_selfRevive_FAKs", "STR_WH_settings_selfRevive_FAKs_tooltip"],
    ["STR_WH_settings", "STR_WH_settings_selfRevive"],
    [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], [], 4],
    true,
    {},
    false
] call WH_fnc_addSetting;

// Unflip
[
    "WH_unflip_duration",
    "SLIDER",
    ["STR_WH_settings_unflip_duration", "STR_WH_settings_unflip_duration_tooltip"],
    ["STR_WH_settings", "STR_WH_settings_unflip"],
    [0, 30, 10, 0, false],
    true,
    {call WH_fnc_initUnflipAction},
    false
] call WH_fnc_addSetting;
[
    "WH_unflip_angle",
    "SLIDER",
    ["STR_WH_settings_unflip_angle", "STR_WH_settings_unflip_angle_tooltip"],
    ["STR_WH_settings", "STR_WH_settings_unflip"],
    [-1, 1, 0.1, 0, true],
    true,
    {},
    false
] call WH_fnc_addSetting;
[
    "WH_unflip_radius",
    "SLIDER",
    ["STR_WH_settings_unflip_radius", "STR_WH_settings_unflip_radius_tooltip"],
    ["STR_WH_settings", "STR_WH_settings_unflip"],
    [5, 50, 25, 0, false],
    true,
    {},
    false
] call WH_fnc_addSetting;
