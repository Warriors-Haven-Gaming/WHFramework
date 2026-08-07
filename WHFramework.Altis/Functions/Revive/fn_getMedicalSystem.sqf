/*
Function: WHF_fnc_getMedicalSystem

Description:
    Check if a custom medical system like ACE Medical is active.
    If vanilla medical is active, return an empty string.

Returns:
    String

Author:
    thegamecracks

*/
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) exitWith {"ace_medical"};
if (missionNamespace getVariable ["diw_armor_plates_main_enable", false] isEqualTo true) exitWith {"diw_armor_plates"};
""
