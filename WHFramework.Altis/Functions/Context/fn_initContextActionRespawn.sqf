/*
Function: WHF_fnc_initContextActionRespawn

Description:
    Add a context menu action to respawn a vehicle.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
[
    "WHF_context_action_respawn_vehicle",
    localize "$STR_WHF_context_action_respawn_vehicle",
    {
        private _vehicle = cursorObject;

        private _confirmed = [
            format [
                localize "$STR_WHF_context_action_respawn_vehicle_confirm",
                [configOf _vehicle] call BIS_fnc_displayName
            ],
            localize "$STR_WHF_context_action_respawn_vehicle",
            true,
            true,
            nil,
            false,
            false
        ] call BIS_fnc_guiMessage;
        if (!_confirmed) exitWith {};

        if !([_vehicle] call WHF_fnc_canForceRespawnVehicle) exitWith {};
        if (!isServer && {netId _vehicle isEqualTo "0:0"}) then {
            // Vehicle is local, can't be received by server
            deleteVehicle _vehicle;
        } else {
            [_vehicle] remoteExec ["WHF_fnc_forceRespawnVehicle", 2];
        };

        focusOn playActionNow "PutDown";
        playSoundUI ["a3\3den\data\sound\cfgsound\notificationdefault.wss"];
    },
    nil,
    true,
    {[cursorObject] call WHF_fnc_canForceRespawnVehicle},
    false,
    getTextRaw (configFile >> "CfgVehicles" >> "CAManBase" >> "ACE_SelfActions" >> "ACE_Explosives" >> "icon")
] call WHF_fnc_contextMenuAdd;
