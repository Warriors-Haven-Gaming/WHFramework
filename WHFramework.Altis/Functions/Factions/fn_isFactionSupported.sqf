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
    case "rhsafrf": {["rhs_main"]};
    default {-1};
};
if (_patches isEqualTo -1) exitWith {false};

_patches findIf {!isClass (configFile >> "CfgPatches" >> _x)} < 0
