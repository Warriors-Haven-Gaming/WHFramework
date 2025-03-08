/*
Function: WHF_fnc_initPrisonerAction

Description:
    Add actions related to handling of prisoners.
    See also WHF_fnc_addPrisonerActions for actions when looking at prisoners,
    and WHF_fnc_addEscorterActions for actions when escorting a prisoner.

Author:
    thegamecracks

*/
player removeAction (player getVariable ["WHF_prisoner_unloadID", -1]);
private _unloadID = player addAction [
    localize "$STR_VIV_UNLOAD",
    {
        private _target = crew cursorObject select {
            !isNil {_x getVariable 'WHF_prisoner_actionIDs'}
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
    "isNil {_this getVariable 'WHF_escort'} && {
        getCursorObjectParams params ['_vehicle', '', '_distance'];
        _distance < 3
        && {!(_vehicle isKindOf 'Man')
        && {crew _vehicle findIf {!isNil {_x getVariable 'WHF_prisoner_actionIDs'}} >= 0}}
    }"
];
player setVariable ["WHF_prisoner_unloadID", _unloadID];
