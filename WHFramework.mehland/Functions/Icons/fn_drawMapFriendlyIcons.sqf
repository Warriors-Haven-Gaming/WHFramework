/*
Function: WHF_fnc_drawMapFriendlyIcons

Description:
    Draw friendly map icons.

Parameters:
    Display display:
        The map display to draw on.

Author:
    thegamecracks

*/
params ["_display"];

if (!WHF_icons_map) exitWith {};

private _getName = {
    if (!freeLook) exitWith {name _this};
    private _role = _this getVariable "WHF_role";
    if (isNil "_role") exitWith {name _this};
    format ["%1 (%2)", name _this, _role call WHF_fnc_localizeRole]
};

private _getNameCrew = {
    params ["_unit", "_crew"];
    if (count _crew < 2) exitWith {_unit call _getName};
    if (inputAction "curatorMultipleMod" isEqualTo 0) exitWith {
        format ["%1 + %2", _unit call _getName, count _crew - 1]
    };

    private _players = [_unit] + ((_crew select {isPlayer _x}) - [_unit]);
    private _names = _players apply {_x call _getName} joinString ", ";
    private _other = _crew - _players;

    if (_other isEqualTo []) exitWith {_names};
    format ["%1 + %2", _names, count _other]
};

private _mapScale = ctrlMapScale _display;
private _iconScale = linearConversion [0.05, 0.002, _mapScale, 20, 32, true];
private _textMinMapScale = 0.062;
private _lineMinMapScale = 0.175;
private _mousePos = getMousePosition;
private _selectedUnits = groupSelectedUnits focusOn;
private _isFocused = {
    _mapScale <= _textMinMapScale
    || {_display ctrlMapWorldToScreen _pos distance2D _mousePos < 0.02
    || {_crew findIf {_x in _selectedUnits} >= 0}}
};

// Separate units from vehicles
private _side = side group focusOn;
private _groups = groups _side;
private _units = flatten (
    _groups
    apply {units _x}
    select {_x findIf {
        isPlayer _x || {_x isEqualTo focusOn || {unitIsUAV _x}}
    } >= 0}
);
private _standaloneUnits = [];
private _leaders = [];
private _vehicles = [];
{
    private _vehicle = objectParent _x;
    if (!isNull _vehicle) then {
        _vehicles pushBackUnique _vehicle;
    } else {
        if (_mapScale > _textMinMapScale && {_x isEqualTo leader _x}) then {
            _leaders pushBack _x;
        };
        _standaloneUnits pushBack _x;
    };
} forEach _units;

private _getSideColor = {
    params ["_side"];
    switch (_side) do {
        case blufor: {WHF_icons_color_blufor};
        case opfor: {WHF_icons_color_opfor};
        case independent: {WHF_icons_color_independent};
        case civilian: {WHF_icons_color_civilian};
        default {[_side] call BIS_fnc_sideColor}
    }
};

// Draw unit lines
if (_mapScale < _lineMinMapScale) then {
    private _getUnitPos = {
        params ["_unit"];
        private _vehicle = objectParent _unit;
        if (!isNull _vehicle) then {getPosWorldVisual _vehicle} else {getPosWorldVisual _unit}
    };
    {
        _display drawLine [
            _x call _getUnitPos,
            leader _x call _getUnitPos,
            [1,1,1,0.6]
        ];
    } forEach _units;
};

// Draw unit icons
{
    private _side = side group _x;
    private _crew = [_x];
    private _color = switch (true) do {
        case (!alive _x): {WHF_icons_color_dead};
        case (lifeState _x in ["INCAPACITATED"]): {WHF_icons_color_incap};
        default {[_side] call _getSideColor};
    };
    private _pos = getPosWorldVisual _x;
    private _textScale = 0.045;
    private _text = if (call _isFocused) then {_x call _getName} else {""};
    _display drawIcon [
        [_x] call WHF_fnc_getUnitIcon,
        _color + [1],
        _pos,
        _iconScale,
        _iconScale,
        getDirVisual _x + ctrlMapDir _display,
        _text,
        1,
        _textScale,
        "RobotoCondensed",
        "right"
    ];
} forEach _standaloneUnits;

{
    private _config = configFile >> "CfgGroupIcons" >> "b_inf";
    private _pos = getPosWorldVisual _x;
    private _offsetPos = _pos vectorAdd [150, 150, 0];
    _display drawLine [
        _pos,
        _offsetPos,
        [1,1,1,0.6]
    ];
    _display drawIcon [
        getText (_config >> "icon"),
        ([side group _x] call _getSideColor) + [1],
        _offsetPos,
        _iconScale,
        _iconScale,
        0, // ctrlMapDir _display
        groupId group _x,
        1,
        0.08,
        "RobotoCondensed",
        "right"
    ];
} forEach _leaders;

// Draw vehicle icons
{
    private _config = configOf _x;
    private _side = side group effectiveCommander _x;
    private _crew = crew _x select {_x in _units};
    private _color = switch (true) do {
        case (_crew findIf {alive _x} < 0): {WHF_icons_color_dead};
        case (_crew findIf {lifeState _x isEqualTo "INCAPACITATED"} >= 0): {WHF_icons_color_incap};
        default {[_side] call _getSideColor};
    };
    private _pos = getPosWorldVisual _x;
    private _iconScale = _iconScale;
    private _textScale = 0.05;
    private _text = switch (true) do {
        case (unitIsUAV _x): {
            private _controller = _crew apply {remoteControlled _x} select {!isNull _x};
            private _displayName = [_config] call BIS_fnc_displayName;
            if (_controller isNotEqualTo []) then {
                format ["%1 (%2)", _displayName, _controller # 0 call _getName]
            } else {
                _displayName
            }
        };
        case (!call _isFocused): {groupId group effectiveCommander _x};
        default {
            private _commander = effectiveCommander _x;
            format [
                "%1 (%2)",
                [_config] call BIS_fnc_displayName,
                [_commander, _crew] call _getNameCrew
            ]
        };
    };

    _display drawIcon [
        getText (_config >> "icon"),
        _color + [1],
        _pos,
        _iconScale,
        _iconScale,
        getDirVisual _x + ctrlMapDir _display,
        _text,
        1,
        _textScale,
        "RobotoCondensed",
        "right"
    ];
} forEach _vehicles;
