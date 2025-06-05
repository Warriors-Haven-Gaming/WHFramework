/*
Function: WHF_fnc_getLastLoadout

Description:
    Get the player's last loadout.
    If no last loadout could be found, an empty array is returned.

Parameters:
    String role:
        (Optional, default player getVariable ["WHF_role", ""])
        The role to get the player's last loadout for.

Returns:
    Array

Author:
    thegamecracks

*/
params [["_role", player getVariable ["WHF_role", ""]]];
if (_role isEqualTo "") exitWith {[]};

private _loadouts = missionProfileNamespace getVariable ["WHF_last_loadouts", createHashMap];
private _key = [WHF_loadout_collection, _role];
_loadouts getOrDefaultCall [_key, {switch (_role) do {
    case "arty": {[["arifle_MXC_F","","acc_pointer_IR","optic_Holosight",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",5]]],["V_PlateCarrier2_rgr",[["30Rnd_65x39_caseless_mag",8,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["B_Mortar_01_weapon_F",[]],"H_HelmetB_light","G_Combat",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]};
    case "at": {[["arifle_MXC_F","","acc_pointer_IR","optic_Holosight",["30Rnd_65x39_caseless_mag",30],[],""],["launch_B_Titan_short_F","","","",["Titan_AT",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",5]]],["V_PlateCarrier1_rgr",[["FirstAidKit",5],["30Rnd_65x39_caseless_mag",8,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1]]],["B_Carryall_cbr",[["FirstAidKit",2],["Titan_AT",3,1]]],"H_HelmetB_light_desert","G_Combat",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]};
    case "autorifleman": {[["arifle_MX_SW_F","","acc_pointer_IR","",["100Rnd_65x39_caseless_mag",100],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",5]]],["V_PlateCarrier2_rgr",[["100Rnd_65x39_caseless_mag",4,100],["16Rnd_9x21_Mag",2,16],["HandGrenade",1,1],["SmokeShellGreen",1,1],["SmokeShell",3,1],["Chemlight_green",1,1]]],["B_Carryall_cbr",[["FirstAidKit",20],["100Rnd_65x39_caseless_mag",6,100]]],"H_HelmetB_grass","G_Combat",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]};
    case "engineer": {[["arifle_MXC_F","","acc_pointer_IR","optic_Holosight",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",5]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_mag",9,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1]]],["B_Carryall_cbr",[["ToolKit",1],["MineDetector",1],["FirstAidKit",12],["SatchelCharge_Remote_Mag",1,1],["DemoCharge_Remote_Mag",2,1]]],"H_HelmetB_desert","G_Combat",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]};
    case "jtac": {[["arifle_MX_GL_F","muzzle_snds_H","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_snds_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",5]]],["V_PlateCarrier2_rgr",[["30Rnd_65x39_caseless_mag",5,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["B_IR_Grenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],["B_Carryall_cbr",[["FirstAidKit",20],["1Rnd_HE_Grenade_shell",10,1],["30Rnd_65x39_caseless_mag",10,30]]],"H_Watchcap_camo","G_Aviator",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]};
    case "medic": {[["arifle_MX_F","","acc_pointer_IR","",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",5]]],["V_PlateCarrierSpec_rgr",[["30Rnd_65x39_caseless_mag",7,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1]]],["B_Carryall_cbr",[["Medikit",1],["FirstAidKit",30]]],"H_HelmetB_light_desert","G_Combat",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]};
    case "pilot_cas": {[[],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_PilotCoveralls",[["FirstAidKit",4],["16Rnd_9x21_Mag",3,16],["SmokeShellOrange",1,1],["Chemlight_green",2,1]]],[],[],"H_PilotHelmetFighter_B","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]]};
    case "pilot_transport": {[["SMG_01_F","","","optic_Holosight_smg",["30Rnd_45ACP_Mag_SMG_01",30],[],""],[],[],["U_B_HeliPilotCoveralls",[["FirstAidKit",5]]],["V_TacVest_blk",[["FirstAidKit",5],["30Rnd_45ACP_Mag_SMG_01",4,30],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["SmokeShell",1,1],["Chemlight_green",2,1]]],[],"H_PilotHelmetHeli_B","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]};
    case "rifleman": {[["arifle_MX_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",5]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",9,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1],["HandGrenade",2,1]]],["B_Carryall_cbr",[["FirstAidKit",30],["30Rnd_65x39_caseless_mag",8,30]]],"H_HelmetB","G_Combat",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]};
    case "sniper": {[["srifle_LRR_camo_F","","","optic_LRPS",["7Rnd_408_Mag",7],[],""],[],["hgun_P07_snds_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_GhillieSuit",[["FirstAidKit",7],["SmokeShell",1,1]]],["V_PlateCarrier2_rgr",[["16Rnd_9x21_Mag",2,16],["ClaymoreDirectionalMine_Remote_Mag",1,1],["APERSTripMine_Wire_Mag",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",2,1],["SmokeShell",4,1],["7Rnd_408_Mag",4,7]]],["B_Carryall_cbr",[["FirstAidKit",20],["7Rnd_408_Mag",11,7]]],"","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]};
    case "uav": {[["arifle_MX_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",5]]],["V_PlateCarrierSpec_rgr",[["30Rnd_65x39_caseless_mag",7,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["HandGrenade",1,1]]],["B_UAV_01_backpack_F",[]],"H_HelmetB","G_Combat",["Binocular","","","",[],[],""],["ItemMap","B_UavTerminal","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]};
    default {[]};
}}]
