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
    case "rhsafrf": {["rhs_main"]};
    case "cup_afrf": {["CUP_Creatures_Military_Russia", "CUP_WheeledVehicles_UAZ"]};
    case "cup_afrf_modern": {["CUP_Creatures_Military_RussiaModern_Units", "CUP_WheeledVehicles_GAZTigr"]};
    default {-1};
};
if (_patches isEqualTo -1) exitWith {false};

_patches findIf {!isClass (configFile >> "CfgPatches" >> _x)} < 0
