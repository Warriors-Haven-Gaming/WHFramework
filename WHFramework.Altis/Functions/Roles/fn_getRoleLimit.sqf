/*
Function: WHF_fnc_getRoleLimit

Description:
    Return the number of players allowed for the given role.
    If an invalid role is given, return -1.

Parameters:
    String role:
        The role to get the limit of.

Returns:
    Number

Author:
    thegamecracks

*/
params ["_role"];

private _current = count allPlayers;
private _calculateLimit = {
    params ["_start", "_step"];
    floor (_start + _current / _step)
};

// TODO: add settings to customize role limits
switch (_role) do {
    case "arty":            {[1, 20] call _calculateLimit};
    case "aa":              {[3,  3] call _calculateLimit};
    case "at":              {[3,  3] call _calculateLimit};
    case "autorifleman":    {[3,  3] call _calculateLimit};
    case "engineer":        {[3,  8] call _calculateLimit};
    case "jtac":            {[2, 20] call _calculateLimit};
    case "medic":           {[4,  8] call _calculateLimit};
    case "pilot_cas":       {[2, 20] call _calculateLimit};
    case "pilot_transport": {[2, 10] call _calculateLimit};
    case "rifleman":        {_current};
    case "sniper":          {[4,  8] call _calculateLimit};
    case "uav":             {[1, 20] call _calculateLimit};
    default {-1};
}
