/*
Function: WHF_fnc_initFriendlyIcons

Description:
    Set up friendly icons.
    Function must be ran in scheduled environment.

Author:
    thegamecracks

*/
waitUntil {sleep 1; !isNull (findDisplay 12 displayCtrl 51)};
findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
    params ["_display"];

    private _mapScale = ctrlMapScale _display;
    private _iconScale = linearConversion [0.01, 0.15, _mapScale, 16, 20, true];
    private _textMinMapScale = 0.062;
    private _lineMinMapScale = 0.175;

    // Separate units from vehicles
    private _side = side group focusOn;
    private _allUnits = units _side select {
        isPlayer _x
        || {!isNil {_x getVariable "WHF_recruitOwnedBy"}}
    };
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
    } forEach _allUnits;

    private _getVibrantSideColor = {
        params ["_side"];
        switch (_side) do {
            // Preferably wouldn't hardcode this, but it's fast enough
            case blufor: {[0, 0.45, 0.9, 1]};
            case opfor: {[0.75, 0, 0, 1]};
            case independent: {[0, 0.75, 0, 1]};
            case civilian: {[0.6, 0, 0.75, 1]};
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
        } forEach _allUnits;
    };

    // Draw unit icons
    {
        private _config = configOf _x;
        private _side = side group _x;
        private _color = if (
            lifeState _x in ["HEALTHY", "INJURED"]
        ) then {[_side] call _getVibrantSideColor} else {[1, 0.5, 0, 1]};
        private _textScale = 0.03;
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
        private _offsetPos = _pos vectorAdd [50, 50, 0];
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
            0.06,
            "TahomaB",
            "right"
        ];
    } forEach _leaders;

    // Draw vehicle icons
    {
        private _config = configOf _x;
        private _side = side group effectiveCommander _x;
        private _color = if (
            crew _x findIf {lifeState _x isEqualTo "INCAPACITATED"} < 0
        ) then {[_side] call _getVibrantSideColor} else {[1, 0.5, 0, 1]};
        private _pos = getPosWorldVisual _x;
        private _iconScale = _iconScale;
        private _textScale = 0.03;
        private _text = if (_mapScale > _textMinMapScale) then {
            _iconScale = _iconScale * 1.5;
            _textScale = _textScale * 2;
            groupId group effectiveCommander _x
        } else {
            private _commander = effectiveCommander _x;
            private _crew = crew _x;
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
