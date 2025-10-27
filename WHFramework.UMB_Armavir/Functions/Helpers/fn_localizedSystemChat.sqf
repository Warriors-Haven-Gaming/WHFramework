/*
Function: WHF_fnc_localizedSystemChat

Description:
    Localize and show a system chat message.

Parameters:
    String message:
        The message to localize and show.
    Array params:
        (Optional, default [])
        The parameters to format the message with.

Author:
    thegamecracks

*/
params ["_message", ["_params", []]];
_message = format ([_message call BIS_fnc_localize] + _params);
systemChat _message;
