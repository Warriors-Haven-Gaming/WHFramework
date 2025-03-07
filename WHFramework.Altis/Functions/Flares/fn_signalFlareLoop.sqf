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
        groups east + groups independent
        select {
            _x getVariable ["WHF_siren_disabled", false] isNotEqualTo true
            && {isNil {_x getVariable "WHF_siren_lastFlare"}
            || {time - (_x getVariable "WHF_siren_lastFlare") > WHF_signalFlareGroupCooldown}}
        }
        apply {leader _x}
        select {
            private _leader = _x;
            local _leader
            && {alive _leader
            && {simulationEnabled _leader
            && {isNull objectParent _leader
            && {!captive _leader
            && {eyePos _leader select 2 >= 0
            && {stance _leader in ["STAND", "CROUCH"]
            && {["sniper", "ghillie"] findIf {_x in toLowerANSI typeOf _leader} < 0
            && {
                _leader targets [true, WHF_signalFlareMaxDistance, [west], 30]
                select {_leader knowsAbout _x >= 1.5}
                isNotEqualTo []
            && {
                private _pos = getPosASL _leader;
                !lineIntersects [_pos, _pos vectorAdd [0, 0, 50], _leader]
            }}}}}}}}}
        };
    if (count _leadersOnAlert < 1) then {continue};

    // TODO: prioritize leaders closer to targets
    private _siren = selectRandom _leadersOnAlert;
    [_siren, random 100] remoteExec ["WHF_fnc_signalFlareBegin"];

    // NOTE: conditions duplicated in WHF_fnc_signalFlareBegin
    sleep 2;
    if (!alive _siren) then {continue};
    if (captive _siren) then {continue}; // Probably detained mid-signal, nice
    if (isNil {_siren getVariable "WHF_siren_startedAt"}) then {continue};

    private _targets = _siren nearTargets WHF_signalFlareMaxDistance select {_x # 2 == west} apply {_x # 4};
    private _allies = (
        groups opfor + groups independent
        apply {leader _x}
        inAreaArray [getPosATL _siren, WHF_signalFlareRevealDistance, WHF_signalFlareRevealDistance]
    ) - [_siren];
    [_targets, _allies] remoteExec ["WHF_fnc_signalFlareReveal"];

    _lastSiren = time;
    group _siren setVariable ["WHF_siren_lastFlare", _lastSiren];
};
