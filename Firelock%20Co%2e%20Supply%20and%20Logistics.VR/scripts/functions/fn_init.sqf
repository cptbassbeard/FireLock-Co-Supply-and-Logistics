
// CHECKBOX --- extra argument: default value
["FLCSL_CBA_debug", "CHECKBOX", ["Debug", "turn on debug for all trains"], "Firelock Co Supply & Logistics", false,1,{},false] call CBA_fnc_addSetting;
["FLCSL_CBA_aiCanUseTrains", "CHECKBOX", ["Allow AI to use trains (EXPERIMENTAL)", "Enable or disable AI using trains"], "Firelock Co Supply & Logistics", false,1,{},false] call CBA_fnc_addSetting;
["FLCSL_CBA_trainRamming", "CHECKBOX", ["Allow trains to ram blockades (EXPERIMENTAL)", "Enable or disable trains colliding with objects on the track"], "Firelock Co Supply & Logistics", false,1,{},false] call CBA_fnc_addSetting;


// EDITBOX --- extra argument: default value
["FLCSL_CBA_tracks", "EDITBOX",  ["custom track classnames", "for adding custom tracks"], "Firelock Co Supply & Logistics", "['ATS_Tracks_Base','somemoreclassnames']", 1, {},true] call CBA_fnc_addSetting;
["FLCSL_CBA_customTrain", "EDITBOX",  ["custom train classnames (TBA)", "for adding custom trains"], "Firelock Co Supply & Logistics", "['VariableNameofTrain,someOtherVariableName']", 1, {},true] call CBA_fnc_addSetting;


// EDITBOX --- Change train Accelerataion values
["FLCSL_CBA_Acceleration", "EDITBOX",  ["Train Acceleration", "Customise how fast the train is Accelerating. Its a fixed acceleration value"], "Firelock Co Supply & Logistics", "0.0001", 1, {},true] call CBA_fnc_addSetting;
["FLCSL_CBA_Reverse", "EDITBOX",  ["Train Reverse", "Customise how fast the train is Reversing. Its a fixed acceleration value"], "Firelock Co Supply & Logistics", "0.0001", 1, {},true] call CBA_fnc_addSetting;
["FLCSL_CBA_Breaking", "EDITBOX",  ["Train Breaking", "Customise how fast the train is at Breaking. Its a multiplier"], "Firelock Co Supply & Logistics", "0.9", 1, {},true] call CBA_fnc_addSetting;
["FLCSL_CBA_dragEnabled", "CHECKBOX", ["train drag", "Enable or disable train drag"], "Firelock Co Supply & Logistics", false,1,{},false] call CBA_fnc_addSetting;
["FLCSL_CBA_Drag", "EDITBOX",  ["Train Drag", "Customise how fast the train is slowing down without any input. Its a multiplier"], "Firelock Co Supply & Logistics", "0.9", 1, {},true] call CBA_fnc_addSetting;

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
"ATS_Tracks_Base", //ATS tracks
"Land_Rail_Track_25_F", //start of epoc tracks
"Land_Rail_Track_L25_10_F",
"Land_Rail_Track_R25_10_F",
"Land_Rail_Track_Down_25_F",
"Land_Rail_TrackE_25_F",
"Land_Rail_TrackE_L25_10_F",
"Land_Rail_TrackE_R25_10_F",
"Land_Rail_TrackE_L25_5_F",
"Land_Rail_TrackE_R25_5_F",
"Land_Rail_TrackE_25NOLC_F",
"Land_Rail_Track_Up_25_F",
"Land_Rail_TrackE_2_F",
"Land_Rail_TrackE_R30_20_F",
"Land_Rail_TrackE_L30_20_F",
"Land_Rail_Track_Down_40_F",
"Land_Rail_TrackE_40_F",
"Land_Rail_TrackE_40NOLC_F",
"Land_Rail_Track_Up_40_F",
"Land_Rail_TrackE_4_F",
"Land_Rail_TrackE_8_F",
"Land_Rail_TrackE_8NOLC_F",
"Land_Rail_Track_LB_RE_F",
"Land_Rail_Track_LB1_RE_F",
"Land_Rail_Track_LE_RB_F",
"Land_Rail_Track_LE1_RB_F",
"Land_Rail_Track_SP_F",
"Land_Rail_Track_Passing_10_F",
"Land_Rail_Track_Passing_25_F",
"Land_Rail_Track_Passing_25NOLC_F",
"Land_Rail_TrackE_TurnOutL_F",
"Land_Rail_Track_TurnOutL_F",
"Land_Rail_TrackE_TurnOutR_F",
"Land_Rail_Track_TurnOutR_F" //epoc track end
];
FLCSL_configTracks append (parseSimpleArray FLCSL_CBA_tracks);