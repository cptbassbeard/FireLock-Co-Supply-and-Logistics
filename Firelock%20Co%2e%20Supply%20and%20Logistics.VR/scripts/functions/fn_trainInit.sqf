parmas ["_trainObj", ["_carriages"]];

if (isNull _trainObj) exitWith {false};
if (count _carriages == 0)
_trainObj call BIS_fnc_log;
_carriages call BIS_fnc_log;
_trainObj setVariable ["LTH_carriage", _carriages, true];
{
	[_x, true] remoteExec ["CBB_fnc_trainmove", 2]; 
} forEach _carriages;

true