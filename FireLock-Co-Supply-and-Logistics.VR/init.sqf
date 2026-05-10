["FLCSL_trainControl", {
	params ["_veh","_mode","_value"];
	[_veh,_mode,_value] call FLCSL_fnc_serverTrainControl;
}] call CBA_fnc_addEventHandler;

diag_log format ["Initializing train control system with Acceleration: %1, Reverse: %2, Breaking: %3, Top Speed: %4", FLCSL_CBA_Acceleration, FLCSL_CBA_Reverse, FLCSL_CBA_Breaking, FLCSL_CBA_TopSpeed];