/*
Function: WHF_fnc_getDirSurfaceNormal

Description:
    Return a direction relative to the surface normal at a given position.
    If surface is exactly flat, return a random direction.

Parameters:
    Array position:
        The position to read the surface normal from.
    Number offset:
        (Optional, default 0)
        The angle offset from the surface normal in degrees.

Returns:
    Number

Author:
    thegamecracks

*/
params ["_position", ["_offset", 0]];

private _normal = surfaceNormal _position;
if (_normal isEqualTo [0,0,1]) exitWith {random 360};

private _dir = _position getDir (_position vectorAdd _normal);
_dir = (_dir + _offset) % 360;
_dir
