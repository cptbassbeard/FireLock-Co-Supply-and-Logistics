params ["_trainobj"];
if (isNil "_trainObj") exitWith {systemchat "train object is not valid init"};
[{
	_this select 0 setvariable ["FLCSL_isTrain", true, true];
	_this select 0 setVariable ["FLCSL_trainThrust", 0, true];
	_velocity = _this select 0 getVariable "FLCSL_trainThrust";
	if (isNil "_velocity") exitwith {systemchat "thrust isnt set inside init"};
	_this select 0 setvariable ["FLCSL_carriages", _carriages, true];
	_this select 0 setvariable ["FLCSL_interval", 0, true];
	_this select 0 setvariable ["FLCSL_nextIndex", [_this select 0,false] call FLCSL_fnc_findNextTrack, true];
	_this select 0 setvariable ["FLCSL_lastIndex", [_this select 0,true] call FLCSL_fnc_findNextTrack, true];
	[_this select 0] call FLCSL_fnc_trainMove;
}, [_trainobj]] call CBA_fnc_execNextFrame;