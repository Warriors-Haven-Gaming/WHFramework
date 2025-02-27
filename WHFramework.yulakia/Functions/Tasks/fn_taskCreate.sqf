/*
Function: WHF_fnc_taskCreate

Description:
    A simple proxy for BIS_fnc_taskCreate except that the taskID is randomly
    generated and returned. This is safe from race conditions even when
    ran in scheduled environment.
    See also: https://community.bistudio.com/wiki/BIS_fnc_taskCreate

Returns:
    String
        The task ID that was generated.

Examples:
    (begin example)
        [blufor, "", "clearZombies", _center, "CREATED", -1, true, "kill"] call BIS_fnc_taskCreate;
        // Note that taskID is an empty string - any dummy value is fine,
        // as the array will be modified in place with the new task ID.
    (end)

Author:
    thegamecracks

*/
private _ret = "";
isNil {
    if (_this # 1 isEqualType []) then {
        _this # 1 set [0, call WHF_fnc_randomTaskID];
    } else {
        _this set [1, call WHF_fnc_randomTaskID];
    };
    _ret = _this call BIS_fnc_taskCreate;
};
_ret
