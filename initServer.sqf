#include "Headers\Player Radius Defines.hpp"

/* ----------------------------------------------------------------------------
    General Setup
---------------------------------------------------------------------------- */
// KOR_testing = !(["ACE_main"] call KISKA_fnc_isPatchLoaded);
// [] call KOR_fnc_setupClassEventHandler;

// private _arsenals = ["Arsenals"] call KISKA_fnc_getMissionLayerObjects;
// [_arsenals] call KISKA_fnc_addArsenal;


/* ----------------------------------------------------------------------------
    Traits
---------------------------------------------------------------------------- */
// ["medic"] call KISKA_fnc_traitManager_addToPool_global;
// ["engineer"] call KISKA_fnc_traitManager_addToPool_global;


/* ----------------------------------------------------------------------------
    Effects
---------------------------------------------------------------------------- */
// call KOR_fnc_ambientShipFire;


/* ----------------------------------------------------------------------------
    Create Bases
---------------------------------------------------------------------------- */
// ["Airfield"] call KISKA_fnc_bases_createFromConfig;
// ["freedomFlightDeck"] call KISKA_fnc_bases_createFromConfig;
// ["lhdFlightDeck"] call KISKA_fnc_bases_createFromConfig;

/* ----------------------------------------------------------------------------
    Tasks
---------------------------------------------------------------------------- */
// ["KOR_airfield"] call KISKA_fnc_createTaskFromConfig;
// ["KOR_airfield_captureRadarStation"] call KISKA_fnc_createTaskFromConfig;
// ["KOR_airfield_destoryAntiAir"] call KISKA_fnc_createTaskFromConfig;


/* ----------------------------------------------------------------------------
    Setup the AA destruction task
---------------------------------------------------------------------------- */
// private _antiAirObjects = ["Airfield AA Objects"] call KISKA_fnc_getMissionLayerObjects;
// [
//     _antiAirObjects,
//     {
//         ["KOR_airfield_destoryAntiAir",0] call KISKA_fnc_endTask;
//     }
// ] call KISKA_fnc_setupMultiKillEvent;


// [
//     -1,
//     [
//         "CCM_AM_againstGhost",
//         "CCM_AM_hardDay",
//         "CCM_AM_hope",
//         "CCM_AM_iWillNotReturn",
//         "CCM_GERN_gloom",
//         "CCM_AV_Uncertainty",
//         "CCM_AM_youPromise",
//         "CCM_HF_adrift",
//         "CCM_HF_theWayOutLonging",
//         "CCM_HINT_covid1084",
//         "CCM_KE_TakeALookAroundYou",
//         "CCM_KE_Laburnum",
//         "CCM_KE_Thunderstorm",
//         "CCM_KE_Downpour",
//         "CCM_KE_Shinedown",
//         "CCM_KE_Imminence",
//         "CCM_KE_CurtainsAreAlwaysDrawn",
//         "CCM_SAV_pastTense",
//         "CCM_sb_midvinter",
//         "CCM_sb_aurora",
//         "CCM_sb_celestial",
//         "CCM_SQ_SunrisePiano",
//         "CCM_SQ_DramaticPiano",
//         "CCM_SQ_MyLand",
//         "CCM_sb_mercuryrising"
//     ],
//     [60]
// ] spawn KISKA_fnc_randomMusic;