/*
Function: WHF_fnc_localizeRole

Description:
    Localize the given role ID.

Parameters:
    String role:
        The role ID to localize.

Returns:
    String

Author:
    thegamecracks

*/
params ["_role"];
switch (_role) do {
    case "autorifleman": {localize "str_b_soldier_ar_f0"};
    case "engineer": {localize "str_b_engineer_f0"};
    case "jtac": {localize "str_a3_b_ctrg_soldier_jtac_tna_f0"};
    case "rifleman": {localize "str_dn_rifleman"};
    case "sniper": {localize "str_b_sniper_f0"};
    case "uav": {localize "str_a3_b_soldier_uav_f0"};
    default {
        private _key = format ["STR_WHF_roles_%1", _role];
        if (isLocalized _key) then {localize _key} else {_role}
    };
}
