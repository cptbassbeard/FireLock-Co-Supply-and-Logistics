params ["_trainObj","_trainCarriages"];
_trainObj = _this select 0;
_trainCarriages = _this select 1;

//setup for variables
_trainObj setVariable ["FLCSL_trainThrust", 0];

_tracks = lineIntersectsObjs [getPosASL _trainObj vectorAdd [0,0,5], getPosASL _trainObj vectorAdd [0,0,-8], _trainObj, objNull, true, 0];
_trainObj setVariable ["FLCSL_currentTrack", _tracks select 0];
_trainObj setVariable ["FLCSL_trainCarriages", _trainCarriages];
_trainObj setVariable ["FLCSL_startPos", getPosASL _trainObj];


_trainObj allowDamage false;
_trainObj enableSimulationGlobal true;

/* train fuckery fixery - hide the train and its carriages,
create invisible dummies to take their place and attach them to the train and carriages 
to prevent them from being deleted by the engine when they are hidden, 
while still allowing them to be detected by raycasts for track detection and keybinds. */

{
    _x allowDamage false;
    if ((allTurrets [_x, true]) isNotEqualTo []) then {
        _x hideObjectGlobal true;
        private _dummy = createVehicle [typeOf _x, getPosASL _x, [], 0, "NONE"];
        _dummy attachTo [_x, [0,0,0]];
        _dummy setVectorDir vectorDir _x;
        _dummy setVectorUp vectorUp _x;
        _dummy setVariable ["FLCSL_isTrainDummy", true, true];
        _dummy setVariable ["FLCSL_dummyParent", _x, true];
    };
} forEach _trainCarriages;

_trainObj hideObjectGlobal true;
_dummy = createVehicle [typeOf _trainObj, getPosASL _trainObj, [], 0, "NONE"];
_dummy allowDamage false;
_dummy setPosWorld getPosASL _trainObj;
_dummy setVectorDir vectorDir _trainObj;
_dummy setVectorUp vectorUp _trainObj;
_dummy setVariable ["FLCSL_isTrainDummy", true, true];
_dummy setVariable ["FLCSL_dummyParent", _trainObj, true];
_trainObj setVariable ["FLCSL_childDummy", _dummy, true];
systemchat format ["Train hidden and dummy created at position: %1", getPosASL _trainObj];

diag_log format ["Train initialized at position: %1 with %2 carriages", getPosASL _trainObj, count _trainCarriages];


{
    _x setVariable ["FLCSL_startPos", getPosASL _x];
    _tracks = lineIntersectsSurfaces [getPosASL _x vectorAdd [0,0,5], getPosASL _x vectorAdd [0,0,-8], _x, objNull, true, -1, "FIRE", "GEOM", true];
	_x Setvariable ["FLCSL_currentTrack", ((_tracks select 0) select 0)];
    systemchat format ["Carriage %1 starting position: %2", _x, getPosASL _x];
} forEach _trainCarriages;

systemChat format  ["Train initialized with carriages: %1",str (count _trainCarriages)];
systemChat format ["Train starting position: %1", getPosASL _trainObj];
[_trainObj,_trainCarriages,8] remoteExec ["FLCSL_fnc_trainmove",0,true];

diag_log format ["Train initialization complete. Train object: %1, Carriages: %2", _trainObj, count _trainCarriages];