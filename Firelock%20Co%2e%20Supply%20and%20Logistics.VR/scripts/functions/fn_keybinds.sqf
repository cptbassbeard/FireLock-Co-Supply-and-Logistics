#include "\a3\ui_f\hpp\defineDIKCodes.inc"

["Last train home", "LTH_Reverse_Train", ["Backward", "Reverse the train you are in"], {
		private _unit = call CBA_fnc_currentUnit;
		_trainthrust = ((vehicle _unit) getVariable "FLCSL_thrust") - FLCSL_trainThrust;
		(vehicle _unit) setVariable ["FLCSL_thrust", _trainthrust, true];
		(vehicle _unit) setVariable ["FLCSL_trainReversing", true, true];
}, {
}, [DIK_S, [false, false, false]],true,1,false] call CBA_fnc_addKeybind;

["Last train home", "LTH_Forward_Train", ["Forward", "Accelerate the train you are in"], {
		private _unit = call CBA_fnc_currentUnit;
		_trainthrust = ((vehicle _unit) getVariable "FLCSL_thrust") + FLCSL_trainThrust;
		(vehicle _unit) setVariable ["FLCSL_thrust", _trainthrust, true];
		(vehicle _unit) setVariable ["FLCSL_trainReversing", false, true];
}, {
}, [DIK_W, [false, false, false]],true,1,false] call CBA_fnc_addKeybind;

["Last train home", "LTH_Break_Train", ["Break", "Stop the train"], {
		private _unit = call CBA_fnc_currentUnit;
		(vehicle _unit) setVariable ["FLCSL_thrust", 0, true];
}, {
}, [DIK_SPACE, [false, false, false]],true,1,false] call CBA_fnc_addKeybind;

// CHECKBOX --- extra argument: default value
["FLCSL_CBA_debug", "CHECKBOX", ["Debug", "turn on debug for all trains"], "Firelock Co Supply & Logistics", false,1,{},false] call CBA_fnc_addSetting;

// EDITBOX --- extra argument: default value
["FLCSL_CBA_tracks", "EDITBOX",  ["custom track classnames", "for adding custom tracks"], "Firelock Co Supply & Logistics", "['ATS_Tracks_Base','somemoreclassnames']", 1, {},true] call CBA_fnc_addSetting;

