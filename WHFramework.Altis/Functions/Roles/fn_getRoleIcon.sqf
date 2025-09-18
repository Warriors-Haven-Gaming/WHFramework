/*
Function: WHF_fnc_getRoleIcon

Description:
    Return the icon representing the given role.
    If an invalid role is given, return an empty string.

Parameters:
    String role:
        The role to get the icon of.

Returns:
    String

Author:
    thegamecracks

*/
params ["_role"];
private _type = switch (_role) do {
    case "arty": {"B_support_Mort_F"};
    case "aa": {"B_soldier_AA_F"};
    case "at": {"B_soldier_AT_F"};
    case "autorifleman": {"B_soldier_AR_F"};
    case "engineer": {"B_engineer_F"};
    case "jtac": {"B_recon_JTAC_F"};
    case "medic": {"B_medic_F"};
    case "pilot_cas": {"B_Fighter_Pilot_F"};
    case "pilot_transport": {"B_Helipilot_F"};
    case "rifleman": {"B_Soldier_F"};
    case "sniper": {"B_sniper_F"};
    case "uav": {"B_soldier_UAV_F"};
    default {""};
};
if (_type isEqualTo "") exitWith {""};
getText (configFile >> "CfgVehicles" >> _type >> "icon")
