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
    private _groups = if (WHF_icons_3D_group) then {[group focusOn]} else {groups _side};
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

    // NOTE: this can return duplicate units and the focusOn unit which is
    //       slightly inefficient, but this array is expected to remain
    //       under a few dozen elements at most.
    private _selectedUnits =
        groupSelectedUnits focusOn
        + (_units inAreaArray [focusOn, 7, 7, 0, false, 7]);

    private _cameraPos = positionCameraToWorld [0, 0, 0];
    private _sideColor = switch (_side) do {
        case blufor: {WHF_icons_color_blufor};
        case opfor: {WHF_icons_color_opfor};
        case independent: {WHF_icons_color_independent};
        case civilian: {WHF_icons_color_civilian};
        default {[_side] call BIS_fnc_sideColor}
    };

    // Draw unit icons
    {
        if (_x isEqualTo focusOn) then {continue};

        private _distance = _cameraPos distance _x;
        private _max = WHF_icons_3D_distance;
        if (_distance >= _max) then {continue};

        private _size = linearConversion [2, 30, _distance, 1, 0.5, true];
        private _opacity = linearConversion [_max - 1000 max _max / 10, _max, _distance, 1, 0, true];
        private _color = switch (true) do {
            case (!alive _x): {WHF_icons_color_dead};
            case (lifeState _x isEqualTo "INCAPACITATED"): {WHF_icons_color_incap};
            default {_sideColor};
        };

        private _config = configOf _x;
        private _isTarget = _x isEqualTo cursorTarget || {_x in _selectedUnits};
        private _text = if (_isTarget) then {name _x} else {""};

        if (WHF_icons_3D_style isEqualTo 0) then {
            drawIcon3D [
                "a3\ui_f\data\igui\cfg\cursors\select_ca.paa",
                _color + [_opacity],
                _x modelToWorldVisual (_x selectionPosition "Spine3"),
                _size,
                _size,
                0,
                _text
            ];
        };

        if (WHF_icons_3D_style isEqualTo 1) then {
            private _icon = switch (true) do {
                case (getPlayerChannel _x >= 0): {"\a3\ui_f\data\IGUI\RscIngameUI\RscDisplayVoiceChat\microphone_ca.paa"};
                case !(lifeState _x in ["HEALTHY", "INJURED"]): {"\a3\ui_f\data\igui\cfg\actions\heal_ca.paa"};
                case !(_isTarget): {""};
                case (_x getUnitTrait "medic"): {"\a3\ui_f\data\map\vehicleicons\pictureHeal_ca.paa"};
                case (_x getUnitTrait "engineer"): {"\a3\ui_f\data\igui\cfg\actions\repair_ca.paa"};
                case (_x getUnitTrait "explosiveSpecialist"): {"\a3\ui_f\data\map\vehicleicons\pictureExplosive_ca.paa"};
                default {""};
            };
            if (_icon isEqualTo "") then {_icon = switch (rank _x) do {
                case "PRIVATE": {"\a3\ui_f\data\GUI\cfg\Ranks\private_pr.paa"};
                case "CORPORAL": {"\a3\ui_f\data\GUI\cfg\Ranks\corporal_pr.paa"};
                case "SERGEANT": {"\a3\ui_f\data\GUI\cfg\Ranks\sergeant_pr.paa"};
                case "LIEUTENANT": {"\a3\ui_f\data\GUI\cfg\Ranks\lieutenant_pr.paa"};
                case "CAPTAIN": {"\a3\ui_f\data\GUI\cfg\Ranks\captain_pr.paa"};
                case "MAJOR": {"\a3\ui_f\data\GUI\cfg\Ranks\major_pr.paa"};
                case "COLONEL": {"\a3\ui_f\data\GUI\cfg\Ranks\colonel_pr.paa"};
                default {"\a3\ui_f\data\GUI\cfg\Ranks\private_pr.paa"};
            }};

            drawIcon3D [
                _icon,
                _color + [_opacity],
                _x modelToWorldVisual (_x selectionPosition "Spine3") vectorAdd [0, 0, 0.6],
                _size,
                _size,
                0,
                _text,
                2
            ];
        };
    } forEach _standaloneUnits;

    // Draw vehicle icons
    {
        if (_x isEqualTo objectParent focusOn) then {continue};

        private _distance = _cameraPos distance _x;
        private _max = WHF_icons_3D_distance;
        if (_distance >= _max) then {continue};

        private _config = configOf _x;
        private _commander = effectiveCommander _x;
        private _crew = crew _x;
        private _aliveCrew = _crew select {alive _x};
        private _hasIncapped = _aliveCrew findIf {lifeState _x isEqualTo "INCAPACITATED"} >= 0;

        private _size = linearConversion [20, 600, _distance, 1, 0.5, true];
        private _opacity = linearConversion [_max - 1000 max _max / 10, _max, _distance, 1, 0, true];
        private _color = switch (true) do {
            case (_hasIncapped): {WHF_icons_color_incap};
            case (count _aliveCrew < 1): {WHF_icons_color_dead};
            default {_sideColor};
        };

        private _pos = if (count _aliveCrew > 0) then {
            _aliveCrew # 0 modelToWorldVisual (_x selectionPosition "Spine3")
        } else {
            _x modelToWorldVisual [0,0,0]
        };

        private _selectedIndex = _selectedUnits findIf {_x in _crew};
        private _target = switch (true) do {
            case (_selectedIndex >= 0): {_selectedUnits # _selectedIndex};
            case (_x isEqualTo cursorTarget): {_commander};
            default {objNull};
        };
        private _text = if (isNull _target) then {""} else {
            format [
                "%1 (%2)",
                [_config] call BIS_fnc_displayName,
                if (count _crew < 2) then {name _target} else {
                    format ["%1 + %2", name _target, count _crew - 1]
                }
            ]
        };

        if (WHF_icons_3D_style isEqualTo 0) then {
            drawIcon3D [
                "a3\ui_f\data\igui\cfg\cursors\select_ca.paa",
                _color + [_opacity],
                _pos,
                _size,
                _size,
                0,
                _text
            ];
        };

        if (WHF_icons_3D_style isEqualTo 1) then {
            private _icon = switch (true) do {
                case (getPlayerChannel _commander >= 0): {"\a3\ui_f\data\IGUI\RscIngameUI\RscDisplayVoiceChat\microphone_ca.paa"};
                default {getText (_config >> "icon")};
            };
            drawIcon3D [
                _icon,
                _color + [_opacity],
                _pos vectorAdd [0, 0, 2],
                _size,
                _size,
                0,
                _text,
                2
            ];
        };
    } forEach _vehicles;
}];

waitUntil {sleep 1; !isNull (findDisplay 12 displayCtrl 51)};
findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
    params ["_display"];

    if (!WHF_icons_map) exitWith {};

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
        private _config = configOf _x;
        private _side = side group _x;
        private _color = switch (true) do {
            case (!alive _x): {WHF_icons_color_dead};
            case (lifeState _x in ["INCAPACITATED"]): {WHF_icons_color_incap};
            default {[_side] call _getSideColor};
        };
        private _textScale = 0.045;
        private _text = if (_mapScale <= _textMinMapScale) then {name _x} else {""};
        _display drawIcon [
            getText (_config >> "icon"),
            _color + [1],
            getPosWorldVisual _x,
            _iconScale,
            _iconScale,
            getDirVisual _x,
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
            0,
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
                if (count _controller > 0) then {
                    format ["%1 (%2)", _displayName, name (_controller # 0)]
                } else {
                    _displayName
                }
            };
            case (_mapScale > _textMinMapScale): {groupId group effectiveCommander _x};
            default {
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
        };

        _display drawIcon [
            getText (_config >> "icon"),
            _color + [1],
            _pos,
            _iconScale,
            _iconScale,
            getDirVisual _x,
            _text,
            1,
            _textScale,
            "RobotoCondensed",
            "right"
        ];
    } forEach _vehicles;
}];
