/*
Function: WHF_fnc_disableUAVConnectability

Description:
    Disable the player's ability to connect to the given drones.

Parameters:
    Array | Object drones:
        The drone or array of drones to disable UAV connectability.

Author:
    thegamecracks

*/
params ["_drones"];
if (isNull player) exitWith {};
if (_drones isEqualType objNull) then {_drones = [_drones]};

private _disabled = player getVariable ["WHF_drones_disabled", []];
_disabled append _drones;
{if (!alive _x) then {_disabled deleteAt _forEachIndex}} forEachReversed _disabled;

{player disableUAVConnectability [_x, true]} forEach _disabled;
player setVariable ["WHF_drones_disabled", _disabled];
