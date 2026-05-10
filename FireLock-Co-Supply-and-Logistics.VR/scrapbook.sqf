["test", "FLCSL_Reverse_Train", ["Backward", "Reverse the train you are in"], {

	private _unit = call CBA_fnc_currentUnit;
	private _veh = vehicle _unit;
	[train_0,"reverse",FLCSL_CBA_Reverse] remoteExec ["FLCSL_fnc_serverTrainControl",2];

}, {}, [DIK_S,[false,false,false]],true,1,false] call CBA_fnc_addKeybind;

["test", "FLCSL_Forward_Train", ["Forward", "Accelerate the train you are in"], {

	private _unit = call CBA_fnc_currentUnit;
	private _veh = vehicle _unit;
	[train_0,"forward",FLCSL_CBA_Acceleration] remoteExec ["FLCSL_fnc_serverTrainControl",2];

}, {}, [DIK_W,[false,false,false]],true,1,false] call CBA_fnc_addKeybind;

["test", "FLCSL_Break_Train", ["Break", "Stop the train"], {
	private _unit = call CBA_fnc_currentUnit;
	private _veh = vehicle _unit;
	[train_0,"brake",FLCSL_CBA_Breaking] remoteExec ["FLCSL_fnc_serverTrainControl",2];

}, {}, [DIK_SPACE,[false,false,false]],true,1,false] call CBA_fnc_addKeybind;


(typeof _this == "CSA38_CZcrew")

_caller switchMove "CivilKneelActions_fixing";


[format ["owner is - %1 (owner %2)", name _this, clientOwner]] remoteExec ["systemChat", 0];

setApertureNew 0.5;


private _dir1 = vectorNormalized (_p2 vectorDiff _p1);

private _next = (_segment + 2) min ((count spline) - 1);
private _p3 = (spline select _next) modelToWorldWorld [0,0,1.05];

private _dir2 = vectorNormalized (_p3 vectorDiff _p2);

private _dir = vectorNormalized (_dir1 vectorAdd (_dir2 vectorMultiply _segmentT));




diag_log "---- LIVONIA RAIL SCAN START ----";

private _center = [worldSize/2, worldSize/2, 0];
private _radius = worldSize;


private _all = nearestTerrainObjects [_center, [], _radius, false];

diag_log format ["Terrain objects scanned: %1", count _all];


private _rails = _all select {
    private _t = toLowerANSI typeOf _x;
    (_t find "railway") > -1 || (_t find "rail_track") > -1
};

diag_log format ["Rails detected: %1", count _rails];



private _classes = [];
{
    _classes pushBackUnique (typeOf _x);
} forEach _rails;

diag_log format ["Rail classes found: %1", _classes];



private _nodes = [];
private _id = 0;

{
    _nodes pushBack [
        _id,
        getPosWorld _x,
        [],
        _x
    ];

    _id = _id + 1;

} forEach _rails;


private _maxDist = 8;

{
    private _nodeA = _x;
    private _idA = _nodeA select 0;
    private _posA = _nodeA select 1;

    {
        private _nodeB = _x;
        private _idB = _nodeB select 0;

        if (_idA != _idB) then {

            private _posB = _nodeB select 1;

            if (_posA distance _posB < _maxDist) then {

                private _conn = _nodeA select 2;

                if !(_idB in _conn) then {
                    _conn pushBack _idB;
                };

            };

        };

    } forEach _nodes;

} forEach _nodes;


private _railGraph = [];

{
    _railGraph pushBack [
        _x select 0,
        _x select 1,
        _x select 2
    ];
} forEach _nodes;

copyToClipboard str _railGraph;

diag_log format ["Rail nodes: %1", count _railGraph];
diag_log "Rail graph copied to clipboard";
diag_log "---- LIVONIA RAIL SCAN COMPLETE ----";
addMissionEventHandler ["Draw3D", {

    {
        drawIcon3D [
            "\a3\ui_f\data\map\markers\military\dot_ca.paa",
            [0,1,0,1],
            _x select 1,
            0.6,
            0.6,
            0,
            str (_x select 0),
            1
        ];

    } forEach _railGraph;

}];

onEachFrame {
    train_0 setowner 2;
};