/*
Function: WHF_fnc_drawMapProjectileIcons

Description:
    Draw projectile map icons.

Parameters:
    Display display:
        The map display to draw on.

Author:
    thegamecracks

*/
params ["_display"];

if (!WHF_icons_projectiles) exitWith {};
if (isNil "WHF_projectiles") exitWith {};

private _mapScale = ctrlMapScale _display;
private _iconScale = linearConversion [0.05, 0.002, _mapScale, 10, 24, true];

{
    _x params ["_started", "_projectile", "_rotation"];
    if (!alive _projectile) then {continue};

    _display drawIcon [
        "a3\ui_f\data\igui\cfg\cursors\explosive_ca.paa",
        [1, 0.1, 0, 0.75],
        _projectile modelToWorldVisual [0,0,0],
        _iconScale,
        _iconScale,
        _rotation + ctrlMapDir _display
    ];
} forEach WHF_projectiles;
