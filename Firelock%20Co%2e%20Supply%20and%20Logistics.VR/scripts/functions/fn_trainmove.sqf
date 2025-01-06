params ["_trainObj"];

lastIndex = track_3;
nextIndex = [trainObj,lastIndex,false] call LTH_fnc_findNextTrack;
trainObj setVariable ["LTH_trainReversing", false, true];
nextIndexPos = [trainobj,nextIndex] call LTH_fnc_findpos;
lastIndexPos = [trainobj,lastIndex] call LTH_fnc_findpos;
_handler = [{
	params ["_args", "_handle"];
	_args params ["_trainObj","_nextIndex","_lastIndex"];
    if (!isMultiplayer && isGamePaused) exitWith {};
	//_trainThrust = trainObj getVariable "LTH_trainThrust";
	//interval = trainObj getVariable "LTH_interval";
	_reversing = trainObj getVariable "LTH_trainReversing";
	_projectedPos = trainObj getVariable "LTH_projectedPos";
	if (trainthrust == 0) exitWith {};
	trainthrust = trainthrust * 0.998; //drag value to return it to close 0
	interval =  interval + trainthrust;
	lastIndexPos call BIS_fnc_log;
	nextIndexPos call BIS_fnc_log;
	trainobj setdir ([getdir trainobj, (trainobj getdir nextIndexPos), interval] call BIS_fnc_clerp);
	pos = (interval bezierInterpolation [lastIndexPos,((lastIndexPos vectorAdd nextIndexPos) vectorMultiply 0.5) vectorAdd (vectorside trainObj),nextIndexPos]);
	pos call BIS_fnc_log;
	//_marker = createVehicle ["Sign_Arrow_Large_F", (interval bezierInterpolation [lastIndexPos,((lastIndexPos vectorAdd nextIndexPos) vectorMultiply 0.5) vectorAdd (vectorside trainObj),nextIndexPos]),[],0,"CAN_COLLIDE"]; //debug
		trainObj setVelocityTransformation [
			pos, // From point
			pos, // to point
			[0,0,0], // from vel
			[0,0,0],// to vel
			(vectorDir trainObj), //fromVectorDir
			(vectorDir trainObj), //toVectorDir 
			(vectorUp lastindex), //fromVectorUp
			(vectorUp nextIndex), //toVectorUp - this is the problem child
			interval]; //
			if (interval <= 0 && (_reversing) && (trainthrust <= 0)) then {interval = 1; 
			nextIndex = lastindex;
			lastindex = [trainObj,lastindex,false] call LTH_fnc_findNextTrack;
			nextIndexPos = [trainobj,nextIndex] call LTH_fnc_findpos;
			lastIndexPos = [trainobj,lastIndex] call LTH_fnc_findpos;
			};
			//add if reversing and interval is greater than 1 to run the forward motion code minus the interval setting. stops overshooting when reversing
			if (interval >= 1 && !(_reversing) && (trainthrust >= 0)) then {interval = 0; 
			lastindex = nextIndex;
			nextIndex = [trainObj,lastIndex,false] call LTH_fnc_findNextTrack;
			nextIndexPos = [trainobj,nextIndex] call LTH_fnc_findpos;
			lastIndexPos = [trainobj,lastIndex] call LTH_fnc_findpos;
			};
},
 0,
[trainObj,nextIndex,lastIndex]] 
call CBA_fnc_addPerFrameHandler;

//[trainObj,nextIndex] spawn LTH_fnc_trainmove;
/*

interval bezierInterpolation [lastIndexPos,((lastIndexPos vectorAdd nextIndexPos) / 2) vectorAdd ((getdir trainObj) vectorMultiply 25),nextIndexPos]
((lastIndexPos vectorAdd nextIndexPos) / 2) vectorAdd ((getdir trainObj) vectorMultiply interval)