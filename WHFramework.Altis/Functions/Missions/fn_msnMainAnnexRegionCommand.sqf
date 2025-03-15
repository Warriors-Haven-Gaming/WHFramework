/*
Function: WHF_fnc_msnMainAnnexRegionCommand

Description:
    Players must capture or kill the region's commander.
    Function must be ran in scheduled environment.

Parameters:
    Position2D center:
        The center of the mission.
    Number radius:
        The radius of the mission.
    String parent:
        The parent task ID.
    Array objects:
        An array to append composition objects to.
        Useful for garbage collection.
    Array terrain:
        An array to append hidden terrain to.
        Useful for garbage collection.
    Array groups:
        An array to append groups to.
        Useful for garbage collection.
    Array vehicles:
        An array to individually append vehicles to.
        Useful for garbage collection.

Author:
    thegamecracks

*/
params ["_center", "_radius", "_parent", "_objects", "_terrain", "_groups", "_vehicles"];

[opfor, 1, _center, _radius, ["hq", 1], _objects] call WHF_fnc_createEmplacements
    params ["_compObjects", "_compTerrain", "_compGroups"];
_objects append flatten _compObjects;
_terrain append flatten _compTerrain;
_groups append _compGroups;

private _pos = getPosATL (_compObjects # 0 # 0);
private _garrisonGroup = [opfor, "standard", selectRandom [16, 24, 32], _pos, 25] call WHF_fnc_spawnUnits;
private _commanderGroup = [opfor, "officer", 1, _pos, 10] call WHF_fnc_spawnUnits;
private _commander = units _commanderGroup # 0;
[[_commander] + units _garrisonGroup, _pos, 30, true] call WHF_fnc_garrisonUnits;
_groups append [_garrisonGroup, _commanderGroup];

private _taskID = [
    blufor,
    ["", _parent],
    "mainAnnexRegionCommand",
    _pos getPos [75 + random 75, random 360],
    "CREATED",
    -1,
    false,
    "kill"
] call WHF_fnc_taskCreate;

while {true} do {
    sleep 3;
    if (!alive _commander || {captive _commander}) exitWith {
        [_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
    };
};
