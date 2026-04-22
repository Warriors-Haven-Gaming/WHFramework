/*
Function: WHF_fnc_stringStartsWith

Description:
    Checks if the given string starts with some prefix (case-sensitive).

Parameters:
    String string:
        The string to check for a suffix.
    String prefix:
        The prefix to look for.

Returns:
    Boolean

Examples:
    (begin example)
        ["foobar", "foo"] call WHF_fnc_stringStartsWith;
    (end)

Author:
    thegamecracks

*/
params ["_string", "_prefix"];
_string select [0, count _prefix] isEqualTo _prefix
