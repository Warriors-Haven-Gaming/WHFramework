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

    private _frame = _display ctrlCreate ["RscText", -1];
    _frame ctrlSetPosition [safezoneX + 0.35 * safezoneW, safezoneY + 0.45 * safezoneH, 0.3 * safezoneW, 0.15 * safezoneH];
    _frame ctrlSetBackgroundColor [0, 0, 0, 0.7];
    _frame ctrlEnable false;
    _frame ctrlCommit 0;

    _atButton = _display ctrlCreate ["RscButton", -1];
    _atButton ctrlSetPosition [safezoneX + 0.3925 * safezoneW, safezoneY + 0.49 * safezoneH, 0.065 * safezoneW, 0.03 * safezoneH];
    _atButton ctrlSetText "Anti-Tank";
    _atButton ctrlCommit 0;

    _autoriflemanButton = _display ctrlCreate ["RscButton", -1];
    _autoriflemanButton ctrlSetPosition [safezoneX + 0.4675 * safezoneW, safezoneY + 0.49 * safezoneH, 0.065 * safezoneW, 0.03 * safezoneH];
    _autoriflemanButton ctrlSetText "Autorifleman";
    _autoriflemanButton ctrlCommit 0;

    _engineerButton = _display ctrlCreate ["RscButton", -1];
    _engineerButton ctrlSetPosition [safezoneX + 0.5425 * safezoneW, safezoneY + 0.49 * safezoneH, 0.065 * safezoneW, 0.03 * safezoneH];
    _engineerButton ctrlSetText "Engineer";
    _engineerButton ctrlCommit 0;

    _medicButton = _display ctrlCreate ["RscButton", -1];
    _medicButton ctrlSetPosition [safezoneX + 0.43 * safezoneW, safezoneY + 0.53 * safezoneH, 0.065 * safezoneW, 0.03 * safezoneH];
    _medicButton ctrlSetText "Medic";
    _medicButton ctrlCommit 0;

    _riflemanButton = _display ctrlCreate ["RscButton", -1];
    _riflemanButton ctrlSetPosition [safezoneX + 0.505 * safezoneW, safezoneY + 0.53 * safezoneH, 0.065 * safezoneW, 0.03 * safezoneH];
    _riflemanButton ctrlSetText "Rifleman";
    _riflemanButton ctrlCommit 0;

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
};
