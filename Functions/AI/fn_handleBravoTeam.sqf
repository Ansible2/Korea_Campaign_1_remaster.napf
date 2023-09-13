#define RADIUS 20;

scriptName "KOR_fnc_handleBravoTeam";

if (!isServer) exitWith {
    ["Was not executed on the server!",true] call KISKA_fnc_log;
    _this remoteExec ["KOR_fnc_handleBravoTeam",2];
};

params [
    ["_bravoGroup",grpNull,[grpNull]]
];


private _timeline = [
    [
        [[_bravoGroup],{
            _thisArgs params ["_bravoGroup"];
            private _groupOwner = groupOwner _bravoGroup;
            [_bravoGroup, "WHITE"] remoteExecCall ["setCombatMode",_groupOwner];
            [_bravoGroup, "STEALTH"] remoteExecCall ["setBehaviourStrong",_groupOwner];

            _bravoGroup
        }],
        {
            params ["","","","_bravoGroup"];

            (getPosASL (leader _bravoGroup)) 
                vectorDistance 
            (getPosASL KOR_bravoBoatDismount) 
                <= RADIUS
        },
        5
    ],
    [
        {
            params ["","","","_bravoGroup"];
            ["Bravo team reached dismount"] call KISKA_fnc_log;

            private _leader = leader _bravoGroup;
            private _boat = objectParent _leader;
            private _groupOwner = groupOwner _bravoGroup;
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
            [_leader, getPosATL KOR_bravoWaitPoint_1] remoteExecCall ["move",_groupOwner];

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
                KOR_bravoAttackPoint_1
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
                KOR_bravoAttackPoint_2
            ] remoteExecCall ["KISKA_fnc_attack",_groupOwner];

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
                KOR_bravoAttackPoint_3
            ] remoteExecCall ["KISKA_fnc_attack",_groupOwner];

            _bravoGroup
        },
        {
            localNamespace getVariable ["KOR_cleared_outpostSoutheast",false]
        },
        5
    ]
];

[_timeline] call KISKA_fnc_startTimeline;

