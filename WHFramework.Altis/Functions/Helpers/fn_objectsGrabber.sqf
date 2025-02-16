/*
    File: objectGrabber.sqf
    Author: Joris-Jan van 't Land, thegamecracks

    Description:
    Converts a set of placed objects to an object array for the DynO mapper.
    Places this information in the debug output for processing.

    To use this, create a composition in the editor, place your player beside
    it, then run the function using the editor's debug console.

    Parameter(s):
    _this select 0: position of the anchor point (Array)
    _this select 1: size of the covered area (Scalar)
    _this select 2: grab object orientation? (Boolean) [default: false]

    Example:
    [AGLToASL getPosATL player,10] call WHF_fnc_objectsGrabber;

    Returns:
    Output text (String)
*/

private ["_anchorPos", "_anchorDim", "_grabOrientation"];
_anchorPos = _this param [0, [0, 0], [[]]];
_anchorDim = _this param [1, 50, [-1]];
_grabOrientation = _this param [2, false, [false]];

private ["_objs"];
_objs = nearestObjects [_anchorPos, ["All"], _anchorDim];

//Formatting for output
private ["_br", "_tab", "_outputText"];
_br = toString [13, 10];
_tab = toString [9];

//Adding meta-data
_outputText = "/*" + _br + "Grab data:" + _br;
_outputText = _outputText + "Mission: " + (if (missionName == "") then {"Unnamed"} else {missionName}) + _br;
_outputText = _outputText + "World: " + worldName + _br;
_outputText = _outputText + "Anchor position: [" + (str (_anchorPos select 0)) + ", " + (str (_anchorPos select 1)) + "]" + _br;
_outputText = _outputText + "Area size: " + (str _anchorDim) + _br;
_outputText = _outputText + "Using orientation of objects: " + (if (_grabOrientation) then {"yes"} else {"no"}) + _br + "*/" + _br + _br;
_outputText = _outputText + "[" + _br;

//First filter illegal objects
{
    //Exclude non-dynamic objects (world objects)
    private ["_allDynamic"];
    _allDynamic = allMissionObjects "All";

    if (_x in _allDynamic) then
    {
        //Exclude characters
        private ["_sim"];
        _sim = getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "simulation");

        if (_sim in ["soldier"]) then
        {
            _objs set [_forEachIndex, -1];
        };
    }
    else
    {
        _objs set [_forEachIndex, -1];
    };
} forEach _objs;

_objs = _objs - [-1];

//Process remaining objects
{
    private ["_type", "_objPos", "_dX", "_dY", "_dZ", "_azimuth", "_fuel", "_damage", "_orientation", "_varName", "_init", "_simulation", "_replaceBy", "_outputArray"];
    _type = typeOf _x;
    _objPos = getPosASL _x;
    _objPos vectorDiff _anchorPos params ["_dX", "_dY", "_dZ"];
    _azimuth = direction _x;
    _fuel = fuel _x;
    _damage = damage _x;
    if (_grabOrientation) then {_orientation = _x call BIS_fnc_getPitchBank;} else {_orientation = [];};
    _varName = vehicleVarName _x;
    _init = _x getVariable ["init", ""];

    _replaceBy = _x getVariable ["replaceBy", ""];
    if (_replaceBy != "") then {_type = _replaceBy;};

    _outputArray = [_type, [_dX, _dY, _dZ], _azimuth, _fuel, _damage, _orientation, _varName, _init, true, _dZ > 0.5];
    _outputText = _outputText + _tab + (str _outputArray);
    _outputText = if (_forEachIndex < ((count _objs) - 1)) then {_outputText + ", " + _br} else {_outputText + _br};

    debugLog (format ["Log: objectGrabber: %1", _outputArray]);
} forEach _objs;

_outputText = _outputText + "]";
copyToClipboard _outputText;

_outputText
