params ["_trainObj"];
//if !(isServer) exitWith {false};
if (isNull _trainObj) exitWith {false};
_carriages = [objNull];
if (count _carriages == 0) then {systemchat "no carriages loaded";};
_trainObj call BIS_fnc_log;
_carriages call BIS_fnc_log;
_trainObj setVariable ["FLCSL_carriage", _carriages, true];
_trainObj setVariable ["FLCSL_carriage", _carriages, true];
_trainObj setVariable ["FLCSL_trainActive", true, true];
_trainObj setVariable ["FLCSL_interval", 0, true];
_trainObj setVariable ["FLCSL_thrust", 0, true];
_trainObj setVariable ["FLCSL_trainReversing", false, true];
_trainObj setVariable ["FLCSL_projectedPos", [0,0,0], true];
_trainObj setVariable ["FLCSL_lastIndexPos", [0,0,0], true];
_trainObj setVariable ["FLCSL_nextIndexPos", [0,0,0], true];
private _trainmove = [_trainObj] remoteExecCall ["FLCSL_fnc_trainmove", 0];
_trainmove