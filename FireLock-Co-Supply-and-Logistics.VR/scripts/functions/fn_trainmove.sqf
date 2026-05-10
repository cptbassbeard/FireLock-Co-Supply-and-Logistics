params ["_train","_carriages"];

spline = [
    sp_s1_001, sp_s1_002, sp_s1_003, sp_s1_004, sp_s1_005, sp_s1_006, sp_s1_007, sp_s1_008, sp_s1_009, sp_s1_010,
    sp_s1_011, sp_s1_012, sp_s1_013, sp_s1_014, sp_s1_015, sp_s1_016, sp_s1_017, sp_s1_018, sp_s1_019, sp_s1_020,
    sp_s1_021, sp_s1_022, sp_s1_023, sp_s1_024, sp_s1_025, sp_s1_026, sp_s1_027, sp_s1_028, sp_s1_029, sp_s1_030
];

/* this is for if you have zen loaded and want the markers
{
    [_x, true] call zen_building_markers_fnc_set
} forEach spline;
*/

systemChat format ["Spline compiled, %1 nodes", count spline];

if (isNil "_carriages") then {_carriages = []};

private _vehicles = [_train] + _carriages;
private _count = count spline;

/* ---------------------------------------------------------
    Disable collisions between train vehicles
--------------------------------------------------------- */

FLCSL_fnc_disableTrainCollisions = {

    params ["_vehicles"];

    {
        private _veh = _x;

        {
            if (_veh != _x) then {
                _veh disableCollisionWith _x;
                _x disableCollisionWith _veh;
            };
        } forEach _vehicles;

    } forEach _vehicles;

};

[_vehicles] remoteExec ["FLCSL_fnc_disableTrainCollisions", 0, true];


/* ---------------------------------------------------------
    PRECOMPUTE SPLINE SEGMENT LENGTHS
--------------------------------------------------------- */

private _segLengths = [];
private _cumLengths = [0];
private _totalLength = 0;

for "_i" from 0 to (_count - 2) do {

    private _p1 = getPosASL (spline select _i);
    private _p2 = getPosASL (spline select (_i + 1));

    private _d = _p1 distance _p2;

    _segLengths pushBack _d;

    _totalLength = _totalLength + _d;
    _cumLengths pushBack _totalLength;
};


/* ---------------------------------------------------------
    FIND START POSITION ON SPLINE
--------------------------------------------------------- */

private _trainPos = getPosASL _train;

private _closestSeg = 0;
private _closestDist = 1e10;
private _closestT = 0;

for "_i" from 0 to (_count - 2) do {

    private _p1 = getPosASL (spline select _i);
    private _p2 = getPosASL (spline select (_i + 1));

    private _segVec = _p2 vectorDiff _p1;
    private _toTrain = _trainPos vectorDiff _p1;

    private _lenSq = _segVec vectorDotProduct _segVec;

    if (_lenSq == 0) then {continue};

    private _tSeg = (_toTrain vectorDotProduct _segVec) / _lenSq;
    _tSeg = _tSeg max 0 min 1;

    private _proj = _p1 vectorAdd (_segVec vectorMultiply _tSeg);

    private _dist = _trainPos distance _proj;

    if (_dist < _closestDist) then {

        _closestDist = _dist;
        _closestSeg = _i;
        _closestT = _tSeg;

    };
};

private _segment = _closestSeg;
private _segmentT = _closestT;

diag_log format ["Train start segment: %1, T: %2", _segment, _segmentT];


/* ---------------------------------------------------------
    VEHICLE LENGTHS + OFFSETS
--------------------------------------------------------- */

private _lengths = _vehicles apply {
    private _bb = boundingBoxReal _x;
    abs(((_bb select 1) select 1) - ((_bb select 0) select 1))
};

private _offsets = [];
private _acc = 0;

private _engineGap = 2;
private _carriageGap = 0.5;

for "_i" from 1 to ((count _vehicles) - 1) do {

    private _prev = _lengths select (_i - 1);
    private _cur = _lengths select _i;

    private _gap = if (_i == 1) then {_engineGap} else {_carriageGap};

    _acc = _acc + (_prev/2) + (_cur/2) + _gap;

    _offsets pushBack _acc;

};

private _trainLength = if (count _offsets > 0) then {
    _offsets select ((count _offsets) - 1)
} else {
    0
};


/* ---------------------------------------------------------
    DISTANCE -> SEGMENT/T
--------------------------------------------------------- */

private _fnc_distToSeg = {

    params ["_dist","_cumLengths","_segLengths"];

    private _seg = 0;

    for "_i" from 0 to ((count _segLengths) - 1) do {

        if (_dist < (_cumLengths select (_i + 1))) exitWith {
            _seg = _i;
        };

    };

    private _segStart = _cumLengths select _seg;
    private _segLen = _segLengths select _seg;

    private _t = (_dist - _segStart) / _segLen;

    [_seg,_t]
};


/* ---------------------------------------------------------
    PER FRAME TRAIN MOVEMENT
--------------------------------------------------------- */

_handler = [{

    params ["_args"];

    _args params [
        "_train",
        "_carriages",
        "_segment",
        "_segmentT",
        "_segLengths",
        "_cumLengths",
        "_offsets",
        "_totalLength",
        "_trainLength",
        "_fnc_distToSeg"
    ];

    _train setowner 2;

    if (!isServer && {isNil "FLCSL_trainState"}) exitWith {};

    private _speed = _train getVariable ["FLCSL_trainThrust",0];

    // If server has broadcast authoritative state, use it
    if (!isServer && {!isNil "FLCSL_trainState"}) then {

        _segment  = FLCSL_trainState select 0;
        _segmentT = FLCSL_trainState select 1;
        _speed    = FLCSL_trainState select 2;

    };

    private _dist = (_cumLengths select _segment) + (_segmentT * (_segLengths select _segment));

    if (isServer) then {
        _dist = _dist + (_speed * diag_deltaTime);
    };

    private _maxDist = _totalLength - _trainLength;

    if (_dist > _maxDist) then {
        _dist = _maxDist;
        _train setVariable ["FLCSL_trainThrust",0,true];
    };

    if (_dist < 0) then {
        _dist = 0;
        _train setVariable ["FLCSL_trainThrust",0,true];
    };

    private _segData = [_dist,_cumLengths,_segLengths] call _fnc_distToSeg;

    _segment = _segData select 0;
    _segmentT = _segData select 1;

    private _a = spline select _segment;
    private _b = spline select (_segment + 1);

    private _pos1 = _a modelToWorldWorld [0,0,1.05];
    private _pos2 = _b modelToWorldWorld [0,0,1.05];

    private _dir = vectorNormalized (_pos2 vectorDiff _pos1);
    private _vel = _dir vectorMultiply _speed;

    _dummyTrain = _train getVariable ["FLCSL_childDummy", objNull];

    _dummyTrain setPosASL getposASl _train;

    _dummyTrain setVectorDir vectorDir _train;
    _dummyTrain setVectorUp vectorUp _a;

    /* ---- move locomotive ---- */

    if (local _train) then {

        _train setVelocityTransformation [
            _pos1,_pos2,
            _vel,_vel,
            _dir,_dir,
            vectorUp _a,vectorUp _b,
            _segmentT
        ];

    };

    /* ---- move carriages (only if local) ---- */

    {

        private _veh = _x;

        if (!local _veh) then {continue};

        private _offset = _offsets select _forEachIndex;

        private _vehDist = _dist - _offset;

        if (_vehDist < 0) then {_vehDist = 0};

        private _segData = [_vehDist,_cumLengths,_segLengths] call _fnc_distToSeg;

        private _segC = _segData select 0;
        private _segT = _segData select 1;

        private _aW = spline select _segC;
        private _bW = spline select (_segC + 1);

        private _p1 = _aW modelToWorldWorld [0,0,1.05];
        private _p2 = _bW modelToWorldWorld [0,0,1.05];

        private _dirW = vectorNormalized (_p2 vectorDiff _p1);

        _veh setVelocityTransformation [
            _p1,_p2,
            _vel,_vel,
            _dirW,_dirW,
            vectorUp _aW,vectorUp _bW,
            _segT
        ];

    } forEach _carriages;

    _args set [2,_segment];
    _args set [3,_segmentT];

    /* ---- network sync ---- */

    if (isServer) then {

        if (isNil "FLCSL_lastSync") then { FLCSL_lastSync = 0 };

        if (serverTime - FLCSL_lastSync > 0.1) then {

            FLCSL_lastSync = serverTime;

            private _thrust = _train getVariable ["FLCSL_trainThrust",0];
            private _reversing = _train getVariable ["FLCSL_trainReversing", false];

            FLCSL_trainState = [
                _segment,
                _segmentT,
                _thrust,
                _reversing
            ];

            publicVariable "FLCSL_trainState";

            missionNamespace setVariable ["FLCSL_trainState", FLCSL_trainState, true];

        };

    };

},0,[
    _train,
    _carriages,
    _segment,
    _segmentT,
    _segLengths,
    _cumLengths,
    _offsets,
    _totalLength,
    _trainLength,
    _fnc_distToSeg
]] call CBA_fnc_addPerFrameHandler;
/*
[trainphys,10] remoteExec ["CBB_fnc_trainmove", 2];
_surface = lineIntersectsSurfaces [getPosASL _nextIndex vectorAdd [0,0,5], getPosASL _nextIndex vectorAdd [0,0,-8], objNull, objNull, true, -1, "FIRE", "GEOM", true];