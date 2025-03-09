/*
Function: WHF_fnc_initUnloadAction

Description:
    Add an action to unload units from a vehicle.

Author:
    thegamecracks

*/
player removeAction (player getVariable ["WHF_load_unloadID", -1]);
private _unloadID = player addAction [
    localize "$STR_VIV_UNLOAD",
    {
        private _target = crew cursorObject select {
            !isNil {_x getVariable 'WHF_load_actionIDs'}
        } select -1;

        private _sound = getArray (configFile >> "CfgVehicles" >> typeOf cursorObject >> "soundGetOut") # 0;
        if !("." in _sound) then {_sound = _sound + ".wss"};
        playSound3D [_sound, objNull, false, getPosASL _target];
        moveOut _target;
    },
    nil,
    11,
    true,
    true,
    "",
    "
    getCursorObjectParams params ['_vehicle', '', '_distance'];
    _distance < 3
    && {!(_vehicle isKindOf 'Man')
    && {crew _vehicle findIf {!isNil {_x getVariable 'WHF_load_actionIDs'}} >= 0}}
    "
];
player setVariable ["WHF_load_unloadID", _unloadID];
