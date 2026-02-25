/*
Function: WHF_fnc_initMinimapHandlers

Description:
    Set up minimap draw handlers.
    This should be called once on startup, and additionally every time
    the player gets into a vehicle to potentially handle new minimap displays.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};

private _minimap = uiNamespace getVariable "RscCustomInfoMiniMap";

{
    if (!isNil {_x getVariable "WHF_addMinimapHandlers_called"}) then {continue};

    // NOTE: order determines which icons draw over each other
    _x ctrlAddEventHandler ["Draw", WHF_fnc_drawMapProjectileIcons];
    _x ctrlAddEventHandler ["Draw", WHF_fnc_drawMapFriendlyIcons];

    _x setVariable ["WHF_addMinimapHandlers_called", true];
} forEach (
    uiNamespace getVariable ["IGUI_displays", []]
    select {ctrlIDD _x isEqualTo ctrlIDD _minimap}
    apply {_x displayCtrl 101}
);
