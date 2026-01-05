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
    private _vehicle = objectParent focusOn;
    private _seats = _vehicle emptyPositions "";
    if (_seats < 1) exitWith {[]};

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
        select [0, _seats]
};

[
    "WHF_context_action_loadCrew",
    localize "$STR_WHF_context_action_loadCrew",
    {
        private _vehicle = objectParent focusOn;
        private _recruits = call WHF_fnc_initContextActionLoadCrew_getNearbyCrew;
        private _loaded = {_x moveInAny _vehicle} count _recruits;
        if (_loaded > 0) then {
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
        && {call WHF_fnc_initContextActionLoadCrew_getNearbyCrew isNotEqualTo []}}}}}
    }
] call WHF_fnc_contextMenuAdd;
