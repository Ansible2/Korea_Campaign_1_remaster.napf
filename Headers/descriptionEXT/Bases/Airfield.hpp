class Airfield {
    side = SIDE_OPFOR;
    infantryClasses[] = {
        ENEMY_INFANTRY_UNIT_CLASSES
    };

    class turrets
    {
        class airfieldTurrets
        {
            side = SIDE_OPFOR;
            turrets = "Airfield Turrets";
            dynamicSim = ON;
        };
    };

    class infantry
    {
        class controlTower
        {
            side = SIDE_OPFOR;
            numberOfUnits = 8;
            unitsPerGroup = -1;

            positions = "Control Tower Spawns";

            dynamicSim = ON;
            canPath = OFF;
        };

        class samSiteA_spawns
        {
            numberOfUnits = 2;
            unitsPerGroup = -1;
            positions = "SAM Site A Spawns";
            dynamicSim = ON;
            canPath = ON;
            
        };
        class samSiteB_spawns : samSiteA_spawns
        {
            positions = "SAM Site B Spawns";
            numberOfUnits = 5;
            unitsPerGroup = -1;
        };

        class northRunway_spawns
        {
            positions = "North Runway Spawns";
            numberOfUnits = 5;
            unitsPerGroup = -1;
        };

        class southWestOutpost_spawns
        {
            numberOfUnits = 4;
            unitsPerGroup = -1;
            positions = "Southwest Outpost Spawns";
            dynamicSim = ON;
            canPath = ON;
        };

        class southEastOutpost_spawns : southWestOutpost_spawns
        {
            positions = "Southeast Outpost Spawns";
        };

        class radioTower_spawns : southWestOutpost_spawns
        {
            numberOfUnits = 2;
            positions = "Radio Tower Spawns";
        };

        class checkPoint_a_spawns
        {
            numberOfUnits = 4;
            unitsPerGroup = -1;
            positions = "Checkpoint a Spawns";

            dynamicSim = ON;
            canPath = ON;
        };
        class checkPoint_b_spawns : checkPoint_a_spawns
        {
            numberOfUnits = 5;
            unitsPerGroup = -1;
            positions = "Checkpoint b Spawns";
        };
        class checkPoint_c_spawns : checkPoint_a_spawns
        {
            numberOfUnits = 6;
            unitsPerGroup = -1;
            positions = "Checkpoint c Spawns";
        };
        class checkPoint_d_spawns : checkPoint_a_spawns
        {
            numberOfUnits = 6;
            unitsPerGroup = -1;
            positions = "Checkpoint d Spawns";
        };
        class checkPoint_e_spawns : checkPoint_a_spawns
        {
            numberOfUnits = 8;
            unitsPerGroup = -1;
            positions = "Checkpoint e Spawns";
        };

        class tower_1a_spawns
        {
            numberOfUnits = 4;
            unitsPerGroup = -1;
            positions = "Tower 1a Spawns";
            canPath = OFF;
            dynamicSim = ON;
        };

        class tower_1b_spawns
        {
            numberOfUnits = 4;
            unitsPerGroup = -1;
            positions = "Tower 1b Spawns";
            canPath = OFF;
            dynamicSim = ON;
        };

        class tower_2_spawns
        {
            numberOfUnits = 2;
            canPath = OFF;
            dynamicSim = ON;
            positions = "Tower 2 Spawns";
        };
        class tower_3_spawns : tower_2_spawns
        {
            positions = "Tower 3 Spawns";
        };
        class tower_4_spawns : tower_2_spawns
        {
            positions = "Tower 4 Spawns";
        };

        class stationBuilding
        {
            numberOfUnits = 10;
            unitsPerGroup = -1;
            dynamicSim = ON;
            canPath = OFF;
            positions = "Station Builing Spawns";
            // onUnitsCreated = "[_this select 0,'KOR_airfield_captureRadarStation'] call KISKA_fnc_setupKillTask;";
        };

        class barracksInterior_spawns
        {
            numberOfUnits = 6;
            unitsPerGroup = 3;
            dynamicSim = ON;
            canPath = ON;
            positions = "Barracks Interior Spawns";
        };
        class barracksExterior_spawns
        {
            numberOfUnits = -1;
            unitsPerGroup = -1;
            dynamicSim = ON;
            canPath = ON;
            positions = "Barracks Extorier Spawns";
        };
    };

    class patrols
    {
        class basePatrol_1
        {
            spawnPosition = "basePatrol_1_spawn";
            numberOfUnits = 5;
            dynamicSim = ON;

            speed = "LIMITED";
            behaviour = "SAFE";
            combatMode = "RED";
            formation = "STAG COLUMN";

            onGroupCreated = "";

            class SpecificPatrol
            {
                patrolPoints = "Base Patrol 1 Route";
                random = OFF;
                numberOfPoints = -1;
            };
        };
        class basePatrol_2 : basePatrol_1
        {
            spawnPosition = "basePatrol_2_spawn";
            class SpecificPatrol : SpecificPatrol
            {
                patrolPoints = "Base Patrol 2 Route";
            };
        };
        class basePatrol_3
        {
            spawnPosition = "basePatrol_3_spawn";
            numberOfUnits = 6;
            dynamicSim = ON;

            speed = "LIMITED";
            behaviour = "SAFE";
            combatMode = "RED";
            formation = "STAG COLUMN";

            onGroupCreated = "";

            class RandomPatrol
            {
                numberOfPoints = 4;
                radius = 300;
                waypointType = "MOVE";
            };
        };
        class basePatrol_4 : basePatrol_3
        {
            spawnPosition = "basePatrol_4_spawn";
        };
        class basePatrol_5 : basePatrol_3
        {
            spawnPosition = "basePatrol_5_spawn";
        };

    };

    class simples
    {
        class bm21s
        {
            positions = "Airfield BM21 Markers";
            class bm21
            {
                type = "RHS_BM21_MSV_01";
            };
        };

        class helicopters
        {
            positions = "Airfield Helicopter Markers";
            class lightHelicopter
            {
                superSimple = 0;
                type = "rhs_ka60_c";
                offset[] = {0,0,1.6};
                vectorUp[] = {-0.0384334,0.0364229,0.998597};
                selections[] = {
                    {"zasleh",1},
                    {"clan_sign",1},
                    {"clan",1}
                };
            };
            class heavyHelicopter
            {
                type = "RHS_Mi8mt_vvsc";
                offset[] = {0,0,1.75};
                vectorUp[] = {-0.0441042,0.0423563,0.998128};
                selections[] = {
                    {"zasleh",1},
                    {"clan_sign",1},
                    {"clan",1}
                };
            };
        };

        class fixedArty
        {
            positions = "Airfield Fixed Arty Markers";
            class object
            {
                type = "rhs_D30_at_msv";
            };
        };

        class fuelTrucks
        {
            positions = "Airfield FuelTruck Markers";
            class truck
            {
                type = "RHS_Ural_Fuel_MSV_01";
                selections[] = {
                    {"zasleh",1},
                    {"clan_sign",1},
                    {"clan",1}
                };
            };
        };

        class planes
        {
            positions = "Airfield Plane Markers";
            class attackPlane
            {
                type = "RHS_Su25SM_vvsc";
                offset[] = {0,0,1.95};
                vectorUp[] = {-0.0555795,0.062675,0.996485};
            };
        };

        class towingTractors
        {
            positions = "Airfield Towing Tractor Markers";
            class tractor
            {
                type = "CUP_O_TowingTractor_CSAT";
            };
        };

        class lightVehicles
        {
            positions = "Airfield Light Vehicle Markers";

            class uazOpen
            {
                type = "rhs_uaz_open_MSV_01";
                selections[] = {
                    {"clan_sign",1},
                    {"clan",1}
                };
            };
            class uaz : uazOpen
            {
                type = "RHS_UAZ_MSV_01";
            };
            class ural : uazOpen
            {
                type = "RHS_Ural_Flat_MSV_01";
            };
        };

        class heavyVehicles
        {
            positions = "Airfield Heavy Vehicle Markers";
            class tigr1
            {
                type = "rhs_tigr_sts_msv";
            };
            class tigr2
            {
                type = "rhs_tigr_m_msv";
            };
        };
    };
};