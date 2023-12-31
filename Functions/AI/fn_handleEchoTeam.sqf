#define DISMOUNT_RADIUS 20;

// ECHO TEAM DETAILS
// - 11 man team
// - inserts via boat
// - Should immediately drive boat to KOR_echoTeam_boatDismount and dismount

scriptName "KOR_fnc_handleEchoTeam";

if (!isServer) exitWith {
    ["Was not executed on the server!",true] call KISKA_fnc_log;
    _this remoteExecCall ["KOR_fnc_handleEchoTeam",2];
};

params [
    ["_echoGroup",grpNull,[grpNull]]
];


private _timeline = [
    [
        {},
        {
            localNamespace getVariable ["KOR_bluforSteppingOff",false]
        },
        2
    ],
    [
        [[_echoGroup],{
            _thisArgs params ["_echoGroup"];

            private _waypointObjects = ["Echo Team Insert Waypoints"] call KISKA_fnc_getMissionLayerObjects;
            private _waypointObjectNames = _waypointObjects apply { vehicleVarName _x };
            private _waypointObjectNames_sorted = [_waypointObjectNames] call KISKA_fnc_sortStringsNumerically;

            private _waypoints = _waypointObjectNames_sorted apply { 
                private _waypointPosition = getPosASL (missionNamespace getVariable _x);
                private _waypoint = _echoGroup addWaypoint [_waypointPosition,-1];
                _waypoint setWaypointType "MOVE";

                _waypoint
            };

            private _lastMoveWaypoint = _waypoints select -1;
            [
                _lastMoveWaypoint,
                {
                    params ["_echoGroup"];
                    private _boat = _echoGroup getVariable ["KOR_teamBoat",objNull];
                    (driver _boat) move (position KOR_echoTeam_boatDismount);
                }
            ] call KISKA_fnc_setWaypointExecStatement;

            _echoGroup
        }],
        {
            params ["","","","_echoGroup"];

            private _leader = leader _echoGroup;
            private _distance = (getPosASL _leader) vectorDistance (getPosASL KOR_echoTeam_boatDismount);

            _distance <= DISMOUNT_RADIUS
        },
        5
    ],
    [
        {
            params ["","","","_echoGroup"];

            private _groupOwner = groupOwner _echoGroup;
            [_echoGroup, "WHITE"] remoteExecCall ["setCombatMode",_groupOwner];
            [_echoGroup, "STEALTH"] remoteExecCall ["setBehaviourStrong",_groupOwner];
            
            private _leader = leader _echoGroup;
            private _boat = objectParent _leader;
            if !(isNull _boat) then {
                [_echoGroup, _boat] remoteExecCall ["leaveVehicle",_groupOwner];
                [units _echoGroup, _boat] remoteExecCall ["doGetOut",_groupOwner];
            };

            _echoGroup
        },
        {
            params ["","","","_echoGroup"];
            private _aUnitIsInTheBoat = [
                units _echoGroup, 
                { !(isNull (objectParent _x)) }
            ] call KISKA_fnc_findIfBool;

            !_aUnitIsInTheBoat
        },
        2
    ],
    [
        {
            params ["","","","_echoGroup"];

            private _groupOwner = groupOwner _echoGroup;
            [
                leader _echoGroup, 
                getPosATL KOR_echoTeam_waitPoint_1
            ] remoteExecCall ["move",_groupOwner];

            _echoGroup
        },
        { missionNamespace getVariable ["KOR_initiateAirfieldAttack",false] },
        3
    ],
    [
        {
            params ["","","","_echoGroup"];

            private _groupOwner = groupOwner _echoGroup;
            [_echoGroup, "RED"] remoteExecCall ["setCombatMode",_groupOwner];
            [_echoGroup, "AWARE"] remoteExecCall ["setBehaviourStrong",_groupOwner];
            [
                _echoGroup,
                KOR_echoTeam_attackPoint_1
            ] remoteExecCall ["KISKA_fnc_attack",_groupOwner];

            _echoGroup
        },
        {
            localNamespace getVariable ["KOR_cleared_AANorth",false]
        },
        5
    ],
    [
        {
            params ["","","","_echoGroup"];

            private _groupOwner = groupOwner _echoGroup;
            [
                _echoGroup,
                KOR_echoTeam_attackPoint_2
            ] remoteExecCall ["KISKA_fnc_attack",_groupOwner];
            [_echoGroup, "STAG COLUMN"] remoteExecCall ["setFormation",_groupOwner];

            _echoGroup
        },
        {
            localNamespace getVariable ["KOR_cleared_radioTower",false]
        },
        5
    ],
    [
        {
            params ["","","","_echoGroup"];

            private _groupOwner = groupOwner _echoGroup;
            [
                _echoGroup,
                KOR_echoTeam_attackPoint_3
            ] remoteExecCall ["KISKA_fnc_attack",_groupOwner];

            _echoGroup
        },
        {
            localNamespace getVariable ["KOR_cleared_outpostSoutheast",false]
        },
        5
    ]
];

[_timeline] call KISKA_fnc_timeline_start;

