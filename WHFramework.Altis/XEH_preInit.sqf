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

// APS
[
    "WHF_aps_enabled",
    "CHECKBOX",
    ["STR_WHF_settings_aps_enabled", "STR_WHF_settings_aps_enabled_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_aps"],
    true,
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_aps_enabled_ai",
    "CHECKBOX",
    ["STR_WHF_settings_aps_enabled_ai", "STR_WHF_settings_aps_enabled_ai_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_aps"],
    true,
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_aps_radius",
    "SLIDER",
    ["STR_WHF_settings_aps_radius", "STR_WHF_settings_aps_radius_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_aps"],
    [100, 300, 150, 0, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_aps_rate",
    "SLIDER",
    ["STR_WHF_settings_aps_rate", "STR_WHF_settings_aps_rate_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_aps"],
    [8, 128, 32, 0, false],
    true,
    {WHF_aps_rate = 1 / round _this},
    false
] call WHF_fnc_addSetting;
[
    "WHF_aps_distance",
    "SLIDER",
    ["STR_WHF_settings_aps_distance", "STR_WHF_settings_aps_distance_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_aps"],
    [4, 16, 4, 1, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_aps_ammoMRAP",
    "SLIDER",
    ["STR_WHF_settings_aps_ammoMRAP", "STR_WHF_settings_aps_ammoMRAP_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_aps"],
    [0, 8, 2, 0, false],
    true,
    {WHF_aps_ammoMRAP = round _this},
    false
] call WHF_fnc_addSetting;
[
    "WHF_aps_ammoAPC",
    "SLIDER",
    ["STR_WHF_settings_aps_ammoAPC", "STR_WHF_settings_aps_ammoAPC_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_aps"],
    [0, 8, 3, 0, false],
    true,
    {WHF_aps_ammoAPC = round _this},
    false
] call WHF_fnc_addSetting;
[
    "WHF_aps_ammoMBT",
    "SLIDER",
    ["STR_WHF_settings_aps_ammoMBT", "STR_WHF_settings_aps_ammoMBT_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_aps"],
    [0, 8, 4, 0, false],
    true,
    {WHF_aps_ammoMBT = round _this},
    false
] call WHF_fnc_addSetting;

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
    "WHF_halo_eject",
    "CHECKBOX",
    ["STR_WHF_settings_halo_eject", "STR_WHF_settings_halo_eject_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_halo"],
    true,
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
[
    "WHF_halo_limit_player",
    "SLIDER",
    ["STR_WHF_settings_halo_limit_player", "STR_WHF_settings_halo_limit_player_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_halo"],
    [0, 100, 20, 0, false],
    true,
    {WHF_halo_limit_player = round _this},
    false
] call WHF_fnc_addSetting;

// Icons
[
    "WHF_icons_3D",
    "CHECKBOX",
    ["STR_WHF_settings_icons_3D", "STR_WHF_settings_icons_3D_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_icons"],
    true,
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_icons_3D_group",
    "CHECKBOX",
    ["STR_WHF_settings_icons_3D_group", "STR_WHF_settings_icons_3D_group_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_icons"],
    false,
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_icons_3D_distance",
    "SLIDER",
    ["STR_WHF_settings_icons_3D_distance", "STR_WHF_settings_icons_3D_distance_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_icons"],
    [10, 10000, 6000, 0, false],
    false,
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

// Locks
[
    "WHF_locks_enabled",
    "CHECKBOX",
    ["STR_WHF_settings_locks_enabled", "STR_WHF_settings_locks_enabled_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_locks"],
    true,
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_locks_copilot",
    "CHECKBOX",
    ["STR_WHF_settings_locks_copilot", "STR_WHF_settings_locks_copilot_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_locks"],
    true,
    true,
    {},
    false
] call WHF_fnc_addSetting;

// Prisoners
[
    "WHF_detain_cooldown",
    "SLIDER",
    ["STR_WHF_settings_prisoners_detain_cooldown", "STR_WHF_settings_prisoners_detain_cooldown_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_prisoners"],
    [3, 30, 3, 1, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;

// Missions
[
    "WHF_missions_annex_size",
    "SLIDER",
    ["STR_WHF_settings_missions_annex_size", "STR_WHF_settings_missions_annex_size_tooltip"],
    ["STR_WHF_settings_missions", "STR_WHF_settings_missions_annex"],
    [0.5, 2, 1, 0, true],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_missions_annex_threshold",
    "SLIDER",
    ["STR_WHF_settings_missions_annex_threshold", "STR_WHF_settings_missions_annex_threshold_tooltip"],
    ["STR_WHF_settings_missions", "STR_WHF_settings_missions_annex"],
    [0.3, 1, 0.55, 0, true],
    true,
    {WHF_missions_annex_threshold = 1 - _this},
    false
] call WHF_fnc_addSetting;
[
    "WHF_missions_annex_units",
    "SLIDER",
    ["STR_WHF_settings_missions_annex_units", "STR_WHF_settings_missions_annex_units_tooltip"],
    ["STR_WHF_settings_missions", "STR_WHF_settings_missions_annex"],
    [0.5, 2, 1, 0, true],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_missions_annex_units_types",
    "EDITBOX",
    ["STR_WHF_settings_missions_annex_units_types", "STR_WHF_settings_missions_annex_units_types_tooltip"],
    ["STR_WHF_settings_missions", "STR_WHF_settings_missions_annex"],
    '["standard"]',
    true,
    {WHF_missions_annex_units_types = parseSimpleArray _this},
    false
] call WHF_fnc_addSetting;
[
    "WHF_missions_annex_vehicles",
    "SLIDER",
    ["STR_WHF_settings_missions_annex_vehicles", "STR_WHF_settings_missions_annex_vehicles_tooltip"],
    ["STR_WHF_settings_missions", "STR_WHF_settings_missions_annex"],
    [0, 2, 1, 0, true],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_missions_annex_vehicles_types",
    "EDITBOX",
    ["STR_WHF_settings_missions_annex_vehicles_types", "STR_WHF_settings_missions_annex_vehicles_types_tooltip"],
    ["STR_WHF_settings_missions", "STR_WHF_settings_missions_annex"],
    '["standard", "supply"]',
    true,
    {WHF_missions_annex_vehicles_types = parseSimpleArray _this},
    false
] call WHF_fnc_addSetting;
[
    "WHF_missions_annex_reinforce_frequency_units",
    "SLIDER",
    ["STR_WHF_settings_missions_annex_reinforce_frequency_units", "STR_WHF_settings_missions_annex_reinforce_frequency_units_tooltip"],
    ["STR_WHF_settings_missions", "STR_WHF_settings_missions_annex"],
    [10, 600, 120, 0, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_missions_annex_reinforce_frequency_vehicles",
    "SLIDER",
    ["STR_WHF_settings_missions_annex_reinforce_frequency_vehicles", "STR_WHF_settings_missions_annex_reinforce_frequency_vehicles_tooltip"],
    ["STR_WHF_settings_missions", "STR_WHF_settings_missions_annex"],
    [10, 600, 180, 0, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_missions_aaa_types",
    "EDITBOX",
    ["STR_WHF_settings_missions_aaa_types", "STR_WHF_settings_missions_aaa_types_tooltip"],
    ["STR_WHF_settings_missions", "STR_WHF_destroyAAA_title"],
    '["aa_short",1, "aa_medium",1, "aa_long",1]',
    true,
    {WHF_missions_aaa_types = parseSimpleArray _this},
    false
] call WHF_fnc_addSetting;

[
    "WHF_missions_main_enabled",
    "CHECKBOX",
    ["STR_WHF_settings_missions_main_enabled", "STR_WHF_settings_missions_main_enabled_tooltip"],
    ["STR_WHF_settings_missions", "STR_WHF_settings_missions_main"],
    true,
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_missions_main_min",
    "SLIDER",
    ["STR_WHF_settings_missions_main_min", "STR_WHF_settings_missions_main_min_tooltip"],
    ["STR_WHF_settings_missions", "STR_WHF_settings_missions_main"],
    [1, 3, 1, 0, false],
    true,
    {WHF_missions_main_min = round _this},
    false
] call WHF_fnc_addSetting;
[
    "WHF_missions_main_max",
    "SLIDER",
    ["STR_WHF_settings_missions_main_max", "STR_WHF_settings_missions_main_max_tooltip"],
    ["STR_WHF_settings_missions", "STR_WHF_settings_missions_main"],
    [1, 3, 1, 0, false],
    true,
    {WHF_missions_main_max = round _this},
    false
] call WHF_fnc_addSetting;

[
    "WHF_missions_music_main",
    "CHECKBOX",
    ["STR_WHF_settings_missions_music_main", "STR_WHF_settings_missions_music_main_tooltip"],
    ["STR_WHF_settings_missions", "STR_WHF_settings_missions_music"],
    true,
    true,
    {},
    false
] call WHF_fnc_addSetting;

[
    "WHF_missions_side_enabled",
    "CHECKBOX",
    ["STR_WHF_settings_missions_side_enabled", "STR_WHF_settings_missions_side_enabled_tooltip"],
    ["STR_WHF_settings_missions", "STR_WHF_settings_missions_side"],
    true,
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_missions_side_min",
    "SLIDER",
    ["STR_WHF_settings_missions_side_min", "STR_WHF_settings_missions_side_min_tooltip"],
    ["STR_WHF_settings_missions", "STR_WHF_settings_missions_side"],
    [1, 10, 1, 0, false],
    true,
    {WHF_missions_side_min = round _this},
    false
] call WHF_fnc_addSetting;
[
    "WHF_missions_side_max",
    "SLIDER",
    ["STR_WHF_settings_missions_side_max", "STR_WHF_settings_missions_side_max_tooltip"],
    ["STR_WHF_settings_missions", "STR_WHF_settings_missions_side"],
    [1, 10, 3, 0, false],
    true,
    {WHF_missions_side_max = round _this},
    false
] call WHF_fnc_addSetting;

// Recruits
[
    "WHF_recruits_speaker",
    "CHECKBOX",
    ["STR_WHF_settings_recruits_speaker", "STR_WHF_settings_recruits_speaker_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_recruits"],
    false,
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_recruits_limit",
    "SLIDER",
    ["STR_WHF_settings_recruits_limit", "STR_WHF_settings_recruits_limit_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_recruits"],
    [0, 50, 6, 0, false],
    true,
    {WHF_recruits_limit = round _this},
    false
] call WHF_fnc_addSetting;
[
    "WHF_recruits_limit_global",
    "SLIDER",
    ["STR_WHF_settings_recruits_limit_global", "STR_WHF_settings_recruits_limit_global_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_recruits"],
    [0, 200, 40, 0, false],
    true,
    {WHF_recruits_limit_global = round _this},
    false
] call WHF_fnc_addSetting;
[
    "WHF_recruits_limit_player",
    "SLIDER",
    ["STR_WHF_settings_recruits_limit_player", "STR_WHF_settings_recruits_limit_player_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_recruits"],
    [0, 100, 20, 0, false],
    true,
    {WHF_recruits_limit_player = round _this},
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
[
    "WHF_recruits_incap_FAKs",
    "LIST",
    ["STR_WHF_settings_recruits_incap_FAKs", "STR_WHF_settings_recruits_incap_FAKs_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_recruits"],
    [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], ["STR_A3_Disabled"], 6],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_recruits_incap_noFAKs",
    "CHECKBOX",
    ["STR_WHF_settings_recruits_incap_noFAKs", "STR_WHF_settings_recruits_incap_noFAKs_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_recruits"],
    false,
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
    [0, 180, 3, 0, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_selfRevive_duration",
    "SLIDER",
    ["STR_WHF_settings_revive_self_duration", "STR_WHF_settings_revive_self_duration_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_revive"],
    [0.5, 30, 2.5, 1, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_selfRevive_FAKs",
    "LIST",
    ["STR_WHF_settings_revive_self_FAKs", "STR_WHF_settings_revive_self_FAKs_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_revive"],
    [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], [], 3],
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
    [0, 30, 3.5, 0, false],
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
