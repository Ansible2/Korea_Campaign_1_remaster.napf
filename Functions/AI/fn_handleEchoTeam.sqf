#define DISMOUNT_RADIUS 20;

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
        [[_echoGroup],{
            _thisArgs params ["_echoGroup"];

            private _boat = _echoGroup getVariable ["KOR_teamBoat",objNull];
            (driver _boat) move (position KOR_echoTeam_dismount);

            _echoGroup
        }],
        {
            localNamespace getVariable ["KOR_bluforSteppingOff",false]
        },
        2
    ],
    [
        {
            params ["","","","_echoGroup"];
            private _groupOwner = groupOwner _echoGroup;
            [_echoGroup, "WHITE"] remoteExecCall ["setCombatMode",_groupOwner];
            [_echoGroup, "STEALTH"] remoteExecCall ["setBehaviourStrong",_groupOwner];

            _echoGroup
        },
        {
            params ["","","","_echoGroup"];

            (getPosASL (leader _echoGroup)) 
                vectorDistance 
            (getPosASL KOR_echoTeam_dismount) 
                <= DISMOUNT_RADIUS
        },
        5
    ],
    [
        {
            params ["","","","_echoGroup"];
            ["Echo team reached dismount"] call KISKA_fnc_log;

            private _leader = leader _echoGroup;
            private _boat = objectParent _leader;
            private _groupOwner = groupOwner _echoGroup;
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
            private _leader = leader _echoGroup;
            [_leader, getPosATL KOR_echoTeam_waitPoint_1] remoteExecCall ["move",_groupOwner];

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

[_timeline] call KISKA_fnc_startTimeline;

