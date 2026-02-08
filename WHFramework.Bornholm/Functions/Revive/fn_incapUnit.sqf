/*
Function: WHF_fnc_incapUnit

Description:
    Incapacitate a unit.
    Function must be executed in scheduled environment.

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
        private _pvp = isPlayer _killer;
        private _sniper = ["ghillie", "sniper"] findIf {_x in toLowerANSI typeOf _killer} >= 0;
        private _key = switch (true) do {
            case (_friendly && _pvp): {"$STR_WHF_incapUnit_friendly"};
            case (_sniper): {"$STR_WHF_incapUnit_sniper"};
            default {"$STR_WHF_incapUnit_chat"};
        };
        systemChat format [localize _key, name _unit, name _killer];
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


// If unit is remote, allow for some network delay before starting incap loop
// so unit's unconscious state can be synchronized
if (!isRemoteExecutedJIP && {!local _unit}) then {sleep 0.5};

private _incapScript = _unit getVariable ["WHF_incapacitated_script", scriptNull];
if (!scriptDone _incapScript) then {terminate _incapScript};
_unit setVariable ["WHF_incapacitated_script", [_unit] spawn WHF_fnc_incapLoop];
