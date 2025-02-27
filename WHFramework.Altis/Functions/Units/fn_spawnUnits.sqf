/*
Function: WHF_fnc_spawnUnits

Description:
    Spawn units at the given position.

Parameters:
    Side side:
        The group's side.
    Array types:
        One or more group types to spawn units from.
        See WHF_fnc_getUnitTypes for allowed values.
    Number quantity:
        The number of units to spawn.
    PositionATL center:
        The position at which units will spawn around.
    Number radius:
        The radius around the position at which units will spawn around.
    Array equipment:
        (Optional, default [])
        A list of equipment types to add to each unit.
        Can be contain of the following:
            "flashlights"

Returns:
    Group
        The group that was spawned in.

Author:
    thegamecracks

*/
params ["_side", "_types", "_quantity", "_center", "_radius", ["_equipment", []]];

private _group = createGroup _side;
private _unitTypes = _types call WHF_fnc_getUnitTypes;
for "_i" from 1 to _quantity do {
    private _unit = _group createUnit [selectRandom _unitTypes, _center, [], _radius, "NONE"];
    [_unit] joinSilent _group;
    _unit triggerDynamicSimulation false;

    _unit setSkill 1;
    _unit setSkill ["aimingAccuracy", 0.1 + random 0.1];
    _unit setSkill ["aimingShake", 0.45 + random 0.1];
    _unit setSkill ["aimingSpeed", 0.3 + random 0.1];
    _unit setSkill ["courage", 0.4 + random 0.2];
    _unit setSkill ["reloadSpeed", 0.45 + random 0.1];
    _unit setSkill ["spotDistance", 0.2 + random 0.1];
    _unit setSkill ["spotTime", 0.2 + random 0.1];

    if ("flashlights" in _equipment) then {
        _unit addPrimaryWeaponItem "acc_flashlight";
        _unit addHandgunItem "acc_flashlight_pistol";
        _unit enableGunLights "ForceOn";
    };
};
_group setBehaviourStrong "SAFE";
_group setCombatMode "RED";
_group spawn {sleep 1; [_this, true] remoteExec ["enableDynamicSimulation"]};
_group
