/*
Function: WHF_fnc_introGUI

Description:
    Show the introduction GUI.

Author:
    thegamecracks

*/
focusOn call WHF_fnc_lowerWeapon;

isNil {with uiNamespace do {
    createDialog "RscDisplayEmpty";
    private _display = findDisplay -1;

    if (isNil "WHF_fnc_diaryLocalize") then {WHF_fnc_diaryLocalize = missionNamespace getVariable "WHF_fnc_diaryLocalize"};

    private _primaryColor = ["GUI", "BCG_RGB"] call BIS_fnc_displayColorGet;
    private _scaleToGroup = {_this vectorMultiply [_width, _height, _width, _height]};

    private _group = _display ctrlCreate ["RscControlsGroup", -1];
    _group ctrlSetPosition [safeZoneX + 0.25 * safeZoneW, safeZoneY + 0.1 * safeZoneH, 0.5 * safeZoneW, 0.8 * safeZoneH];
    _group ctrlCommit 0;
    ctrlPosition _group params ["_groupX", "_groupY", "_width", "_height"];

    private _frame = _display ctrlCreate ["RscText", -1, _group];
    _frame ctrlSetPosition ([0, 0, 1, 1] call _scaleToGroup);
    _frame ctrlSetBackgroundColor [0, 0, 0, 0.7];
    _frame ctrlEnable false;
    _frame ctrlCommit 0;

    private _title = _display ctrlCreate ["RscText", -1, _group];
    _title ctrlSetPosition ([0, 0, 1, 0.04] call _scaleToGroup);
    _title ctrlSetBackgroundColor _primaryColor;
    _title ctrlSetText localize "$STR_WHF_intro_title";
    _title ctrlEnable false;
    _title ctrlCommit 0;

    private _description = _display ctrlCreate ["RscStructuredText", -1, _group];
    _description ctrlSetPosition ([0.02, 0.08, 0.96, 0.92] call _scaleToGroup);
    _description ctrlSetStructuredText composeText [
        image selectRandom [
            "images\guide\fpv.jpg",
            "images\guide\halo.jpg",
            "images\guide\incapacitation.jpg",
            "images\guide\recruits.jpg",
            "images\guide\service.jpg",
            "images\guide\summary.jpg"
        ] setAttributes ["size", "8", "align", "center"],
        parseText "<br/><br/>",
        parseText format [
            "$STR_WHF_intro_description" call WHF_fnc_diaryLocalize,
            getText (configFile >> "CfgWorlds" >> worldName >> "description")
        ]
    ];
    _description ctrlCommit 0;

    private _clearButton = _display ctrlCreate ["RscButtonMenu", 2];
    _clearButton ctrlSetPosition [
        _groupX + _width - 0.07 * safeZoneW - 0.01,
        _groupY + _height + 0.01,
        0.07 * safeZoneW,
        0.025 * safeZoneH
    ];
    _clearButton ctrlSetText localize "$STR_DISP_CLOSE";
    _clearButton ctrlCommit 0;
}};
