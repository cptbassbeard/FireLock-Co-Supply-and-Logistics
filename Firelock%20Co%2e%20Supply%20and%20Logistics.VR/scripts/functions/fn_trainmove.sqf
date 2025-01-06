params ["_trainObj"];
_lastIndex = _trainObj;
_nextIndex = [_trainObj,_lastIndex,false] call FLCSL_fnc_findNextTrack;
_trainObj setVariable ["FLCSL_trainReversing", false, true];
_handler = [{
	params ["_args", "_handle"];
	_args params ["_trainObj","__nextIndex","_lastIndex"];
	if (!isMultiplayer && isGamePaused) exitWith {};
	_trainThrust = _trainObj getVariable "FLCSL__trainThrust";
	_interval = _trainObj getVariable "FLCSL_interval";
	systemchat str _interval;
	_reversing = _trainObj getVariable "FLCSL_trainReversing";
	_projectedPos = _trainObj getVariable "FLCSL_projectedPos";
	if (_trainThrust == 0) exitWith {};
	_trainThrust = _trainThrust * 0.998; //drag value to return it to close 0
	//_interval = linearConversion [0,1,(_interval + _trainThrust),0,1, true];
	_interval = _interval + _trainThrust;
	_trainObj setVariable ["FLCSL_interval", _interval, true];
	_nextIndexPos = [_trainObj,_nextIndex] call FLCSL_fnc_findpos;
	_lastIndexPos = [_trainObj,_lastIndex] call FLCSL_fnc_findpos;
	_trainObj setdir ([getdir _trainObj, (_trainObj getdir _nextIndex), _interval] call BIS_fnc_clerp);
	systemchat str (_interval bezierInterpolation [_lastIndexPos,((_lastIndexPos vectorAdd _nextIndexPos) vectorMultiply 0.5) vectorAdd (vectorside _trainObj),_nextIndexPos]);
		_trainObj setVelocityTransformation [
			(_interval bezierInterpolation [_lastIndexPos,((_lastIndexPos vectorAdd _nextIndexPos) vectorMultiply 0.5) vectorAdd (vectorside _trainObj),_nextIndexPos]), // From point
			(_interval bezierInterpolation [_lastIndexPos,((_lastIndexPos vectorAdd _nextIndexPos) vectorMultiply 0.5) vectorAdd (vectorside _trainObj),_nextIndexPos]), // to point
			[0,0,0], // from vel
			[0,0,0],// to vel
			(vectorDir _trainObj), //fromVectorDir
			(vectorDir _trainObj), //toVectorDir 
			(vectorUp _lastIndex), //fromVectorUp
			(vectorUp _nextIndex), //toVectorUp - this is the problem child
			_interval
			]; //
		if (_interval <= 0 && (_reversing) && (_trainThrust <= 0)) then {_interval = 1; 
		_nextIndex = _lastIndex;
		_lastIndex = [_trainObj,_lastIndex,false] call FLCSL_fnc_findNextTrack;
		_nextIndexPos = [_trainObj,_nextIndex] call FLCSL_fnc_findpos;
		_lastIndexPos = [_trainObj,_lastIndex] call FLCSL_fnc_findpos;
		};
		//add if reversing and _interval is greater than 1 to run the forward motion code minus the _interval setting. stops overshooting when reversing
		if (_interval >= 1 && !(_reversing) && (_trainThrust >= 0)) then {_interval = 0; 
		lastindex = _nextIndex;
		_nextIndex = [_trainObj,_lastIndex,false] call FLCSL_fnc_findNextTrack;
		_nextIndexPos = [_trainObj,_nextIndex] call FLCSL_fnc_findpos;
		_lastIndexPos = [_trainObj,_lastIndex] call FLCSL_fnc_findpos;
		};
		if !(alive _trainObj) exitWith {_this select 1 call CBA_fnc_removePerFrameHandler };
},
 0,
[_trainObj,_nextIndex,_lastIndex]] 
call CBA_fnc_addPerFrameHandler;
true

//[_trainObj,_nextIndex] spawn FLCSL_fnc_trainmove;
/*