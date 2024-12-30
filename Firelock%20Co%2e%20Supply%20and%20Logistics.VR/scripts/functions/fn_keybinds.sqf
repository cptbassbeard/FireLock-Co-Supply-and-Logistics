#include "\a3\ui_f\hpp\defineDIKCodes.inc"

["Last train home", "LTH_Reverse_Train", ["Backward", "Reverse the train you are in"], {
		private _unit = call CBA_fnc_currentUnit;
		trainthrust = trainthrust - 0.0001;
		vehicle _unit setVariable ["LTH_trainReversing", true, true];
}, {
}, [DIK_S, [false, false, false]],true,1,false] call CBA_fnc_addKeybind;

["Last train home", "LTH_Forward_Train", ["Forward", "Accelerate the train you are in"], {
		private _unit = call CBA_fnc_currentUnit;
		trainthrust = trainthrust + 0.0001;
		vehicle _unit setVariable ["LTH_trainReversing", false, true];
}, {
}, [DIK_W, [false, false, false]],true,1,false] call CBA_fnc_addKeybind;

["Last train home", "LTH_Break_Train", ["Break", "Stop the train"], {
		private _unit = call CBA_fnc_currentUnit;
		trainthrust = 0;
}, {
}, [DIK_SPACE, [false, false, false]],true,1,false] call CBA_fnc_addKeybind;

// CHECKBOX --- extra argument: default value
["FLC_CBA_debug", "CHECKBOX", ["Debug", "turn on debug for all trains"], "Firelock Co Supply & Logistics", false,1,{},false] call CBA_fnc_addSetting;

// EDITBOX --- extra argument: default value
["FLC_CBA_tracks", "EDITBOX",  ["custom track classnames", "for adding custom tracks"], "Firelock Co Supply & Logistics", "['ATS_Tracks_Base','somemoreclassnames']", 1, {FLCSL_Tracks = FLCSL_configTracks append (parseSimpleArray FLC_CBA_tracks)},false] call CBA_fnc_addSetting;

