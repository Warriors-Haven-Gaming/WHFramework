/*
Function: WHF_fnc_signalFlareInterrupt

Description:
    Interrupt the flare animation on a unit.
    Function should be remote executed on server and all clients.

Parameters:
    Object siren:
        The unit to be interrupted.

Author:
    thegamecracks

*/
params ["_siren"];

private _startedAt = _siren getVariable "WHF_siren_startedAt";
if (isNil "_startedAt") exitWith {};

_siren setVariable ["WHF_siren_startedAt", nil];
if (time < _startedAt + 10) then {_siren switchMove ["", 0, 0, false]};
