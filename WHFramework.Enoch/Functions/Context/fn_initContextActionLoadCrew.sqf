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
    private _positions = [];
    if (_unlockedDriver) then {_positions pushBack "DRIVER"};
    if (_unlockedGunner) then {_positions append ["COMMANDER", "GUNNER"]};
    if (_unlockedCargo) then {_positions append ["TURRET", "CARGO"]};
    _units select {_x moveInAny [_vehicle, _positions, true]}
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
        && {focusOn in [currentPilot _vehicle, effectiveCommander _vehicle]
        && {vectorMagnitude velocity _vehicle < 1.39
        && {
            (
                isTouchingGround cameraOn
                || {private _z = getPos cameraOn # 2; _z <= 0 && {_z > -3}}
            )
        && {_vehicle emptyPositions "" > 0 // Skip vehicle locks for performance
        && {call WHF_fnc_initContextActionLoadCrew_getNearbyCrew isNotEqualTo []}}}}}}
    }
] call WHF_fnc_contextMenuAdd;
