/*
Function: WHF_fnc_freeUnit

Description:
    Make a unit free a prisoner.
    Function must be executed where the unit is local.

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

if ("amovpercmstpssurwnondnon" in animationState _target) then {
    private _animation = "amovpercmstpssurwnondnon_amovpercmstpsnonwnondnon";
    [_target, [_animation, 0, 0, false]] remoteExec ["switchMove"];
};
_target setCaptive false;
_target enableAIFeature ["PATH", true];
// _target setUnitPos "AUTO";

// Healing the target afterwards can cause them to follow the player
// indefinitely, so let's make sure their legs work right away
_target setHit ["legs", (_target getHit "legs") min 0.45];

// If garbage collection is disabled, assume there's custom behaviour
// for this unit and that they shouldn't run away
if (!isNil {_target getVariable "WHF_disableGC"}) exitWith {};

private _group = group _target;
if (side _group isNotEqualTo civilian || {count units _group > 1}) then {
    _group = createGroup [civilian, true];
    [_target] joinSilent _group;
} else {
    {deleteWaypoint _x} forEachReversed waypoints _group;
};

// FIXME: maybe prevent running into water?
private _dir = getPosATL _caller getDir getPosATL _target;
private _pos = getPosATL _target getPos [500, _dir];
private _waypoint = _group addWaypoint [_pos, 0];
