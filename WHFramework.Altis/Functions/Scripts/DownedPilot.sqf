
//	Based on Hunt Player Script by Maff
//	Run from the On Activation of a trigger: execVM "DownedPilot.sqf";

//	Spawn units on marker "dp1" or spawn custom amount and type.
//_huntGroup = [markerPos "dp1", EAST, 25] call BIS_fnc_spawnGroup;

_huntGroup = [markerPos "dp1", EAST, [
"O_V_Soldier_TL_hex_F",
"O_V_Soldier_jtac_hex_F",
"O_V_Soldier_m_hex_F",
"O_V_Soldier_Exp_hex_F",
"O_V_Soldier_lat_hex_F",
"O_V_Soldier_Medic_hex_F",
"O_QRF_Soldier_SL_RF",
"O_QRF_soldier_M_RF",
"O_QRF_medic_RF",
"O_QRF_Soldier_RF",
"O_QRF_Soldier_HAT_RF",
"O_QRF_Soldier_AR_RF",
"O_QRF_Soldier_UAV_RF",
"O_QRF_Soldier_GL_RF",
]] call BIS_fnc_spawnGroup;

// Set the behavior of each unit in a group.
_huntGroup setCombatMode "RED";
_huntGroup setSpeedMode "FULL";
_huntGroup setBehaviourStrong "AWARE";

//	Set the skill for each unit in a group.
{
	_x setskill ["aimingAccuracy",0.2];
	_x setskill ["aimingShake",0.1];
	_x setskill ["aimingSpeed",0.1];
	_x setskill ["spotDistance",0.1];
	_x setskill ["spotTime",0.3];
	_x setskill ["courage",0.3];
	_x setskill ["reloadSpeed",0.1];
	_x setskill ["commanding",0.6];
	_x setskill ["general",0.7];
} forEach (units _huntGroup);

//	Tell _huntGroup to stalk, hunt the player and group.
_isHunting = [_huntGroup, group player] spawn BIS_fnc_stalk;
