/*
Function: WHF_fnc_simulateAPSLoop

Description:
    Continuously identify and intercept threats around vehicles with APS.
    Function must be executed in scheduled environment.

Author:
    thegamecracks

*/
private _interceptTarget = {
    private _pos = getPosATL _x;
    deleteVehicle _x;

    private _vectorDir = _pos vectorDiff getPosATL _vehicle;
    private _vectorUp = vectorDir _vehicle vectorCrossProduct _vectorDir;
    private _bomb = createVehicle ["ClaymoreDirectionalMine_Remote_Ammo_Scripted", _pos, [], 0, "CAN_COLLIDE"];
    _bomb setVectorDirAndUp [_vectorDir, _vectorUp];
    _bomb setDamage 1;
};

private _showMessage = {
    // NOTE: does not consider remote controlled units
    private _players = crew _vehicle select {isPlayer _x};
    private _message = [
        "$STR_WHF_simulateAPSLoop_intercept",
        _ammo,
        _vehicle getVariable ["WHF_aps_ammo_max", _ammo]
    ];
    {_message remoteExec ["WHF_fnc_localizedCutText", _x]} forEach _players;
};

while {true} do {
    if (isNil "WHF_aps_vehicles" || {count WHF_aps_vehicles < 1}) then {
        sleep (1 + random 1);
        continue;
    };

    {
        private _vehicle = _x;
        if (!alive _vehicle) then {continue};

        private _ammo = _vehicle getVariable ["WHF_aps_ammo", 0];
        if (_ammo < 1) then {continue};

        private _targets = [getPosATL _vehicle, WHF_aps_radius] call WHF_fnc_nearAPSTargets;
        if (count _targets < 1) then {continue};

        _targets = [_vehicle, _targets] call WHF_fnc_checkAPSTargetPaths;
        if (count _targets < 1) then {continue};

        _targets = _targets select [0, _ammo];
        _interceptTarget forEach _targets;

        // FIXME: this has a race condition where if the same vehicle intercepts
        //        projectiles across multiple clients, the ammo may not decrement
        //        correctly.
        _ammo = _ammo - count _targets;
        _vehicle setVariable ["WHF_aps_ammo", _ammo, true];
        call _showMessage;
    } forEach WHF_aps_vehicles;

    sleep WHF_aps_rate;
};
