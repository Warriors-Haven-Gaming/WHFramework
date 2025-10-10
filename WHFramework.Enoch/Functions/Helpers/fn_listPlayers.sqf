/*
Function: WHF_fnc_listPlayers

Description:
    Return all human players, not including virtual entities.
    About 6x faster than BIS_fnc_listPlayers, but 4x slower than allPlayers.
    Avoid usage in hot loops or per-frame contexts such as action conditions.

Returns:
    Array

Author:
    thegamecracks

*/
allPlayers select {!(_x isKindOf "VirtualMan_F")}
