class CfgRemoteExec {
    class Functions {
        mode = 2;
        jip = 0;

        class AR_Client_Rappel_From_Heli {};
        class AR_Enable_Rappelling_Animation { allowedTargets = 2; };
        class AR_Hide_Object_Global { allowedTargets = 2; };
        class AR_Hint { allowedTargets = 1; };
        class AR_Rappel_From_Heli { allowedTargets = 2; };

        class AUR_Enable_Rappelling_Animation_Global { allowedTargets = 2; };
        class AUR_Hide_Object_Global { allowedTargets = 2; };
        class AUR_Hint { allowedTargets = 1; };
        class AUR_Play_Rappelling_Sounds_Global { allowedTargets = 2; };

        class BIS_fnc_callScriptedEventHandler {};
        class BIS_fnc_curatorRespawn {};
        class BIS_fnc_debugConsoleExec {};
        class BIS_fnc_deleteTask { jip = 1; };
        class BIS_fnc_dynamicGroups {};
        class BIS_fnc_effectKilled {};
        class BIS_fnc_effectKilledAirDestruction {};
        class BIS_fnc_effectKilledAirDestructionStage2 {};
        class BIS_fnc_effectKilledSecondaries {};
        class BIS_fnc_error {};
        class BIS_fnc_fire {};
        class BIS_fnc_initIntelObject { jip = 1; };
        class BIS_fnc_objectVar {};
        class BIS_fnc_playSound { allowedTargets = 1; };
        class BIS_fnc_sayMessage { allowedTargets = 1; };
        class BIS_fnc_setCustomSoundController {};
        class BIS_fnc_setIdentity {};
        class BIS_fnc_setTask { jip = 1; };
        class BIS_fnc_setTaskLocal { jip = 1; };
        class BIS_fnc_sharedObjectives {};
        class BIS_fnc_showNotification { allowedTargets = 1; };

        class SA_Attach_Tow_Ropes {};
        class SA_Drop_Tow_Ropes {};
        class SA_Hide_Object_Global { allowedTargets = 2; };
        class SA_Hint { allowedTargets = 1; };
        class SA_Pickup_Tow_Ropes {};
        class SA_Put_Away_Tow_Ropes {};
        class SA_Set_Owner { allowedTargets = 2; };
        class SA_Simulate_Towing {};
        class SA_Take_Tow_Ropes {};

        class WHF_fnc_addPrisonerActions { jip = 1; };
        class WHF_fnc_detainUnitRequest {};
        class WHF_fnc_disableUAVConnectability { allowedTargets = 1; jip = 1; };
        class WHF_fnc_enableDynamicSimulation { allowedTargets = 2; };
        class WHF_fnc_freeUnit {};
        class WHF_fnc_haloJumpCut {};
        class WHF_fnc_incapBleedout {};
        class WHF_fnc_incapUnit { jip = 1; };
        class WHF_fnc_localChat { allowedTargets = 1; };
        class WHF_fnc_localizedCutText { allowedTargets = 1; };
        class WHF_fnc_localizedHint { allowedTargets = 1; };
        class WHF_fnc_localizedSideChat { allowedTargets = 1; };
        class WHF_fnc_msnDownloadIntelLaptopTimer {};
        class WHF_fnc_msnSecureCachesActionCompleted {};
        class WHF_fnc_playMusicSnippet { allowedTargets = 1; };
        class WHF_fnc_queueGCDeletion { allowedTargets = 2; };
        class WHF_fnc_removePrisonerActions {};
        class WHF_fnc_reportJTACTarget { allowedTargets = 2; };
        class WHF_fnc_requestSkipTime { allowedTargets = 2; };
        class WHF_fnc_reviveUnit {};
        class WHF_fnc_serviceVehicle {};
        class WHF_fnc_setPhysicsCollisions { jip = 1; };
        class WHF_fnc_setSpeaker { allowedTargets = 1; jip = 1; };
        class WHF_fnc_signalFlareBegin {};
        class WHF_fnc_signalFlareInterrupt {};
        class WHF_fnc_signalFlareReveal {};
        class WHF_fnc_unflipVehicle {};
        class WHF_fnc_vehSpawnGUIServer { allowedTargets = 2; };
        class WHF_fnc_vehSpawnRequest { allowedTargets = 2; };
    };

    class Commands {
        mode = 2;
        jip = 0;
        class enableDynamicSimulation {}; // Should be server-only
        class lockTurret {}; // CUP?
        class moveInCargo {};
        class switchGesture {};
        class switchMove {};
        class triggerDynamicSimulation {}; // Should be server-only
        class unassignVehicle {};
    };
};
