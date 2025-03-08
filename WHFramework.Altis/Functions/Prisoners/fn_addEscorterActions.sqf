/*
Function: WHF_fnc_addEscorterActions

Description:
    Add actions to an escorter.

Parameters:
    Object unit:
        The unit to add actions to.

Author:
    thegamecracks

*/
params ["_unit"];

{_unit removeAction _x} forEach (_unit getVariable ["WHF_escort_actionIDs", []]);

private _condition = "
    !isNil {_this getVariable 'WHF_escort'}
    && {attachedTo (_this getVariable 'WHF_escort') isEqualTo _this
    && {lifeState (_this getVariable 'WHF_escort') in ['HEALTHY', 'INJURED']}}
";

private _loadID = _unit addAction [
    localize "$STR_VIV_GETIN",
    {
        params ["", "_unit"];
        private _target = _unit getVariable "WHF_escort";
        detach _target;

        private _sound = getArray (configFile >> "CfgVehicles" >> typeOf cursorObject >> "soundGetIn") # 0;
        if !("." in _sound) then {_sound = _sound + ".wss"};
        playSound3D [_sound, objNull, false, getPosASL cursorObject];
        [_target, cursorObject] remoteExec ["moveInCargo", _target];
    },
    nil,
    11,
    true,
    true,
    "",
    _condition + " && {
        getCursorObjectParams params ['_vehicle', '', '_distance'];
        _distance < 3 && {_vehicle emptyPositions 'Cargo' > 0}
    }"
];

private _releaseID = _unit addAction [
    localize "$STR_WHF_prisoner_release",
    {
        params ["", "_unit"];
        detach (_unit getVariable "WHF_escort");
        _unit setVariable ["WHF_escort", nil];
    },
    nil,
    11,
    true,
    true,
    "",
    _condition
];

_unit setVariable ["WHF_escort_actionIDs", [_loadID, _releaseID]];
