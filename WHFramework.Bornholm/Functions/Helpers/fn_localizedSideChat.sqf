/*
Function: WHF_fnc_localizedSideChat

Description:
    Localize and show a side chat message.

Parameters:
    Array | Object source:
        The source of the message. Can be a unit or a [side, identity] array.
        This message only shows if the side matches the player's side.
        See also: https://community.bistudio.com/wiki/sideChat
    String message:
        The message to localize and show.
    Array params:
        (Optional, default [])
        The parameters to format the message with.

Author:
    thegamecracks

*/
params ["_source", "_message", ["_params", []]];
_message = format ([_message call BIS_fnc_localize] + _params);
_source sideChat _message;
