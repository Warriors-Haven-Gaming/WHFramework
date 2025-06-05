/*
Function: WHF_fnc_incapLoop

Description:
    Handle a unit becoming incapacitated.
    This may be called on a remote unit, in which case the script will
    idle until the unit is killed/revived or the unit becomes local.
    Function must be executed in scheduled environment.

Parameters:
    Object unit:
        The unit to be incapacitated.

Author:
    thegamecracks

*/
params ["_unit"];

private _findNearestMedic = {
    private _assigned = _unit getVariable ["WHF_reviveActionAuto_assigned", objNull];
    if (lifeState _assigned in ["HEALTHY", "INJURED"]) exitWith {format [
        localize "$STR_WHF_incapLoop_status_assigned",
        name _assigned,
        ceil (_unit distance _assigned)
    ]};

    private _medics = units side group _unit select {
        _x getUnitTrait "medic"
        && {lifeState _x in ["HEALTHY", "INJURED"]
        && {isPlayer _x || {!isNil {_x getVariable "WHF_recruiter"}}}}
    };
    _medics = _medics inAreaArray [getPosATL _unit, 500, 500];
    if (count _medics < 1) exitWith {""};

    private _distances = [];
    {
        _distances pushBack [_unit distance _x, _forEachIndex, _x];
    } forEach _medics;

    _distances sort true;
    _distances # 0 params ["_distance", "", "_medic"];
    format [localize "$STR_WHF_incapLoop_status_medic", name _medic, ceil _distance]
};

private _actOfGod = if (random 1 < 0.1) then {time + 30 + random 60} else {-1};
// NOTE: bleedout time is defined by each client and not synchronized
private _bleedoutAt = time + WHF_revive_bleedout;
private _drownAt = -1;

private _killedEH = ["Killed", _unit addEventHandler ["Killed", {
    params ["_unit"];
    if (_unit isEqualTo focusOn) then {hintSilent ""};
    _unit removeEventHandler [_thisEvent, _thisEventHandler];
}]];

[_unit, _findNearestMedic, _bleedoutAt] spawn {
    params ["_unit", "_findNearestMedic", "_bleedoutAt"];
    scriptName "WHF_fnc_incapLoop_status";

    sleep 3;
    while {lifeState _unit isEqualTo "INCAPACITATED"} do {
        if (_unit isNotEqualTo focusOn) then {sleep (1 + random 1); continue};

        private _status = [];
        _status pushBack format [
            localize "$STR_WHF_incapLoop_status_bleedout",
            ceil ((_bleedoutAt - time) / 60)
        ];
        private _medic = call _findNearestMedic;
        if (_medic isNotEqualTo "") then {_status pushBack _medic};
        hintSilent (_status joinString "\n");

        sleep 0.2;
    };

    if (_unit isEqualTo focusOn) then {hintSilent ""};
};

while {lifeState _unit isEqualTo "INCAPACITATED"} do {
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

    if (_bleedoutAt - _time <= 0) exitWith {
        _unit setDamage 1;
        if (isPlayer _unit) then {[_unit] remoteExec ["WHF_fnc_incapBleedout"]};
    };

    private _drowning = isNull _vehicle && {!isAbleToBreathe _unit};
    switch (true) do {
        case (!_drowning): {_drownAt = -1};
        case (_drownAt < 0): {_drownAt = _time + 9};
        case (_time > _drownAt): {_unit setDamage 1};
    };

    if (_actOfGod > 0 && {_time > _actOfGod && {_unit isEqualTo focusOn}}) exitWith {
        [_unit] call WHF_fnc_reviveUnit;
        50 cutText [localize "$STR_WHF_incapLoop_actOfGod", "PLAIN", 0.5];
    };

    if (!isNull _vehicle && {!alive _vehicle}) then {_unit moveOut _vehicle};

    sleep (1 + random 1);
};

_unit removeEventHandler _killedEH;
