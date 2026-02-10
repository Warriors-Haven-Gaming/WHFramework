/*
Function: WHF_fnc_reviveUnit

Description:
    Revives the given unit.
    Function must be executed where the unit is local.

Parameters:
    Object unit:
        The unit to be revived.

Author:
    thegamecracks

*/
params ["_unit"];
if (!local _unit) exitWith {};
_unit setDamage 0;
_unit setUnconscious false;
_unit allowDamage true;
// NOTE: captive state is restored in WHF_fnc_incapLoop

if (isNull objectParent _unit) then {
    if (
        _unit isEqualTo focusOn
        && {animationState _unit isNotEqualTo "unconsciousrevivedefault"
        || {cameraView isNotEqualTo "INTERNAL"}}
    ) then {
        private _eyePos = positionCameraToWorld [0,0,0];
        private _dirVector = getCameraViewDirection _unit;
        private _dir = _eyePos getDir (_eyePos vectorAdd _dirVector);
        _unit setDir _dir;
    };

    private _weapon = currentWeapon _unit;
    private _hasPrimary = primaryWeapon _unit isNotEqualTo "";
    private _hasHandgun = handgunWeapon _unit isNotEqualTo "";
    private _primaryAnim = "amovppnemstpsnonwnondnon_amovppnemstpsraswrfldnon";
    private _handgunAnim = "amovppnemstpsnonwnondnon_amovppnemstpsraswpstdnon";
    private _animation = switch (true) do {
        case (_hasPrimary && {_weapon isEqualTo primaryWeapon _unit}): {_primaryAnim};
        case (_hasHandgun && {_weapon isEqualTo handgunWeapon _unit}): {_handgunAnim};
        case (_hasPrimary): {_primaryAnim};
        case (_hasHandgun): {_handgunAnim};
        default {"unconsciousoutprone"};
    };

    [_unit, [_animation, 0, 0, false]] remoteExec ["switchMove"];
};
if (_unit isEqualTo focusOn) then {hintSilent ""};

playSound3D [
    selectRandom [
        "a3\sounds_f\characters\human-sfx\p18\soundrecovered_1.wss",
        "a3\sounds_f\characters\human-sfx\p18\soundrecovered_2.wss",
        "a3\sounds_f\characters\human-sfx\p18\soundrecovered_water_2.wss"
    ],
    _unit,
    false,
    _unit modelToWorldVisualWorld [0, 1, 0]
];
