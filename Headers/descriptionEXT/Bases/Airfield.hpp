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
            ambientAnim = ON;
        };

        // TODO: fill out base
    };
};