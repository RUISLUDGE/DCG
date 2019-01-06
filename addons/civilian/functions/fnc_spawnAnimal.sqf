/*
Author:
Nicholas Clark (SENSEI)

Description:
spawns animals

Arguments:
0: position to spawn <ARRAY>
1: types to spawn <ARRAY>

Return:
none
__________________________________________________________________*/
#include "script_component.hpp"

params ["_pos","_types"];

private _agentList = [];

missionNamespace setVariable [CIV_LOCATION_ID(_pos),true];

for "_i" from 1 to 10 do {
    private _agent = createAgent [selectRandom _types, _pos, [], 150, "NONE"];
    _agentList pushBack _agent;
};

[{
    params ["_args","_idPFH"];
    _args params ["_pos","_agentList"];

    if (([_pos,GVAR(spawnDist),CIV_ZDIST] call EFUNC(main,getNearPlayers)) isEqualTo []) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _agentList call EFUNC(main,cleanup);
        missionNamespace setVariable [CIV_LOCATION_ID(_pos),false];
    };
}, CIV_HANDLER_DELAY, [_pos,_agentList]] call CBA_fnc_addPerFrameHandler;
