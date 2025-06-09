/*
Function: WHF_fnc_selectBestPlaces

Description:
    An alternative for selectBestPlaces which always operates on the entire
    map and returns a subset of cached results. This should be used to prevent
    disk loading the entire map, which can freeze the game for several seconds.

    Caching is based on the expression key. As such, it is recommended to always
    normalize equivalent expressions, for example, sorting by alphabetical order
    and placing larger coefficients in front:
        2 * meadow + houses - hills - 2 * forest

    If the end of the cache has been reached, results will loop back around
    to the start of the cache.

Parameters:
    String expression:
        The simple expression to evaluate.
    Number sourcesCount:
        (Optional, default -1)
        The number of sources to return.
        If negative, a number between 30 to 50 is used.
        May return fewer sources if larger than cache.

Returns:
    Array

Author:
    thegamecracks

*/
params ["_expression", ["_sourcesCount", -1]];
if (_sourcesCount < 0) then {_sourcesCount = 30 + floor random 21};
if (isNil "WHF_selectBestPlaces_cache") then {WHF_selectBestPlaces_cache = createHashMap};

private _cache = WHF_selectBestPlaces_cache get _expression;
if (isNil "_cache") then {
    private _results = selectBestPlaces [
        [worldSize / 2, worldSize / 2],
        sqrt 2 / 2 * worldSize,
        _expression,
        200,
        2000
    ];
    _cache = [_results, 0];
    WHF_selectBestPlaces_cache set [_expression, _cache];
};

_cache params ["_results", "_index"];
if (_index + _sourcesCount >= count _results) then {_index = 0};
_cache set [1, _index + _sourcesCount];

+(_results select [_index, _sourcesCount])
