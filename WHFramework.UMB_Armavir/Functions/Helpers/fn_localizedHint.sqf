/*
Function: WHF_fnc_localizedHint

Description:
    Localize and show a hint message.
    The parameters are the same as the format command, except that
    the message may be a localizable key.

Parameters:
    String message:
    Array params:
        (Optional, default [])
        The parameters to format the message with.

Author:
    thegamecracks

*/
if !(_this isEqualType []) then {_this = [_this]};
params ["_message"];
private _values = _this select [1];
hint format ([_message call BIS_fnc_localize] + _values);
