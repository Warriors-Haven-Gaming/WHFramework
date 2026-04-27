/*
Function: WHF_fnc_initEnemyIcons

Description:
    Set up enemy icons.
    Function must be executed in scheduled environment.

Author:
    thegamecracks

*/
addMissionEventHandler ["Draw3D", {
    if (!WHF_icons_3D_enemy) exitWith {};

    private _maxAge = WHF_icons_3D_enemy_age;
    private _maxDistance = WHF_icons_3D_enemy_distance;

    private _cameraPos = positionCameraToWorld [0, 0, 0];
    private _playerSide = side group focusOn;
    // private _targets = focusOn targets [true, _maxDistance, [], _maxAge];
    private _targets =
        focusOn targetsQuery [focusOn, sideUnknown, "", [], 0]
        // NOTE: targetsQuery maxAge filter won't return actively-spotted targets
        //       where age < 0, so we're filtering it afterwards.
        select {_x # 5 < _maxAge}
        select {!(_x # 2 in [_playerSide, sideUnknown, sideFriendly, civilian])};

    {
        _x params ["", "_target", "", "", "", "_age"];
        private _posATL = focusOn getHideFrom _target;
        private _posAGL = ASLToAGL ATLToASL _posATL;

        private _distance = _cameraPos distance _posAGL;
        if (_distance >= _maxDistance) then {continue};

        // private _isTarget = _target isEqualTo cursorTarget;
        private _side = side group _target; // more consistent than target knowledge
        private _size = linearConversion [2, 30, _distance, 1, 0.5, true];
        private _opacity = linearConversion [_maxAge / 2, _maxAge, _age, 1, 0, true];
        private _color = switch (true) do {
            case (!alive _target): {WHF_icons_color_dead};
            case (lifeState _target isEqualTo "INCAPACITATED"): {WHF_icons_color_incap};
            case (_side isEqualTo blufor): {WHF_icons_color_blufor};
            case (_side isEqualTo opfor): {WHF_icons_color_opfor};
            case (_side isEqualTo independent): {WHF_icons_color_independent};
            case (_side isEqualTo civilian): {WHF_icons_color_civilian};
            default {[_side] call BIS_fnc_sideColor};
        };

        // Debug mode
        private _text = if (false) then {
            format [
                "Age: %1s, Diff: %2m",
                _age toFixed 1,
                vectorMagnitude (_posATL vectorDiff getPosATL _target) toFixed 1
            ]
        } else {""};

        drawIcon3D [
            "a3\ui_f\data\map\markers\military\dot_CA.paa",
            _color + [_opacity],
            _posAGL vectorAdd [0, 0, 0.6],
            _size,
            _size,
            0,
            _text
        ];
    } forEach _targets;
}];
