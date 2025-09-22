/*
Function: WHF_fnc_msnMainAnnexRegionCommand

Description:
    Players must capture or kill the region's commander.
    Function must be executed in scheduled environment.

Parameters:
    Position2D center:
        The center of the mission.
    Number radius:
        The radius of the mission.
    String faction:
        The faction to spawn units from.
    String parent:
        The parent task ID.
    Array objects:
        An array to append objects to.
        Useful for garbage collection.
    Array terrain:
        An array to append hidden terrain to.
        Useful for garbage collection.
    Array groups:
        An array to append groups to.
        Useful for garbage collection.

Author:
    thegamecracks

*/
params ["_center", "_radius", "_faction", "_parent", "_objects", "_terrain", "_groups"];

private _standard = ["standard", _faction];
private _officer = ["officer", _faction];

[opfor, [_standard], 1, _center, _radius, ["hq", 1], _objects]
    call WHF_fnc_createEmplacements
    params ["_compObjects", "_compTerrain", "_compGroups"];
if (count _compObjects < 1) exitWith {};

_objects append _compObjects;
_terrain append _compTerrain;
_groups append _compGroups;

private _pos = getPosATL (_compObjects # 0 # 0);
private _garrisonCount = [16, 32] call WHF_fnc_scaleUnitsMain;
private _garrisonGroup = [opfor, [_standard], _garrisonCount, _pos, 25] call WHF_fnc_spawnUnits;
private _commanderGroup = [opfor, [_officer], 1, _pos, 10] call WHF_fnc_spawnUnits;
private _commander = units _commanderGroup # 0;
[[_commander] + units _garrisonGroup, _pos, 30, true] call WHF_fnc_garrisonUnits;
_groups append [_garrisonGroup, _commanderGroup];

_commander addEventHandler ["Killed", {
    params ["_commander", "_killer", "_instigator"];
    if (!isNull (_commander call WHF_fnc_getDetainedBy)) exitWith {};
    if (isNull _instigator) then {_instigator = effectiveCommander _killer};
    if (!isPlayer _instigator) exitWith {};
    [
        [blufor, "HQ"],
        "$STR_WHF_mainAnnexRegionCommand_success_kill",
        [name _instigator]
    ] remoteExec ["WHF_fnc_localizedSideChat", blufor];
}];

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

private _detainer = _commander call WHF_fnc_getDetainedBy;
if (isPlayer _detainer) then {
    [
        [blufor, "HQ"],
        "$STR_WHF_mainAnnexRegionCommand_success_detain",
        [name _detainer]
    ] remoteExec ["WHF_fnc_localizedSideChat", blufor];
};
