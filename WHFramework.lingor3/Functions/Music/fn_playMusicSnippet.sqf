/*
Function: WHF_fnc_playMusicSnippet

Description:
    Play a snippet of the given music.
    Function must be executed in scheduled environment.

Parameters:
    String music:
        The name of the music class to play.
    Number duration:
        The duration to play before fading out.
        This duration does not include the time spent fading in.
    Number offset:
        (Optional, default 0)
        How far in to start the music.
    Number fadeIn:
        (Optional, default 0.5)
        How long to fade in the music.
    Number fadeOut:
        (Optional, default 3)
        How long to fade out the music after the duration has been played.
        After this, the music will be stoppped and the volume will be reset to 100%.
    Number fadeLast:
        (Optional, default -1)
        How long to fade out any previous music before playing.
        If less than 0, the music snippet will not be played at all.

Author:
    thegamecracks

*/
params [
    "_music",
    "_duration",
    ["_offset", 0],
    ["_fadeIn", 0.5],
    ["_fadeOut", 3],
    ["_fadeLast", -1]
];

private _canPlay = !isNil {
    if (_fadeLast < 0 && {getMusicPlayedTime > 0}) exitWith {};
    if (!isNil "WHF_playMusicSnippet_script") then {terminate WHF_playMusicSnippet_script};
    WHF_playMusicSnippet_script = _thisScript;
    true
};
if (!_canPlay) exitWith {};

if (_fadeLast >= 0 && {getMusicPlayedTime > 0}) then {
    _fadeLast fadeMusic 0;
    sleep _fadeLast;
} else {
    0 fadeMusic 0;
};

playMusic [_music, _offset];
_fadeIn fadeMusic 1;
sleep (_fadeIn + _duration);
if (getMusicPlayedTime <= 0) exitWith {};

_fadeOut fadeMusic 0;
sleep _fadeOut;

playMusic "";
0 fadeMusic 1;
