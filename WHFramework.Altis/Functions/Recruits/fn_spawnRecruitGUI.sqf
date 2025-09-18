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
    ctrlPosition _group params ["", "", "_width", "_height"];

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

    _atButton = _display ctrlCreate ["RscButton", -1, _group];
    _atButton ctrlSetPosition ([0.14, 0.26, 0.21, 0.2] call _scaleToGroup);
    _atButton ctrlSetText ("at" call _localizeRole);
    _atButton ctrlCommit 0;

    _autoriflemanButton = _display ctrlCreate ["RscButton", -1, _group];
    _autoriflemanButton ctrlSetPosition ([0.39, 0.26, 0.21, 0.2] call _scaleToGroup);
    _autoriflemanButton ctrlSetText ("autorifleman" call _localizeRole);
    _autoriflemanButton ctrlCommit 0;

    _engineerButton = _display ctrlCreate ["RscButton", -1, _group];
    _engineerButton ctrlSetPosition ([0.64, 0.26, 0.21, 0.2] call _scaleToGroup);
    _engineerButton ctrlSetText ("engineer" call _localizeRole);
    _engineerButton ctrlCommit 0;

    _medicButton = _display ctrlCreate ["RscButton", -1, _group];
    _medicButton ctrlSetPosition ([0.26, 0.52, 0.21, 0.2] call _scaleToGroup);
    _medicButton ctrlSetText ("medic" call _localizeRole);
    _medicButton ctrlCommit 0;

    _riflemanButton = _display ctrlCreate ["RscButton", -1, _group];
    _riflemanButton ctrlSetPosition ([0.52, 0.52, 0.21, 0.2] call _scaleToGroup);
    _riflemanButton ctrlSetText ("rifleman" call _localizeRole);
    _riflemanButton ctrlCommit 0;

    _clearButton = _display ctrlCreate ["RscButton", -1, _group];
    _clearButton ctrlSetPosition ([0.7, 0.72, 0.26, 0.2] call _scaleToGroup);
    _clearButton ctrlSetText localize "$STR_WHF_spawnRecruitGUI_clear";
    _clearButton ctrlCommit 0;

    _atButton ctrlAddEventHandler ["ButtonClick", {
        private _position = uiNamespace getVariable "WHF_spawnRecruitGUI_pos";
        [_position, "at"] call WHF_fnc_spawnRecruit;
    }];

    _autoriflemanButton ctrlAddEventHandler ["ButtonClick", {
        private _position = uiNamespace getVariable "WHF_spawnRecruitGUI_pos";
        [_position, "autorifleman"] call WHF_fnc_spawnRecruit;
    }];

    _engineerButton ctrlAddEventHandler ["ButtonClick", {
        private _position = uiNamespace getVariable "WHF_spawnRecruitGUI_pos";
        [_position, "engineer"] call WHF_fnc_spawnRecruit;
    }];

    _medicButton ctrlAddEventHandler ["ButtonClick", {
        private _position = uiNamespace getVariable "WHF_spawnRecruitGUI_pos";
        [_position, "medic"] call WHF_fnc_spawnRecruit;
    }];

    _riflemanButton ctrlAddEventHandler ["ButtonClick", {
        private _position = uiNamespace getVariable "WHF_spawnRecruitGUI_pos";
        [_position, "rifleman"] call WHF_fnc_spawnRecruit;
    }];

    _clearButton ctrlAddEventHandler ["ButtonClick", {
        private _recruits = units focusOn select {
            !isPlayer _x
            && {local _x
            && {_x getVariable ["WHF_recruiter", ""] isEqualTo getPlayerUID player}}
        };
        deleteVehicle _recruits;
    }];
};
