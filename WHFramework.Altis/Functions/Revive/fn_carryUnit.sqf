/*
Function: WHF_fnc_carryUnit

Description:
    Make a unit carry a target.
    Function must be executed where the unit is local.

Parameters:
    Object caller:
        The unit carrying the target.
    Object target:
        The unit to be carried.

Author:
    thegamecracks

*/
params ["_caller", "_target"];
if (!isNil {_caller getVariable "WHF_carry"}) exitWith {};

_target attachTo [_caller, [-0.25,0,-1.2], "spine3"];
[_target, ["ainjpfalmstpsnonwnondf_carried_dead", 0, 1, false]] remoteExec ["switchMove"];

_caller setVariable ["WHF_carry", _target];
_caller allowSprint false;

private _onRelease = {
    params ["_target", "_caller"];
    [_target, ["unconsciousrevivedefault", 0, 1, false]] remoteExec ["switchMove"];
    _target setPosATL (_caller modelToWorldVisual [0, 1.5, 0]);
};
[_caller, "WHF_carry", ["INCAPACITATED"], nil, [_caller, _onRelease]] call WHF_fnc_addLoadActions;

_caller spawn {
    while {true} do {
        private _target = _this getVariable "WHF_carry";
        if (isNil "_target") then {break};
        if (attachedTo _target isNotEqualTo _this) then {break};
        if !(lifeState _this in ["HEALTHY", "INJURED"]) then {break};
        if !(lifeState _target in ["INCAPACITATED"]) then {break};
        sleep (1 + random 1);
    };

    _this allowSprint true;
    private _target = _this getVariable "WHF_carry";
    if (!isNil "_target") then {
        detach _target;
        _this setVariable ["WHF_carry", nil];
    };
};
