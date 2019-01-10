/*
Author:
Nicholas Clark (SENSEI)

Description:
handles animal unit spawns

Arguments:
0: positions and animal classes <ARRAY>

Return:
none
__________________________________________________________________*/
#include "script_component.hpp"

{
    _x params ["_pos","_types"];

    _pos =+ _pos;
    _pos resize 2;

    if !(missionNamespace getVariable [CIV_LOCATION_ID(_pos),false]) then {
        private _players = [_pos,GVAR(spawnDist),CIV_ZDIST] call EFUNC(main,getNearPlayers);

        if !(_players isEqualTo []) then {
            [_pos,_types] call FUNC(spawnAnimal);
        };
    };
} forEach (_this select 0);
