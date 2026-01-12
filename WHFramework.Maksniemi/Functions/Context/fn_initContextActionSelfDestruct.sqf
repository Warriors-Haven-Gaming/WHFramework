/*
Function: WHF_fnc_initContextActionSelfDestruct

Description:
    Add a context menu action to self-destruct a UAV.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
[
    "WHF_context_action_selfdestruct",
    localize "$STR_WHF_context_action_selfdestruct",
    {[player, objectParent focusOn] remoteExec ["WHF_fnc_selfDestructUAV"]},
    nil,
    true,
    {
        unitIsUAV focusOn
        && {!isNull cameraOn
        && {local focusOn
        && {
            private _owner = cameraOn getVariable "WHF_drones_owner";
            isNil "_owner" || {_owner isEqualTo "" || {getPlayerUID player isEqualTo _owner}}
        }}}
    },
    false,
    getTextRaw (configFile >> "CfgVehicles" >> "CAManBase" >> "ACE_SelfActions" >> "ACE_Explosives" >> "icon")
] call WHF_fnc_contextMenuAdd;
