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

private _findNearestMedic = {
    private _medics = allPlayers select {
        side group _x isEqualTo side group _unit
        && {_x getUnitTrait "medic"}
    };
    _medics = _medics inAreaArray [getPosATL _unit, 500, 500];
    if (count _medics < 1) exitWith {[objNull, 0]};

    private _distances = [];
    {
        _distances pushBack [_unit distance _x, _forEachIndex, _x];
    } forEach _medics;

    _distances sort false;
    [_distances # 0 # 2, _distances # 0 # 0]
};

private _statusAfter = time + 3;
private _actOfGod = if (random 1 < 0.1) then {time + 30 + random 60} else {-1};
// NOTE: bleedout time is defined by each client and not synchronized
private _bleedoutAt = time + WHF_revive_bleedout;

while {alive _unit && {lifeState _unit isEqualTo "INCAPACITATED"}} do {
    private _vehicle = objectParent _unit;
    if (
        isNull _vehicle
        && {isNull attachedTo _unit
        && {animationState _unit isNotEqualTo "unconsciousrevivedefault"}}
    ) then {
        _unit switchMove ["unconsciousrevivedefault", 0, 0, false];
    };

    if (!local _unit) then {sleep (1 + random 1); continue};
    if (damage _unit isEqualTo 0) exitWith {[_unit] call WHF_fnc_reviveUnit};

    private _time = time;

    private _bleedoutLeft = _bleedoutAt - _time;
    if (_bleedoutLeft <= 0) exitWith {
        _unit setDamage 1;
        if (isPlayer _unit) then {[_unit] remoteExec ["WHF_fnc_incapBleedout"]};
    };

    if (_actOfGod > 0 && {_time > _actOfGod && {_unit isEqualTo focusOn}}) exitWith {
        [_unit] call WHF_fnc_reviveUnit;
        50 cutText [localize "$STR_WHF_incapLoop_actOfGod", "PLAIN", 0.5];
    };

    if (_time >_statusAfter && {_unit isEqualTo focusOn}) then {
        private _status = [];

        _status pushBack format [
            localize "$STR_WHF_incapLoop_status_bleedout",
            ceil (_bleedoutLeft / 60)
        ];

        call _findNearestMedic params ["_medic", "_medicDistance"];
        if (!isNull _medic) then {
            _status pushBack format [
                localize "$STR_WHF_incapLoop_status_medic",
                name _medic,
                ceil _medicDistance
            ];
        };

        hintSilent (_status joinString "\n");
    };

    if (!isNull _vehicle && {!alive _vehicle}) then {_unit moveOut _vehicle};

    sleep (1 + random 1);
};
