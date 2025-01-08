params ["_arrayOfObjects"];
{
	{
		systemchat str _x;
		_objectname = _x select 2;
		if (_objectname in FLCSL_configTracks) exitWith {_trackPosition = _x select 0;};
	} forEach _x;
} forEach _arrayOfObjects;
_time = time;
waitUntil {not isNil "_track" || time - _time > 0.5 };
_trackPosition