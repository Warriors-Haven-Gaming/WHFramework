/*
Function: WHF_fnc_setupVehicle

Description:
    Apply custom modifications to a vehicle.
    Function must be executed where vehicle is local.

Parameters:
    Object vehicle:
        The vehicle to configure.

Author:
    thegamecracks

*/
params ["_vehicle"];
if (!local _vehicle) exitWith {};
if !(_vehicle isKindOf "AllVehicles") exitWith {};
if (_vehicle isKindOf "Man") exitWith {};

// NOTE: only prevents multiple calls for one client, locality transfer will
//       allow re-initialization
if (!isNil {_vehicle getVariable "WHF_setupVehicle_called"}) exitWith {};
_vehicle setVariable ["WHF_setupVehicle_called", true];

switch (true) do {
    // Vanilla
    case (_vehicle isKindOf "AFV_Wheeled_01_base_F"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "APC_Wheeled_01_base_F"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "MBT_01_base_F"): {
        [_vehicle, WHF_aps_ammoMBT] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "MRAP_01_base_F"): {
        [_vehicle, WHF_aps_ammoMRAP] call WHF_fnc_addAPS;
    };
    // CUP
    case (_vehicle isKindOf "CUP_AAV_Base"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_Boxer_Base"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_Challenger2_base"): {
        [_vehicle, WHF_aps_ammoMBT] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_Dingo_Base"): {
        [_vehicle, WHF_aps_ammoMRAP] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_FV510_Base"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_LAV25_Base"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_M1A2Abrams_Base"): {
        [_vehicle, WHF_aps_ammoMBT] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_M2Bradley_Base"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_Mastiff_Base"): {
        [_vehicle, WHF_aps_ammoMRAP] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_MCV80_Base"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_RG31_BASE"): {
        [_vehicle, WHF_aps_ammoMRAP] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_Ridgback_Base"): {
        [_vehicle, WHF_aps_ammoMRAP] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_StrykerBase"): {
        [_vehicle, WHF_aps_ammoAPC] call WHF_fnc_addAPS;
    };
    case (_vehicle isKindOf "CUP_T90M_Base"): {
        [_vehicle, WHF_aps_ammoMBT] call WHF_fnc_addAPS;
    };
    // QAV - AbramsX
    case (_vehicle isKindOf "qav_abramsx_base"): {
        [_vehicle, WHF_aps_ammoMBT] call WHF_fnc_addAPS;
    };
};
