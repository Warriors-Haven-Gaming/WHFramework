/*
Function: WHF_fnc_garbageCollectorLoop

Description:
    Handles garbage collection of objects.

Author:
    thegamecracks

*/
private _processDiscreetQueue = {
    params ["_queue", "_units", "_callback"];
    private _time = time;
    private _queueProcessed = [];
    {
        _x params ["_objects", "_minDistance", "_startAt"];

        _objects = _objects select {!isNull _x};
        if (count _objects < 1) then {
            _queueProcessed pushBack _forEachIndex;
            continue;
        };
        _x set [0, _objects];

        if (_time < _startAt) then {continue};

        private _center = _objects # 0;
        private _area = [getPosATL _center, _minDistance, _minDistance, 0, false];
        if ([_units, _area] call WHF_fnc_anyInArea) then {continue};

        _callback forEach _objects;
        _queueProcessed pushBack _forEachIndex;
    } forEach _queue;
    {_queue deleteAt _x} forEachReversed _queueProcessed;
};

private _deleteAbandonedRecruits = {
    private _hasACEMedical = isClass (configFile >> "CfgPatches" >> "ace_medical");

    {
        private _recruits = [];
        private _recruitOwners = [];
        private _presentOwners = [];

        {
            private _owner = _x getVariable "WHF_recruiter";
            switch (true) do {
                case (isPlayer _x): {_presentOwners pushBack getPlayerUID _x};
                case (!isNil "_owner"): {
                    _recruits pushBack _x;
                    _recruitOwners pushBackUnique _owner;
                };
            };
        } forEach units _x;

        private _missingOwners = _recruitOwners - _presentOwners;
        {
            if !(_x getVariable "WHF_recruiter" in _missingOwners) then {continue};

            private _incapacitated = lifeState _x isEqualTo "INCAPACITATED";
            if (_incapacitated && {_hasACEMedical}) then {continue};

            deleteVehicle _x;
        } forEach _recruits;
    } forEach groups blufor;
};

while {true} do {
    sleep (10 + random 10);

    if (isServer) then {call _deleteAbandonedRecruits};

    private _remoteControlledUnits = allPlayers apply {remoteControlled _x} select {!isNull _x};
    private _units = units blufor select {isPlayer _x};
    _units append allPlayers;
    _units append _remoteControlledUnits;
    _units = _units arrayIntersect _units;

    [WHF_gcDeletionQueue, _units, {deleteVehicle _x}] call _processDiscreetQueue;
    [WHF_gcUnhideQueue, _units, {_x hideObjectGlobal false}] call _processDiscreetQueue;
};
