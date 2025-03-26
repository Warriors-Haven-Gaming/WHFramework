/*
Function: WHF_fnc_selfReviveAuto

Description:
    Handle automatically performing a self-revive on a unit.
    Function must be executed in scheduled environment.
    Function must be executed where unit is local.

Parameters:
    Object unit:
        The unit that is incapacitated.
    Number requiredFAKs:
        (Optional, default WHF_selfRevive_FAKs)
        The number of first aid kits required for the unit to self-revive.
    Number delay:
        (Optional, default WHF_selfRevive_minTime)
        The initial delay before the unit can attempt self-reviving.
    Number duration:
        (Optional, default WHF_selfRevive_duration)
        How long it takes for the unit to self-revive.

Author:
    thegamecracks

*/
params [
    "_unit",
    ["_requiredFAKs", WHF_selfRevive_FAKs],
    ["_delay", WHF_selfRevive_minTime],
    ["_duration", WHF_selfRevive_duration]
];

sleep (_delay + random 5);

private _incappedAt = time;
private _bleedoutAt = _incappedAt + WHF_revive_bleedout; // Duplicated in WHF_fnc_incapLoop
private _mustRevive = _bleedoutAt - _duration - 10;
private _startedAt = -1;
while {local _unit && {lifeState _unit isEqualTo "INCAPACITATED"}} do {
    sleep (1 + random 1);

    // Interrupt self-reviving if we're being revived by another unit
    if (!isNil {_unit getVariable "WHF_revive_caller"}) then {
        _startedAt = -1;
        continue;
    };

    // Give some time for AI medics to arrive
    private _time = time;
    if (
        !isNil {_unit getVariable "WHF_reviveActionAuto_assigned"}
        && {_time < _incappedAt + WHF_recruits_incap_hold_assigned min _mustRevive}
    ) then {
        _startedAt = -1;
        continue;
    };

    if (_time < _incappedAt + WHF_recruits_incap_hold min _mustRevive) then {
        _startedAt = -1;
        continue;
    };

    private _FAKs = items _unit select {
        _x call BIS_fnc_itemType select 1 isEqualTo "FirstAidKit"
    } select [0, _requiredFAKs];

    if (count _FAKs < _requiredFAKs) then {
        _startedAt = -1;
        continue;
    };

    if (_startedAt < 0) then {_startedAt = _time; continue};
    if (_time < _startedAt + _duration) then {continue};

    {_unit removeItem _x} forEach _FAKs;
    _unit call WHF_fnc_reviveUnit;
    break;
};
