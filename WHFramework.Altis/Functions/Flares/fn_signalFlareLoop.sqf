/*
Function: WHF_fnc_signalFlareLoop

Description:
    Periodically check if any enemy groups should fire a signal flare.
    Must be executed in scheduled environment.

Author:
    thegamecracks

*/
private _lastSiren = time - WHF_signalFlareGlobalCooldown;
while {true} do {
    sleep (WHF_signalFlareCheckInterval max 1);

    if (time < _lastSiren + WHF_signalFlareGlobalCooldown) then {continue};

    private _leadersOnAlert =
        groups opfor + groups independent
        select {_x getVariable ["WHF_siren_disabled", false] isNotEqualTo true}
        select {
            isNil {_x getVariable "WHF_siren_lastFlare"}
            || {time - (_x getVariable "WHF_siren_lastFlare") > WHF_signalFlareGroupCooldown}
        }
        apply {leader _x}
        select {local _x}
        select {simulationEnabled _x}
        select {isNull objectParent _x}
        select {!captive _x}
        select {lifeState _x in ["HEALTHY", "INJURED"]}
        select {eyePos _x select 2 >= 0}
        select {currentWeapon _x isNotEqualTo ""}
        select {stance _x in ["STAND", "CROUCH"]}
        select {!("sniper" in toLowerANSI typeOf _x)}
        select {!("ghillie" in toLowerANSI typeOf _x)}
        select {
            private _leader = _x;
            _leader targets [true, WHF_signalFlareMaxDistance, [blufor], 30]
            findIf {_leader knowsAbout _x >= 2.5} >= 0
        }
        select {!lineIntersects [getPosASL _x, getPosASL _x vectorAdd [0, 0, 50], _x]};
    if (count _leadersOnAlert < 1) then {continue};

    // TODO: prioritize leaders closer to targets
    private _siren = selectRandom _leadersOnAlert;
    [_siren, random 100] remoteExec ["WHF_fnc_signalFlareBegin"];

    // NOTE: conditions duplicated in WHF_fnc_signalFlareBegin
    sleep 2;
    if (captive _siren) then {continue}; // Probably detained mid-signal, nice
    if !(lifeState _siren in ["HEALTHY", "INJURED"]) then {continue};
    if (isNil {_siren getVariable "WHF_siren_startedAt"}) then {continue};

    private _targets = _siren nearTargets WHF_signalFlareMaxDistance select {_x # 2 == blufor} apply {_x # 4};
    private _allies = (
        groups opfor + groups independent
        apply {leader _x}
        inAreaArray [getPosATL _siren, WHF_signalFlareRevealDistance, WHF_signalFlareRevealDistance]
    ) - [_siren];
    [_targets, _allies] remoteExec ["WHF_fnc_signalFlareReveal"];

    _lastSiren = time;
    group _siren setVariable ["WHF_siren_lastFlare", _lastSiren];
};
