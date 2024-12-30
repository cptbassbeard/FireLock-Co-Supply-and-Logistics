_handle = [] spawn {
	createVehicle
} 


#include "\a3\ui_f\hpp\defineDIKCodes.inc"

["telestration", "telestration", ["Draw", "drawing with telestration"], {
	systemchat "fired";
    _paint = "UserTexture1m_F" createVehicle (screenToWorld [getMousePosition select 0, getMousePosition select 1]);
	_paint setPosASL [getPosASL _paint select 0, getPosASL _paint select 1, (getPosASL player select 2) + 0.2];
	[_paint, -90, 0] call BIS_fnc_setPitchBank;
	_paint setObjectTextureGlobal [0, "#(rgb,8,8,3)color(1,0,0,1)"];
}, {
}, [DIK_U, [false, false, false]],true,0,true] call CBA_fnc_addKeybind;


_handle = 0 spawn {[true,false,[0,0,0],true] execVM "e.sqf";};

[[array], [_trainobj], { _input0 distance _x }, "ASCEND"] call BIS_fnc_sortBy;


	if (["track", ((getDescription _x) select 0)] call BIS_fnc_inString) then {
fnc_getNextTrack = {
	_trainobj = _this select 0;
	_obj = _this select 1;
	_num = _trainobj getRelDir _obj;
	if ((_num >= 0 && _num <= 15) ||(_num >= 345 && _num <= 360)) exitWith {
		systemchat "object is infront of the train!"
		};
	if (_num >= 165 && _num <= 195) exitWith {
		systemchat "object is behind the train!"
		};
};

params ["_trainObj","_nextIndex"];
_nextIndex = _this select 1;
_trainObj = _this select 0;
_alpha = 0;
_handler = [{
	params ["_args", "_handle"];
	_args params ["_trainObj", "_alpha","_nextIndex"];
    if (!isMultiplayer && isGamePaused) exitWith {};
	if (trainendtrigger) exitWith { _this select 1 call CBA_fnc_removePerFrameHandler };
	if (trainThrust == 0) exitWith {};
	_args set [1, linearConversion [0, 1, (_args select 1) + 0.01, 0, 1, true]];
	_trainObj setposASL (getPosASL _trainObj vectorAdd (((getPosASL _trainObj) vectorFromTo (spline select (_args select 2))) vectorMultiply trainThrust));
	_trainObj setdir ([getDir _trainObj, (_trainObj getDir (spline select (_args select 2))), (_args select 1)] call BIS_fnc_clerp);
	if (_trainObj distance (ASLtoAGL (spline select (_args select 2))) <= 2) then {
		_args set [2, (_args select 2) + 1];
		_args set [1, 0];
		[_trainObj,"CBB_trainMove"] remoteExec ["say3D",0,true];
	};
},
 0, 
[_trainObj,_alpha,_nextIndex]] 
call CBA_fnc_addPerFrameHandler;


//[_trainObj,_nextIndex] spawn CBB_fnc_trainmove;
/*
trainthrust = 0.01;
[trainphys,10] remoteExec ["CBB_fnc_trainmove", 2]; 
[trainphys_1,10] remoteExec ["CBB_fnc_trainmove", 2]; 
[trainphys_2,10] remoteExec ["CBB_fnc_trainmove", 2]; 
[trainphys_3,10] remoteExec ["CBB_fnc_trainmove", 2];
*/
