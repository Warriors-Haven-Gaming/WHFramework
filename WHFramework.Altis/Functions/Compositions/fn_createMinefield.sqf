/*
Function: WHF_fnc_createMinefield

Description:
    Create a minefield in the given area.

Parameters:
    Side side:
        The side to reveal the mines to.
    Number quantity:
        The number of mines to spawn.
    Position2D center:
        The center of the area.
    Number radius:
        The radius of the area.
    String type:
        The type of minefield. Must be one of:
            "AP"
            "AT"
            "ATAP"
    Boolean signs:
        (Optional, default false)
        If true, warning signs are created around the mine field.

Returns:
    Array
        An array of mines and props that were created.

Author:
    thegamecracks

*/
params ["_side", "_quantity", "_center", "_radius", "_type", ["_signs", false]];

private _apMines = [
    "APERSBoundingMine",
    "APERSMine",
    "APERSMineDispenser_Mine_F",
    "APERSTripMine"
];
private _atMines = ["ATMine"];

private _objects = [];
for "_i" from 1 to _quantity do {
    private _pos = [_center, _radius] call WHF_fnc_randomPos;
    if (_pos isEqualTo [0,0]) then {continue};

    if (_type in ["AT", "ATAP"]) then {
        private _roads = _pos nearRoads 20 apply {getRoadInfo _x} select {
            _x params ["", "", "_isPedestrian"];
            !_isPedestrian
        };
        if (count _roads < 1) exitWith {};
        selectRandom _roads params ["", "_width", "", "", "", "", "_begPos", "_endPos"];

        private _line = _endPos vectorDiff _begPos;
        private _posASL = vectorLinearConversion [0, 1, random 1, _begPos, _endPos];
        private _normal = vectorNormalized _line vectorCrossProduct [0, 0, 1];
        private _distance = _width * (-1 + random 2);
        _posASL = _posASL vectorAdd (_normal vectorMultiply _distance);
        _pos = ASLToATL _posASL;
    };

    private _mines = switch (_type) do {
        case "AP": {
            private _ap = createMine [selectRandom _apMines, _pos, [], 0];
            [_ap]
        };
        case "AT": {
            private _at = createMine [selectRandom _atMines, _pos, [], 0];
            [_at]
        };
        case "ATAP": {
            if (random 1 < 0.5) then {
                private _at = createMine [selectRandom _atMines, _pos, [], 0.2];
                private _ap = createMine [selectRandom _apMines, _pos, [], 0.2];
                [_at, _ap]
            } else {
                private _at = createMine [selectRandom _atMines, _pos, [], 0];
                [_at]
            }
        };
        default {[]};
    };

    {_x setDir random 360; _side revealMine _x} forEach _mines;
    _objects append _mines;
};

if (_signs) then {
    private _signs = [];
    private _spacing = 20 + random 15;
    private _step = 360 / ceil (2 * pi * _radius / _spacing);
    for "_i" from 0 to 359 step _step do {
        private _pos = _center getPos [_radius, _i + random _step - _step / 2];
        private _sign = createSimpleObject [
            selectRandom ["Land_Sign_Mines_F", "Land_Sign_MinesTall_F"],
            ATLToASL _pos
        ];
        _sign setDir (_pos getDir _center);
        _sign setVectorUp surfaceNormal _pos;
    };
    _objects append _signs;
};

_objects
