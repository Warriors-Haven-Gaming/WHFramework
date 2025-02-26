/*
Function: WHF_fnc_sirenFlareBegin

Description:
    Begin the animation to fire a flare for a unit.
    Must be executed in scheduled environment.
    Should be remote executed on server and all clients.

Parameters:
    Object siren:
        The unit to perform the animation.
    Number seed:
        A random number to determine which animation to play.

Author:
    thegamecracks

*/
params ["_siren", "_seed"];

private _sequences = [
    [["Acts_JetsCrewaidRCrouchThumbup_in", "Acts_JetsCrewaidRCrouchThumbup_out"], 270],
    [["Acts_JetsCrewaidRCrouchThumbup_in_m", "Acts_JetsCrewaidRCrouchThumbup_out_m"], 90]
];

_seed = floor (_seed % count _sequences);
_sequences select _seed params ["_animations", "_flareDir"];

_siren switchMove [_animations # 0, 0, 0, false];
_siren playMove _animations # 1;

// Allow interrupting the unit via damage (can result in some janky hit reactions)
_siren setVariable ["WHF_siren_startedAt", time];
if (local _siren) then {
    _siren addEventHandler ["HandleDamage", {
        params ["_siren"];
        [_siren] remoteExec ["WHF_fnc_signalFlareInterrupt"];
        _siren removeEventHandler [_thisEvent, _thisEventHandler];
    }];
};

// NOTE: conditions duplicated in WHF_fnc_signalFlareLoop
sleep 2;
if (!alive _siren) exitWith {};
if (isNil {_siren getVariable "WHF_siren_startedAt"}) exitWith {};

_flareDir = getDir _siren + _flareDir;
[getPosATL _siren vectorAdd [0, 0, 2], [sin _flareDir * 3, cos _flareDir * 3, 50]] call WHF_fnc_signalFlareFire;
