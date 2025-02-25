/*
Function: WHF_fnc_initIncapacitatedHandlers

Description:
    Sets up player damage handlers for incapacitation.

Author:
    thegamecracks

*/
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) exitWith {};
player addEventHandler ["HandleDamage", {call {
    params ["_unit", "", "_damage", "", "", "_hitIndex"];
    if (lifeState _unit isEqualTo "INCAPACITATED") exitWith {};

    // Check for fatal wounds to body, head, or unknown part
    if !(_hitIndex in [7, 2, -1]) exitWith {};
    if (_damage < 0.95) exitWith {};

    if (isDamageAllowed _unit) then {
        _unit allowDamage false;
        private _jipID = netId _unit + ":incapUnit";
        [_unit] remoteExec ["WHF_fnc_incapUnit", 0, _jipID];
    };
    0.95
}}];
