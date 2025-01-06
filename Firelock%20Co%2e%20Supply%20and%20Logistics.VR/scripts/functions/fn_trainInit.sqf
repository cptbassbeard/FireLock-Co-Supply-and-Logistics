parmas ["_trainObj", ["_carriages"]];

if (isNull _trainObj) exitWith {false};
if (count _carriages == 0) then {systemchat "no carriages loaded"};
_trainObj call BIS_fnc_log;
_carriages call BIS_fnc_log;
_trainObj setVariable ["LTH_carriage", _carriages, true];
true