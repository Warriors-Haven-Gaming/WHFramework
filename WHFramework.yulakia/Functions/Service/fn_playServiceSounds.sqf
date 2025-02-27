/*
Function: WHF_fnc_playServiceSounds

Description:
    Plays servicing sounds in a loop until stopped.
    Only one vehicle can play service sounds at a time.

Parameters:
    Object vehicle:
        The vehicle to play servicing sounds from.

Author:
    thegamecracks

*/
params ["_vehicle"];
call WHF_fnc_stopServiceSounds;

if (!isNil "WHF_lastServiceSound" && {time - WHF_lastServiceSound < 5}) exitWith {};
WHF_lastServiceSound = time;

WHF_serviceSoundScript = [_vehicle] spawn {
    params ["_vehicle"];

    private _sounds = [
        "a3\sounds_f\sfx\ui\vehicles\vehicle_repair.wss",
        "a3\sounds_f\sfx\ui\vehicles\vehicle_rearm.wss",
        "a3\sounds_f\sfx\ui\vehicles\vehicle_refuel.wss"
    ] call WHF_fnc_arrayShuffle;

    while {true} do {
        private _sound = _sounds deleteAt 0;
        _sounds pushBack _sound;
        playSound3D [_sound, _vehicle];
        sleep 4.95;
    };

};
