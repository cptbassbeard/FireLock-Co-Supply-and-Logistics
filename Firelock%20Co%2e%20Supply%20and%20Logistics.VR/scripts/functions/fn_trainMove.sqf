params ["_trainobj"];
if (isNil "_trainObj") exitWith {systemchat "train object is not valid"};
FLCSL_fnc_mainHandler = {
	params ["_trainobj"];
	_trainObj setVariable ["FLCSL_lastIndexPos",([_trainObj,objnull,true] call FLCSL_trackPosition), true];
	_nextindex = _trainObj getVariable "FLCSL_nextIndex";
	_nextIndexPos = _trainobj setVariable ["FLCSL_nextIndexPos",[_trainObj,_nextIndex,false] call FLCSL_trackPosition,true];
	_handler = [{
		params ["_args", "_handle"];
		_args params ["_trainObj"];
		_velocity = _trainobj getVariable "FLCSL_trainThrust";
		systemChat str _velocity;
		if (_velocity == 0) exitwith {};
		if (!isMultiplayer && isGamePaused) exitWith {};
		_interval = _trainobj getVariable "FLCSL_interval";
		_lastindex = _trainObj getVariable "FLCSL_lastIndex";
		_nextindex = _trainObj getVariable "FLCSL_nextIndex";
		_nextIndexPos = _trainObj getVariable "FLCSL_nextIndexPos";
		_lastIndexPos = _trainObj getVariable "FLCSL_lastIndexPos";
		if (isNil "_trainObj") exitWith {systemchat "train object is not valid"};
		if (isNil "_velocity") exitwith {systemchat "thrust isnt set"};
		if (isNil "_interval") exitwith {systemchat "interval isnt set"};
		if (isNil "_lastIndexPos") exitwith {systemchat "last index pos isnt set"};
		if (isNil "_nextIndexPos") exitwith {systemchat "next index pos isnt set"};
		if (isNil "_lastindex") exitwith {systemchat "next index isnt set"};
		if (isNil "_nextindex") exitwith {systemchat "next index isnt set"};
		if (_velocity == 0) exitwith {};
		[_trainObj] call FLCSL_isDerailed;
		if (FLCSL_CBA_dragEnabled) then {_velocity = _velocity * FLCSL_CBA_Drag}; //drag value to return it to close 0
		_interval =  _interval + _velocity;
		_trainObj setvariable ["FLCSL_interval", _interval, true];
		_trainObj setVelocityTransformation
		[
			(_interval bezierInterpolation [_lastIndexPos,((_lastIndexPos vectorAdd _nextIndexPos) vectorMultiply 0.5) vectorAdd (vectorside [_trainObj,_left call FLCSL_vectorSideCalc]),_nextIndexPos]), //_currentpos
			(_interval bezierInterpolation [_lastIndexPos,((_lastIndexPos vectorAdd _nextIndexPos) vectorMultiply 0.5) vectorAdd (vectorside [_trainObj,_left call FLCSL_vectorSideCalc]),_nextIndexPos]), //_nextpos
			[0,0,0], //_currentvelocity
			[0,0,0], //_next velocity
			vectorDir _trainobj getVariable "FLCSL_lastIndex", //_currentvectorDir
			vectorDir _trainobj getVariable "FLCSL_nextIndex", //_nextvectorDir
			vectorup _trainobj getVariable "FLCSL_lastIndex", //_currentvectorUp
			vectorup _trainobj getVariable "FLCSL_nextIndex", //_nextVectorUp
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
[{
	_trainObj setVariable ["FLCSL_trainHandler", _handle, true];
}, [_trainobj]] call CBA_fnc_execNextFrame;
};
[_trainObj] call FLCSL_fnc_mainHandler;