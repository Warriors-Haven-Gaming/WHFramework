/*
Function: WHF_fnc_signalFlareFire

Description:
    Locally fire a signal flare.

Parameters:
    PositionATL pos:
        The position where the signal flare will spawn.
    Array vel:
        The 3D velocity at which the signal flare should fire with.

Author:
    thegamecracks

*/
params ["_pos", "_vel"];

private _flare = "F_40mm_Red" createVehicleLocal _pos;
private _l = "#lightpoint" createVehicleLocal _pos;
_flare setVelocity _vel;
_flare setVariable ["WHF_siren_light", _l];

_l attachTo [_flare, [0,0,0]];
_l setLightColor [1, 0.5, 0.5];
_l setLightAmbient [1, 0.5, 0.5];
_l setLightUseFlare true;
_l setLightFlareSize 30;
_l setLightFlareMaxDistance 1000;
_l setLightAttenuation [2, 0, 0, 1];
_l setLightBrightness 6;
_l setLightDayLight true;

_flare addEventHandler ["Deleted", {
    params ["_flare"];
    deleteVehicle (_flare getVariable ["WHF_siren_light", objNull]);
}];

playSound3D ["a3\missions_f_exp\data\sounds\exp_m04_flare.wss", _flare, false, getPosASL _flare, 3, 1, 0, 0, true];
