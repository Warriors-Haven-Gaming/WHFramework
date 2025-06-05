/*
Function: WHF_fnc_laserLightLoop

Description:
    Periodically toggles IR lasers and flashlights of the player's group
    to match the player's usage.
    Function must be executed in scheduled environment.

Author:
    thegamecracks

*/
while {true} do {
    sleep (1 + random 1);
    private _unit = focusOn;
    if (isNull _unit) then {continue};
    if (!local group _unit) then {continue};
    if (leader _unit isNotEqualTo _unit) then {continue};

    private _weapon = currentWeapon _unit;
    private _lasersOn = _unit isIRLaserOn _weapon;
    private _lightsOn = _unit isFlashlightOn _weapon;
    group _unit enableIRLasers _lasersOn;
    group _unit enableGunLights (["ForceOff", "ForceOn"] select _lightsOn);
};
