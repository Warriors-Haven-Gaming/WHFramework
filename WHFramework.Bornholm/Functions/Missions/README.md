# Missions

This category contains all functions involved in procedurally generated tasks
for this gamemode. Each mission consists of a function which handles the entire
sequence from start to end following this order:

1. Finding an appropriate location
2. Spawning in compositions, units, and vehicles
3. Creating a task for players to complete
4. Determining when the mission has succeeded or failed
5. Marking leftover objects for garbage collection

[initServer.sqf] uses the [fn_missionLoop.sqf] function to orchestrate
mission generation. When it wants to start a mission, its function is spawned
in and the [script handle] is stored. Once the script is done, the mission is
considered as completed and the mission loop can decide to spawn another mission.

To get started, it is strongly recommended to find a mission that already has
a similar structure to the mission you're planning to create, then copy it and
redesign sections as needed. This will help you produce code that is consistent
in style and behaviour with other missions.

[initServer.sqf]: ../../initServer.sqf
[fn_missionLoop.sqf]: fn_missionLoop.sqf
[script handle]: https://community.bistudio.com/wiki/Script_Handle
