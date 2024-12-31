
trainthrust = 0;
interval = 0;
FLCSL_configTracks = [
"Land_Track_01_10m_F", //start of base game tracks
"Land_Track_01_20m_F",
"Land_Track_01_3m_F",
"Land_Track_01_15deg_F",
"Land_Track_01_30deg_F",
"Land_Track_01_7deg_F",
"Land_Track_01_bumper_F",
"Land_Track_01_bridge_F",
"Land_Track_01_crossing_F",
"Land_Track_01_turnout_left_F",
"Land_Track_01_turnout_right_F", // end of base game tracks
"ATS_Tracks_Base" //ATS tracks
];
FLCSL_configTracks append (parseSimpleArray FLC_CBA_tracks);
missionNamespace setVariable ["FLCSL_Tracks", FLCSL_configTracks, true];

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