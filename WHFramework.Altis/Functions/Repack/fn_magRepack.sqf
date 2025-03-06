/*
Function: WHF_fnc_magRepack

Description:
    Make a local unit repack their magazines.
    Function must be executed in scheduled environment.

Parameters:
    Object unit:
        The unit to repack magazines for.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_unit"];
if (!local _unit) exitWith {};

private _animSpeed = getAnimSpeedCoef _unit;

if (_unit isEqualTo focusOn) then {
    _unit action ["Gear", objNull];
} else {
    _unit playActionNow "Medic";
};

_unit setAnimSpeedCoef (_animSpeed / 2);
_unit setVariable ["WHF_magRepack", true];

private _transferredRounds = false;
private _addMagazine = {
    params ["_type", "_count"];
    // TODO: queue magazines to be reloaded while repacking is in progress
    // TODO: drop magazines if inventory is full
    _unit addMagazine [_type, _count];

    if (_transferredRounds) then {
        playSound3D [
            selectRandom [
                "a3\sounds_f\weapons\other\reload_bolt_1.wss",
                "a3\sounds_f\weapons\other\reload_bolt_2.wss"
            ],
            _unit,
            false,
            getPosASL _unit,
            1,
            1,
            0,
            0,
            true
        ];
        sleep 0.5;
        _transferredRounds = false;
    };
};

_unit addEventHandler ["InventoryClosed", {
    params ["_unit"];
    _unit setVariable ["WHF_magRepack", nil];
    _unit removeEventHandler [_thisEvent, _thisEventHandler];
}];

private _magazineGroups = [_unit, true] call WHF_fnc_groupMagazines;
private _completed = false;
{
    private _magazines = _x;

    // Since we can't delete a specific magazine from the unit's inventory,
    // we'll delete all inventory magazines upfront, plus partial weapon magazines
    {
        if (_x # 3 isEqualTo -1) then {_unit removeMagazine _x # 0; continue};
        private _capacity = getNumber (configFile >> "CfgMagazines" >> _x # 0 >> "count");
        if (_x # 1 >= _capacity) then {continue};
        switch (_x # 3) do {
            case 1: {_unit removePrimaryWeaponItem _x # 0};
            case 2: {_unit removeHandgunItem _x # 0};
            case 4: {_unit removeSecondaryWeaponItem _x # 0};
        };
    } forEach _magazines;

    while {
        count _magazines > 1
        && {lifeState _unit in ["HEALTHY", "INJURED"]
        && {!isNil {_unit getVariable "WHF_magRepack"}}}
    } do {
        private _first = _magazines # 0;
        private _firstCount = _first # 1;
        private _firstCapacity = getNumber (configFile >> "CfgMagazines" >> _first # 0 >> "count");

        private _missing = _firstCapacity - _firstCount;
        if (_missing <= 0) then {
            _magazines deleteAt 0;
            [_first # 0, _first # 1] call _addMagazine;
            continue;
        };

        private _last = _magazines # -1;
        private _lastCount = _last # 1;
        private _transfer = _missing min _lastCount;
        _firstCount = _firstCount + _transfer;
        _first set [1, _firstCount];
        _lastCount = _lastCount - _transfer;
        _last set [1, _lastCount];

        if (_lastCount < 1) then {_magazines deleteAt [-1]};
        _transferredRounds = true;
    };

    {[_x # 0, _x # 1] call _addMagazine} forEach _magazines;
    _completed = count _magazines <= 1;
} forEach _magazineGroups;

if (_completed) then {
    playSound3D [
        "a3\sounds_f\arsenal\weapons\machineguns\mk200\reload_mk200.wss",
        _unit,
        false,
        getPosASL _unit,
        1,
        1,
        0,
        4.2,
        true
    ];
};

_unit setAnimSpeedCoef _animSpeed;
_unit setVariable ["WHF_magRepack", nil];
