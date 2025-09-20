/*
Function: WHF_fnc_getLastLoadout

Description:
    Get the player's last loadout.
    If no last loadout could be found, an empty array is returned.

Parameters:
    String role:
        (Optional, default player getVariable ["WHF_role", ""])
        The role to get the player's last loadout for.
    String collection:
        (Optional, default WHF_loadout_collection)
        The loadout collection to retrieve the player's last loadout from.
        Use "" or "default" to retrieve the default loadout.

Returns:
    Array

Author:
    thegamecracks

*/
params [["_role", player getVariable ["WHF_role", ""]], ["_collection", WHF_loadout_collection]];
if (_role isEqualTo "") exitWith {[]};

private _loadouts = missionProfileNamespace getVariable ["WHF_last_loadouts", createHashMap];
private _key = [_collection, _role];
private _loadout = _loadouts getOrDefaultCall [_key, {switch (_role) do {
    case "arty": {[["CUP_arifle_M4A1","","","",["30Rnd_556x45_Stanag_Tracer_Red",30],[],""],[],["CUP_hgun_Colt1911","","","",["CUP_7Rnd_45ACP_1911",7],[],""],["CUP_U_B_USMC_MCCUU_gloves",[["FirstAidKit",5]]],["CUP_V_B_Eagle_SPC_Crew",[["FirstAidKit",1],["CUP_7Rnd_45ACP_1911",2,7],["SmokeShell",3,1],["30Rnd_556x45_Stanag_Tracer_Red",11,30]]],[],"CUP_H_CVC","CUP_G_Shades_Blue",[],["ItemMap","B_UavTerminal","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS7_Hide"]]};
    case "aa": {[["CUP_arifle_M16A4_Aim_Laser","","CUP_acc_ANPEQ_15_Flashlight_Black_L","CUP_optic_LeupoldMk4_CQ_T",["30Rnd_556x45_Stanag_Tracer_Red",30],[],""],["CUP_launch_FIM92Stinger_Loaded","","","",["CUP_Stinger_M",1],[],""],[],["CUP_U_B_USMC_MCCUU_gloves",[["FirstAidKit",5]]],["CUP_V_B_Eagle_SPC_AT",[["30Rnd_556x45_Stanag_Tracer_Red",11,30],["SmokeShell",3,1],["CUP_HandGrenade_M67",2,1]]],["CUP_B_USMC_MOLLE_WDL",[["FirstAidKit",10],["CUP_Stinger_M",1,1]]],"CUP_H_LWHv2_MARPAT_comms_cov_fr","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS7_Hide"]]};
    case "at": {[["CUP_arifle_M16A4_Aim_Laser","","CUP_acc_ANPEQ_15_Flashlight_Black_L","CUP_optic_LeupoldMk4_CQ_T",["30Rnd_556x45_Stanag_Tracer_Red",30],[],""],["CUP_launch_MAAWS","","","CUP_optic_MAAWS_Scope",["CUP_MAAWS_HEAT_M",1],[],""],[],["CUP_U_B_USMC_MCCUU_gloves",[["FirstAidKit",5]]],["CUP_V_B_Eagle_SPC_AT",[["30Rnd_556x45_Stanag_Tracer_Red",11,30],["SmokeShell",3,1],["CUP_HandGrenade_M67",2,1]]],["CUP_B_USMC_MOLLE_WDL",[["FirstAidKit",3],["CUP_MAAWS_HEAT_M",4,1]]],"CUP_H_LWHv2_MARPAT_comms_cov_fr","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS7_Hide"]]};
    case "autorifleman": {[["CUP_lmg_M249","","","CUP_optic_Elcan",["CUP_200Rnd_TE4_Red_Tracer_556x45_M249",200],[],""],[],[],["CUP_U_B_USMC_MCCUU_gloves",[["FirstAidKit",5]]],["CUP_V_B_Eagle_SPC_AR",[["FirstAidKit",13],["CUP_HandGrenade_M67",2,1],["SmokeShell",3,1]]],["CUP_B_USMC_MOLLE_WDL",[["FirstAidKit",2],["CUP_200Rnd_TE4_Red_Tracer_556x45_M249",7,200]]],"CUP_H_LWHv2_MARPAT_NVG_gog_cov2","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS7_Hide"]]};
    case "engineer": {[["CUP_arifle_M4A1_Aim","","CUP_acc_ANPEQ_15_Flashlight_Black_L","CUP_optic_LeupoldMk4_CQ_T",["30Rnd_556x45_Stanag_Tracer_Red",30],[],""],[],[],["CUP_U_B_USMC_MCCUU_gloves",[["FirstAidKit",5]]],["CUP_V_B_Eagle_SPC_AT",[["CUP_HandGrenade_M67",2,1],["SmokeShell",3,1],["30Rnd_556x45_Stanag_Tracer_Red",11,30]]],["CUP_B_USMC_MOLLE_WDL",[["ToolKit",1],["MineDetector",1],["FirstAidKit",8],["CUP_PipeBomb_M",3,1]]],"CUP_H_LWHv2_MARPAT_comms_cov_fr","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS7_Hide"]]};
    case "jtac": {[["CUP_srifle_DMR_LeupoldMk4","","CUP_acc_ANPEQ_15_OD","CUP_optic_LeupoldMk4",["CUP_20Rnd_762x51_DMR",20],[],"CUP_bipod_Harris_1A2_L_BLK"],[],[],["CUP_U_B_USMC_MCCUU_roll",[["FirstAidKit",5]]],["CUP_V_B_Eagle_SPC_DMR",[["CUP_HandGrenade_M67",2,1],["CUP_20Rnd_TE1_Red_Tracer_762x51_DMR",6,20],["SmokeShell",3,1]]],["CUP_B_USMC_MOLLE_WDL",[["FirstAidKit",20],["CUP_20Rnd_TE1_Red_Tracer_762x51_DMR",10,20]]],"CUP_H_USA_Cap_MARSOC_DEF","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS7_Hide"]]};
    case "medic": {[["CUP_arifle_M4A1_Aim","","CUP_acc_ANPEQ_15_Flashlight_Black_L","CUP_optic_LeupoldMk4_CQ_T",["30Rnd_556x45_Stanag_Tracer_Red",30],[],""],[],[],["CUP_U_B_USMC_MCCUU_roll",[["FirstAidKit",5]]],["CUP_V_B_Eagle_SPC_Corpsman",[["30Rnd_556x45_Stanag_Tracer_Red",12,30],["CUP_HandGrenade_M67",1,1],["SmokeShell",3,1]]],["CUP_B_USMC_MOLLE_WDL",[["Medikit",1],["FirstAidKit",27]]],"CUP_H_LWHv2_MARPAT_cov_fr","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS7_Hide"]]};
    case "pilot_cas_heli": {[["CUP_smg_MP5A5","","","",["CUP_30Rnd_Red_Tracer_9x19_MP5",30],[],""],[],["CUP_hgun_Colt1911","","","",["CUP_7Rnd_45ACP_1911",7],[],""],["CUP_U_B_USMC_PilotOverall",[["FirstAidKit",5]]],["CUP_V_B_PilotVest",[["FirstAidKit",3],["CUP_7Rnd_45ACP_1911",2,7],["CUP_30Rnd_Red_Tracer_9x19_MP5",3,30],["SmokeShell",3,1]]],[],"CUP_H_SPH4_visor","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]};
    case "pilot_cas_plane": {[["CUP_smg_MP5A5","","","",["CUP_30Rnd_Red_Tracer_9x19_MP5",30],[],""],[],["CUP_hgun_Colt1911","","","",["CUP_7Rnd_45ACP_1911",7],[],""],["CUP_U_B_USMC_PilotOverall",[["FirstAidKit",5]]],["CUP_V_B_PilotVest",[["FirstAidKit",3],["CUP_7Rnd_45ACP_1911",2,7],["CUP_30Rnd_Red_Tracer_9x19_MP5",3,30],["SmokeShell",3,1]]],[],"CUP_H_SPH4_visor","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]};
    case "pilot_transport": {[["CUP_smg_MP5A5","","","",["CUP_30Rnd_Red_Tracer_9x19_MP5",30],[],""],[],["CUP_hgun_Colt1911","","","",["CUP_7Rnd_45ACP_1911",7],[],""],["CUP_U_B_USMC_PilotOverall",[["FirstAidKit",5]]],["CUP_V_B_PilotVest",[["FirstAidKit",3],["CUP_7Rnd_45ACP_1911",2,7],["CUP_30Rnd_Red_Tracer_9x19_MP5",3,30],["SmokeShell",3,1]]],[],"CUP_H_SPH4_visor","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]};
    case "rifleman": {[["CUP_arifle_M16A4_Aim_Laser","","CUP_acc_ANPEQ_15_Flashlight_Black_L","CUP_optic_LeupoldMk4_CQ_T",["30Rnd_556x45_Stanag_Tracer_Red",30],[],""],["CUP_launch_M136_Loaded","","","",["CUP_M136_M",1],[],""],[],["CUP_U_B_USMC_MCCUU_gloves",[["FirstAidKit",5]]],["CUP_V_B_Eagle_SPC_AT",[["CUP_HandGrenade_M67",4,1],["30Rnd_556x45_Stanag_Tracer_Red",8,30],["SmokeShell",3,1]]],["CUP_B_USMC_MOLLE_WDL",[["FirstAidKit",20],["30Rnd_556x45_Stanag_Tracer_Red",17,30]]],"CUP_H_LWHv2_MARPAT_comms_cov_fr","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS7_Hide"]]};
    case "sniper": {[["CUP_srifle_M107_LeupoldVX3","","","CUP_optic_LeupoldMk4_25x50_LRT",["CUP_10Rnd_127x99_M107",10],[],""],[],["CUP_hgun_Colt1911","","","",["CUP_7Rnd_45ACP_1911",7],[],""],["CUP_U_B_USMC_Ghillie_WDL",[["FirstAidKit",10]]],["CUP_V_B_Eagle_SPC_DMR",[["CUP_10Rnd_127x99_M107",6,10],["SmokeShell",3,1],["CUP_7Rnd_45ACP_1911",3,7]]],["CUP_B_USMC_MOLLE_WDL",[["FirstAidKit",10],["MineDetector",1],["CUP_10Rnd_127x99_M107",13,10]]],"","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS7_Hide"]]};
    case "uav": {[["CUP_arifle_M16A4_Base","","CUP_acc_ANPEQ_15_Flashlight_Black_L","CUP_optic_LeupoldMk4_CQ_T",["30Rnd_556x45_Stanag_Tracer_Red",30],[],""],[],[],["CUP_U_B_USMC_MCCUU_gloves",[["FirstAidKit",5]]],["CUP_V_B_Eagle_SPC_Rifleman",[["CUP_HandGrenade_M67",2,1],["30Rnd_556x45_Stanag_Tracer_Red",11,30],["SmokeShell",3,1]]],["CUP_B_USMC_MOLLE_WDL",[["FirstAidKit",10]]],"CUP_H_USA_Cap_MARSOC_DEF","CUP_G_Oakleys_Clr",[],["ItemMap","B_UavTerminal","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS7_Hide"]]};
    default {[]};
}}];
[_loadout] call WHF_fnc_filterUnitLoadout
