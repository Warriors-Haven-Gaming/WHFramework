/*
Function: WHF_fnc_initContextActionLoadCrew

Description:
    Add a context menu action to load nearby AI crew.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};

// TODO: should be declared as a proper function, but in which category?
WHF_fnc_initContextActionLoadCrew_getNearbyCrew = compileFinal {
    private _radius = 50;
    units focusOn
        select {
            !isPlayer _x
            && {local _x
            && {isNull objectParent _x
            && {lifeState _x in ["HEALTHY", "INJURED"]
            && {currentCommand _x isNotEqualTo "GET OUT"}}}}
        }
        inAreaArray [focusOn, _radius, _radius, 0, false, _radius]
};

WHF_fnc_initContextActionLoadCrew_moveInAny = compileFinal {
    params ["_units", "_vehicle"];
    if (_units isEqualType []) then {_units = [] + _units};
    if (_units isEqualType objNull) then {_units = [_units]};
    if (_units isEqualTo []) exitWith {[]};

    // NOTE: This relies on an implementation detail that recruits share the same
    //       locking behaviour as the player to save some performance.
    private _unlockedDriver = [player, _vehicle, "driver"] call WHF_fnc_checkVehicleLock isEqualTo "";
    private _unlockedGunner = [player, _vehicle, "gunner"] call WHF_fnc_checkVehicleLock isEqualTo "";
    private _unlockedCargo = [player, _vehicle, "cargo"] call WHF_fnc_checkVehicleLock isEqualTo "";
    if (_unlockedDriver && _unlockedGunner && _unlockedCargo) exitWith {
        _units select {_x moveInAny _vehicle}
    };

    private _seats = fullCrew [_vehicle, "", true] select {isNull (_x # 0)};
    if (_seats isEqualTo []) exitWith {[]};

    reverse _units; // optimize popping from stack
    private _loaded = [];
    {
        _x params ["", "_role", "_cargoIndex", "_turretPath"];
        if (_units isEqualTo []) then {break};

        private _loadUnit = switch (true) do {
            case (_unlockedDriver && _unlockedGunner && _unlockedCargo): {
                {_unit moveInAny _vehicle} // optimized code path
            };
            case (_role isEqualTo "driver" && _unlockedDriver): {
                {_unit moveInDriver _vehicle}
            };
            case (_role in ["commander"] && _unlockedGunner): {
                {_unit moveInCommander _vehicle}
            };
            case (_role isEqualTo "gunner" && _unlockedGunner): {
                {_unit moveInGunner _vehicle}
            };
            case (_role isEqualTo "turret" && _unlockedGunner): {
                {_unit moveInTurret [_vehicle, _turretPath]}
            };
            case (_role isEqualTo "cargo" && _unlockedCargo): {
                {
                    _unit assignAsCargoIndex [_vehicle, _cargoIndex];
                    _unit moveInCargo _vehicle; // alt syntax does not assign unit
                }
            };
            default {continue};
        };

        private _unit = _units select -1;
        call _loadUnit;
        if (objectParent _unit isEqualTo _vehicle) then {
            _loaded pushBack _unit;
            _units deleteAt [-1];
        };
    } forEach _seats;

    _loaded
};

[
    "WHF_context_action_loadCrew",
    localize "$STR_WHF_context_action_loadCrew",
    {
        private _vehicle = objectParent focusOn;
        private _recruits = call WHF_fnc_initContextActionLoadCrew_getNearbyCrew;
        private _loaded = [_recruits, _vehicle] call WHF_fnc_initContextActionLoadCrew_moveInAny;

        if (_loaded isNotEqualTo []) then {
            private _sound = getArray (configOf _vehicle >> "soundGetIn") # 0;
            if !("." in _sound) then {_sound = _sound + ".wss"};
            playSound3D [_sound, objNull, false, getPosASL _vehicle];
        };
    },
    nil,
    true,
    {
        private _vehicle = objectParent focusOn;
        leader focusOn isEqualTo focusOn
        && {local _vehicle
        && {effectiveCommander _vehicle isEqualTo focusOn
        && {vectorMagnitude velocity _vehicle < 1.39
        && {
            (
                isTouchingGround vehicle focusOn
                || {private _z = getPos vehicle focusOn # 2; _z <= 0 && {_z > -3}}
            )
        && {_vehicle emptyPositions "" > 0 // Skip vehicle locks for performance
        && {call WHF_fnc_initContextActionLoadCrew_getNearbyCrew isNotEqualTo []}}}}}}
    }
] call WHF_fnc_contextMenuAdd;
