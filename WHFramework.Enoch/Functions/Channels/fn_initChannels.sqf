/*
Function: WHF_fnc_initChannels

Description:
    Initializes custom channels.
    Function must be executed on server.

Examples:
    (begin example)
        call WHF_fnc_initChannels;
    (end)

Author:
    thegamecracks

*/
if (!isServer) exitWith {};

WHF_channelID_aircraft = radioChannelCreate [
    [1, 0.4, 1, 1],
    "Aircraft channel", // TODO: localize
    "%UNIT_VEH_NAME (%UNIT_NAME)",
    []
];
publicVariable "WHF_channelID_aircraft";
