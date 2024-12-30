params ["_trainObj"];
lastIndex = track_0;
nextIndex = [trainObj,lastIndex,false] call LTH_fnc_findNextTrack;
trainObj setVariable ["LTH_trainReversing", false, true];
_prevVectorDir = vectorDir trainobj;



_handler = [{
	params ["_args", "_handle"];
	_args params ["_trainObj","_nextIndex","_lastIndex"];
    if (!isMultiplayer && isGamePaused) exitWith {};
	//_trainThrust = trainObj getVariable "LTH_trainThrust";
	//interval = trainObj getVariable "LTH_interval";
	_reversing = trainObj getVariable "LTH_trainReversing";
	if (trainthrust == 0) exitWith {};
	interval =  interval + trainthrust;
	_nextIndexPos = [trainobj,nextIndex,_reversing] call LTH_fnc_findpos;
	_lastIndexPos = [trainobj,lastIndex,_reversing] call LTH_fnc_findpos;
	trainobj setdir ([getdir trainobj, (trainobj getdir nextIndex), interval] call BIS_fnc_clerp);
		trainObj setVelocityTransformation [
			_lastIndexPos, // From point
			_nextIndexPos, // to point
			[0,0,0], // from vel
			[0,0,0],// to vel
			(vectorDir trainObj), //fromVectorDir
			(vectorDir trainObj), //toVectorDir
			(vectorUp trainObj), //fromVectorUp
			(vectorUp trainObj), //toVectorUp - this is the problem child
			interval]; //
		systemChat str interval;
			if (interval <= 0 && (_reversing) && (trainthrust <= 0)) then {interval = 1; 
			nextIndex = lastindex;
			lastindex = [trainObj,lastindex,false] call LTH_fnc_findNextTrack;
			};
			if (interval >= 1 && !(_reversing) && (trainthrust >= 0)) then {interval = 0; 
			lastindex = nextIndex;
			nextIndex = [trainObj,lastIndex,false] call LTH_fnc_findNextTrack;
			};
},
 0,
[trainObj,nextIndex,lastIndex]] 
call CBA_fnc_addPerFrameHandler;


//[trainObj,nextIndex] spawn LTH_fnc_trainmove;
