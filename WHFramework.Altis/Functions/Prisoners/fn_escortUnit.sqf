/*
Function: WHF_fnc_escortUnit

Description:
    Make a unit escort a target.
    Function must be executed where the unit is local.

Parameters:
    Object caller:
        The unit escorting the target.
    Object target:
        The unit to be escorted.

Author:
    thegamecracks

*/
params ["_caller", "_target"];
if (!isNil {_caller getVariable "WHF_escort"}) exitWith {};

_target attachTo [_caller, [0.1, -1.1, 0]];
_caller setVariable ["WHF_escort", _target];
[_caller, "WHF_escort", ["HEALTHY", "INJURED"]] call WHF_fnc_addLoadActions;

_caller spawn {
    while {true} do {
        private _target = _this getVariable "WHF_escort";
        if (isNil "_target") then {break};
        if (attachedTo _target isNotEqualTo _this) then {break};
        if !(lifeState _this in ["HEALTHY", "INJURED"]) then {break};
        if !(lifeState _target in ["HEALTHY", "INJURED"]) then {break};
        sleep (1 + random 1);
    };

    private _target = _this getVariable "WHF_escort";
    if (!isNil "_target") then {
        detach _target;
        _this setVariable ["WHF_escort", nil];
    };
};
