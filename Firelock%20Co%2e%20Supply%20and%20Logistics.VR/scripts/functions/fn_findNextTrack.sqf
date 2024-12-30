params ["_trainobj","_currentIndex","_reversing"];
_pos = getPosASL trainobj;
_forward = vectorDir trainobj;
if (_reversing) then {_forward vectorMultiply -1;};
_projectedPos = ASLtoAGL (_pos vectorAdd (_forward vectorMultiply 25));
_trainobj setVariable ["LTH_projectedPos", _projectedPos, true];
_marker = createVehicle ["Sign_Arrow_Large_F", _projectedPos,[],0,"CAN_COLLIDE"]; //debug
_array = nearestObjects [_projectedPos, missionNamespace getVariable "FLCSL_Tracks" ,25];
_nextIndexCandidate = _array select 0;
if (_nextIndexCandidate == _currentIndex) then {_nextIndexCandidate = _array select 1;};
systemchat str _nextIndexCandidate;

_nextIndexCandidate