/*
Function: WHF_fnc_diaryLocalize

Description:
    Localize a string intended for diary records.
    This is meant to help improve legibility of entries in stringtable.xml,
    allowing writers using a simple text editor to take advantage of whitespace.

Parameters:
    String key:
        The string to be localized.

Returns:
    String

Author:
    thegamecracks

*/
params ["_key"];

private _string = localize _key;
_string = trim _string;
_string = _string regexReplace ["\s{2,}", " "];
_string = _string regexReplace ["<br/>\s+", "<br/>"];
_string
