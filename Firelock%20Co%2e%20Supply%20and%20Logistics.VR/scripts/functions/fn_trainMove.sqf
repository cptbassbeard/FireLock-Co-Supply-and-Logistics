params ["_trainobj"];
if (isNil "_trainObj") exitWith {systemchat "train object is not valid"};
_handler = [{
	params ["_args", "_handle"];
	_args params ["_trainObj"];
	_velocity = _trainobj getVariable "FLCSL_trainThrust";
	_interval = _trainobj getVariable "FLCSL_interval";
	_lastIndexPos = _trainObj getVariable "FLCSL_lastIndex";
	_nextIndexPos = _trainObj getVariable "FLCSL_nextIndex";
    if (!isMultiplayer && isGamePaused) exitWith {};
	if (isNil "_trainObj") exitWith {systemchat "train object is not valid"};
	if (isNil "_velocity") exitwith {systemchat "thrust isnt set"};
	if (isNil "_interval") exitwith {systemchat "interval isnt set"};
	if (isNil "_lastIndexPos") exitwith {systemchat "last index pos isnt set"};
	if (isNil "_nextIndexPos") exitwith {systemchat "next index pos isnt set"};
	if (_velocity == 0) exitwith {};
	_velocity = _velocity * 0.998; //drag value to return it to close 0
	_interval =  _interval + _velocity;
	diag_log _trainobj;
	diag_log _interval;
	_trainObj setVelocityTransformation
	[
	_lastIndexPos, //_currentpos
	_nextIndexPos, //_nextpos
	[0,0,0], //_currentvelocity
	[0,0,0], //_next velocity
	[0,0,0], //_currentvectorDir
	[0,0,0], //_nextvectorDir
	[0,0,0], //_currentvectorUp
	[0,0,0], //_nextVectorUp
	_interval //_interval
	];
},
 0,
[_trainObj]] 
call CBA_fnc_addPerFrameHandler;