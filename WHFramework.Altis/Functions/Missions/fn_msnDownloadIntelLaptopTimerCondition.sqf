/*
Function: WHF_fnc_msnDownloadIntelLaptopTimerCondition

Description:
    The laptop condition required to maintain download.

Parameters:
    Position2D laptop:
        The intel laptop.

Author:
    thegamecracks

*/
params ["_elapsed", "_duration", "_args"];
_args params ["_laptop"];

// Server might be interrupting us to synchronize the progress
private _interruptProgress = _laptop getVariable "downloadInterruptProgress";
if (!isNil "_interruptProgress") exitWith {false};

private _area = [getPosATL _laptop, 5, 5, 0, false, 5];
private _units = units blufor select {lifeState _x in ["HEALTHY", "INJURED"]};
private _bluforInArea = [_units, _area] call WHF_fnc_anyInArea;
if (_bluforInArea) then {_laptop setVariable ["downloadProgress", [_elapsed, _duration]]};
_bluforInArea
