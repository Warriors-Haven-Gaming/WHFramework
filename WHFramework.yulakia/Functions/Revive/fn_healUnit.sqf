/*
Function: WHF_fnc_healUnit

Description:
    Fully heal a unit, handling compatibility with other mods like ACE.

Parameters:
    Object unit:
        The unit to be healed. Unit must be local.

Author:
    thegamecracks

*/
params ["_unit"];
if (!local _unit) exitWith {};

switch (call WHF_fnc_getMedicalSystem) do {
    case "ace_medical": {
        // ACE
        _unit call ace_medical_fnc_fullHeal;
    };
    case "diw_armor_plates": {
        // Armor Plates System
        ["diw_armor_plates_main_healUnit", [_unit], _unit] call CBA_fnc_targetEvent;
        if (missionNamespace getVariable ["diw_armor_plates_main_spawnWithFullPlates", false] isEqualTo true) then {_unit spawn {
            // HACK:
            // Plates are tied to the vest container which gets replaced if
            // the unit receives a new loadout. Delay by at least 1 second
            // to allow loadout changes to apply first.
            sleep 1;
            waitUntil [{!isSwitchingWeapon _this}, 5, 1];

            _this call diw_armor_plates_main_fnc_fillVestWithPlates;

            // HACK: workaround for fill vest function not updating UI
            if (_this isEqualTo focusOn) then {
                disableSerialization;
                call diw_armor_plates_main_fnc_updatePlateUi;
            };
        }};
    };
    default {
        _unit setDamage 0;
    };
};
