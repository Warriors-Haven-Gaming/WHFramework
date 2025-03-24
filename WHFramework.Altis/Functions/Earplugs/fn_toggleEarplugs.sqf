/*
Function: WHF_fnc_toggleEarplugs

Description:
    Toggle the player's earplugs.

Parameters:
    Boolean enabled:
        (Optional, default nil)
        If provided, earplugs will always be set to this state.
        Otherwise, earplugs will be switched between on and off.
    Boolean force:
        (Optional, default false)
        If true, any changes to the player's volume will be ignored
        and overwritten instead of scaling the current volume.

Author:
    thegamecracks

*/
params ["_enabled", ["_force", false]];
if (isNil "WHF_earplugs_isEnabled") then {WHF_earplugs_isEnabled = false};
if (isNil "_enabled") then {_enabled = !WHF_earplugs_isEnabled};
if (_enabled isEqualTo WHF_earplugs_isEnabled) exitWith {};

private _duration = 1;
private _now = diag_tickTime;
if (isNil "WHF_earplugs_last") then {WHF_earplugs_last = _now - _duration};
if (WHF_earplugs_last + _duration > _now) exitWith {};

switch (true) do {
    case (_enabled && {_force}): {
        WHF_earplugs_music_last = 1;
        WHF_earplugs_radio_last = 1;
        WHF_earplugs_sound_last = 1;
        WHF_earplugs_speech_last = 1;

        if (WHF_earplugs_music) then {_duration fadeMusic WHF_earplugs_volume};
        if (WHF_earplugs_radio) then {_duration fadeRadio WHF_earplugs_volume};
        _duration fadeSound WHF_earplugs_volume;
        _duration fadeSpeech WHF_earplugs_volume;

        playSoundUI ["a3\ui_f\data\sound\cfgnotifications\defaultnotificationclose.wss", 5, 0.5];
    };
    case (_enabled): {
        WHF_earplugs_music_last = musicVolume;
        WHF_earplugs_radio_last = radioVolume;
        WHF_earplugs_sound_last = soundVolume;
        WHF_earplugs_speech_last = speechVolume;

        if (WHF_earplugs_music) then {_duration fadeMusic (WHF_earplugs_music_last * WHF_earplugs_volume)};
        if (WHF_earplugs_radio) then {_duration fadeRadio (WHF_earplugs_radio_last * WHF_earplugs_volume)};
        _duration fadeSound (WHF_earplugs_sound_last * WHF_earplugs_volume);
        _duration fadeSpeech (WHF_earplugs_speech_last * WHF_earplugs_volume);

        playSoundUI ["a3\ui_f\data\sound\cfgnotifications\defaultnotificationclose.wss", 5, 0.5];
    };
    case (!_enabled && {_force}): {
        _duration fadeMusic 1;
        _duration fadeRadio 1;
        _duration fadeSound 1;
        _duration fadeSpeech 1;

        playSoundUI ["a3\ui_f\data\sound\cfgingameui\hintexpand.wss", 5, 0.5];
    };
    case (!_enabled): {
        if (isNil "WHF_earplugs_music_last") then {WHF_earplugs_music_last = 1};
        if (isNil "WHF_earplugs_radio_last") then {WHF_earplugs_radio_last = 1};
        if (isNil "WHF_earplugs_sound_last") then {WHF_earplugs_sound_last = 1};
        if (isNil "WHF_earplugs_speech_last") then {WHF_earplugs_speech_last = 1};

        if (WHF_earplugs_music) then {_duration fadeMusic WHF_earplugs_music_last};
        if (WHF_earplugs_radio) then {_duration fadeRadio WHF_earplugs_radio_last};
        _duration fadeSound WHF_earplugs_sound_last;
        _duration fadeSpeech WHF_earplugs_speech_last;

        playSoundUI ["a3\ui_f\data\sound\cfgingameui\hintexpand.wss", 5, 0.5];
    };
};

WHF_earplugs_isEnabled = _enabled;
WHF_earplugs_last = _now;
