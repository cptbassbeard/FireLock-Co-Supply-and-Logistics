params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];
private _veh = train_6;

if ((_veh emptyPositions "cargo") == 0) then {
    _veh = train_7;
};

_newUnit moveInCargo _veh;