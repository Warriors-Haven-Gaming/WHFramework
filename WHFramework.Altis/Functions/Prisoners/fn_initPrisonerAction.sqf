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
        private _prisoners = crew cursorObject select {
            !isNil {_x getVariable 'WHF_prisoner_actionIDs'}
        };
        moveOut (_prisoners # -1);
    },
    nil,
    10,
    true,
    true,
    "",
    "
    getCursorObjectParams params ['_vehicle', '', '_distance'];
    _distance < 3
    && {!(_vehicle isKindOf 'Man')
    && {crew _vehicle findIf {!isNil {_x getVariable 'WHF_prisoner_actionIDs'}} >= 0}}
    "
];
player setVariable ["WHF_prisoner_unloadID", _unloadID];
