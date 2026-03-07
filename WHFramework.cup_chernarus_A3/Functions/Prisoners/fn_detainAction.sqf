/*
Function: WHF_fnc_detainAction

Description:
    Attempt to detain the unit that the player is looking at.

Author:
    thegamecracks

*/
private _target = cursorObject;
if !([focusOn, _target] call WHF_fnc_canDetainUnit) exitWith {};

focusOn setVariable ["WHF_detain_attempt", time];
[focusOn, _target] remoteExec ["WHF_fnc_detainUnitRequest", _target];
