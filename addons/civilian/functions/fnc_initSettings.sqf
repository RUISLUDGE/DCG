/*
Author:
Nicholas Clark (SENSEI)

Description:
initialize settings via CBA framework

Arguments:

Return:
bool
__________________________________________________________________*/
#include "script_component.hpp"

[
    QGVAR(enable), // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    format ["Enable %1", COMPONENT_NAME], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    COMPONENT_NAME, // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting
    true, // "global" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    QGVAR(spawnDist),
    "SLIDER",
    ["Spawn Distance","Civilian entities will spawn when a player is within this distance of a location."],
    COMPONENT_NAME,
    [
        1,
        1000,
        300,
        0
    ],
    true,
    {}
] call CBA_Settings_fnc_init;

[
    QGVAR(unitLimit),
    "SLIDER",
    ["Unit Limit","Limits the number of civilian units per location."],
    COMPONENT_NAME,
    [
        0,
        40,
        30,
        0
    ],
    true,
    {}
] call CBA_Settings_fnc_init;

[
    QGVAR(vehLimit),
    "SLIDER",
    ["Vehicle Limit","Limits the number of spawned civilian vehicles."],
    COMPONENT_NAME,
    [
        0,
        10,
        5,
        0
    ],
    true,
    {}
] call CBA_Settings_fnc_init;

[
    QGVAR(vehCooldown),
    "SLIDER",
    ["Vehicle Cooldown","Time in seconds between potential vehicle spawns."],
    COMPONENT_NAME,
    [
        60,
        3600,
        300,
        0
    ],
    true,
    {}
] call CBA_Settings_fnc_init;
