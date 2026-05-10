"FLCSL_trainState" addPublicVariableEventHandler {
    params ["_var","_data"];

    _data params ["_seg","_t","_speed","_reversing"];

    missionNamespace setVariable ["FLCSL_netSegment", _seg];
    missionNamespace setVariable ["FLCSL_netT", _t];
    missionNamespace setVariable ["FLCSL_netSpeed", _speed];
    missionNamespace setVariable ["FLCSL_netReversing", _reversing];

    // Immediately move train to correct position
    private _train = train_0; // train object
    if (!isNull _train) then {

        private _a = spline select _seg;
        private _b = spline select (_seg + 1);

        private _pos1 = _a modelToWorldWorld [0,0,1];
        private _pos2 = _b modelToWorldWorld [0,0,1];

        private _dir = vectorNormalized (_pos2 vectorDiff _pos1);
        private _vel = _dir vectorMultiply _speed;

        _train setVelocityTransformation [
            _pos1,_pos2,
            _vel,_vel,
            _dir,_dir,
            vectorUp _a,vectorUp _b,
            _t
        ];

        _train setVariable ["FLCSL_trainThrust", _speed, true];
        _train setVariable ["FLCSL_trainReversing", _reversing, true];
    };
};