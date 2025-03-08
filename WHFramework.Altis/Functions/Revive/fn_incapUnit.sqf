/*
Function: WHF_fnc_incapUnit

Description:
    Incapacitate a unit.
    Function must be ran in scheduled environment.

Parameters:
    Object unit:
        The unit to be incapacitated.

Author:
    thegamecracks

*/
params ["_unit"];
if (!alive _unit && {isRemoteExecutedJIP}) exitWith {remoteExec ["", remoteExecutedJIPID]};

[_unit] call WHF_fnc_reviveActionAdd;

private _incapScript = _unit getVariable ["WHF_incapacitated_script", scriptNull];
if (!scriptDone _incapScript) then {terminate _incapScript};
_unit setVariable ["WHF_incapacitated_script", [_unit] spawn WHF_fnc_incapLoop];

if (!isRemoteExecutedJIP) then {
    if (_unit isEqualTo player) then {call WHF_fnc_selfReviveAdd};
    if (isPlayer _unit) then {systemChat format [localize "$STR_WHF_incapUnit_chat", name _unit]};
    if (local _unit) then {
        _unit allowDamage false;
        _unit setCaptive true;
        _unit setUnconscious true;
    };
};
