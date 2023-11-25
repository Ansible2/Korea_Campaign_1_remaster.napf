#define DISMOUNT_RADIUS 20;

scriptName "KOR_fnc_handleBravoTeam";

if (!isServer) exitWith {
    ["Was not executed on the server!",true] call KISKA_fnc_log;
    _this remoteExecCall ["KOR_fnc_handleBravoTeam",2];
};

params [
    ["_bravoGroup",grpNull,[grpNull]]
];

// drive to player drop off
// wait for players to be dropped off
// drive to dismount

private _timeline = [
    [
        {},
        {
            localNamespace getVariable ["KOR_bluforSteppingOff",false]
        },
        2
    ],
    [
        [[_bravoGroup],{
            _thisArgs params ["_bravoGroup"];

            private _waypointObjects = ["Bravo Team Go To Drop Off Waypoints"] call KISKA_fnc_getMissionLayerObjects;
            private _waypointObjectNames = _waypointObjects apply { vehicleVarName _x };
            private _waypointObjectNames_sorted = [_waypointObjectNames] call KISKA_fnc_sortStringsNumerically;

            private _waypointPositions = _waypointObjectNames_sorted apply { 
                private _waypointPosition = getPosASL (missionNamespace getVariable _x);
                private _waypoint = _bravoGroup addWaypoint [_waypointPosition,-1];
                _waypoint setWaypointType "MOVE";

                _waypointPosition
            };

            private _lastWaypointPosition = _waypointPositions select -1;
            [_bravoGroup,_lastWaypointPosition]
        }],
        {
            params ["","","","_returnedArgs"];
            _returnedArgs params ["_bravoGroup","_lastWaypointPosition"];

            private _leader = leader _bravoGroup;
            private _distance = (getPosASL _leader) vectorDistance _lastWaypointPosition;
            private _inRadius = _distance <= DISMOUNT_RADIUS;

            private _boat = _bravoGroup getVariable ["KOR_teamBoat",objNull];
            private _unitsInBoat = crew _boat;
            private _playerInBoat = [
                _unitsInBoat,
                {isPlayer _x}
            ] call KISKA_fnc_findIfBool;

            _inRadius AND (!_playerInBoat)
        },
        5
    ],
    [
        [[_bravoGroup],{
            _thisArgs params ["_bravoGroup"];

            private _waypointObjects = ["Bravo Team After Drop Off Waypoints"] call KISKA_fnc_getMissionLayerObjects;
            private _waypointObjectNames = _waypointObjects apply { vehicleVarName _x };
            private _waypointObjectNames_sorted = [_waypointObjectNames] call KISKA_fnc_sortStringsNumerically;

            private _waypoints = _waypointObjectNames_sorted apply { 
                private _waypointPosition = getPosASL (missionNamespace getVariable _x);
                private _waypoint = _bravoGroup addWaypoint [_waypointPosition,-1];
                _waypoint setWaypointType "MOVE";

                _waypoint
            };

            private _lastMoveWaypoint = _waypoints select -1;
            [
                _lastMoveWaypoint,
                {
                    params ["_bravoGroup"];
                    private _boat = _bravoGroup getVariable ["KOR_teamBoat",objNull];
                    (driver _boat) move (position KOR_bravoTeam_dismount);
                }
            ] call KISKA_fnc_setWaypointExecStatement;

            _bravoGroup
        }],
        {
            params ["","","","_bravoGroup"];

            private _leader = leader _bravoGroup;
            private _distance = (getPosASL _leader) vectorDistance (getPosASL KOR_bravoTeam_dismount);
            _distance <= DISMOUNT_RADIUS
        },
        5
    ],
    [
        {
            params ["","","","_bravoGroup"];
            
            private _groupOwner = groupOwner _bravoGroup;
            [_bravoGroup, "WHITE"] remoteExecCall ["setCombatMode",_groupOwner];
            [_bravoGroup, "STEALTH"] remoteExecCall ["setBehaviourStrong",_groupOwner];

            private _leader = leader _bravoGroup;
            private _boat = objectParent _leader;
            if !(isNull _boat) then {
                [_bravoGroup, _boat] remoteExecCall ["leaveVehicle",_groupOwner];
                [units _bravoGroup, _boat] remoteExecCall ["doGetOut",_groupOwner];
            };

            _bravoGroup
        },
        {
            params ["","","","_bravoGroup"];
            private _aUnitIsInTheBoat = [
                units _bravoGroup, 
                { !(isNull (objectParent _x)) }
            ] call KISKA_fnc_findIfBool;

            !_aUnitIsInTheBoat
        },
        2
    ],
    [
        {
            params ["","","","_bravoGroup"];

            private _groupOwner = groupOwner _bravoGroup;
            private _leader = leader _bravoGroup;
            [_leader, getPosATL KOR_bravoTeam_waitPoint_1] remoteExecCall ["move",_groupOwner];

            _bravoGroup
        },
        { missionNamespace getVariable ["KOR_initiateAirfieldAttack",false] },
        3
    ],
    [
        {
            params ["","","","_bravoGroup"];

            private _groupOwner = groupOwner _bravoGroup;
            [_bravoGroup, "RED"] remoteExecCall ["setCombatMode",_groupOwner];
            [_bravoGroup, "AWARE"] remoteExecCall ["setBehaviourStrong",_groupOwner];
            [
                _bravoGroup,
                KOR_bravoTeam_attackPoint_1
            ] remoteExecCall ["KISKA_fnc_attack",_groupOwner];

            _bravoGroup
        },
        {
            localNamespace getVariable ["KOR_cleared_AANorth",false]
        },
        5
    ],
    [
        {
            params ["","","","_bravoGroup"];

            private _groupOwner = groupOwner _bravoGroup;
            [
                _bravoGroup,
                KOR_bravoTeam_attackPoint_2
            ] remoteExecCall ["KISKA_fnc_attack",_groupOwner];
            [_bravoGroup, "STAG COLUMN"] remoteExecCall ["setFormation",_groupOwner];

            _bravoGroup
        },
        {
            localNamespace getVariable ["KOR_cleared_radioTower",false]
        },
        5
    ],
    [
        {
            params ["","","","_bravoGroup"];

            private _groupOwner = groupOwner _bravoGroup;
            [
                _bravoGroup,
                KOR_bravoTeam_attackPoint_3
            ] remoteExecCall ["KISKA_fnc_attack",_groupOwner];

            _bravoGroup
        },
        {
            localNamespace getVariable ["KOR_cleared_outpostSoutheast",false]
        },
        5
    ]
];

[_timeline] call KISKA_fnc_timeline_start;

