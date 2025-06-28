/*
Function: WHF_fnc_randomMarkerID

Description:
    Generates a random marker ID with the given prefix that is not in use.
    Note that this can potentially return a duplicate string if
    multiple calls are made to this function without a marker being
    created for each one. As such, running this in unscheduled environment
    alongside the marker creation would be preferable.

Parameters:
    String prefix:
        (Optional, default "")
        The prefix to use for the marker.

Returns:
    String
        A unique marker name, or an empty string if unsuccessful.

Examples:
    (begin example)
        [] call WHF_fnc_randomMarkerID;
    (end)
    (begin example)
        ["WHF_myMarkerPrefix_"] call WHF_fnc_randomMarkerID;
    (end)

Author:
    thegamecracks

*/
params [["_prefix", ""]];

private _marker = "";
for "_i" from 1 to 100 do {
    private _id = format ["%1%2", _prefix, [6] call WHF_fnc_randomString];
    if (markerColor _id isEqualTo "") exitWith {_marker = _id};
};
_marker
