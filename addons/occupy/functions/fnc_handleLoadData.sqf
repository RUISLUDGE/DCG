/*
Author:
Nicholas Clark (SENSEI)

Description:
handle loading data

Arguments:
0: saved data <ARRAY>

Return:
nothing
__________________________________________________________________*/
#include "script_component.hpp"

params ["_data"];

if !(_data isEqualTo []) then {
	[_data select 0] call FUNC(findLocation);
} else {
	[] call FUNC(findLocation);
};

nil