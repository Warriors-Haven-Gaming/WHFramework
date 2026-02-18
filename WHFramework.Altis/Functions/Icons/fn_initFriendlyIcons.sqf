/*
Function: WHF_fnc_initFriendlyIcons

Description:
    Set up friendly icons.
    Function must be executed in scheduled environment.

Author:
    thegamecracks

*/
addMissionEventHandler ["Draw3D", {
    if (!WHF_icons_3D) exitWith {};

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

        private _isTarget = _x isEqualTo cursorTarget || {_x in _selectedUnits};
        private _text = if (_isTarget) then {_x call _getName} else {""};

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
                case (_x call WHF_fnc_isMedic): {"\a3\ui_f\data\map\vehicleicons\pictureHeal_ca.paa"};
                case (_x call WHF_fnc_isEngineer): {"\a3\ui_f\data\igui\cfg\actions\repair_ca.paa"};
                case (_x call WHF_fnc_isEOD): {"\a3\ui_f\data\map\vehicleicons\pictureExplosive_ca.paa"};
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
            case (_aliveCrew isEqualTo []): {WHF_icons_color_dead};
            default {_sideColor};
        };

        private _pos = if (_aliveCrew isNotEqualTo []) then {
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
                [_target, _crew] call _getNameCrew
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

addMissionEventHandler ["Draw3D", {
    // Maybe add a separate setting for laser target icons?
    if (!WHF_icons_3D) exitWith {};

    private _vehicle = objectParent focusOn;
    if (isNull _vehicle) exitWith {};

    assignedVehicleRole focusOn params [["_role", ""]];
    if !(_role in ["driver", "turret"]) exitWith {};

    private _laserTargets =
        getSensorTargets _vehicle
        select {_x # 1 isEqualTo "lasertarget"}
        apply {_x # 0};
    if (count _laserTargets < 1) exitWith {};

    private _getName = {
        if (!freeLook) exitWith {name _this};
        private _role = _this getVariable "WHF_role";
        if (isNil "_role") exitWith {name _this};
        format ["%1 (%2)", name _this, _role call WHF_fnc_localizeRole]
    };

    private _getLaserParents = {
        private _target = _x;
        private _vehicle = objectParent _target; // NOTE: only works in 2.22+
        if (isNull _vehicle) exitWith {[objNull, objNull]};
        if (_vehicle isKindOf "Man") exitWith {[_vehicle, _vehicle]};

        // Intentionally obfuscate laser parents from other sides
        private _commander = effectiveCommander _vehicle;
        if (side group _commander isNotEqualTo side group focusOn) exitWith {[objNull, objNull]};

        private _crewTargets =
            crew _vehicle
            apply {[_x, _vehicle laserTarget (_vehicle unitTurret _x)]};
        private _index = _crewTargets findIf {_x # 1 isEqualTo _target};
        private _unit = if (_index >= 0) then {_crewTargets # _index # 0} else {_commander};

        private _instigator = switch (true) do {
            case (isPlayer _unit): {_unit};
            case (!isNull (UAVControl _vehicle # 0)): {UAVControl _vehicle # 0};
            case (isPlayer leader _unit): {leader _unit};
            default {_unit};
        };

        [_vehicle, _instigator]
    };

    private _getCurrentText = {
        call _getLaserParents params ["_source", "_instigator"];
        if (isNull _source) exitWith {""};

        private _sourceName = [configOf _source] call BIS_fnc_displayName;
        if (isNull _instigator) exitWith {_sourceName};

        if (_source isEqualTo _instigator) exitWith {_instigator call _getName};
        format ["%1 (%2)", _sourceName, _instigator call _getName]
    };

    {
        private _isTarget = cursorTarget isEqualTo _x;
        private _distance = focusOn distanceSqr _x;
        private _size = linearConversion [2500, 6250000, _distance, 1, 0.5, true];
        private _text = call _getCurrentText;

        drawIcon3D [
            "\a3\ui_f_curator\data\cfgcurator\laser_ca.paa",
            [1, 0.2, 0.2, [0.5, 0.9] select _isTarget],
            _x modelToWorldVisual [0,0,0],
            _size,
            _size,
            0,
            _text,
            2
        ];
    } forEach _laserTargets;
}];

waitUntil {sleep 1; !isNull (findDisplay 12 displayCtrl 51)};
findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
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
            getDirVisual _x,
            _text,
            1,
            _textScale,
            "RobotoCondensed",
            "right"
        ];
    } forEach _vehicles;
}];
