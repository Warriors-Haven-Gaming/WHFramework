/*
Function: WHF_fnc_createAreaMarker

Description:
    Creates a random, invisible marker from an area array.

Parameters:
    Array randomMarkerIDParams:
        Parameters to use for WHF_fnc_randomMarkerID.
    Array area:
        The area in the format [center, a, b, angle, isRectangle].
        Similar to the format used for inArea except that c is ignored.
    Boolean local:
        (Optional, default false)
        If true, the marker will be local to the client.
        Recommended to enable this for network optimization if you need
        to customize the marker.

Returns:
    String
        The name of the marker created, or an empty string if unsuccessful.

Examples:
    (begin example)
        [[], [[0,0,0], 100, 100, 0, false]] call WHF_fnc_creaAreaMarker;
    (end)

Author:
    thegamecracks

*/
params ["_randomMarkerIDParams", "_area", ["_local", false]];
_area params ["_center", "_a", "_b", "_angle", "_isRectangle"];

private _marker = [_randomMarkerIDParams, _center] call WHF_fnc_createLocalMarker;
if (_marker isEqualTo "") exitWith {_marker};

private _shape = ["ELLIPSE", "RECTANGLE"] select _isRectangle;
_marker setMarkerShapeLocal _shape;
_marker setMarkerDirLocal _angle;
_marker setMarkerSizeLocal [_a, _b];
if (_local) then {_marker setMarkerAlphaLocal 0} else {_marker setMarkerAlpha 0};

_marker
