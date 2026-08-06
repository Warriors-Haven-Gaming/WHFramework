/*
Script: initServer.sqf

Description:
    Executed only on server when mission is started.
    https://community.bistudio.com/wiki/Event_Scripts#initServer.sqf

Author:
    thegamecracks

*/
private _fnc_scriptName = "initServer.sqf";

skipTime random 24;
enableSaving [false, false];

if (isMultiplayer) then {
    deleteVehicle (playableUnits select {!isPlayer _x});
} else {
    deleteVehicle (switchableUnits select {!isPlayer _x});
};

if (isMultiplayer) then {["Initialize"] call BIS_fnc_dynamicGroups};

WHF_timeMultiplierLoop_script = 0 spawn WHF_fnc_timeMultiplierLoop;

private _headlessClients =  entities "HeadlessClient_F" select {isPlayer _x};
private _runMissionLoopMain = {
    [] call WHF_fnc_waitSyncCBA;
    WHF_mainMissionLoop_script = [] spawn WHF_fnc_missionLoopMain;
};
private _runMissionLoopSide = {
    [] call WHF_fnc_waitSyncCBA;
    WHF_sideMissionLoop_script = [] spawn WHF_fnc_missionLoopSide;
};
switch (true) do {
    case (_headlessClients isEqualTo []): {
        diag_log text format ["%1: Starting main/side mission loops on server", _fnc_scriptName];
        call _runMissionLoopMain;
        call _runMissionLoopSide;
    };
    case (count _headlessClients > 1): {
        private _mainHC = _headlessClients # 0;
        private _sideHC = _headlessClients # 1;
        diag_log text format [
            "%1: Starting main/side mission loops on HCs '%2' and '%3'",
            _fnc_scriptName,
            name _mainHC,
            name _sideHC
        ];

        [0, _runMissionLoopMain] remoteExec ["spawn", _mainHC];
        [0, _runMissionLoopSide] remoteExec ["spawn", _sideHC];

        if (count _headlessClients > 2) then {diag_log text format [
            "%1: %2 more headless clients detected, they will be unused!",
            _fnc_scriptName,
            count _headlessClients - 2
        ]};
    };
    default {
        private _mainHC = _headlessClients # 0;
        diag_log text format [
            "%1: Starting main/side mission loops on HC '%2'",
            _fnc_scriptName,
            name _mainHC
        ];

        [0, _runMissionLoopMain] remoteExec ["spawn", _mainHC];
        [0, _runMissionLoopSide] remoteExec ["spawn", _mainHC];
    };
};
