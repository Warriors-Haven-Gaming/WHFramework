/*
Function: WHF_fnc_incapUnit

Description:
    Incapacitate a unit.
    Function must be ran in scheduled environment.

Parameters:
    Object unit:
        The unit to be incapacitated.
    Object killer:
        (Optional, default objNull)
        The unit's killer, if any.

Author:
    thegamecracks

*/
params ["_unit", ["_killer", objNull]];
if (
    isRemoteExecutedJIP
    && {lifeState _unit isNotEqualTo "INCAPACITATED"}
) exitWith {
    remoteExec ["", remoteExecutedJIPID];
};
if (!alive _unit) exitWith {};
if !(_unit isKindOf "Man") exitWith {};

[_unit] call WHF_fnc_reviveActionAdd;
[_unit] call WHF_fnc_addCarryAction;

if (!isRemoteExecutedJIP) then {
    if (_unit isEqualTo player) then {call WHF_fnc_selfReviveAdd};
    if (isPlayer _unit) then {
        private _friendly = side group _unit isEqualTo side group _killer;
        switch (true) do {
            case (_friendly && isPlayer _killer): {
                systemChat format [localize "$STR_WHF_incapUnit_friendly", name _unit, name _killer];
            };
            default {
                systemChat format [localize "$STR_WHF_incapUnit_chat", name _unit];
            };
        };
    };
    if (local _unit) then {
        if (isNil {_unit getVariable "WHF_incapUnit_wasCaptive"}) then {
            _unit setVariable ["WHF_incapUnit_wasCaptive", captive _unit, true];
        };
        _unit setCaptive true;
        _unit setUnconscious true;
        if (damage _unit < 0.05) then {_unit setDamage 0.05};
    };
};

private _incapScript = _unit getVariable ["WHF_incapacitated_script", scriptNull];
if (!scriptDone _incapScript) then {terminate _incapScript};
_unit setVariable ["WHF_incapacitated_script", [_unit] spawn WHF_fnc_incapLoop];
