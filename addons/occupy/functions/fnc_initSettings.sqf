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
    QGVAR(multiplier),
    "SLIDER",
    ["Enemy Count Multiplier",""],
    COMPONENT_NAME,
    [
        0.5,
        2,
        1,
        0
    ],
    false,
    {}
] call CBA_Settings_fnc_init;

[
    QGVAR(sniper),
    "CHECKBOX",
    ["Spawn Snipers","Spawn sniper units near occupied locations."],
    COMPONENT_NAME,
    true,
    false,
    {}
] call CBA_Settings_fnc_init;

[
    QGVAR(static),
    "CHECKBOX",
    ["Spawn Static Emplacements","Spawn static emplacements in occupied locations."],
    COMPONENT_NAME,
    true,
    false,
    {}
] call CBA_Settings_fnc_init;
