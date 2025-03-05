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

// Curators
[
    "WHF_curators_uids",
    "EDITBOX",
    ["STR_WHF_settings_curators_uids", "STR_WHF_settings_curators_uids_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_curators"],
    "[]",
    true,
    {
        WHF_curators_uids = parseSimpleArray _this;
        if (isServer) then {call WHF_fnc_refreshCurators};
    },
    false
] call WHF_fnc_addSetting;

// Damage
[
    "WHF_playerDamageScale",
    "SLIDER",
    ["STR_WHF_settings_damage_scale", "STR_WHF_settings_damage_scale_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_damage"],
    [0.05, 1, 0.3, 0, true],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_recruitDamageScale",
    "SLIDER",
    ["STR_WHF_settings_damage_scale_recruit", "STR_WHF_settings_damage_scale_recruit_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_damage"],
    [0.05, 1, 0.3, 0, true],
    true,
    {},
    false
] call WHF_fnc_addSetting;

// Factions
/*
    Useful scripts for adding new factions:
    - Units:
        units player apply {typeOf _x}
    - Vehicles:
        _types = player nearObjects ["LandVehicle",50] apply {typeOf _x};
        _types sort true;
        _types
    - Patches:
        configSourceAddonList (configFile >> "CfgVehicles" >> typeOf cursorObject)
*/
[
    "WHF_factions_selected",
    "LIST",
    ["STR_WHF_settings_factions_selected", "STR_WHF_settings_factions_selected_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_factions"],
    [["random", "base", "csat", "csat_pacific", "rhsafrf", "cup_afrf", "cup_afrf_modern", "cup_npc"], ["STR_WHF_settings_factions_selected_random", "STR_WHF_factions_base", "STR_WHF_factions_csat", "STR_WHF_factions_csat_pacific", "STR_WHF_factions_rhsafrf", "STR_WHF_factions_cup_afrf", "STR_WHF_factions_cup_afrf_modern", "STR_WHF_factions_cup_npc"]],
    true,
    {call WHF_fnc_cycleFaction},
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

// Flares
[
    "WHF_signalFlareEnabled",
    "CHECKBOX",
    ["STR_WHF_settings_flares_enabled", "STR_WHF_settings_flares_enabled_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_flares"],
    true,
    true,
    {
        if (!isNil "WHF_signalFlareLoop_script") then {terminate WHF_signalFlareLoop_script};
        if (_this) then {WHF_signalFlareLoop_script = 0 spawn WHF_fnc_signalFlareLoop};
    },
    false
] call WHF_fnc_addSetting;
[
    "WHF_signalFlareCheckInterval",
    "SLIDER",
    ["STR_WHF_settings_flares_interval", "STR_WHF_settings_flares_interval_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_flares"],
    [1, 30, 5, 0, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_signalFlareGlobalCooldown",
    "SLIDER",
    ["STR_WHF_settings_flares_globalCooldown", "STR_WHF_settings_flares_globalCooldown_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_flares"],
    [0, 300, 0, 0, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_signalFlareGroupCooldown",
    "SLIDER",
    ["STR_WHF_settings_flares_groupCooldown", "STR_WHF_settings_flares_groupCooldown_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_flares"],
    [0, 300, 120, 0, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_signalFlareMaxDistance",
    "SLIDER",
    ["STR_WHF_settings_flares_maxDistance", "STR_WHF_settings_flares_maxDistance_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_flares"],
    [50, 1000, 500, 0, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_signalFlareRevealDistance",
    "SLIDER",
    ["STR_WHF_settings_flares_revealDistance", "STR_WHF_settings_flares_revealDistance_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_flares"],
    [100, 500, 500, 0, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;

// Garbage Collection
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

// Halo
[
    "WHF_halo_altitude_unit",
    "SLIDER",
    ["STR_WHF_settings_halo_altitude_unit", "STR_WHF_settings_halo_altitude_unit_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_halo"],
    [300, 2000, 800, 0, false],
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_halo_altitude_vehicle",
    "SLIDER",
    ["STR_WHF_settings_halo_altitude_vehicle", "STR_WHF_settings_halo_altitude_vehicle_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_halo"],
    [300, 2000, 400, 0, false],
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_halo_parachuteAltitude_unit",
    "SLIDER",
    ["STR_WHF_settings_halo_parachuteAltitude_unit", "STR_WHF_settings_halo_parachuteAltitude_unit_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_halo"],
    [80, 300, 80, 0, false],
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_halo_parachuteAltitude_vehicle",
    "SLIDER",
    ["STR_WHF_settings_halo_parachuteAltitude_vehicle", "STR_WHF_settings_halo_parachuteAltitude_vehicle_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_halo"],
    [100, 500, 200, 0, false],
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_halo_spacing_unit",
    "SLIDER",
    ["STR_WHF_settings_halo_spacing_unit", "STR_WHF_settings_halo_spacing_unit_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_halo"],
    [10, 30, 10, 0, false],
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_halo_spacing_vehicle",
    "SLIDER",
    ["STR_WHF_settings_halo_spacing_vehicle", "STR_WHF_settings_halo_spacing_vehicle_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_halo"],
    [20, 50, 20, 0, false],
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_halo_antiair_distance",
    "SLIDER",
    ["STR_WHF_settings_halo_antiair_distance", "STR_WHF_settings_halo_antiair_distance_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_halo"],
    [0, 5000, 2000, 0, false],
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

// Recruits
[
    "WHF_recruits_limit",
    "SLIDER",
    ["STR_WHF_settings_recruits_limit", "STR_WHF_settings_recruits_limit_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_recruits"],
    [0, 50, 6, 0, false],
    true,
    {WHF_recruits_limit = round WHF_recruits_limit},
    false
] call WHF_fnc_addSetting;
[
    "WHF_recruits_skill",
    "SLIDER",
    ["STR_WHF_settings_recruits_skill", "STR_WHF_settings_recruits_skill_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_recruits"],
    [0, 1, 1, 0, true],
    true,
    {},
    false
] call WHF_fnc_addSetting;

// Revive
[
    "WHF_selfRevive_minTime",
    "SLIDER",
    ["STR_WHF_settings_revive_self_minTime", "STR_WHF_settings_revive_self_minTime_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_revive"],
    [0, 180, 30, 0, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_selfRevive_duration",
    "SLIDER",
    ["STR_WHF_settings_revive_self_duration", "STR_WHF_settings_revive_self_duration_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_revive"],
    [0.5, 30, 10, 1, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_selfRevive_FAKs",
    "LIST",
    ["STR_WHF_settings_revive_self_FAKs", "STR_WHF_settings_revive_self_FAKs_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_revive"],
    [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], [], 4],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_revive_captiveDuration",
    "SLIDER",
    ["STR_WHF_settings_revive_captive", "STR_WHF_settings_revive_captive_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_revive"],
    [0, 30, 5, 1, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_revive_bleedout",
    "SLIDER",
    ["STR_WHF_settings_revive_bleedout", "STR_WHF_settings_revive_bleedout_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_revive"],
    [30, 3600, 600, 0, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_revive_FAKs",
    "LIST",
    ["STR_WHF_settings_revive_FAKs", "STR_WHF_settings_revive_FAKs_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_revive"],
    [[0, 1, 2, 3, 4, 5], [], 1],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_revive_medic",
    "CHECKBOX",
    ["STR_WHF_settings_revive_medic", "STR_WHF_settings_revive_medic_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_revive"],
    true,
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_revive_medkit",
    "CHECKBOX",
    ["STR_WHF_settings_revive_medkit", "STR_WHF_settings_revive_medkit_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_revive"],
    true,
    true,
    {},
    false
] call WHF_fnc_addSetting;

// Time
[
    "WHF_requestSkipTime_enabled",
    "CHECKBOX",
    ["STR_WHF_settings_time_skipEnabled", "STR_WHF_settings_time_skipEnabled_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_time"],
    true,
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_requestSkipTime_cooldown",
    "SLIDER",
    ["STR_WHF_settings_time_skipCooldown", "STR_WHF_settings_time_skipCooldown_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_time"],
    [5, 60, 30, 0, false],
    true,
    {WHF_requestSkipTime_cooldown = _this * 60},
    false
] call WHF_fnc_addSetting;
[
    "WHF_timeMultiplier",
    "SLIDER",
    ["STR_WHF_settings_time_multiplier", "STR_WHF_settings_time_multiplier_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_time"],
    [1, 60, 10, 1, false],
    true,
    {
        WHF_timeMultiplier = round (_this * 10) / 10;
        if (isServer) then {setTimeMultiplier WHF_timeMultiplier};
    },
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

// Units
[
    "WHF_units_skill",
    "LIST",
    ["STR_WHF_settings_units_skill", "STR_WHF_settings_units_skill_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_units"],
    [[0, 1, 2, 3, 4], ["STR_A3_OPTIONS_LOW", "STR_A3_OPTIONS_MEDIUM", "STR_A3_OPTIONS_HIGH", "STR_A3_OPTIONS_VERYHIGH", "STR_A3_OPTIONS_EXTREME"]],
    true,
    {call WHF_fnc_refreshUnitSkills},
    false
] call WHF_fnc_addSetting;
[
    "WHF_units_equipment",
    "LIST",
    ["STR_WHF_settings_units_equipment", "STR_WHF_settings_units_equipment_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_units"],
    [[[], ["flashlights"], ["lasers"]], ["STR_A3_None", "STR_WHF_settings_units_equipment_flashlights", "STR_WHF_settings_units_equipment_lasers"], 1],
    true,
    {},
    false
] call WHF_fnc_addSetting;
