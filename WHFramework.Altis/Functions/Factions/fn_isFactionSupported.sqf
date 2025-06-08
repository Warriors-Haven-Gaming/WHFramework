/*
Function: WHF_fnc_isFactionSupported

Description:
    Check if the given faction is supported by the client.

Parameters:
    String faction:
        The faction to check.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_faction"];

private _patches = switch (_faction) do {
    case "base": {[]};
    case "csat": {[]};
    case "csat_pacific": {[]};
    case "aaf": {[]};
    case "ldf": {[]};
    case "ws_tura": {["Characters_f_lxWS", "Vehicles_F_lxWS_Truck_02"]};
    case "rhsafrf": {["rhs_main"]};
    case "cup_afrf": {["CUP_Creatures_Military_Russia", "CUP_WheeledVehicles_UAZ"]};
    case "cup_afrf_modern": {["CUP_Creatures_Military_RussiaModern_Units", "CUP_WheeledVehicles_GAZTigr"]};
    case "cup_npc": {["CUP_Creatures_Military_NAPA", "CUP_WheeledVehicles_Hilux"]};
    case "cup_tk": {["CUP_Creatures_Military_Taki", "CUP_WheeledVehicles_Hilux"]};
    case "cup_tk_ins": {["CUP_Creatures_Military_TakiInsurgents", "CUP_WheeledVehicles_Hilux"]};
    case "nato": {[]};
    case "nato_pacific": {[]};
    case "cup_usa_woodland": {["CUP_Creatures_Military_USArmy","CUP_WheeledVehicles_NewM1097"]};
    case "cup_usmc_woodland": {["CUP_Creatures_Military_USMC","CUP_WheeledVehicles_NewM1097"]};
    default {-1};
};
if (_patches isEqualTo -1) exitWith {false};

_patches findIf {!isClass (configFile >> "CfgPatches" >> _x)} < 0
