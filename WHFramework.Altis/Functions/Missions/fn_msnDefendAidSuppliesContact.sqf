/*
Function: WHF_fnc_msnDefendAidSuppliesContact

Description:
    Detect guard contact with enemies.
    Function must be ran in scheduled environment.

Parameters:
    Array signal:
        An array that should contain a single boolean.
        By setting this to false, the function can be safely terminated
        during execution. The status task will count as completed.
    Position2D center:
        The center of the mission area.
    Number radius:
        The radius of the mission area.
    Array groups:
        An array containing BLUFOR groups to watch for targets.

Author:
    thegamecracks

*/
params ["_signal", "_center", "_radius", "_groups"];

private _area = [_center, _radius, _radius];
private _playersInArea = {
    allPlayers
        select {side group _x isEqualTo blufor}
        inAreaArray _area
};

private _sideChat = {
    params ["_source", "_message", ["_params", []]];
    private _players = call _playersInArea;
    [_source, _message, _params] remoteExec ["WHF_fnc_localizedSideChat", _players];
};

private _guardGroups = _groups select {side _x isEqualTo blufor};
private _getFirstContact = {
    private _getTargets = {
        leader _this targets [true]
            select {leader _this targetKnowledge _x select 4 isNotEqualTo sideUnknown}
    };

    private _index =
        _guardGroups
        findIf {_x call _getTargets isNotEqualTo []};
    if (_index < 0) exitWith {[grpNull, []]};

    private _group = _guardGroups # _index;
    [_group, _group call _getTargets]
};

while {true} do {
    sleep 5;
    if !(_signal # 0) exitWith {};

    call _getFirstContact params ["_group", "_targets"];
    private _leader = leader _group;
    if (!alive _leader) then {continue};

    private _dir = _center getDir _targets # 0;
    _dir = round (_dir / 10) * 10;
    [_leader, "$STR_WHF_defendAidSupplies_contact", [_dir]] call _sideChat;

    {
        private _group = _x;
        {_group reveal _x} forEach _targets;
    } forEach _guardGroups;

    break;
};
