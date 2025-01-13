params ["_trainobj","_reversing"];
_currentIndex = _trainobj getVariable "FLCSL_lastIndex";
_pos = getPosASL _trainobj;
_forward = vectorDir _trainobj;
if (_reversing) then {_forward vectorMultiply -1;};
_projectedPos = ASLtoAGL (_pos vectorAdd (_forward vectorMultiply 25));
_trainobj setVariable ["LTH_projectedPos", _projectedPos, true];
_marker = createVehicle ["Sign_Arrow_Large_F", _projectedPos,[],0,"CAN_COLLIDE"]; //debug
_array = nearestObjects [_projectedPos,FLCSL_configTracks ,15, false];
if (count _array == 0) then {_array = nearestTerrainObjects [_projectedPos,["Railway"] ,30,true,false];};
_nextIndexCandidate = _array select 0;
if ((isNil "_currentIndex") && (_nextIndexCandidate == _currentIndex)) then {_nextIndexCandidate = _array select 1;};
systemchat str _nextIndexCandidate;
_nextIndexCandidate