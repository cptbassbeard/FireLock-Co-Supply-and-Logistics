params ["_trainObj","_nextIndex","_lastIndex"];
systemchat "traindirection.sqf fired";
diag_log _trainObj;
if (isNil _trainObj getVariable "FLCSL_interval") exitWith {systemchat "interval not valid, exiting scope"};
if (isNil _trainObj getVariable "FLCSL_nextIndex") exitWith {systemchat "next index not valid, exiting scope"};
if (isNil _trainObj getVariable "FLCSL_lastIndex") exitWith {systemchat "last index not valid, exiting scope"};


_reversing = _trainobj getVariable "FLCSL_isReversing";
if (_reversing) then {
	[{	
		_trainObj setVariable ["FLCSL_nextIndex", _lastIndex, true];
		_trainobj setVariable ["FLCSL_interval", 1, true];
		_trainobj setVariable ["FLCSL_lastIndex", ([_trainobj,_reversing] call FLCSL_fnc_findNextTrack), true];
		if (isNil _trainObj) exitwith {systemchat format ["%1 trainObj is invalid, exiting scope",_trainObj]};
		_execute = true;
		[{_execute == true;}, {
			_trackSwitch = true;
	}, _trainObj, 0.1, {systemchat "waituntil clause timeout triggered";}] call CBA_fnc_waitUntilAndExecute;
	}, [_trainObj]] call CBA_fnc_execNextFrame;
} else (
		[{	
		_trainObj setVariable ["FLCSL_nextIndex", _lastIndex, true];
		_trainobj setVariable ["FLCSL_interval", 0, true];
		_trainobj setVariable ["FLCSL_lastIndex", ([_trainobj,_reversing] call FLCSL_fnc_findNextTrack), true];
		if (isNil _trainObj) exitwith {systemchat format ["%1 trainObj is invalid, exiting scope",_trainObj]};
		_execute = true;
		[{_execute == true;}, {
			_trackSwitch = true;
	}, _trainObj, 0.1, {systemchat "waituntil clause timeout triggered";}] call CBA_fnc_waitUntilAndExecute;
	}, [_trainObj]] call CBA_fnc_execNextFrame;
);


waitUntil { _trackSwitch; };
_trackSwitch