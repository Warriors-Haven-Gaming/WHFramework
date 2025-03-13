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
_unit spawn {
    sleep WHF_revive_captiveDuration;
    if !(lifeState _this in ["HEALTHY", "INJURED"]) exitWith {};
    _this setCaptive false;
};
if (isNull objectParent _unit) then {
    private _animation = switch (true) do {
        case (primaryWeapon _unit isNotEqualTo ""): {"amovppnemstpsnonwnondnon_amovppnemstpsraswrfldnon"};
        case (handgunWeapon _unit isNotEqualTo ""): {"amovppnemstpsnonwnondnon_amovppnemstpsraswpstdnon"};
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
