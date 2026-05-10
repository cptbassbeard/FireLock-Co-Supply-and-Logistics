params ["_train","_mode","_value"];

TAG_fnc_showThrust = {
    params ["_thrust"];
    hintSilent format ["Thrust: %1", _thrust];
};

private _thrust = _train getVariable ["FLCSL_trainThrust",0];

switch (_mode) do {

	case "forward": {

		private _top = FLCSL_CBA_TopSpeed;

		private _startFactor = 0.2 + (abs _thrust / _top) * 0.8;
		private _accel = _value * _startFactor;
		
		_thrust = _thrust + _accel;
		_thrust = _thrust min _top;

		diag_log format ["Thrust after forward calculation: %1", _thrust];

		_train setVariable ["FLCSL_trainThrust",_thrust,true];
		_train setVariable ["FLCSL_trainReversing",false,true];

		private _driver = driver _train;
		[_thrust] remoteExec ["TAG_fnc_showThrust", owner _driver];
	};

	case "reverse": {

		private _top = FLCSL_CBA_TopSpeed;

		private _startFactor = 0.2 + (abs _thrust / _top) * 0.8;
		private _accel = _value * _startFactor;

		_thrust = _thrust - _accel;
		_thrust = _thrust max -_top;

		_train setVariable ["FLCSL_trainThrust",_thrust,true];

		diag_log format ["Thrust after reverse calculation: %1", _thrust];

		private _driver = driver _train;
		if (!isNull _driver) then {
			[_thrust] remoteExec ["TAG_fnc_showThrust", owner _driver];
		};

		if (_thrust <= 0) then {
			_train setVariable ["FLCSL_trainReversing",true,true];
		};
	};

	case "brake": {

		private _brakeBase = 0.2;
		private _brakeScale = abs _thrust * 0.05;

		private _brake = _brakeBase + _brakeScale;

		diag_log format ["Brake value: %1 (Base: %2, Scale: %3)", _brake, _brakeBase, _brakeScale];

		if (_thrust > 0) then {
			_thrust = _thrust - _brake;
			if (_thrust < 0) then {_thrust = 0};
		} else {
			_thrust = _thrust + _brake;
			if (_thrust > 0) then {_thrust = 0};
		};

		[_thrust] remoteExec ["TAG_fnc_showThrust", driver _train];
		_train setVariable ["FLCSL_trainThrust",_thrust,true];
	};
};