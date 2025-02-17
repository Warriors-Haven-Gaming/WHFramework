/*
Function: WHF_fnc_initIncapacitatedHandlers

Description:
    Sets up player damage handlers for incapacitation.

Author:
    thegamecracks

*/
// TODO: disable when ACE medical is enabled
player addEventHandler ["HandleDamage", {call {
    params ["_unit", "", "_damage", "", "", "_hitIndex"];
    if (lifeState _unit isEqualTo "INCAPACITATED") exitWith {};

    // Check for fatal wounds to body, head, or unknown part
    if !(_hitIndex in [7, 2, -1]) exitWith {};
    if (_damage < 0.95) exitWith {};

    if (isDamageAllowed _unit) then {
        _unit allowDamage false;
        if (!isNil "WHF_incapacitated_script" && {!scriptDone WHF_incapacitated_script}) then {
            terminate WHF_incapacitated_script;
        };
        WHF_incapacitated_script = [_unit] spawn WHF_fnc_triggerIncapacitation;
        if (isMultiplayer) then {[_unit] remoteExec ["WHF_fnc_triggerIncapacitation", -clientOwner]};
    };
    0.95
}}];
