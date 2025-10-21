/*
Function: WHF_fnc_vehSpawnGUIClient

Description:
    Show the vehicle spawner GUI.
    Function must be remote executed on client from the server.

Parameters:
    Object spawner:
        The vehicle spawner object being used.
    Number cooldown:
        The remaining time left until the spawn cooldown expires.
        May not be accurate with server time.

Author:
    thegamecracks

*/
params ["_spawner", "_cooldown"];
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};

private _role = player getVariable "WHF_role";
private _catalog = [_role] call WHF_fnc_vehSpawnCatalogRoleFilter;

private _pos = _spawner getVariable "WHF_vehSpawn_pos";
private _dir = _spawner getVariable "WHF_vehSpawn_dir";
private _categories = _spawner getVariable "WHF_vehSpawn_categories";
private _safeArea = _spawner getVariable "WHF_vehSpawn_safeArea";
if (count _categories == 0) then {_categories = keys _catalog};

if (_categories findIf {count (_catalog get _x get "_vehicles") > 0} < 0) exitWith {
    50 cutText [localize "$STR_WHF_vehSpawnGUIClient_empty", "PLAIN", 0.5];
};

_safeArea params ["_radius"];
private _objects = [_pos, _radius] call WHF_fnc_nearObjectsRespawn;
if (count _objects > 0) then {_pos = _pos findEmptyPosition _safeArea};
if (_pos isEqualTo []) exitWith {call WHF_fnc_vehSpawnObstructed};

player call WHF_fnc_lowerWeapon;
disableUserInput true;
0 cutText ["", "BLACK OUT", 0.5];
sleep 0.5;

private _posAGL = ASLToAGL ATLToASL _pos;
private _cameraPos = _pos getPos [15, _dir - 45];
_cameraPos set [2, _posAGL # 2 + 5];

private _camera = "camera" camCreate ASLToAGL eyePos player;
_camera cameraEffect ["internal", "back"];
_camera camPreparePos _cameraPos;
_camera camPrepareTarget (_posAGL vectorAdd [0, 0, 1]);
_camera camCommitPrepared (2.5 + random 0.5);
showCinemaBorder true;
camUseNVG (currentVisionMode player isEqualTo 1);
disableUserInput false;
0 cutText ["", "BLACK IN", 0.5];

uiNamespace setVariable ["WHF_vehSpawnGUI_camera", _camera];
uiNamespace setVariable ["WHF_vehSpawnGUI_spawner", _spawner];
uiNamespace setVariable ["WHF_vehSpawnGUI_pos", _pos];
uiNamespace setVariable ["WHF_vehSpawnGUI_dir", _dir];
uiNamespace setVariable ["WHF_vehSpawnGUI_categories", _categories];
uiNamespace setVariable ["WHF_vehSpawnGUI_cooldown", uiTime + _cooldown];
uiNamespace setVariable ["WHF_vehSpawnGUI_vehicles", _catalog];

isNil {with uiNamespace do {
    createDialog "RscDisplayEmpty";
    private _display = findDisplay -1;

    WHF_vehSpawnGUI_getSelectedCategory = {
        if (WHF_vehSpawnGUI_categories isEqualTo []) exitWith {nil};
        WHF_vehSpawnGUI_categories
            select lbCurSel WHF_vehSpawnGUI_ctrlCategory
            select 2;
    };

    WHF_vehSpawnGUI_refreshVehicles = {
        lbClear WHF_vehSpawnGUI_ctrlVehicle;
        private _category = call WHF_vehSpawnGUI_getSelectedCategory;
        if (isNil "_category") exitWith {};

        WHF_vehSpawnGUI_lastCategory = _category;
        _category = WHF_vehSpawnGUI_vehicles get _category;
        private _vehicles = _category get "_vehicles";

        WHF_vehSpawnGUI_ctrlVehicle_values = keys _vehicles apply {
            private _class = configFile >> "CfgVehicles" >> _x;
            [
                getText (_class >> "displayName"),
                _x,
                _class
            ]
        };
        WHF_vehSpawnGUI_ctrlVehicle_values sort true;

        {
            _x params ["_displayName", "", "_class"];
            WHF_vehSpawnGUI_ctrlVehicle lbAdd _displayName;
            WHF_vehSpawnGUI_ctrlVehicle lbSetPicture [_forEachIndex, getText (_class >> "icon")];
        } forEach WHF_vehSpawnGUI_ctrlVehicle_values;

        private _lastVehicle = WHF_vehSpawnGUI_lastVehicles getOrDefault [WHF_vehSpawnGUI_lastCategory, ""];
        private _lastVehicleIndex = WHF_vehSpawnGUI_ctrlVehicle_values findIf {_x # 1 isEqualTo _lastVehicle};
        _lastVehicleIndex = _lastVehicleIndex max 0;
        WHF_vehSpawnGUI_ctrlVehicle lbSetCurSel _lastVehicleIndex;
    };

    WHF_vehSpawnGUI_getSelectedVehicle = {
        if (WHF_vehSpawnGUI_ctrlVehicle_values isEqualTo []) exitWith {nil};
        WHF_vehSpawnGUI_ctrlVehicle_values
            select lbCurSel WHF_vehSpawnGUI_ctrlVehicle
            select 1;
    };

    WHF_vehSpawnGUI_refreshStatus = {
        private _cooldown = ceil (WHF_vehSpawnGUI_cooldown - uiTime);
        private _text = switch (true) do {
            case (_cooldown > 0): {
                WHF_vehSpawnGUI_ctrlConfirm ctrlEnable false;
                parseText format [
                    "<t align='center' color='#ff0000'>"
                    + "<img image='\a3\ui_f\data\igui\cfg\simpletasks\types\wait_ca.paa'/>"
                    + "%1</t>",
                    [_cooldown, "HH:MM:SS"] call BIS_fnc_secondsToString
                ]
            };
            case (isNil {call WHF_vehSpawnGUI_getSelectedCategory}): {
                WHF_vehSpawnGUI_ctrlConfirm ctrlEnable false;
                text ""
            };
            case (isNil {call WHF_vehSpawnGUI_getSelectedVehicle}): {
                WHF_vehSpawnGUI_ctrlConfirm ctrlEnable false;
                text ""
            };
            default {
                WHF_vehSpawnGUI_ctrlConfirm ctrlEnable true;
                private _category = call WHF_vehSpawnGUI_getSelectedCategory;
                private _vehicle = call WHF_vehSpawnGUI_getSelectedVehicle;
                private ["_cooldown"];
                with missionNamespace do {
                    _cooldown = [_category, _vehicle] call WHF_fnc_vehSpawnCatalogCooldown;
                };
                parseText format [
                    "<t align='center' color='#00ff00'>"
                    + "<img image='\a3\ui_f\data\igui\cfg\actions\ico_on_ca.paa'/>"
                    + "%1</t>",
                    [_cooldown, "HH:MM:SS"] call BIS_fnc_secondsToString
                ]
            };
        };
        WHF_vehSpawnGUI_ctrlStatus ctrlSetStructuredText _text;
    };

    WHF_vehSpawnGUI_categories =
        keys WHF_vehSpawnGUI_vehicles
        arrayIntersect WHF_vehSpawnGUI_categories
        select {count (WHF_vehSpawnGUI_vehicles get _x get "_vehicles") > 0}
        apply {[WHF_vehSpawnGUI_vehicles get _x get "_order", _x call BIS_fnc_localize, _x]};
    WHF_vehSpawnGUI_categories sort true;

    private _frame = _display ctrlCreate ["RscText", -1];
    _frame ctrlSetPosition [safeZoneX + 0.2 * safeZoneW, safeZoneY + 0.7 * safeZoneH, 0.6 * safeZoneW, 0.2 * safeZoneH];
    _frame ctrlSetBackgroundColor [0, 0, 0, 0.7];
    _frame ctrlEnable false;
    _frame ctrlCommit 0;

    WHF_vehSpawnGUI_ctrlCategory = _display ctrlCreate ["RscListbox", -1];
    WHF_vehSpawnGUI_ctrlCategory ctrlSetPosition [safeZoneX + 0.22 * safeZoneW, safeZoneY + 0.72 * safeZoneH, 0.1 * safeZoneW, 0.16 * safeZoneH];
    {
        _x params ["", "_displayName", "_category"];
        _category = WHF_vehSpawnGUI_vehicles get _category;
        WHF_vehSpawnGUI_ctrlCategory lbAdd _displayName;
        WHF_vehSpawnGUI_ctrlCategory lbSetPicture [_forEachIndex, _category get "_icon"];
    } forEach WHF_vehSpawnGUI_categories;
    WHF_vehSpawnGUI_ctrlCategory ctrlCommit 0;

    WHF_vehSpawnGUI_ctrlVehicle = _display ctrlCreate ["RscListbox", -1];
    WHF_vehSpawnGUI_ctrlVehicle ctrlSetPosition [safeZoneX + 0.33 * safeZoneW, safeZoneY + 0.72 * safeZoneH, 0.2 * safeZoneW, 0.16 * safeZoneH];
    WHF_vehSpawnGUI_ctrlVehicle ctrlCommit 0;
    WHF_vehSpawnGUI_ctrlVehicle_preview = objNull;

    WHF_vehSpawnGUI_ctrlStatus = _display ctrlCreate ["RscStructuredText", -1];
    WHF_vehSpawnGUI_ctrlStatus ctrlSetPosition [safeZoneX + 0.615 * safeZoneW, safeZoneY + 0.755 * safeZoneH, 0.1 * safeZoneW, 0.02 * safeZoneH];
    WHF_vehSpawnGUI_ctrlStatus ctrlEnable false;
    WHF_vehSpawnGUI_ctrlStatus ctrlCommit 0;

    WHF_vehSpawnGUI_ctrlConfirm = _display ctrlCreate ["RscButton", 1];
    WHF_vehSpawnGUI_ctrlConfirm ctrlSetPosition [safeZoneX + 0.615 * safeZoneW, safeZoneY + 0.785 * safeZoneH, 0.1 * safeZoneW, 0.05 * safeZoneH];
    WHF_vehSpawnGUI_ctrlConfirm ctrlSetText "Spawn";
    WHF_vehSpawnGUI_ctrlConfirm ctrlEnable false;
    WHF_vehSpawnGUI_ctrlConfirm ctrlCommit 0;

    WHF_vehSpawnGUI_ctrlCategory ctrlAddEventHandler ["LBSelChanged", {with uiNamespace do {
        call WHF_vehSpawnGUI_refreshVehicles;
    }}];

    WHF_vehSpawnGUI_ctrlVehicle ctrlAddEventHandler ["LBSelChanged", {with uiNamespace do {
        if (!isNull WHF_vehSpawnGUI_ctrlVehicle_preview) then {deleteVehicle WHF_vehSpawnGUI_ctrlVehicle_preview};
        call WHF_vehSpawnGUI_refreshStatus;

        private _category = call WHF_vehSpawnGUI_getSelectedCategory;
        private _vehicle = call WHF_vehSpawnGUI_getSelectedVehicle;
        if (isNil "_category" || {isNil "_vehicle"}) exitWith {};

        WHF_vehSpawnGUI_lastVehicles set [_category, _vehicle];
        WHF_vehSpawnGUI_ctrlVehicle_preview = _vehicle createVehicleLocal [-random 500, -random 500, random 500];
        WHF_vehSpawnGUI_ctrlVehicle_preview allowDamage false;
        WHF_vehSpawnGUI_ctrlVehicle_preview setPhysicsCollisionFlag false;
        WHF_vehSpawnGUI_ctrlVehicle_preview setVehicleLock "LOCKED";
        WHF_vehSpawnGUI_ctrlVehicle_preview setDir WHF_vehSpawnGUI_dir;
        WHF_vehSpawnGUI_ctrlVehicle_preview setVehiclePosition [WHF_vehSpawnGUI_pos, [], 0, "CAN_COLLIDE"];
        WHF_vehSpawnGUI_ctrlVehicle_preview enableSimulation false;
    }}];

    _display displayAddEventHandler ["Unload", {with uiNamespace do {
        params ["", "_exitCode"];

        missionProfileNamespace setVariable ["WHF_vehSpawnGUI_lastCategory", WHF_vehSpawnGUI_lastCategory];
        missionProfileNamespace setVariable ["WHF_vehSpawnGUI_lastVehicles", WHF_vehSpawnGUI_lastVehicles];
        saveMissionProfileNamespace;

        private _category = call WHF_vehSpawnGUI_getSelectedCategory;
        private _vehicle = call WHF_vehSpawnGUI_getSelectedVehicle;

        [_exitCode, _category, _vehicle] spawn {
            params ["_exitCode", "_category", "_vehicle"];

            0 cutText ["", "BLACK OUT", 0.5];
            sleep 0.5;
            WHF_vehSpawnGUI_camera cameraEffect ["terminate", "back"];
            deleteVehicle WHF_vehSpawnGUI_camera;
            deleteVehicle WHF_vehSpawnGUI_ctrlVehicle_preview;

            if (_exitCode isEqualTo 1) then {
                player setDir (getPosATL player getDir WHF_vehSpawnGUI_pos);
                [player, WHF_vehSpawnGUI_spawner, _category, _vehicle] remoteExec ["WHF_fnc_vehSpawnRequest", 2];
                sleep 0.5;
            };

            0 cutText ["", "BLACK IN", 0.5];
        };
    }}];

    WHF_vehSpawnGUI_lastCategory = missionProfileNamespace getVariable ["WHF_vehSpawnGUI_lastCategory", ""];
    WHF_vehSpawnGUI_lastVehicles = missionProfileNamespace getVariable ["WHF_vehSpawnGUI_lastVehicles", createHashMap];

    private _lastCategoryIndex = WHF_vehSpawnGUI_categories findIf {_x # 2 isEqualTo WHF_vehSpawnGUI_lastCategory};
    _lastCategoryIndex = _lastCategoryIndex max 0;
    WHF_vehSpawnGUI_ctrlCategory lbSetCurSel _lastCategoryIndex;

    _display spawn {
        while {!isNull _this} do {
            call WHF_vehSpawnGUI_refreshStatus;
            uiSleep (1 - abs (WHF_vehSpawnGUI_cooldown - uiTime) % 1);
        };
    };
}};
