params ["_trainObj"];
if (isNil "_trainObj") exitWith {systemchat "train is null inside startposition"};
_posToCheck = getPosASL _trainObj;
_surfaces = lineIntersectsSurfaces [_posToCheck vectoradd [0,0,8], _posToCheck vectoradd [0,0,-8], _trainObj, objNull, true, -1, "GEOM", "PHYSX", true];
if (isNil "_surfaces") exitWith {getPosASL _trainObj};
_startposition = [_surfaces] call FLCSL_trackCheck;
_startposition