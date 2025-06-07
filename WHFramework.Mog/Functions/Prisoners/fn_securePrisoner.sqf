/*
Function: WHF_fnc_securePrisoner

Description:
    Secure a prisoner that has been placed in a prison area.
    Function must be executed where the target is local.

Parameters:
    Object caller:
        The unit that released the prisoner.
    Object target:
        The unit to be imprisoned. Unit must be local.

Author:
    thegamecracks

*/
params ["_caller", "_target"];
if (!local _target) exitWith {};

if (isNull _caller) exitWith {};
if (!isNil {_target getVariable "WHF_prisoner_secured"}) exitWith {};
if (_target call WHF_fnc_inAreaPrison isEqualTo []) exitWith {};

// TODO: replace target unit with an agent?

// Garbage collection is queued upon successful detain attempt,
// but we can make them cleanup more aggressively here
// (some prisoners don't garbage collect either if they have WHF_disableGC)
[_target, 50, 300] remoteExec ["WHF_fnc_queueGCDeletion", 2];

_target setVariable ["WHF_prisoner_secured", true, true];
_target setObjectTextureGlobal [0,"#(rgb,8,8,3)color(0.7,0.1,0,1)"];
_target enableAIFeature ["ALL", false];
_target enableAIFeature ["ANIM", true];
// Have some decency!
// removeVest _target;
// removeBackpack _target;
// removeHeadgear _target;
// removeGoggles _target;
if (!isPlayer _target) then {
    _target allowDamage false;
    _target setCaptive false;
    [[_target], false] remoteExec ["WHF_fnc_setPhysicsCollisions", 0, true];
};

// private _detainer = _target call WHF_fnc_getDetainedBy;
// if (isNull _detainer) exitWith {};

private _seed = floor random 1000000;
[_caller, _target, _seed] remoteExec ["WHF_fnc_showSecuredPrisoner", side group _caller];
