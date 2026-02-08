/*
Function: WHF_fnc_playServiceSound

Description:
    Play a servicing sound from the given vehicle.

Parameters:
    Object vehicle:
        The vehicle to play servicing sounds from.

Author:
    thegamecracks

*/
params ["_vehicle"];

if (isNil "WHF_service_sounds") then {WHF_service_sounds = [
    "a3\sounds_f\sfx\ui\vehicles\vehicle_repair.wss",
    "a3\sounds_f\sfx\ui\vehicles\vehicle_rearm.wss",
    "a3\sounds_f\sfx\ui\vehicles\vehicle_refuel.wss"
] call WHF_fnc_arrayShuffle};

if (!isNil "WHF_serviceSound_last" && {time < WHF_serviceSound_last + 4.25}) exitWith {};

private _sound = WHF_service_sounds deleteAt 0;
WHF_service_sounds pushBack _sound;
playSound3D [_sound, _vehicle];

WHF_serviceSound_last = time;
