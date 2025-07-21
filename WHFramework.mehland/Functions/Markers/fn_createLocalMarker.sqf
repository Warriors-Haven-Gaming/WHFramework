/*
Function: WHF_fnc_createLocalMarker

Description:
    Creates a local marker with a random ID.
    This function tries to mitigate race conditions, although when multiple
    clients are involved, network latency may result in conflicting markers.

Parameters:
    Array randomMarkerIDParams:
        Parameters to use for WHF_fnc_randomMarkerID.
    *createMarkerLocalParams:
        Remaining parameters to pass to createMarkerLocal.
        See also: https://community.bistudio.com/wiki/createMarkerLocal

Returns:
    String
        A unique marker name, or an empty string if unsuccessful.

Examples:
    (begin example)
        [[], [0,0,0]] call WHF_fnc_createLocalMarker;
    (end)
    (begin example)
        [["WHF_myMarkerPrefix_"], [0,0,0]] call WHF_fnc_createLocalMarker;
    (end)

Author:
    thegamecracks

*/
if !(_this isEqualType []) then {_this = [_this]};
params ["_randomMarkerIDParams"];
private _createMarkerLocalParams = _this select [1];

private _marker = "";
isNil {
    _marker = _randomMarkerIDParams call WHF_fnc_randomMarkerID;
    _marker = createMarkerLocal ([_marker] + _createMarkerLocalParams);
};
_marker
