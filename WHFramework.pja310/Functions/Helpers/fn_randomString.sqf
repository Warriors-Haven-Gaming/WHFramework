/*
Function: WHF_fnc_randomString

Description:
    Generates a random string of the given length.

Parameters:
    Number length:
        The length of the string.

Returns:
    String

Author:
    thegamecracks

*/
params ["_length"];

private _chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789" splitString "";
private _selected = [];
for "_i" from 1 to _length do {_selected pushBack selectRandom _chars};
_selected joinString "";
