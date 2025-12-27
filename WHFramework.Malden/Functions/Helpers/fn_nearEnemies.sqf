/*
Function: WHF_fnc_nearEnemies

Description:
    Return an array of enemy units in a given area.

Parameters:
    Group | Object | Side side:
        The side to determine hostility towards.
        If a group is given, use its side.
        If an object is given, use the side of its group.
        For optimization, sideUnknown is considered friendly to all sides.
    Object | PositionAGL | Position2D pos:
        The position to find enemies around.
    Number radius:
        The radius to search around for enemies.

Returns:
    Array

Author:
    thegamecracks

*/
// Copied from BIS_fnc_sideIsEnemy
// #define SIDES_ENUM [east, west, independent, civilian, sideUnknown, sideEnemy, sideFriendly, sideLogic, sideEmpty, sideAmbientLife]
#define SIDES_ENUM [east, west, independent, civilian, sideEnemy]

params ["_side", "_pos", "_radius"];
if (_side isEqualType objNull) then {_side = group _side};
if (_side isEqualType grpNull) then {_side = side _side};
if (_pos isEqualType objNull) then {_pos = ASLToAGL getPosASL _pos};
// NOTE: after 2.22, it might be faster to use PositionWorld

// 0.017ms
private _area = [_pos, _radius, _radius, 0, false];
private _units = _area nearEntities [["CAManBase"], false, true, true];

// 0.012ms
_units = _units select {
	!unitIsUAV _x
	&& {!captive _x
	&& {simulationEnabled _x
	&& {isDamageAllowed _x
	&& {!isObjectHidden _x
	&& {side group _x isNotEqualTo _side}}}}}
};
if (_units isEqualTo []) exitWith {_units};

if (isNil "WHF_fnc_nearEnemies_cache" || {time > WHF_fnc_nearEnemies_cache_expiry}) then {
    WHF_fnc_nearEnemies_cache = createHashMap;
    WHF_fnc_nearEnemies_cache_expiry = time + 5;
};

// 0.040ms with full SIDES_ENUM, 0.020ms with reduced SIDES_ENUM
private _getEnemySides = {SIDES_ENUM select {[_side, _x] call BIS_fnc_sideIsEnemy}};
private _enemySides = WHF_fnc_nearEnemies_cache getOrDefaultCall [_side, _getEnemySides, true];

// 0.006ms
_units select {side group _x in _enemySides}
