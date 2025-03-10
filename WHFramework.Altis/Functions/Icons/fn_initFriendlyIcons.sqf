/*
Function: WHF_fnc_initFriendlyIcons

Description:
    Set up friendly icons.
    Function must be ran in scheduled environment.

Author:
    thegamecracks

*/
addMissionEventHandler ["Draw3D", {
    if (!WHF_icons_3D) exitWith {};

    // Separate units from vehicles
    private _side = side group focusOn;
    private _groups = if (WHF_icons_3D_group) then {group focusOn} else {groups _side};
    private _units = flatten (
        _groups
        apply {units _x}
        select {_x findIf {isPlayer _x || {_x isEqualTo focusOn}} >= 0}
    );
    private _standaloneUnits = [];
    private _vehicles = [];
    {
        private _vehicle = objectParent _x;
        if (!isNull _vehicle) then {
            _vehicles pushBackUnique _vehicle;
        } else {
            _standaloneUnits pushBack _x;
        };
    } forEach _units;

    private _sideColor = switch (_side) do {
        // Preferably wouldn't hardcode this, but it's fast enough
        case blufor: {[0, 0.65, 0.9]};
        case opfor: {[0.75, 0, 0]};
        case independent: {[0, 0.75, 0]};
        case civilian: {[0.6, 0, 0.75]};
        default {[_side] call BIS_fnc_sideColor}
    };
    private _incapColor = [1, 0.5, 0];
    private _deadColor = [0.2, 0.2, 0.2];

    {
        if (_x isEqualTo focusOn) then {continue};

        private _distance = focusOn distance _x;
        private _max = WHF_icons_3D_distance;
        if (_distance >= _max) then {continue};

        private _size = linearConversion [2, 30, _distance, 1, 0.5, true];
        private _opacity = linearConversion [_max - 1000 max 0, _max, _distance, 1, 0, true];
        private _color = switch (true) do {
            case (!alive _x): {_deadColor};
            case (!(lifeState _x in ["HEALTHY", "INJURED"])): {_incapColor};
            default {_sideColor};
        };

        drawIcon3D [
            "a3\ui_f\data\igui\cfg\cursors\select_ca.paa",
            _color + [_opacity],
            _x modelToWorldVisual (_x selectionPosition "Spine3"),
            _size,
            _size,
            0
        ];
    } forEach _standaloneUnits;

    {
        if (_x isEqualTo objectParent focusOn) then {continue};

        private _distance = focusOn distance _x;
        private _max = WHF_icons_3D_distance;
        if (_distance >= _max) then {continue};

        private _aliveCrew = crew _x select {alive _x};
        private _hasIncapped = _aliveCrew findIf {!(lifeState _x in ["HEALTHY", "INJURED"])} >= 0;

        private _size = linearConversion [20, 200, _distance, 1, 0.5, true];
        private _opacity = linearConversion [_max - 1000 max 0, _max, _distance, 1, 0, true];
        private _color = switch (true) do {
            case (_hasIncapped): {_incapColor};
            case (count _aliveCrew < 1): {_deadColor};
            default {_sideColor};
        };

        drawIcon3D [
            "a3\ui_f\data\igui\cfg\cursors\select_ca.paa",
            _color + [_opacity],
            _aliveCrew # 0 modelToWorldVisual (_x selectionPosition "Spine3"),
            _size,
            _size,
            0
        ];
    } forEach _vehicles;
}];

waitUntil {sleep 1; !isNull (findDisplay 12 displayCtrl 51)};
findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
    params ["_display"];

    private _mapScale = ctrlMapScale _display;
    private _iconScale = linearConversion [0.05, 0.002, _mapScale, 20, 32, true];
    private _textMinMapScale = 0.062;
    private _lineMinMapScale = 0.175;

    // Separate units from vehicles
    private _side = side group focusOn;
    private _groups = groups _side;
    private _units = flatten (
        _groups
        apply {units _x}
        select {_x findIf {isPlayer _x || {_x isEqualTo focusOn}} >= 0}
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

    private _getVibrantSideColor = {
        params ["_side"];
        switch (_side) do {
            // Preferably wouldn't hardcode this, but it's fast enough
            case blufor: {[0, 0.75, 1, 1]};
            case opfor: {[0.85, 0, 0, 1]};
            case independent: {[0, 0.85, 0, 1]};
            case civilian: {[0.7, 0, 0.85, 1]};
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
        private _config = configOf _x;
        private _side = side group _x;
        private _color = switch (true) do {
            case (!alive _x): {[0.2, 0.2, 0.2, 1]};
            case (lifeState _x in ["INCAPACITATED"]): {[1, 0.5, 0, 1]};
            default {[_side] call _getVibrantSideColor};
        };
        private _textScale = 0.045;
        private _text = if (_mapScale <= _textMinMapScale) then {name _x} else {""};
        _display drawIcon [
            getText (_config >> "icon"),
            _color,
            getPosWorldVisual _x,
            _iconScale,
            _iconScale,
            getDirVisual _x,
            _text,
            1,
            _textScale,
            "TahomaB",
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
            [side group _x] call _getVibrantSideColor,
            _offsetPos,
            _iconScale,
            _iconScale,
            0,
            groupId group _x,
            1,
            0.08,
            "TahomaB",
            "right"
        ];
    } forEach _leaders;

    // Draw vehicle icons
    {
        private _config = configOf _x;
        private _side = side group effectiveCommander _x;
        private _crew = crew _x select {_x in _units};
        private _color = switch (true) do {
            case (_crew findIf {alive _x} < 0): {[0.2, 0.2, 0.2, 1]};
            case (_crew findIf {lifeState _x isEqualTo "INCAPACITATED"} >= 0): {[1, 0.5, 0, 1]};
            default {[_side] call _getVibrantSideColor};
        };
        private _pos = getPosWorldVisual _x;
        private _iconScale = _iconScale;
        private _textScale = 0.05;
        private _text = if (_mapScale > _textMinMapScale) then {
            groupId group effectiveCommander _x
        } else {
            private _commander = effectiveCommander _x;
            format [
                "%1 (%2)",
                [_config] call BIS_fnc_displayName,
                // _crew apply {
                //     if (isPlayer _x) then {name _x} else {
                //         format ["%1 [AI]", name _x]
                //     }
                // } joinString ", "
                if (count _crew < 2) then {name _commander} else {
                    format ["%1 + %2", name _commander, count _crew - 1]
                }
            ]
        };
        _display drawIcon [
            getText (_config >> "icon"),
            _color,
            _pos,
            _iconScale,
            _iconScale,
            getDirVisual _x,
            _text,
            1,
            _textScale,
            "TahomaB",
            "right"
        ];
    } forEach _vehicles;
}];
