# Garbage Collection

This implements custom garbage collection specific to the mission,
and is meant to be used alongside ARMA's [built-in garbage collector].

Missions can use [fn_queueGCDeletion.sqf] to queue objects to be deleted
and [fn_queueGCUnhide.sqf] to queue objects, usually terrain, to be unhidden
when players are no longer near the area.

[built-in garbage collector]: https://community.bistudio.com/wiki/Eden_Editor:_Scenario_Attributes#Garbage_Collection
[fn_queueGCDeletion.sqf]: fn_queueGCDeletion.sqf
[fn_queueGCUnhide.sqf]: fn_queueGCUnhide.sqf
