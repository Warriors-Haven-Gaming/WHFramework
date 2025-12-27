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

if (
    getNumber (configOf cameraOn >> "artilleryScanner") > 0
    && {isNil "WHF_fnc_initMinimapHandlers_artillery"
    || {scriptDone WHF_fnc_initMinimapHandlers_artillery}}
) then {WHF_fnc_initMinimapHandlers_artillery = 0 spawn {
    scriptName "WHF_fnc_initMinimapHandlers_artillery";
    disableSerialization;

    // The artillery computer display is destroyed and created on demand.
    // While the player is in their artillery vehicle, wait until the
    // artillery computer is created and register icons on it.
    // Would be preferable to have an event handler for new displays...
    while {!isNull objectParent focusOn} do {
        sleep 1;
        if (!shownArtilleryComputer) then {continue};

        private _displays = allDisplays select {
            ctrlIDD _x isEqualTo -1
            && {ctrlClassName (_x displayCtrl 500) isEqualTo "CA_TSMap"}
        };
        if (_displays isEqualTo []) then {continue};

        private _ctrl = _displays # 0 displayCtrl 500;
        if (!isNil {_ctrl getVariable "WHF_addMinimapHandlers_called"}) then {continue};

        // FIXME: duplicated above
        _ctrl ctrlAddEventHandler ["Draw", WHF_fnc_drawMapProjectileIcons];
        _ctrl ctrlAddEventHandler ["Draw", WHF_fnc_drawMapFriendlyIcons];
        _ctrl setVariable ["WHF_addMinimapHandlers_called", true];
    };
}};
