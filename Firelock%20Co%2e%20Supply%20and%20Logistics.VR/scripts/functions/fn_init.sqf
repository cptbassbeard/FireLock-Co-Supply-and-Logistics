if !(isServer) exitWith {};
trainthrust = 0;
interval = 0;

/*
_newTrack = nearestTerrainObjects [trackStart, ["Railway"], worldSize * sqrt 2 / 2, true];
{
	_x setVariable ["CBB_obstructed", false];
	_surface = lineIntersectsSurfaces [getPosASL _x vectorAdd [0,0,5], getPosASL _x vectorAdd [0,0,-8], objNull, objNull, true, -1, "FIRE", "GEOM", true];
	_sufaceASL = ((_surface select 0) select 0);
	systemChat format ["%1",_sufaceASL];
	spline pushBackUnique _sufaceASL;
	//_marker = createVehicle ["Sign_Arrow_Large_F", ASLtoAGL _sufaceASL,[],0,"CAN_COLLIDE"];
} forEach _newTrack;
//spline deleteAt 39;