params ["_trainobj"];
if (isNil "_trainObj") exitWith {systemchat "train object is not valid"};


FLCSL_fnc_mainHandler = {
	params ["_trainobj"];
	_trainObj setVariable ["FLCSL_lastIndexPos",([_trainObj] call FLCSL_startPosition), true];
	_nextindex = _trainObj getVariable "FLCSL_nextIndex";
	_nextIndexPos = _trainobj setVariable ["FLCSL_nextIndexPos",]
	_handler = [{
		params ["_args", "_handle"];
		_args params ["_trainObj"];
		_velocity = _trainobj getVariable "FLCSL_trainThrust";
		_interval = _trainobj getVariable "FLCSL_interval";
		_lastindex = _trainObj getVariable "FLCSL_lastIndex";
		_nextindex = _trainObj getVariable "FLCSL_nextIndex";
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
			(_interval bezierInterpolation [_lastIndexPos,((_lastIndexPos vectorAdd _nextIndexPos) vectorMultiply 0.5) vectorAdd (vectorside _trainObj),_nextIndexPos]), //_currentpos
			(_interval bezierInterpolation [_lastIndexPos,((_lastIndexPos vectorAdd _nextIndexPos) vectorMultiply 0.5) vectorAdd (vectorside _trainObj),_nextIndexPos]), //_nextpos
			[0,0,0], //_currentvelocity
			[0,0,0], //_next velocity
			[0,0,0], //_currentvectorDir
			[0,0,0], //_nextvectorDir
			[0,0,0], //_currentvectorUp
			[0,0,0], //_nextVectorUp
			_interval //_interval
		];
	if (interval >= 1 && !(_reversing) && (trainthrust >= 0)) then { //forward
		_reversing = _trainObj getvariable "FLCSL_trainReversing";
		[_trainObj, _reversing] call FLCSL_trainDirection;
	};
	if (interval <= 0 && (_reversing) && (trainthrust <= 0)) then { //backward
		_reversing = _trainObj getvariable "FLCSL_trainReversing";
		[_trainObj, _reversing] call FLCSL_trainDirection;
	};
	},
	0,
	[_trainObj]] 
call CBA_fnc_addPerFrameHandler;
};
[_trainObj] call FLCSL_fnc_mainHandler;