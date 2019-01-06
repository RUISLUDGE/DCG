/*
Author:
Nicholas Clark (SENSEI)

Description:
get approval value for region

Arguments:
0: center position <ARRAY>

Return:
number
__________________________________________________________________*/
#include "script_component.hpp"

params [
    ["_position",[],[[]]]
];

private _region = [_position] call FUNC(getRegion);
private _ret = _region getVariable QGVAR(regionValue);

ISNILS(_ret,AP_DEFAULT);

_ret = (_ret min AP_MAX) max AP_MIN;

_ret
