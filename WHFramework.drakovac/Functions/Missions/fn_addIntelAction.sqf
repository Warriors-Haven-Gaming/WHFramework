/*
Function: WHF_fnc_addIntelAction

Description:
    Add an action to collect intel.

Parameters:
    Object intel:
        The intel object to collect.
    String mode:
        (Optional, default "delete")
        The action performed after players collect the intel. Must be one of:
            "delete": deletes the object.
            "variable": sets WHF_intel_collected to true.

Author:
    thegamecracks

*/
params ["_intel", ["_mode", "delete"]];

private _condition = "true";
if (_mode isEqualTo "variable") then {
    _condition = _condition + "
        && {!(_originalTarget getVariable ['WHF_intel_collected', false])}
    ";
};
if (_intel isKindOf "Man") then {
    _condition = _condition + "
        && {!(lifeState _originalTarget in ['HEALTHY', 'INJURED'])
        || {captive _originalTarget}}
    ";
};

_intel addAction [
    localize "$STR_WHF_addIntelAction_title",
    {
        params ["_target", "_caller", "", "_mode"];

        _caller playActionNow "PutDown";
        playSoundUI [selectRandom [
            "a3\missions_f_oldman\data\sound\intel_body\1sec\intel_body_1sec_01.wss",
            "a3\missions_f_oldman\data\sound\intel_body\1sec\intel_body_1sec_02.wss",
            "a3\missions_f_oldman\data\sound\intel_body\1sec\intel_body_1sec_03.wss",
            "a3\missions_f_oldman\data\sound\intel_body\2sec\intel_body_2sec_01.wss",
            "a3\missions_f_oldman\data\sound\intel_body\2sec\intel_body_2sec_02.wss",
            "a3\missions_f_oldman\data\sound\intel_body\2sec\intel_body_2sec_03.wss"
        ]];

        sleep 1;
        switch (_mode) do {
            case "variable": {_target setVariable ["WHF_intel_collected", true, true]};
            default {deleteVehicle _target};
        };
    },
    _mode,
    12,
    true,
    true,
    "",
    _condition,
    3
];
