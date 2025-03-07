/*
Function: WHF_fnc_escortUnit

Description:
    Make a unit escort a target.

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

// FIXME: could be extracted into a function
_caller removeAction (_caller getVariable ["WHF_escort_releaseID", -1]);
private _releaseID = _caller addAction [
    localize "$STR_WHF_prisoner_release",
    {
        params ["", "_caller"];
        detach (_caller getVariable "WHF_escort");
        _caller setVariable ["WHF_escort", nil];
    },
    nil,
    11,
    true,
    true,
    "",
    "
    !isNil {_this getVariable 'WHF_escort'}
    && {attachedTo (_this getVariable 'WHF_escort') isEqualTo _this
    && {lifeState (_this getVariable 'WHF_escort') in ['HEALTHY', 'INJURED']}}
    "
];
_caller setVariable ["WHF_escort_releaseID", _releaseID];

// TODO: add Load/Unload actions

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
