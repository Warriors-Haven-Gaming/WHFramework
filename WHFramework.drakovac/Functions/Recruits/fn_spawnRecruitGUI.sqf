/*
Function: WHF_fnc_spawnRecruitGUI

Description:
    Show the GUI to request recruits.

Parameters:
    PositionATL position:
        The position to spawn the recruit on.

Author:
    thegamecracks

*/
params ["_position"];

uiNamespace setVariable ["WHF_spawnRecruitGUI_pos", _position];
uiNamespace setVariable ["WHF_spawnRecruitGUI_roles", [
    "aa",
    "at",
    "autorifleman",
    "engineer",
    "medic",
    "rifleman"
]];

focusOn call WHF_fnc_lowerWeapon;

with uiNamespace do {
    createDialog "RscDisplayEmpty";
    private _display = findDisplay -1;

    private _localizeRole = missionNamespace getVariable "WHF_fnc_localizeRole";
    private _primaryColor = ["GUI", "BCG_RGB"] call BIS_fnc_displayColorGet;
    private _scaleToGroup = {_this vectorMultiply [_width, _height, _width, _height]};

    private _group = _display ctrlCreate ["RscControlsGroup", -1];
    _group ctrlSetPosition [safeZoneX + 0.35 * safeZoneW, safeZoneY + 0.45 * safeZoneH, 0.3 * safeZoneW, 0.15 * safeZoneH];
    _group ctrlCommit 0;
    ctrlPosition _group params ["_groupX", "_groupY", "_width", "_height"];

    private _frame = _display ctrlCreate ["RscText", -1, _group];
    _frame ctrlSetPosition ([0, 0, 1, 1] call _scaleToGroup);
    _frame ctrlSetBackgroundColor [0, 0, 0, 0.7];
    _frame ctrlEnable false;
    _frame ctrlCommit 0;

    private _title = _display ctrlCreate ["RscText", -1, _group];
    _title ctrlSetPosition ([0, 0, 1, 0.16] call _scaleToGroup);
    _title ctrlSetBackgroundColor _primaryColor;
    _title ctrlSetText localize "$STR_WHF_spawnRecruit";
    _title ctrlEnable false;
    _title ctrlCommit 0;

    {
        private _row = floor (_forEachIndex / 3);
        private _col = _forEachIndex % 3;

        _button = _display ctrlCreate ["RscButton", -1, _group];
        _button ctrlSetPosition ([
            0.14 + 0.25 * _col,
            0.26 + 0.26 * _row,
            0.21,
            0.2
        ] call _scaleToGroup);
        _button ctrlSetText (_x call _localizeRole);
        _button ctrlCommit 0;
        _button setVariable ["WHF_role", _x];
        _button ctrlAddEventHandler ["ButtonClick", {
            params ["_button"];
            private _position = uiNamespace getVariable "WHF_spawnRecruitGUI_pos";
            private _role = _button getVariable "WHF_role";
            [_position, _role] call WHF_fnc_spawnRecruit;
        }];
    } forEach WHF_spawnRecruitGUI_roles;

    _clearButton = _display ctrlCreate ["RscButton", -1];
    _clearButton ctrlSetPosition [
        _groupX + _width - 0.07 * safeZoneW - 0.01,
        _groupY + _height + 0.01,
        0.07 * safeZoneW,
        0.03 * safeZoneH
    ];
    _clearButton ctrlSetText localize "$STR_WHF_spawnRecruitGUI_clear";
    _clearButton ctrlCommit 0;
    _clearButton ctrlAddEventHandler ["ButtonClick", {
        private _recruits = units focusOn select {
            !isPlayer _x
            && {local _x
            && {_x getVariable ["WHF_recruiter", ""] isEqualTo getPlayerUID player}}
        };
        deleteVehicle _recruits;
    }];
};
