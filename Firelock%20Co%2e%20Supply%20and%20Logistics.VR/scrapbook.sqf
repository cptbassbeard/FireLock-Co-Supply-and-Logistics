_handler = [{
	params ["_args", "_handle"];
	_args params ["_trainObj"];
	_interval = _trainobj getVariable "FLCSL_interval";
	if (isNil "_interval") exitwith {systemchat "interval isnt set"};
	systemchat str _interval;
},
 0,
[_trainObj]] 
call CBA_fnc_addPerFrameHandler;