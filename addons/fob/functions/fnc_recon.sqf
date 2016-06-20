/*
Author:
Nicholas Clark (SENSEI)

Description:
add recon UAV to FOB, must run local to unit assigned to curator logic

Arguments:
0: to add or remove recon <BOOL>
1: position to add recon <ARRAY>
2: side of recon UAV <SIDE>

Return:
none
__________________________________________________________________*/
#include "script_component.hpp"

private ["_type","_wp","_statement"];
params [
	["_ifRecon",true],
	["_position",[0,0,0]],
	["_side",EGVAR(main,playerSide)]
];

if (_ifRecon) then {
	_type = "";

	call {
		if (_side isEqualTo WEST) exitWith {
			_type = "B_UAV_02_F";
		};
		if (_side isEqualTo EAST) exitWith {
			_type = "O_UAV_02_F";
		};
		if (_side isEqualTo RESISTANCE) exitWith {
			_type = "I_UAV_02_F";
		};
	};

	GVAR(reconUAV) = createVehicle [_type, _position, [], 0, "FLY"];
    createVehicleCrew GVAR(reconUAV);
	GVAR(reconUAV) allowDamage false;
	GVAR(reconUAV) setCaptive true;
    {
        _x setCaptive true;
    } forEach crew GVAR(reconUAV);
	GVAR(reconUAV) setVehicleAmmo 0;
	GVAR(reconUAV) lockDriver true;
	GVAR(reconUAV) flyInHeight 150;

	_wp = group GVAR(reconUAV) addWaypoint [_position, 0];
	_wp setWaypointType "LOITER";
	_wp setWaypointLoiterType "CIRCLE_L";
	_wp setWaypointLoiterRadius GVAR(range);

	_statement = "
		player action ['SwitchToUAVGunner',%1];
	";
	GVAR(reconAction) = [QUOTE(DOUBLES(ADDON,recon)),"Switch to UAV Camera",format [_statement,QGVAR(reconUAV),_position],QUOTE(true),"",player,1,ACTIONPATH] call EFUNC(main,setAction);

	["HQ deployed.\nAerial reconnaissance online.",true] call EFUNC(main,displayText);
} else {
	deleteVehicle GVAR(reconUAV);
	[player, 1, GVAR(reconAction)] call EFUNC(main,removeAction);
	["HQ removed.\nAerial reconnaissance offline.",true] call EFUNC(main,displayText);
};
