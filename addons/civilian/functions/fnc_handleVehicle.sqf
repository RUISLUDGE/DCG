/*
Author:
Nicholas Clark (SENSEI)

Description:
handles civilian vehicle spawns

Arguments:

Return:
none
__________________________________________________________________*/
#include "script_component.hpp"
#define ITERATIONS 300
#define BUFFER 100
#define RANGE 1000

private ["_players","_player","_roads","_roadStart","_roadEnd","_roadMid","_road","_roadConnect"];

if (count GVAR(drivers) <= ceil GVAR(vehMaxCount)) then {
	_players = call CBA_fnc_players;

	if !(_players isEqualTo []) then {
		_player = selectRandom _players;

		if ((getPos _player) select 2 > 5) exitWith {};

		_roads = _player nearRoads 200;

		// get start and end point for vehicle that passes by target player
		if !(_roads isEqualTo []) then {
			_roadStart = objNull;
			_roadEnd = objNull;

			// get midpoint road
			_roadMid = _roads select 0;
			_road = _roadMid;

			// get roads in start direction
			for "_i" from 1 to ITERATIONS do {
				_roadConnect = roadsConnectedTo _road;

				// if next road doesn't exist, exit with last road
				if (isNil {_roadConnect select 0}) exitWith {
					_roadStart = _road;
				};

				_road = _roadConnect select 0;

				// if loop is done or road is far enough
				if (!(CHECK_VECTORDIST(getPosASL _road,getPosASL _roadMid,RANGE)) || {_i isEqualTo ITERATIONS}) exitWith {
					_roadStart = _road;
				};
			};

			_road = _roadMid;

			// get roads in end direction
			for "_i" from 1 to ITERATIONS do {
				_roadConnect = roadsConnectedTo _road;

				// if next road doesn't exist, exit with last road
				// also check if array is empty, 'select' will throw error when checking for an element more than one index out of range
				if (_roadConnect isEqualTo [] || {isNil {_roadConnect select 1}}) exitWith {
					_roadEnd = _road;
				};

				_road = _roadConnect select 1;

				// if loop is done or road is far enough
				if (!(CHECK_VECTORDIST(getPosASL _road,getPosASL _roadMid,RANGE)) || {_i isEqualTo ITERATIONS}) exitWith {
					_roadEnd = _road;
				};
			};

			if (!(_roadStart isEqualTo _roadEnd) &&
				{!(CHECK_VECTORDIST(getPosASL _roadStart,getPosASL _roadEnd,RANGE))} &&
			    {!([getPosASL _roadStart,eyePos _player] call EFUNC(main,inLOS))} &&
			    {([getPos _roadStart,BUFFER] call EFUNC(main,getNearPlayers)) isEqualTo []} &&
			    {([getPos _roadEnd,BUFFER] call EFUNC(main,getNearPlayers)) isEqualTo []} &&
				{!([_roadStart,_roadEnd] call EFUNC(safezone,inAreaAll))}) then {
					[getPos _roadStart,getPos _roadMid,getPos _roadEnd,_player] call FUNC(spawnVehicle);
			};
		};
	};
}; 