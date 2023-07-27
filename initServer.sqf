#include "Headers\Player Radius Defines.hpp"

/* ----------------------------------------------------------------------------
    General Setup
---------------------------------------------------------------------------- */
KOR_testing = !(["ACE_main"] call KISKA_fnc_isPatchLoaded);
[] call KOR_fnc_setupClassEventHandler;

private _arsenals = ["Arsenals"] call KISKA_fnc_getMissionLayerObjects;
[_arsenals] call KISKA_fnc_addArsenal;


/* ----------------------------------------------------------------------------
    Traits
---------------------------------------------------------------------------- */
["medic"] call KISKA_fnc_traitManager_addToPool_global;
["engineer"] call KISKA_fnc_traitManager_addToPool_global;


/* ----------------------------------------------------------------------------
    Effects
---------------------------------------------------------------------------- */
call KOR_fnc_ambientShipFire;


/* ----------------------------------------------------------------------------
    Create Bases
---------------------------------------------------------------------------- */
["Airfield"] call KISKA_fnc_createbasefromconfig;
["freedomFlightDeck"] call KISKA_fnc_createbasefromconfig;
["lhdFlightDeck"] call KISKA_fnc_createbasefromconfig;