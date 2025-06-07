/*
Function: WHF_fnc_freeUnit

Description:
    Make a unit free a prisoner.
    Function must be executed in scheduled environment where the unit is local.

Parameters:
    Object caller:
        The unit freeing the target.
    Object target:
        The unit to be freed.

Author:
    thegamecracks

*/
params ["_caller", "_target"];

remoteExec ["", netId _target + ":addPrisonerActions"];
[_target] remoteExec ["WHF_fnc_removePrisonerActions"];

// TODO: request/response local chat

private _animation = "amovpercmstpssurwnondnon_amovpercmstpsnonwnondnon";
[_target, [_animation, 0, 0, false]] remoteExec ["switchMove"];
_target setCaptive false;
_target enableAIFeature ["PATH", true];
_target setUnitPos "UP";

// Healing the target afterwards can cause them to follow the player
// indefinitely, so let's make sure their legs work right away
_target setHit ["legs", (_target getHit "legs") min 0.45];

// If garbage collection is disabled, assume there's custom behaviour
// for this unit and that they shouldn't run away
if (!isNil {_target getVariable "WHF_disableGC"}) exitWith {};

_target enableAIFeature ["FSM", false];
_target forceSpeed (_target getSpeed "FAST");

private _group = group _target;
if (side _group isNotEqualTo civilian || {count units _group > 1}) then {
    _group = createGroup [civilian, true];
    [_target] joinSilent _group;
} else {
    [_group] call WHF_fnc_clearWaypoints;
};

private _dir = getPosATL _caller getDir getPosATL _target;
private _pos = getPosATL _target getPos [700, _dir];
if (surfaceIsWater _pos) then {
    private _randPos = [[[_pos, 200]]] call BIS_fnc_randomPos;
    if (_randPos isNotEqualTo [0,0]) exitWith {_pos = _randPos};
    _randPos = [[[_pos, 1000]], [[getPosATL _target, 500], "water"]] call BIS_fnc_randomPos;
    if (_randPos isNotEqualTo [0,0]) exitWith {_pos = _randPos};
};
_target doMove (_pos vectorMultiply [1,1,0]);
