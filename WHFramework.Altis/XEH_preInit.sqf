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
    "LIST",
    ["STR_WHF_settings_aps_enabled", "STR_WHF_settings_aps_enabled_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_aps"],
    [[0, 1, 2, 3], ["STR_A3_Disabled", "STR_WHF_settings_aps_enabled_players", "STR_WHF_settings_aps_enabled_recruits", "STR_WHF_settings_aps_enabled_everyone"], 2],
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
    [2, 16, 4, 1, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_aps_ammoMRAP",
    "LIST",
    ["STR_WHF_settings_aps_ammoMRAP", "STR_WHF_settings_aps_ammoMRAP_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_aps"],
    [[0, 1, 2, 3, 4, 5, 6, 7, 8], [], 2],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_aps_ammoAPC",
    "LIST",
    ["STR_WHF_settings_aps_ammoAPC", "STR_WHF_settings_aps_ammoAPC_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_aps"],
    [[0, 1, 2, 3, 4, 5, 6, 7, 8], [], 3],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_aps_ammoMBT",
    "LIST",
    ["STR_WHF_settings_aps_ammoMBT", "STR_WHF_settings_aps_ammoMBT_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_aps"],
    [[0, 1, 2, 3, 4, 5, 6, 7, 8], [], 4],
    true,
    {},
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
    [0.05, 1, 0.4, 0, true],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_recruitDamageScale",
    "SLIDER",
    ["STR_WHF_settings_damage_scale_recruit", "STR_WHF_settings_damage_scale_recruit_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_damage"],
    [0.05, 1, 0.4, 0, true],
    true,
    {},
    false
] call WHF_fnc_addSetting;

// Drones
[
    "WHF_drones_combat_enabled",
    "CHECKBOX",
    ["STR_WHF_settings_drones_combat_enabled", "STR_WHF_settings_drones_combat_enabled_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_drones"],
    true,
    true,
    {
        if (!isNil "WHF_combatDroneLoop_script") then {terminate WHF_combatDroneLoop_script};
        if (_this) then {WHF_combatDroneLoop_script = 0 spawn WHF_fnc_combatDroneLoop};
    },
    false
] call WHF_fnc_addSetting;
[
    "WHF_drones_combat_uavOnly",
    "CHECKBOX",
    ["STR_WHF_settings_drones_combat_uavOnly", "STR_WHF_settings_drones_combat_uavOnly_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_drones"],
    false,
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_drones_owned",
    "CHECKBOX",
    ["STR_WHF_settings_drones_owned", "STR_WHF_settings_drones_owned_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_drones"],
    true,
    false,
    {},
    false
] call WHF_fnc_addSetting;

// Earplugs
[
    "WHF_earplugs_volume",
    "SLIDER",
    ["STR_WHF_settings_earplugs_volume", "STR_WHF_settings_earplugs_volume_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_earplugs"],
    [0.1, 1, 0.8, 0, true],
    false,
    {WHF_earplugs_volume = 1 - _this},
    false
] call WHF_fnc_addSetting;
[
    "WHF_earplugs_radio",
    "CHECKBOX",
    ["STR_WHF_settings_earplugs_radio", "STR_WHF_settings_earplugs_radio_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_earplugs"],
    true,
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_earplugs_music",
    "CHECKBOX",
    ["STR_WHF_settings_earplugs_music", "STR_WHF_settings_earplugs_music_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_earplugs"],
    false,
    false,
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
private _blufor = [
    "WHF_factions_nato",
    "WHF_factions_nato_pacific",
    "WHF_factions_ef_mjtf_desert",
    "WHF_factions_ef_mjtf_woodland",
    "WHF_factions_ws_ion",
    "WHF_factions_ws_una",
    "WHF_factions_cup_usa_woodland",
    "WHF_factions_cup_usmc_woodland"
] apply {[_x, blufor]};

private _opfor = [
    "WHF_factions_base",
    "WHF_factions_csat",
    "WHF_factions_csat_pacific",
    "WHF_factions_aaf",
    "WHF_factions_ldf",
    "WHF_factions_ws_sfia",
    "WHF_factions_ws_tura",
    "WHF_factions_rhsafrf",
    "WHF_factions_cup_afrf",
    "WHF_factions_cup_afrf_modern",
    "WHF_factions_cup_npc",
    "WHF_factions_cup_tk",
    "WHF_factions_cup_tk_ins"
] apply {[_x, opfor]};

private _categories = [
    ["opfor", "str_east", opfor],
    ["blufor", "str_west", blufor]
];

{
    _x params ["_faction", "_factionSide"];
    {
        _x params ["_side", "_category", "_categorySide"];
        [
            format ["%1_%2", _faction, _side],
            "CHECKBOX",
            format ["STR_%1", _faction],
            ["STR_WHF_settings_factions", _category],
            _factionSide isEqualTo _categorySide,
            true,
            {},
            false
        ] call WHF_fnc_addSetting;
    } forEach _categories;
} forEach _blufor + _opfor;

call WHF_fnc_cycleFaction;

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
    "WHF_signalFlareBLUFOR",
    "CHECKBOX",
    ["STR_WHF_settings_flares_blufor", "STR_WHF_settings_flares_blufor_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_flares"],
    false,
    true,
    {},
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
    [50, 1500, 500, 0, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_signalFlareRevealDistance",
    "SLIDER",
    ["STR_WHF_settings_flares_revealDistance", "STR_WHF_settings_flares_revealDistance_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_flares"],
    [100, 1500, 750, 0, false],
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
    [0, 5000, 1000, 0, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_halo_enemy_distance",
    "SLIDER",
    ["STR_WHF_settings_halo_enemy_distance", "STR_WHF_settings_halo_enemy_distance_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_halo"],
    [0, 500, 100, 0, false],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_halo_mission_exfil",
    "CHECKBOX",
    ["STR_WHF_settings_halo_mission_exfil", "STR_WHF_settings_halo_mission_exfil_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_halo"],
    false,
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
[
    "WHF_icons_3D_style",
    "LIST",
    ["STR_WHF_settings_icons_3D_style", "STR_WHF_settings_icons_3D_style_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_icons"],
    [[0, 1], ["STR_WHF_settings_icons_3D_style_hex", "STR_WHF_settings_icons_3D_style_overhead"], 1],
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_icons_map",
    "CHECKBOX",
    ["STR_WHF_settings_icons_map", "STR_WHF_settings_icons_map_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_icons"],
    true,
    false,
    {},
    false
] call WHF_fnc_addSetting;

// Icon Colors
[
    "WHF_icons_color_blufor",
    "COLOR",
    "STR_WHF_settings_icons_color_blufor",
    ["STR_WHF_settings", "STR_WHF_settings_icons_color"],
    [0, 0.85, 1],
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_icons_color_opfor",
    "COLOR",
    "STR_WHF_settings_icons_color_opfor",
    ["STR_WHF_settings", "STR_WHF_settings_icons_color"],
    [0.85, 0, 0],
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_icons_color_independent",
    "COLOR",
    "STR_WHF_settings_icons_color_independent",
    ["STR_WHF_settings", "STR_WHF_settings_icons_color"],
    [0, 0.85, 0],
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_icons_color_civilian",
    "COLOR",
    "STR_WHF_settings_icons_color_civilian",
    ["STR_WHF_settings", "STR_WHF_settings_icons_color"],
    [0.7, 0, 0.85],
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_icons_color_incap",
    "COLOR",
    "STR_WHF_settings_icons_color_incap",
    ["STR_WHF_settings", "STR_WHF_settings_icons_color"],
    [1, 0.5, 0],
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_icons_color_dead",
    "COLOR",
    "STR_WHF_settings_icons_color_dead",
    ["STR_WHF_settings", "STR_WHF_settings_icons_color"],
    [0.2, 0.2, 0.2],
    false,
    {},
    false
] call WHF_fnc_addSetting;

// JTAC
[
    "WHF_jtac_tasks_max",
    "LIST",
    ["STR_WHF_settings_jtac_tasks_max", "STR_WHF_settings_jtac_tasks_max_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_jtac"],
    [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], ["STR_A3_Disabled"], 5],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_jtac_tasks_cooldown",
    "SLIDER",
    ["STR_WHF_settings_jtac_tasks_cooldown", "STR_WHF_settings_jtac_tasks_cooldown_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_jtac"],
    [0, 300, 15, 1, false],
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
    "WHF_missions_annex_forts",
    "SLIDER",
    ["STR_WHF_settings_missions_annex_forts", "STR_WHF_settings_missions_annex_forts_tooltip"],
    ["STR_WHF_settings_missions", "STR_WHF_settings_missions_annex"],
    [0, 2, 1, 0, true],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_missions_annex_units_types",
    "EDITBOX",
    ["STR_WHF_settings_missions_annex_units_types", "STR_WHF_settings_missions_annex_units_types_tooltip"],
    ["STR_WHF_settings_missions", "STR_WHF_settings_missions_annex"],
    '[["standard", 2, 8, 0], 0.8, ["recon", 2, 8, 1], 0.1, ["elite", 4, 8, 2], 0.05, ["sniper", 2, 2, 3], 0.05]',
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
    '["standard", "supply", "mrap", "apc", "ifv", "mbt", "aa"]',
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
    "WHF_missions_main_units",
    "SLIDER",
    ["STR_WHF_settings_missions_main_units", "STR_WHF_settings_missions_main_units_tooltip"],
    ["STR_WHF_settings_missions", "STR_WHF_settings_missions_main"],
    [0.25, 2, 1, 0, true],
    true,
    {},
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
[
    "WHF_missions_side_units",
    "SLIDER",
    ["STR_WHF_settings_missions_side_units", "STR_WHF_settings_missions_side_units_tooltip"],
    ["STR_WHF_settings_missions", "STR_WHF_settings_missions_side"],
    [0.25, 2, 1, 0, true],
    true,
    {},
    false
] call WHF_fnc_addSetting;

// Recruits
[
    "WHF_recruits_identity",
    "LIST",
    ["STR_WHF_settings_recruits_identity", "STR_WHF_settings_recruits_identity_tooltip"],
    "STR_WHF_settings_recruits",
    [["american", "british", "chinese", "french", "polish", "russian"], ["STR_WHF_settings_recruits_identity_american", "STR_WHF_settings_recruits_identity_british", "STR_WHF_settings_recruits_identity_chinese", "STR_WHF_settings_recruits_identity_french", "STR_WHF_settings_recruits_identity_polish", "STR_WHF_settings_recruits_identity_russian"], 0],
    false,
    {
        WHF_recruits_speaker_types = switch (_this) do {
            case "american": {["Male01ENG","Male02ENG","Male03ENG","Male04ENG","Male05ENG","Male06ENG","Male07ENG","Male08ENG","Male09ENG","Male10ENG","Male11ENG","Male12ENG"]};
            case "british": {["Male01ENGB","Male02ENGB","Male03ENGB","Male04ENGB","Male05ENGB"]};
            case "chinese": {["Male01CHI","Male02CHI","Male03CHI"]};
            case "french": {["Male01FRE","Male02FRE","Male03FRE"]};
            case "polish": {["Male01POL","Male02POL","Male03POL"]};
            case "russian": {["Male01RUS","Male02RUS","Male03RUS"]};
            default {["NoVoice"]};
        };
    },
    false
] call WHF_fnc_addSetting;
[
    "WHF_recruits_speaker",
    "LIST",
    ["STR_WHF_settings_recruits_speaker", "STR_WHF_settings_recruits_speaker_tooltip"],
    "STR_WHF_settings_recruits",
    [[0, 1, 2, 3], ["str_enabled", "STR_WHF_settings_recruits_speaker_recruits", "STR_WHF_settings_recruits_speaker_player", "STR_A3_Disabled"], 1],
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_recruits_limit",
    "SLIDER",
    ["STR_WHF_settings_recruits_limit", "STR_WHF_settings_recruits_limit_tooltip"],
    "STR_WHF_settings_recruits",
    [0, 50, 6, 0, false],
    true,
    {WHF_recruits_limit = round _this},
    false
] call WHF_fnc_addSetting;
[
    "WHF_recruits_limit_global",
    "SLIDER",
    ["STR_WHF_settings_recruits_limit_global", "STR_WHF_settings_recruits_limit_global_tooltip"],
    "STR_WHF_settings_recruits",
    [0, 200, 24, 0, false],
    true,
    {WHF_recruits_limit_global = round _this},
    false
] call WHF_fnc_addSetting;
[
    "WHF_recruits_limit_player",
    "SLIDER",
    ["STR_WHF_settings_recruits_limit_player", "STR_WHF_settings_recruits_limit_player_tooltip"],
    "STR_WHF_settings_recruits",
    [0, 100, 20, 0, false],
    true,
    {WHF_recruits_limit_player = round _this},
    false
] call WHF_fnc_addSetting;
[
    "WHF_recruits_skill",
    "SLIDER",
    ["STR_WHF_settings_recruits_skill", "STR_WHF_settings_recruits_skill_tooltip"],
    "STR_WHF_settings_recruits",
    [0, 1, 1, 0, true],
    true,
    {},
    false
] call WHF_fnc_addSetting;

[
    "WHF_recruits_revive_radius_group",
    "SLIDER",
    ["STR_WHF_settings_recruits_revive_radius_group", "STR_WHF_settings_recruits_revive_radius_group_tooltip"],
    ["STR_WHF_settings_recruits", "STR_WHF_settings_recruits_revive"],
    [30, 500, 500, 0, false],
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_recruits_revive_radius",
    "SLIDER",
    ["STR_WHF_settings_recruits_revive_radius", "STR_WHF_settings_recruits_revive_radius_tooltip"],
    ["STR_WHF_settings_recruits", "STR_WHF_settings_recruits_revive"],
    [30, 500, 50, 0, false],
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_recruits_revive_targets",
    "LIST",
    ["STR_WHF_settings_recruits_revive_targets", "STR_WHF_settings_recruits_revive_targets_tooltip"],
    ["STR_WHF_settings_recruits", "STR_WHF_settings_recruits_revive"],
    [[0, 1, 2], ["STR_WHF_settings_recruits_revive_targets_group", "STR_WHF_settings_recruits_revive_targets_side", "STR_WHF_settings_recruits_revive_targets_all"], 1],
    false,
    {},
    false
] call WHF_fnc_addSetting;

[
    "WHF_recruits_incap_hold",
    "SLIDER",
    ["STR_WHF_settings_recruits_incap_hold", "STR_WHF_settings_recruits_incap_hold_tooltip"],
    ["STR_WHF_settings_recruits", "STR_WHF_settings_recruits_incap"],
    [0, 600, 25, 0, false],
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_recruits_incap_hold_assigned",
    "SLIDER",
    ["STR_WHF_settings_recruits_incap_hold_assigned", "STR_WHF_settings_recruits_incap_hold_assigned_tooltip"],
    ["STR_WHF_settings_recruits", "STR_WHF_settings_recruits_incap"],
    [0, 600, 180, 0, false],
    false,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_recruits_incap_FAKs",
    "LIST",
    ["STR_WHF_settings_recruits_incap_FAKs", "STR_WHF_settings_recruits_incap_FAKs_tooltip"],
    ["STR_WHF_settings_recruits", "STR_WHF_settings_recruits_incap"],
    [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30], ["STR_A3_Disabled"], 6],
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_recruits_incap_noFAKs",
    "CHECKBOX",
    ["STR_WHF_settings_recruits_incap_noFAKs", "STR_WHF_settings_recruits_incap_noFAKs_tooltip"],
    ["STR_WHF_settings_recruits", "STR_WHF_settings_recruits_incap"],
    false,
    true,
    {},
    false
] call WHF_fnc_addSetting;

// Repack
[
    "WHF_repack_prefer_capacity",
    "CHECKBOX",
    ["STR_WHF_settings_repack_prefer_capacity", "STR_WHF_settings_repack_prefer_capacity_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_repack"],
    true,
    false,
    {},
    false
] call WHF_fnc_addSetting;

// Revive
[
    "WHF_selfRevive_maxPlayers",
    "SLIDER",
    ["STR_WHF_settings_revive_self_maxPlayers", "STR_WHF_settings_revive_self_maxPlayers_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_revive"],
    [0, 100, 20, 0, false],
    true,
    {WHF_selfRevive_maxPlayers = round _this},
    false
] call WHF_fnc_addSetting;
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
    [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30], [], 3],
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
    [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], [], 1],
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
[
    "WHF_revive_FAKs_modded",
    "CHECKBOX",
    ["STR_WHF_settings_revive_FAKs_modded", "STR_WHF_settings_revive_FAKs_modded_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_revive"],
    true,
    true,
    {},
    false
] call WHF_fnc_addSetting;
[
    "WHF_revive_medkit_modded",
    "CHECKBOX",
    ["STR_WHF_settings_revive_medkit_modded", "STR_WHF_settings_revive_medkit_modded_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_revive"],
    true,
    true,
    {},
    false
] call WHF_fnc_addSetting;

// Safezones
[
    "WHF_safezone_enabled",
    "CHECKBOX",
    ["STR_WHF_settings_safezone_enabled", "STR_WHF_settings_safezone_enabled_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_safezone"],
    true,
    true,
    {},
    false
] call WHF_fnc_addSetting;

// Service
[
    "WHF_service_enabled",
    "CHECKBOX",
    ["STR_WHF_settings_service_enabled", "STR_WHF_settings_service_enabled_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_service"],
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
    false,
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
    [1, 120, 10, 1, false],
    true,
    {
        WHF_timeMultiplier = round (_this * 10) / 10;
        ["refresh"] call WHF_fnc_setTimeMultiplier;
    },
    false
] call WHF_fnc_addSetting;
[
    "WHF_timeMultiplier_night",
    "SLIDER",
    ["STR_WHF_settings_time_multiplier_night", "STR_WHF_settings_time_multiplier_night_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_time"],
    [1, 120, 40, 1, false],
    true,
    {
        WHF_timeMultiplier_night = round (_this * 10) / 10;
        ["refresh"] call WHF_fnc_setTimeMultiplier;
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
