class Airfield
{
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
        // control tower guys
        // infantryClasses[] = {};
        class controlTower
        {
            side = SIDE_OPFOR;
            numberOfUnits = 5;
            unitsPerGroup = 1;

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

        class checkPoint_1a_spawns
        {
            numberOfUnits = 4;
            unitsPerGroup = -1;
            positions = "Checkpoint 1a Spawns";

            dynamicSim = ON;
            canPath = ON;
        };
        class checkPoint_1b_spawns : checkPoint_1a_spawns
        {
            numberOfUnits = 5;
            unitsPerGroup = -1;
            positions = "Checkpoint 1b Spawns";
        };
        class checkPoint_1c_spawns : checkPoint_1a_spawns
        {
            numberOfUnits = 6;
            unitsPerGroup = -1;
            positions = "Checkpoint 1c Spawns";
        };
        class checkPoint_1d_spawns : checkPoint_1a_spawns
        {
            numberOfUnits = 6;
            unitsPerGroup = -1;
            positions = "Checkpoint 1d Spawns";
        };

        class tower_1_spawns
        {
            numberOfUnits = 2;
            unitsPerGroup = 2;
            positions = "Tower 1 Spawns";
            canPath = OFF;
            dynamicSim = ON;
        };
        class tower_2_spawns : tower_1_spawns
        {
            positions = "Tower 2 Spawns";
        };
        class tower_3_spawns : tower_1_spawns
        {
            positions = "Tower 3 Spawns";
        };
        class tower_4_spawns : tower_1_spawns
        {
            positions = "Tower 4 Spawns";
        };

        class stationBuilding
        {
            numberOfUnits = 10;
            unitsPerGroup = 1;
            dynamicSim = ON;
            canPath = OFF;
            positions = "Station Builing Spawns";
            // onUnitsCreated = "[_this select 0,'KOR_airfield_captureRadarStation'] call KISKA_fnc_setupKillTask;";
        };

        class barracksInterior_spawns
        {
            numberOfUnits = 12;
            unitsPerGroup = 1;
            dynamicSim = ON;
            canPath = OFF;
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
};