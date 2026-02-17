/*
Function: WHF_fnc_roleSelectionGUI

Description:
    Show the GUI to select the player's role.

Author:
    thegamecracks

*/
#include "\a3\ui_f\hpp\definedikcodes.inc"

uiNamespace setVariable ["WHF_roleSelectionGUI_roles", [
    "rifleman",
    "autorifleman",
    "at",
    "aa",
    "medic",
    "engineer",
    "sniper",
    "jtac",
    "arty",
    "uav",
    "pilot_transport",
    "pilot_cas_heli",
    "pilot_cas_plane"
]];

focusOn call WHF_fnc_lowerWeapon;

isNil {with uiNamespace do {
    createDialog "RscDisplayEmpty";
    private _display = findDisplay -1;

    if (isNil "WHF_fnc_localizeRole") then {WHF_fnc_localizeRole = missionNamespace getVariable "WHF_fnc_localizeRole"};
    if (isNil "WHF_fnc_getRoleLimit") then {WHF_fnc_getRoleLimit = missionNamespace getVariable "WHF_fnc_getRoleLimit"};

    WHF_roleSelectionGUI_currentRole = {focusOn getVariable ["WHF_role", ""]};
    WHF_roleSelectionGUI_selectedRole = {
        private _roles = WHF_roleSelectionGUI_ctrlRoles;
        _roles lbData lbCurSel _roles
    };

    WHF_roleSelectionGUI_refreshState = {
        call WHF_roleSelectionGUI_updateHeader;
        call WHF_roleSelectionGUI_updateRoles;
        call WHF_roleSelectionGUI_updatePlayers;
        call WHF_roleSelectionGUI_updateSelect;
        call WHF_roleSelectionGUI_updateRespawn;
    };

    WHF_roleSelectionGUI_updateHeader = {
        private _role = call WHF_roleSelectionGUI_currentRole;
        private _message = format [
            "%1 (%2)",
            name focusOn,
            _role call WHF_fnc_localizeRole
        ];
        WHF_roleSelectionGUI_ctrlHeader ctrlSetStructuredText composeText [
            text _message setAttributes ["align", "center", "size", "1.5"]
        ];
    };

    WHF_roleSelectionGUI_updateRoles = {
        private _role = call WHF_roleSelectionGUI_currentRole;
        private _list = WHF_roleSelectionGUI_ctrlRoles;
        private _index = lbCurSel _list;

        lbClear _list;
        {
            private _text = format [
                "%1 (%2/%3)",
                _x call WHF_fnc_localizeRole,
                count ([_x] call WHF_roleSelectionGUI_ctrlPlayersInRole),
                [_x] call WHF_fnc_getRoleLimit
            ];

            private _index = _list lbAdd _text;
            _list lbSetData [_index, _x];
        } forEach WHF_roleSelectionGUI_roles;

        if (_index < 0) then {_index = WHF_roleSelectionGUI_roles find _role};
        if (_index >= 0) then {_list lbSetCurSel _index};
    };

    WHF_roleSelectionGUI_updatePlayers = {
        private _selected = call WHF_roleSelectionGUI_selectedRole;
        private _players = [_selected] call WHF_roleSelectionGUI_ctrlPlayersInRole;

        private _names = _players apply {name _x};
        _names sort true;

        lbClear WHF_roleSelectionGUI_ctrlPlayers;
        {WHF_roleSelectionGUI_ctrlPlayers lbAdd _x} forEach _names;
    };

    WHF_roleSelectionGUI_ctrlPlayersInRole = {
        params ["_role"];
        // FIXME: may return an incomplete set of units, desync issue?
        units side group focusOn
            select {isPlayer _x}
            select {_x getVariable ["WHF_role", ""] isEqualTo _role}
    };

    WHF_roleSelectionGUI_updateSelect = {
        private _selected = call WHF_roleSelectionGUI_selectedRole;
        private _enabled = [_selected] call WHF_roleSelectionGUI_canSwitchToRole;
        WHF_roleSelectionGUI_ctrlSelect ctrlEnable _enabled;
    };

    WHF_roleSelectionGUI_updateRespawn = {
        private _enabled = with missionNamespace do {
            // FIXME: respawn condition is somewhat unintuitive
            // NOTE: WHF_fnc_respawnMarkers is side-specific, but
            //       WHF_fnc_isNearRespawn is side-agnostic
            private _marker = [focusOn] call WHF_fnc_respawnMarkers select 0;
            !isNil "_marker"
            && {focusOn distance2D markerPos _marker > 50
            && {focusOn getVariable ["WHF_safezone_friendly", false] isEqualTo true
            || {[focusOn, 100] call WHF_fnc_isNearRespawn}}}
        };
        WHF_roleSelectionGUI_ctrlRespawn ctrlEnable _enabled;
    };

    WHF_roleSelectionGUI_requestRole = {
        private _selected = call WHF_roleSelectionGUI_selectedRole;
        if !([_selected] call WHF_roleSelectionGUI_canSwitchToRole) exitWith {
            WHF_roleSelectionGUI_ctrlSelect ctrlEnable false;
        };

        focusOn setVariable ["WHF_role", _selected, true];
        with missionNamespace do {
            private _loadout = [] call WHF_fnc_getLastLoadout;
            if (_loadout isEqualTo []) exitWith {};
            [focusOn, _loadout] spawn WHF_fnc_setUnitLoadout;
            [focusOn, _selected] call WHF_fnc_setRoleTraits;
        };

        call WHF_roleSelectionGUI_updateSwitchTimeout;
        call WHF_roleSelectionGUI_refreshState;
        playSoundUI ["a3\3den\data\sound\cfgsound\notificationdefault.wss"];

        WHF_roleSelectionGUI_ctrlSelect spawn {
            sleep WHF_roleSelectionGUI_switchDelay;
            if (isNull _this) exitWith {};
            call WHF_roleSelectionGUI_updateSelect;
        };
    };

    WHF_roleSelectionGUI_switchDelay = 1.5;
    WHF_roleSelectionGUI_lastSwitch = uiTime - WHF_roleSelectionGUI_switchDelay;
    WHF_roleSelectionGUI_canSwitchToRole = {
        params ["_role"];

        if (call WHF_roleSelectionGUI_checkSwitchTimeout) exitWith {false};

        private _current = call WHF_roleSelectionGUI_currentRole;
        if (_current isEqualTo _role) exitWith {false};

        private _players = [_role] call WHF_roleSelectionGUI_ctrlPlayersInRole;
        private _limit = [_role] call WHF_fnc_getRoleLimit;
        if (count _players >= _limit) exitWith {false};

        true
    };
    WHF_roleSelectionGUI_checkSwitchTimeout = {
        private _switchDelay = WHF_roleSelectionGUI_switchDelay;
        private _lastSwitch = WHF_roleSelectionGUI_lastSwitch;
        uiTime < _lastSwitch + _switchDelay
    };
    WHF_roleSelectionGUI_updateSwitchTimeout = {
        WHF_roleSelectionGUI_lastSwitch = uiTime;
    };

    private _primaryColor = ["GUI", "BCG_RGB"] call BIS_fnc_displayColorGet;

    private _group = _display ctrlCreate ["RscControlsGroup", -1];
    _group ctrlSetPosition [safeZoneX + 0.3 * safeZoneW, safeZoneY + 0.3 * safeZoneH, 0.4 * safeZoneW, 0.4 * safeZoneH];
    _group ctrlCommit 0;

    ctrlPosition _group params ["", "", "_width", "_height"];
    private _scaleToGroup = {_this vectorMultiply [_width, _height, _width, _height]};

    private _frame = _display ctrlCreate ["RscText", -1, _group];
    _frame ctrlSetPosition ([0, 0, 1, 1] call _scaleToGroup);
    _frame ctrlSetBackgroundColor [0, 0, 0, 0.7];
    _frame ctrlEnable false;
    _frame ctrlCommit 0;

    private _title = _display ctrlCreate ["RscText", -1, _group];
    _title ctrlSetPosition ([0, 0, 1, 0.05] call _scaleToGroup);
    _title ctrlSetBackgroundColor _primaryColor;
    _title ctrlSetText localize "$STR_WHF_roleSelectionGUI_title";
    _title ctrlEnable false;
    _title ctrlCommit 0;

    WHF_roleSelectionGUI_ctrlHeader = _display ctrlCreate ["RscStructuredText", -1, _group];
    WHF_roleSelectionGUI_ctrlHeader ctrlSetPosition ([0, 0.06, 1, 0.08] call _scaleToGroup);
    WHF_roleSelectionGUI_ctrlHeader ctrlEnable false;
    WHF_roleSelectionGUI_ctrlHeader ctrlCommit 0;

    private _rolesTitle = _display ctrlCreate ["RscText", -1, _group];
    _rolesTitle ctrlSetPosition ([0.05, 0.15, 0.6, 0.05] call _scaleToGroup);
    _rolesTitle ctrlSetText localize "$STR_WHF_roleSelectionGUI_roles";
    _rolesTitle ctrlEnable false;
    _rolesTitle ctrlCommit 0;

    WHF_roleSelectionGUI_ctrlRoles = _display ctrlCreate ["RscListBox", -1, _group];
    WHF_roleSelectionGUI_ctrlRoles ctrlSetPosition ([0.05, 0.2, 0.6, 0.6] call _scaleToGroup);
    WHF_roleSelectionGUI_ctrlRoles ctrlCommit 0;

    WHF_roleSelectionGUI_ctrlRoles ctrlAddEventHandler ["LBSelChanged", {with uiNamespace do {
        // call WHF_roleSelectionGUI_updateRoles; // Skip for performance
        call WHF_roleSelectionGUI_updatePlayers;
        call WHF_roleSelectionGUI_updateSelect;
    }}];

    WHF_roleSelectionGUI_ctrlRoles ctrlAddEventHandler ["KeyDown", {with uiNamespace do {
        params ["", "_key", "_shift", "_ctrl", "_alt"];
        if !(_key in [DIK_SPACE, DIK_RETURN, DIK_NUMPADENTER]) exitWith {};
        if (_alt) exitWith {}; // Alt+Enter usually toggles fullscreen
        call WHF_roleSelectionGUI_requestRole;
    }}];

    private _playersTitle = _display ctrlCreate ["RscText", -1, _group];
    _playersTitle ctrlSetPosition ([0.7, 0.15, 0.25, 0.05] call _scaleToGroup);
    _playersTitle ctrlSetText localize "$STR_WHF_roleSelectionGUI_players";
    _playersTitle ctrlEnable false;
    _playersTitle ctrlCommit 0;

    WHF_roleSelectionGUI_ctrlPlayers = _display ctrlCreate ["RscListBox", -1, _group];
    WHF_roleSelectionGUI_ctrlPlayers ctrlSetPosition ([0.7, 0.2, 0.25, 0.6] call _scaleToGroup);
    // WHF_roleSelectionGUI_ctrlPlayers ctrlEnable false;
    WHF_roleSelectionGUI_ctrlPlayers ctrlCommit 0;

    WHF_roleSelectionGUI_ctrlSelect = _display ctrlCreate ["RscButtonMenu", -1, _group];
    WHF_roleSelectionGUI_ctrlSelect ctrlSetPosition ([0.7, 0.82, 0.25, 0.13] call _scaleToGroup);
    WHF_roleSelectionGUI_ctrlSelect ctrlSetStructuredText composeText [
        parseText "<img image='\a3\ui_f\data\igui\cfg\actions\reammo_ca.paa' size='2'/>",
        text localize "$str_cfg_markers_select" setAttributes [
            "align", "center",
            "font", "RobotoCondensed",
            "size", "1.5",
            "valign", "middle"
        ]
    ];
    WHF_roleSelectionGUI_ctrlSelect ctrlCommit 0;

    WHF_roleSelectionGUI_ctrlSelect ctrlAddEventHandler ["ButtonClick", {with uiNamespace do {
        call WHF_roleSelectionGUI_requestRole;
    }}];

    WHF_roleSelectionGUI_ctrlRespawn = _display ctrlCreate ["RscButtonMenu", -1, _group];
    WHF_roleSelectionGUI_ctrlRespawn ctrlSetPosition ([0.53, 0.89, 0.15, 0.06] call _scaleToGroup);
    WHF_roleSelectionGUI_ctrlRespawn ctrlSetStructuredText composeText [
        parseText "<img image='\a3\ui_f\data\igui\cfg\actions\getout_ca.paa' size='1'/>",
        text localize "$str_disp_int_respawn" setAttributes [
            "align", "center",
            "font", "RobotoCondensed",
            "size", "1",
            "valign", "middle"
        ]
    ];
    WHF_roleSelectionGUI_ctrlRespawn ctrlCommit 0;

    WHF_roleSelectionGUI_ctrlRespawn ctrlAddEventHandler ["ButtonClick", {
        closeDialog 1;
        playSoundUI ["a3\3den\data\sound\cfgsound\notificationdefault.wss"];

        0 spawn {
            scriptName "WHF_fnc_roleSelectionGUI_respawn";
            private _duration = 0.75 + random 0.5;
            private _half = _duration / 2;

            focusOn call WHF_fnc_lowerWeapon;
            cutText ["", "BLACK", _half];
            private _soundVolume = soundVolume;
            _half fadeSound 0;
            sleep _duration;

            private _marker = [focusOn] call WHF_fnc_respawnMarkers select 0;
            focusOn setPosASL AGLToASL markerPos [_marker, true];
            focusOn setDir markerDir _marker;

            _half fadeSound _soundVolume;
            cutText ["", "BLACK IN", _half];
        };
    }];

    call WHF_roleSelectionGUI_refreshState;
    _display spawn {
        while {uiSleep 10; !isNull _this} do {
            call WHF_roleSelectionGUI_refreshState;
        };
    };
}};
