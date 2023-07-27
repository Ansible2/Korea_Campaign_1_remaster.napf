scriptName "KOR_fnc_ambientShipFire";

private _ambientTurrets = ["Ambient Ship Turrets"] call KISKA_fnc_getMissionLayerObjects;
_ambientTurrets apply {
    private _group = group _x;
    [_group,true] call KISKA_fnc_ACEX_setHCTransfer;
    _group setVariable ["KISKA_GCH_exclude",true,true];
};


KOR_ambientMissileTargets = ["Ambient Missile Targets"] call KISKA_fnc_getMissionLayerObjects;
KOR_ambientVLSLaunchers = ["Ambient VLS"] call KISKA_fnc_getMissionLayerObjects;

[] spawn {
    while {
		sleep (random [60,90,120]); 
		missionNamespace getVariable ["KOR_doShipAmbientFire",true]
	} do {
    	KOR_ambientVLSLaunchers apply {
    		sleep (random [5,10,15]);
    		[_x,selectRandom KOR_ambientMissileTargets] call KISKA_fnc_vlsFireAt;
    	};
    };
};


KOR_ambientHammers = ["Ambient Hammers"] call KISKA_fnc_getMissionLayerObjects;
KOR_ambientArtilleryTargets = ["Ambient Artillery Targets"] call KISKA_fnc_getMissionLayerObjects;

[] spawn {
    while {
		sleep (random [70,80,90]); 
		missionNamespace getVariable ["KOR_doShipAmbientFire",true]
	} do {
    	KOR_ambientHammers apply {
    		sleep (random [5,10,15]);
    		[_x,selectRandom KOR_ambientArtilleryTargets,random [1,3,5]] call KISKA_fnc_arty;
    	};
    };
};


nil
