/*
Function: WHF_fnc_reviveAction

Description:
    Make a unit perform a revive on the given target.
    Function must be executed in scheduled environment.

Parameters:
    Object caller:
        The unit to add revive actions to.
    Object target:
        The unit to be revived.

Author:
    thegamecracks

*/
params ["_caller", "_target"];
if !([_caller, _target] call WHF_fnc_unitCanRevive) exitWith {};

switch ([stance _caller, currentWeapon _caller]) do {
    case ["STAND", ""]:                       {["ainvpknlmstpslaywnondnon_medicother", "amovpknlmstpsnonwnondnon"]};
    case ["STAND", primaryWeapon _caller]:    {["ainvpknlmstpslaywrfldnon_medicother", "amovpknlmstpsraswrfldnon"]};
    case ["STAND", handgunWeapon _caller]:    {["ainvpknlmstpslaywpstdnon_medicother", "amovpknlmstpsraswpstdnon"]};
    case ["STAND", secondaryWeapon _caller]:  {["ainvpknlmstpslaywlnrdnon_medicother", "amovpknlmstpsraswlnrdnon"]};
    case ["CROUCH", ""]:                      {["ainvpknlmstpslaywnondnon_medicother", "amovpknlmstpsnonwnondnon"]};
    case ["CROUCH", primaryWeapon _caller]:   {["ainvpknlmstpslaywrfldnon_medicother", "amovpknlmstpsraswrfldnon"]};
    case ["CROUCH", handgunWeapon _caller]:   {["ainvpknlmstpslaywpstdnon_medicother", "amovpknlmstpsraswpstdnon"]};
    case ["CROUCH", secondaryWeapon _caller]: {["ainvpknlmstpslaywlnrdnon_medicother", "amovpknlmstpsraswlnrdnon"]};
    case ["PRONE", ""]:                       {["ainvppnemstpslaywnondnon_medicother", "amovppnemstpsnonwnondnon"]};
    case ["PRONE", primaryWeapon _caller]:    {["ainvppnemstpslaywrfldnon_medicother", "amovppnemstpsraswrfldnon"]};
    case ["PRONE", handgunWeapon _caller]:    {["ainvppnemstpslaywpstdnon_medicother", "amovppnemstpsraswpstdnon"]};
    default {["", ""]};
} params ["_animation", "_cancelAnim"];
if (_animation isEqualTo "") exitWith {};

private _reviveIsCanceled = {
    time > _timeout
    || {lifeState _target isNotEqualTo "INCAPACITATED"
    || {_caller getVariable ["WHF_revive_target", objNull] isNotEqualTo _target}}
};

_caller addEventHandler ["AnimDone", {
    params ["_caller", "_anim"];
    private _animation = _caller getVariable "WHF_revive_animation";
    if (isNil "_animation") exitWith {_caller removeEventHandler [_thisEvent, _thisEventHandler]};
    if (_anim isNotEqualTo _animation) exitWith {};
    _caller setVariable ["WHF_revive_animation", nil];
    _caller removeEventHandler [_thisEvent, _thisEventHandler];
}];

// WHF_revive_animation is cleared to indicate completion of animation, while
// WHF_revive_target is cleared to indicate a revive cancellation request.
_caller setVariable ["WHF_revive_animation", _animation];
_caller setVariable ["WHF_revive_target", _target];
_target setVariable ["WHF_revive_caller", _caller, true];

_caller playMoveNow _animation;
private _timeout = time + 10;
waitUntil {
    sleep 0.1;
    call _reviveIsCanceled || {isNil {_caller getVariable "WHF_revive_animation"}}
};
private _isCanceled = call _reviveIsCanceled;

_caller setVariable ["WHF_revive_animation", nil];
_caller setVariable ["WHF_revive_target", nil];
_target setVariable ["WHF_revive_caller", nil, true];

if (_isCanceled) exitWith {
    if (animationState _caller isEqualTo _animation) then {
        _caller switchMove [_cancelAnim, 0, 0, false];
    };
};

// TODO: consume first aid kit
[_target] remoteExec ["WHF_fnc_reviveUnit", _target];
