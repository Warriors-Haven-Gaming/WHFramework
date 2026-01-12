/*
Function: WHF_fnc_showSecuredPrisoner

Description:
    Show a prisoner being secured.
    Function must be remote executed on client from the server.

Parameters:
    Object caller:
        The unit that released the prisoner.
    Object target:
        The unit to be imprisoned. Unit must be local.
    Number seed:
        A random number to determine which message to show.

Author:
    thegamecracks

*/
if (isNull player) exitWith {};
params ["_caller", "_target", "_seed"];

private _type = toLowerANSI typeOf _target;
private _side = [_target, true] call BIS_fnc_objectSide;
private _messages = [
    "STR_WHF_prisoner_secured_1",
    "STR_WHF_prisoner_secured_2",
    "STR_WHF_prisoner_secured_3"
];
private _titles = switch (true) do {
    case ("officer" in _type): {[
        "STR_WHF_prisoner_secured_officer_1"
    ]};
    case (_side isEqualTo civilian): {[
        "STR_WHF_prisoner_secured_civilian_1"
    ]};
    default {[
        "STR_WHF_prisoner_secured_enemy_1",
        "STR_WHF_prisoner_secured_enemy_2",
        "STR_WHF_prisoner_secured_enemy_3"
    ]};
};
private _selectSeeded = {
    params ["_arr", "_offset"];
    _arr select floor (_seed + _offset random (count _arr - 0.0001))
};

private _message = localize ([_messages, 0] call _selectSeeded);
private _title = localize ([_titles, 1] call _selectSeeded);

[side group player, "BLU"] sideChat format [_message, name _caller, _title];

if (local _caller || {local (_target call WHF_fnc_getDetainedBy)}) then {
    private _notif = format [localize "STR_WHF_prisoner_secured_notification", _title];
    ["TaskSucceeded", ["", _notif]] call BIS_fnc_showNotification;
};
