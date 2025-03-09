/*
Function: WHF_fnc_addLoadActions

Description:
    Add load/release actions to a unit.

Parameters:
    Object unit:
        The unit to add actions to.
    String variable:
        The name of the variable containing the target of the load/unload actions.
        These actions will only appear while the target is attached to the unit.
    Array lifeStates:
        An array of allowed life state strings for the target to be in.
        Strings are compared with the result of the lifeState command.
    Array onLoad:
        (Optional, default [0, {}])
        The function to call after the target is loaded.
        The function will be passed two arguments, the target unit and
        the first element in the array.
    Array onRelease:
        (Optional, default [0, {}])
        The function to call after the target is released.
        The function will be passed two arguments, the target unit and
        the first element in the array.

Author:
    thegamecracks

*/
params [
    "_unit",
    "_targetVar",
    "_lifeStates",
    ["_onLoad", [0, {}]],
    ["_onRelease", [0, {}]]
];

private _targets = _unit getVariable ["WHF_load_targets", createHashMap];
_targets set [_targetVar, [_lifeStates, _onLoad, _onRelease]];
_unit setVariable ["WHF_load_targets", _targets];

{_unit removeAction _x} forEach (_unit getVariable ["WHF_load_actionIDs", []]);

private _condition = "
    private _targets = _this getVariable 'WHF_load_targets';
    !isNil '_targets' && {keys _targets findIf {
        _targets get _x params ['_lifeStates'];
        !isNil {_this getVariable _x}
        && {attachedTo (_this getVariable _x) isEqualTo _this
        && {lifeState (_this getVariable _x) in _lifeStates}}
    } >= 0}
";

private _loadID = _unit addAction [
    localize "$STR_VIV_GETIN",
    {
        params ["", "_unit"];

        private _targets = _unit getVariable "WHF_load_targets";
        private _targetVars = keys _targets;
        private _index = _targetVars findIf {
            _targets get _x params ["_lifeStates"];
            !isNil {_unit getVariable _x}
            && {attachedTo (_unit getVariable _x) isEqualTo _unit
            && {lifeState (_unit getVariable _x) in _lifeStates}}
        };
        private _targetVar = _targetVars # _index;
        private _target = _unit getVariable _targetVar;
        _targets get _targetVar params ["", "_onLoad"];
        _onLoad params ["_onLoadArgs", "_onLoadCode"];

        detach _target;

        private _sound = getArray (configFile >> "CfgVehicles" >> typeOf cursorObject >> "soundGetIn") # 0;
        if !("." in _sound) then {_sound = _sound + ".wss"};
        playSound3D [_sound, objNull, false, getPosASL cursorObject];
        [_target, cursorObject] remoteExec ["moveInCargo", _target];
        [_target, _onLoadArgs] call _onLoadCode;
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

        private _targets = _unit getVariable "WHF_load_targets";
        private _targetVars = keys _targets;
        private _index = _targetVars findIf {
            _targets get _x params ["_lifeStates"];
            !isNil {_unit getVariable _x}
            && {attachedTo (_unit getVariable _x) isEqualTo _unit
            && {lifeState (_unit getVariable _x) in _lifeStates}}
        };
        private _targetVar = _targetVars # _index;
        private _target = _unit getVariable _targetVar;
        _targets get _targetVar params ["", "", "_onRelease"];
        _onRelease params ["_onReleaseArgs", "_onReleaseCode"];

        detach _target;
        [_target, _onReleaseArgs] call _onReleaseCode;
        _unit setVariable [_targetVar, nil];
    },
    nil,
    11,
    true,
    true,
    "",
    _condition
];

_unit setVariable ["WHF_load_actionIDs", [_loadID, _releaseID]];
