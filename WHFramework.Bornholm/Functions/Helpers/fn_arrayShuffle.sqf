/*
Function: WHF_fnc_arrayShuffle

Description:
    Return a shallow copy of an array with its elements shuffled.
    In most cases, this function should be preferred over BIS_fnc_arrayShuffle.

Returns:
    Array

Author:
    Nelson Duarte, optimised by Killzone_Kid, thegamecracks

*/
_this = [] + _this;
private _ret = [];
for "_i" from count _this to 1 step -1 do {
    _ret pushBack (_this deleteAt floor random _i);
};
_ret append _this;
_ret
