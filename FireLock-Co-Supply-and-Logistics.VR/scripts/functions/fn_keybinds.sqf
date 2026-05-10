#include "\a3\ui_f\hpp\defineDIKCodes.inc"

[
    "FLCSL_CBA_Acceleration",
    "SLIDER",
    ["Acceleration", "Forward acceleration multiplier"],
    ["FLCSL", "Movement"],
    [0, 5, 0.15, 2],
    1
] call CBA_fnc_addSetting;

[
    "FLCSL_CBA_Reverse",
    "SLIDER",
    ["Reverse", "Reverse acceleration multiplier"],
    ["FLCSL", "Movement"],
    [0, 5, 0.15, 2],
    1
] call CBA_fnc_addSetting;

[
    "FLCSL_CBA_Breaking",
    "SLIDER",
    ["Breaking", "Braking force multiplier"],
    ["FLCSL", "Movement"],
    [0, 5, 0.5, 2],
    1
] call CBA_fnc_addSetting;

[
    "FLCSL_CBA_TopSpeed",
    "SLIDER",
    ["Top Speed", "Maximum movement speed"],
    ["FLCSL", "Movement"],
    [0, 100, 20, 0],
    1
] call CBA_fnc_addSetting;

if (hasInterface) then {
	["Last train home", "FLCSL_Reverse_Train", ["Backward", "Reverse the train you are in"], {

	private _unit = call CBA_fnc_currentUnit;
	private _veh = vehicle _unit;

	if ((driver _veh isEqualTo _unit) && (_veh getVariable "FLCSL_isTrainDummy")) then {
		_trainobj = _veh getVariable ["FLCSL_dummyParent", objNull];
		["FLCSL_trainControl", [_trainobj,"reverse",FLCSL_CBA_Reverse], _trainobj] call CBA_fnc_targetEvent;
		diag_log format ["%1 - Reverse keybind activated by %2", diag_timestamp, name player];
	};

	}, {}, [DIK_S,[false,false,false]],true,0.5,false] call CBA_fnc_addKeybind;

	["Last train home", "FLCSL_Forward_Train", ["Forward", "Accelerate the train you are in"], {

		private _unit = call CBA_fnc_currentUnit;
		private _veh = vehicle _unit;

		if ((driver _veh isEqualTo _unit) && (_veh getVariable "FLCSL_isTrainDummy")) then {
			_trainobj = _veh getVariable ["FLCSL_dummyParent", objNull];
			["FLCSL_trainControl", [_trainobj,"forward",FLCSL_CBA_Acceleration], _trainobj] call CBA_fnc_targetEvent;

			diag_log format ["%1 - Forward keybind activated by %2", diag_timestamp, name player];
		};

	}, {}, [DIK_W,[false,false,false]],true,0.5,false] call CBA_fnc_addKeybind;

	["Last train home", "FLCSL_Brake_Train", ["Brake", "Stop the train"], {

		private _unit = call CBA_fnc_currentUnit;
		private _veh = vehicle _unit;

		if ((driver _veh isEqualTo _unit) && (_veh getVariable "FLCSL_isTrainDummy")) then {
			_trainobj = _veh getVariable ["FLCSL_dummyParent", objNull];
			["FLCSL_trainControl", [_trainobj,"brake",FLCSL_CBA_Breaking], _trainobj] call CBA_fnc_targetEvent;

			diag_log format ["%1 - Brake keybind activated by %2", diag_timestamp, name player];
		};

	}, {}, [DIK_SPACE,[false,false,false]],true,0.5,false] call CBA_fnc_addKeybind;
};



/*

["Last train home", "FLCSL_Left_Train", ["Turn Left", "Make the train turn left at the next possible junction"], {
		private _unit = call CBA_fnc_currentUnit;
		if ((driver vehicle _unit isEqualTo _unit) && (vehicle player getVariable "FLCSL_isTrain")) then {
			
		};
}, {
}, [DIK_SPACE, [false, false, false]],true,1,false] call CBA_fnc_addKeybind;

["Last train home", "FLCSL_Right_Train", ["Turn right", "Make the train turn right at the next possible junction"], {
		private _unit = call CBA_fnc_currentUnit;
		if ((driver vehicle _unit isEqualTo _unit) && (vehicle player getVariable "FLCSL_isTrain")) then {
			
		};
}, {
}, [DIK_SPACE, [false, false, false]],true,1,false] call CBA_fnc_addKeybind;

//Building Mechanics WIP
["Last train home", "FLCSL_Train_Construction", ["Construction Toggle", "Keybind to alow construction on the train"], {
		private _unit = call CBA_fnc_currentUnit;
		_canBuild = _unit getVariable "FLCSCL_canBuild";
		if (_canbuild) then {}
}, {
}, [DIK_F, [false, false, false]],true,1,false] call CBA_fnc_addKeybind;