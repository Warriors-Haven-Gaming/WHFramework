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

with uiNamespace do {
    createDialog "RscDisplayEmpty";
    private _display = findDisplay -1;

    private _localizeRole = missionNamespace getVariable "WHF_fnc_localizeRole";
    private _primaryColor = ["GUI", "BCG_RGB"] call BIS_fnc_displayColorGet;

    private _frame = _display ctrlCreate ["RscText", -1];
    _frame ctrlSetPosition [safeZoneX + 0.35 * safeZoneW, safeZoneY + 0.45 * safeZoneH, 0.3 * safeZoneW, 0.15 * safeZoneH];
    _frame ctrlSetBackgroundColor [0, 0, 0, 0.7];
    _frame ctrlEnable false;
    _frame ctrlCommit 0;

    private _title = _display ctrlCreate ["RscText", -1];
    _title ctrlSetPosition [safeZoneX + 0.35 * safeZoneW, safeZoneY + 0.45 * safeZoneH, 0.3 * safeZoneW, 0.025 * safeZoneH];
    _title ctrlSetBackgroundColor _primaryColor;
    _title ctrlSetText localize "$STR_WHF_spawnRecruit";
    _title ctrlEnable false;
    _title ctrlCommit 0;

    _atButton = _display ctrlCreate ["RscButton", -1];
    _atButton ctrlSetPosition [safeZoneX + 0.3925 * safeZoneW, safeZoneY + 0.49 * safeZoneH, 0.065 * safeZoneW, 0.03 * safeZoneH];
    _atButton ctrlSetText ("at" call _localizeRole);
    _atButton ctrlCommit 0;

    _autoriflemanButton = _display ctrlCreate ["RscButton", -1];
    _autoriflemanButton ctrlSetPosition [safeZoneX + 0.4675 * safeZoneW, safeZoneY + 0.49 * safeZoneH, 0.065 * safeZoneW, 0.03 * safeZoneH];
    _autoriflemanButton ctrlSetText ("autorifleman" call _localizeRole);
    _autoriflemanButton ctrlCommit 0;

    _engineerButton = _display ctrlCreate ["RscButton", -1];
    _engineerButton ctrlSetPosition [safeZoneX + 0.5425 * safeZoneW, safeZoneY + 0.49 * safeZoneH, 0.065 * safeZoneW, 0.03 * safeZoneH];
    _engineerButton ctrlSetText ("engineer" call _localizeRole);
    _engineerButton ctrlCommit 0;

    _medicButton = _display ctrlCreate ["RscButton", -1];
    _medicButton ctrlSetPosition [safeZoneX + 0.43 * safeZoneW, safeZoneY + 0.53 * safeZoneH, 0.065 * safeZoneW, 0.03 * safeZoneH];
    _medicButton ctrlSetText ("medic" call _localizeRole);
    _medicButton ctrlCommit 0;

    _riflemanButton = _display ctrlCreate ["RscButton", -1];
    _riflemanButton ctrlSetPosition [safeZoneX + 0.505 * safeZoneW, safeZoneY + 0.53 * safeZoneH, 0.065 * safeZoneW, 0.03 * safeZoneH];
    _riflemanButton ctrlSetText ("rifleman" call _localizeRole);
    _riflemanButton ctrlCommit 0;

    _clearButton = _display ctrlCreate ["RscButton", -1];
    _clearButton ctrlSetPosition [safeZoneX + 0.56 * safeZoneW, safeZoneY + 0.56 * safeZoneH, 0.08 * safeZoneW, 0.03 * safeZoneH];
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
