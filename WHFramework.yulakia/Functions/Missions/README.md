# Missions

This contains the functions involved in all the procedurally generated tasks
in the mission.

Yes, this category is poorly named as the term "mission" is already used
by ARMA to describe the gamemode itself. As such, for the purposes of this
explanation, any reference to a generated task here will be described as a
mission, and any reference to the mission as a whole will be described as
the gamemode.

Each mission consists of a function which handles the entire mission from start
to end, including:

- Finding an appropriate location
- Spawning in units
- Creating the task for players to see
- Determining the mission's success or failure
- Determining who participated in the mission so it can be tracked
  in each player's stats

[initServer.sqf] will spawn the [fn_missionLoop.sqf] script to orchestrate
mission generation. When it wants to start a mission, the function is spawned
in and its [script handle] is stored in a variable. Once the script is done,
the mission is considered completed and the mission loop can decide to spawn
another mission.

As of now, there is no way to reliably interrupt active missions.
Scripts can be terminated, but SQF does not provide a way to run cleanup code
when this happens which can cause objects to not be garbage collected,
tasks to not be cancelled, and spawners to continue running silently.
In a future update, a mechanism might be provided for mission scripts
to check if the mission is being asked to stop.

[initServer.sqf]: ../../initServer.sqf
[fn_missionLoop.sqf]: fn_missionLoop.sqf
[script handle]: https://community.bistudio.com/wiki/Script_Handle
