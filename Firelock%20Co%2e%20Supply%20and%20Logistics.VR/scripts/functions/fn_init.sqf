
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
FLCSL_configTracks append (parseSimpleArray FLC_CBA_tracks);
missionNamespace setVariable ["FLCSL_Tracks", FLCSL_configTracks, true];