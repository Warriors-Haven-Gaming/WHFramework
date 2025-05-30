/*
Function: WHF_fnc_deployParachute

Description:
    Deploy a parachute for the given unit.

Parameters:
    Object unit:
        The unit to deploy the parachute for. May be a vehicle.

Author:
    thegamecracks

*/
params ["_unit"];
if (!alive _unit) exitWith {};
if (isTouchingGround _unit) exitWith {};
if (!isNull objectParent _unit) exitWith {};

private _pos = getPosATL _unit vectorAdd [0, 0, 1];

if (_unit isKindOf "Man") then {
    private _parachute = createVehicle ["Steerable_Parachute_F", _pos, [], 0, "CAN_COLLIDE"];
    _parachute setDir getDir _unit;
    _parachute setVelocity velocity _unit;
    _unit moveInDriver _parachute;
} else {
    private _parachute = createVehicle ["B_Parachute_02_F", _pos, [], 0, "CAN_COLLIDE"];
    _parachute setDir getDir _unit;
    _parachute setVelocity velocity _unit;
    _unit attachTo [_parachute, [0, 0, 0]];

    [_unit, _parachute] spawn {
        params ["_unit", "_parachute"];
        waitUntil {
            sleep 0.125;
            private _z = abs (boundingBox _unit # 0 # 2);
            private _pos = getPosASLVisual _unit;
            private _below = _pos vectorAdd [0, 0, _z - 6];

            !alive _unit
            || {!alive _parachute
            || {lineIntersects [_pos, _below, _unit, _parachute]
            || {getPos _unit select 2 < 6}}}
        };
        detach _unit;
    };
};
