scriptName "KOR_fnc_initFriendlyUnits";

#define BOAT_TYPE "B_T_Boat_Armed_01_minigun_F"

if (!isServer) exitWith {
	[] remoteExecCall ["KOR_fnc_initFriendlyUnits",2];
};

// TODO: handle unit health and invincible ratio(?)

private _fn_spawnBoatTeam = {
	params [
		["_handler",{},[{}]],
		["_boatSpawn",objNull,[objNull]],
		["_groupComposition",[],[[]]]
	];

	private _boat = BOAT_TYPE createVehicle [0,0,0];
	[_boat,false] remoteExec ["allowDamage",0,true];
	_boat setPosASL (getPosASL _boatSpawn);
	_boat setDir (getDir _boatSpawn);

	private _group = createGroup BLUFOR;
	[_group,true] call KISKA_fnc_GCH_setGroupExcluded;

	_group setVariable ["KOR_teamBoat",_boat];

	private _units = _groupComposition apply {
		private _unit = _group createUnit [_x,[0,0,0],[],0,"NONE"];
		_unit moveInAny _boat;
		_unit
	};
	
	_units joinSilent _group;
	_group setBehaviourStrong "AWARE";
	_group setCombatMode "BLUE";

	[_group] spawn _handler;

	[_group,_units]
};

private _boatTeams = [
	[
		KOR_fnc_handleBravoTeam,
		KOR_bravoTeam_boatSpawn,
		[
			"rhsusf_usmc_recon_marpat_wd_teamleader_fast",
			"rhsusf_usmc_recon_marpat_wd_rifleman_fast",
			"rhsusf_usmc_recon_marpat_wd_machinegunner_m249_fast",
			"rhsusf_usmc_recon_marpat_wd_rifleman_at_fast",
			"rhsusf_usmc_recon_marpat_wd_autorifleman_fast"
		]
	],
	[
		KOR_fnc_handleEchoTeam,
		KOR_echoTeam_boatSpawn,
		[
			"rhsusf_usmc_recon_marpat_wd_teamleader_fast",
			"rhsusf_usmc_recon_marpat_wd_rifleman_fast",
			"rhsusf_usmc_recon_marpat_wd_rifleman_fast",
			"rhsusf_usmc_recon_marpat_wd_rifleman_fast",
			"rhsusf_usmc_recon_marpat_wd_rifleman_fast",
			"rhsusf_usmc_recon_marpat_wd_machinegunner_m249_fast",
			"rhsusf_usmc_recon_marpat_wd_rifleman_at_fast",
			"rhsusf_usmc_recon_marpat_wd_rifleman_at_fast",
			"rhsusf_usmc_recon_marpat_wd_autorifleman_fast",
			"rhsusf_usmc_recon_marpat_wd_autorifleman_fast",
			"rhsusf_usmc_recon_marpat_wd_machinegunner"
		]
	]
] apply { _x call _fn_spawnBoatTeam };

private _allUnits = [];
_allUnits append ((_boatTeams select 0) select 1);
_allUnits append ((_boatTeams select 1) select 1);







allCurators apply {
	_x addCuratorEditableObjects [_allUnits,false];
};



nil
