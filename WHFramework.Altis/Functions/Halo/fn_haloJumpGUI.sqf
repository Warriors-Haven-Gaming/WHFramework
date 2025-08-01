/*
Function: WHF_fnc_haloJumpGUI

Description:
    Shows the map to select a location for halo jumping.

Author:
    thegamecracks

*/
if (!isNil "WHF_haloJump_mapHandlers") exitWith {};

private _vehicles = focusOn nearEntities ["LandVehicle", WHF_halo_antiair_distance];
if (_vehicles findIf {[_x, focusOn] call WHF_fnc_isEnemyAntiAir} >= 0) exitWith {
    50 cutText [localize "$STR_WHF_haloJumpGUI_antiair", "PLAIN DOWN", 0.3];
};

if (!WHF_halo_mission_exfil && {[focusOn] call WHF_fnc_inAreaMission isNotEqualTo []}) exitWith {
    50 cutText [localize "$STR_WHF_haloJumpGUI_mission", "PLAIN DOWN", 0.3];
};

private _isEnemy = {
    !unitIsUAV _x
    && {!captive _x
    && {lifeState _x in ["HEALTHY", "INJURED"]
    && {[_side, side group _x] call BIS_fnc_sideIsEnemy}}}
};
private _side = side group focusOn;
private _radius = WHF_halo_enemy_distance;
private _area = [getPosATL focusOn, _radius, _radius, 0, false];
private _units = _area nearEntities [["CAManBase"], false, false, true];
if (_units findIf _isEnemy >= 0) exitWith {
    50 cutText [localize "$STR_WHF_haloJumpGUI_enemy", "PLAIN DOWN", 0.3];
};

// TODO: add halo jump cooldown
if (!openMap true) exitWith {};

hint localize "$STR_WHF_haloJumpGUI_description";

WHF_haloJump_removeHandlers = {
    if (!isNil "WHF_haloJump_mapHandlers") then {
        {removeMissionEventHandler _x} forEach WHF_haloJump_mapHandlers;
        WHF_haloJump_mapHandlers = nil;
    };
    if (!isNil "WHF_haloJump_mapUnitHandlers") then {
        {
            _x params ["_unit", "_event"];
            _unit removeEventHandler _event;
        } forEach WHF_haloJump_mapUnitHandlers;
        WHF_haloJump_mapUnitHandlers = nil;
    };
};

WHF_haloJump_mapHandlers = [];
WHF_haloJump_mapHandlers pushBack ["Map", addMissionEventHandler ["Map", {
    params ["_opened"];
    if (_opened) exitWith {};

    hintSilent "";
    call WHF_haloJump_removeHandlers;
}]];
WHF_haloJump_mapHandlers pushBack ["MapSingleClick", addMissionEventHandler ["MapSingleClick", {
    params ["", "_pos"];

    // TODO: drawIcon on cursor position
    private _reason = [focusOn, _pos] call WHF_fnc_checkHaloJump;
    if (_reason isNotEqualTo "") exitWith {50 cutText [_reason, "PLAIN", 0.3]};

    hintSilent "";
    call WHF_haloJump_removeHandlers;

    openMap false;
    _pos = _pos vectorAdd [random 100 - 50, random 100 - 50];
    [_pos] spawn WHF_fnc_haloJump;
}]];

WHF_haloJump_mapUnitHandlers = [];
WHF_haloJump_mapUnitHandlers pushBack [
    focusOn,
    ["HandleDamage", focusOn addEventHandler ["HandleDamage", {
        params ["_unit"];
        openMap false;
        _unit removeEventHandler [_thisEvent, _thisEventHandler];
    }]]
];
