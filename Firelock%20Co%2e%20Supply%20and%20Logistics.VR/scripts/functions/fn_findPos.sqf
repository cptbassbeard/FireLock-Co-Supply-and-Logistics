params ["_trainobj","_nextIndex","_reversing"];
_surface = lineIntersectsSurfaces [getPosASL _nextIndex vectorAdd [0,0,5], getPosASL _nextIndex vectorAdd [0,0,-8], _trainobj, objNull, true, -1, "FIRE", "GEOM", true];
_sufaceASL = ((_surface select 0) select 0);
_sufaceASL