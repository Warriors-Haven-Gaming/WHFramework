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
    private _vehicle = objectParent _unit;
    if (!isNull _vehicle) then {
        _unit actionNow ["Gear", _vehicle];
    } else {
        _unit action ["Gear", objNull];
        sleep 0.5;
    };
} else {
    _unit playActionNow "Medic";
};

_unit setAnimSpeedCoef (_animSpeed / 2);
_unit setVariable ["WHF_magRepack", true];

private _addMagazine = {
    params ["_type", "_count"];
    // TODO: queue magazines to be reloaded while repacking is in progress
    // TODO: drop magazines if inventory is full
    _unit addMagazine [_type, _count];
};

_unit addEventHandler ["InventoryClosed", {
    params ["_unit"];
    _unit setVariable ["WHF_magRepack", nil];
    _unit removeEventHandler [_thisEvent, _thisEventHandler];
}];

private _magazineGroups = [_unit, true] call WHF_fnc_groupMagazines;
private _completed = false;
private _soundPlayed = false;
{
    private _magazines = _x;
    private _canRepack = {
        count _magazines > 1
        && {lifeState _unit in ["HEALTHY", "INJURED"]
        && {!isNil {_unit getVariable "WHF_magRepack"}}}
    };

    if !(call _canRepack) then {continue};

    // Since we can't delete a specific magazine from the unit's inventory,
    // we'll delete all inventory magazines upfront, plus partial weapon magazines
    private _fullLoaded = [];
    private _removeTypes = [];
    {
        if (_x # 3 isEqualTo -1) then {_removeTypes pushBackUnique _x # 0; continue};
        private _capacity = getNumber (configFile >> "CfgMagazines" >> _x # 0 >> "count");
        if (_x # 1 >= _capacity) then {_fullLoaded pushBack _forEachIndex; continue};
        switch (_x # 3) do {
            case 1: {_unit removePrimaryWeaponItem _x # 0};
            case 2: {_unit removeHandgunItem _x # 0};
            case 4: {_unit removeSecondaryWeaponItem _x # 0};
        };
    } forEach _magazines;

    // Skip magazines that we've left in the unit's guns
    {_magazines deleteAt _x} forEachReversed _fullLoaded;
    {_unit removeMagazines _x} forEach _removeTypes;

    while _canRepack do {
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

        if (_soundPlayed) then {sleep 0.5};
        // Before we remove empty magazines, check now to see if the player
        // interrupted the mag repack so we don't play an extra sound.
        // We can't remove empty magazines beforehand as that may cause
        // _canRepack to return false, indicating the group is fully repacked.
        private _interrupted = !call _canRepack;
        if (_lastCount < 1) then {_magazines deleteAt [-1]};
        if (_interrupted) then {break};

        _soundPlayed = true;
        private _sound = selectRandom [
            "a3\sounds_f\weapons\other\reload_bolt_1.wss",
            "a3\sounds_f\weapons\other\reload_bolt_2.wss"
        ];
        if (_unit isEqualTo focusOn) then {
            playSoundUI [_sound, 5, 1, true];
        } else {
            private _pos = _unit modelToWorldVisualWorld [0, 0.5, 0.5];
            playSound3D [_sound, objNull, false, _pos, 3, 1, 0, 0, true];
        };
    };

    {[_x # 0, _x # 1] call _addMagazine} forEach _magazines;
    _completed = count _magazines <= 1;
} forEach _magazineGroups;

if (_completed) then {
    if (_soundPlayed) then {sleep 0.5};
    private _sound = "a3\sounds_f\arsenal\weapons\machineguns\mk200\reload_mk200.wss";
    if (_unit isEqualTo focusOn) then {
        playSoundUI [_sound, 3, 1, true, 4.2];
    } else {
        private _pos = _unit modelToWorldVisualWorld [0, 0.5, 0.5];
        playSound3D [_sound, objNull, false, _pos, 3, 1, 0, 4.2, true];
    };
};

_unit setAnimSpeedCoef _animSpeed;
_unit setVariable ["WHF_magRepack", nil];
