/*
Function: WHF_fnc_shrinkCount

Description:
    Count the elements in an array, additionally filtering it in-place
    when the array grows beyond a certain threshold. For arrays that
    would otherwise grow indefinitely, this can help prevent memory leaks
    and degraded performance.

Parameters:
    Array elements:
        The array to count and/or filter.
    Code predicate:
        The predicate function to use for counting the array.
        The variable _x will contain the currently tested element.
    Number threshold:
        (Optional, default 1000)
        The number of elements allowed before the array is filtered in-place.

Returns:
    Number
        The number of elements for which the predicate function returned true.

Author:
    thegamecracks

*/
params ["_elements", "_predicate", ["_threshold", 1000]];
if (count _elements < _threshold) exitWith {_predicate count _elements};

// Another function might push to the array while this is running
// so we need to be careful with how we delete elements from the array
private _copy = +_elements;
_elements deleteRange [0, count _copy];

_copy = _copy select _predicate;
private _remaining = _predicate count _elements;
_elements append _copy;

count _copy + _remaining
