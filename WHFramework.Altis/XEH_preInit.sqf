/*
Script: XEH_preInit.sqf

Description:
    Executed globally When CBA is loaded.
    https://github.com/CBATeam/CBA_A3/wiki/CBA-Settings-System

    If CBA is not loaded, this is executed at mission start by init(Server).sqf.
    This is to allow assigning default settings via WHF_fnc_addSetting.

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

// Damage
[
    "WHF_playerDamageReduction",
    "SLIDER",
    ["STR_WHF_settings_damage_reduction", "STR_WHF_settings_damage_reduction_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_damage"],
    [0, 1, 0.3, 0, true],
    true,
    {},
    false
] call WHF_fnc_addSetting;

// Factions
[
    "WHF_factions_current",
    "LIST",
    ["STR_WHF_settings_factions_current", "STR_WHF_settings_factions_current_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_factions"],
    [["base"], ["STR_WHF_settings_factions_current_base"]],
    true,
    {}, // TODO: check required mods
    false
] call WHF_fnc_addSetting;

// Fitness
[
    "WHF_fitness_stamina",
    "CHECKBOX",
    ["STR_WHF_settings_fitness_stamina", "STR_WHF_settings_fitness_stamina_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_fitness"],
    false,
    true,
    {player enableStamina _this},
    false
] call WHF_fnc_addSetting;
[
    "WHF_fitness_sway",
    "SLIDER",
    ["STR_WHF_settings_fitness_sway", "STR_WHF_settings_fitness_sway_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_fitness"],
    [0, 1, 0.1, 0, true],
    true,
    {player setCustomAimCoef _this},
    false
] call WHF_fnc_addSetting;

// Garbage Collection
[
    "WHF_gcLootLifetime",
    "SLIDER",
    ["STR_WHF_settings_gc_gcLootLifetime", "STR_WHF_settings_gc_gcLootLifetime_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_gc"],
    [30, 3600, 300, 0, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_gcDeletionDistance",
    "SLIDER",
    ["STR_WHF_settings_gc_gcDeletionDistance", "STR_WHF_settings_gc_gcDeletionDistance_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_gc"],
    [0, 10000, 500, 0, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_gcUnhideDistance",
    "SLIDER",
    ["STR_WHF_settings_gc_gcUnhideDistance", "STR_WHF_settings_gc_gcUnhideDistance_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_gc"],
    [0, 10000, 500, 0, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;

// Loadouts
[
    "WHF_loadout_collection",
    "EDITBOX",
    ["STR_WHF_settings_loadouts_collection", "STR_WHF_settings_loadouts_collection_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_loadouts"],
    "main",
    false,
    {},
    false
] call WHF_fnc_addSetting;

// Self Revive
[
    "WHF_selfRevive_minTime",
    "SLIDER",
    ["STR_WHF_settings_selfRevive_minTime", "STR_WHF_settings_selfRevive_minTime_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_selfRevive"],
    [0, 180, 30, 0, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_selfRevive_duration",
    "SLIDER",
    ["STR_WHF_settings_selfRevive_duration", "STR_WHF_settings_selfRevive_duration_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_selfRevive"],
    [0.5, 30, 10, 1, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_selfRevive_FAKs",
    "LIST",
    ["STR_WHF_settings_selfRevive_FAKs", "STR_WHF_settings_selfRevive_FAKs_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_selfRevive"],
    [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], [], 4],
    true,
    {},
    false
] call WHF_fnc_addSetting;

// Unflip
[
    "WHF_unflip_duration",
    "SLIDER",
    ["STR_WHF_settings_unflip_duration", "STR_WHF_settings_unflip_duration_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_unflip"],
    [0, 30, 10, 0, false],
    true,
    {call WHF_fnc_initUnflipAction},
    false
] call WHF_fnc_addSetting;
[
    "WHF_unflip_angle",
    "SLIDER",
    ["STR_WHF_settings_unflip_angle", "STR_WHF_settings_unflip_angle_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_unflip"],
    [-1, 1, 0.1, 0, true],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_unflip_radius",
    "SLIDER",
    ["STR_WHF_settings_unflip_radius", "STR_WHF_settings_unflip_radius_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_unflip"],
    [5, 50, 25, 0, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
