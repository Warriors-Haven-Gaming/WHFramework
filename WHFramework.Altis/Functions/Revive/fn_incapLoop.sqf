/*
Function: WHF_fnc_incapLoop

Description:
    Handle a unit becoming incapacitated.
    This may be called on a remote unit, in which case the script will
    idle until the unit is killed/revived or the unit becomes local.
    Function must be ran in scheduled environment.

Parameters:
    Object unit:
        The unit to be incapacitated.

Author:
    thegamecracks

*/
params ["_unit"];

// NOTE: bleedout time is defined by each client and not synchronized
private _bleedoutAt = time + WHF_revive_bleedout;

while {alive _unit && {lifeState _unit isEqualTo "INCAPACITATED"}} do {
    if (!local _unit) then {sleep (5 + random 5); continue};
    if (damage _unit isEqualTo 0) exitWith {[_unit] call WHF_fnc_reviveUnit};

    private _time = time;

    private _bleedoutLeft = _bleedoutAt - _time;
    if (_bleedoutLeft <= 0) exitWith {
        _unit setDamage 1;
        if (isPlayer _unit) then {[_unit] remoteExec ["WHF_fnc_incapBleedout"]};
    };

    // if (_unit isEqualTo focusOn) then {
    //     hintSilent format [
    //         localize "$STR_WHF_incapLoop_status",
    //         ceil (_bleedoutLeft / 60)
    //     ];
    // };

    private _vehicle = objectParent _unit;
    if (!isNull _vehicle && {!alive _vehicle}) then {_unit moveOut _vehicle};

    sleep (1 + random 1);
};
