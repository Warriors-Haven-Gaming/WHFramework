/*
Function: WHF_fnc_initContextActionRenumerate

Description:
    Add a context menu action to re-enumerate the group.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};

// TODO: should be declared as a proper function
WHF_fnc_initContextActionRenumerate_firstBreakInIndex = compileFinal {
    params ["_units"];
    private _indexes = _units apply {groupId _x};
    private _ret = -1;
    {
        if (_x - _forEachIndex isNotEqualTo 1) exitWith {
            _ret = _forEachIndex;
        };
    } forEach _indexes;
    _ret
};

[
    "WHF_context_action_renumerate",
    localize "$STR_WHF_context_action_renumerate",
    {isNil {
        private _group = group focusOn;
        if (!local _group) exitWith {};
        if (leader _group isNotEqualTo focusOn) exitWith {};

        // To preserve unit state, only reorder units past the first break in index.
        private _units = units _group;
        private _index = [_units] call WHF_fnc_initContextActionRenumerate_firstBreakInIndex;
        if (_index < 0) exitWith {};
        _units = _units select [_index];

        // Take note of any unit state we can recover
        private _state = _units apply {[
            _x,
            assignedTeam _x,
            currentCommand _x,
            expectedDestination _x
        ]};

        // Might break AI and mods, also might not work on MP players?
        private _temp = createGroup [side _group, true];
        _units joinSilent _temp;
        _units joinSilent _group;
        deleteGroup _temp;

        // Recover as much state as possible
        {
            _x params ["_unit", "_team", "_command", "_destination"];
            _unit assignTeam _team;
            _unit setDestination _destination;
            switch (_command) do {
                case "MOVE": {_x doMove _destination # 0};
                case "STOP": {doStop _x};
            };
        } forEach _state;
    }},
    nil,
    true,
    {
        local group focusOn
        && {leader group focusOn isEqualTo focusOn
        && {[units focusOn] call WHF_fnc_initContextActionRenumerate_firstBreakInIndex >= 0}}
    },
    false,
    "\a3\ui_f\data\igui\rsctitles\mpprogress\respawn_ca.paa"
    // "\a3\ui_f\data\gui\rsc\rscdisplaymultiplayersetup\logicunlocked_ca.paa"
] call WHF_fnc_contextMenuAdd;
