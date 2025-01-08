#include "\a3\ui_f\hpp\defineDIKCodes.inc"

["Last train home", "FLCSL_Reverse_Train", ["Backward", "Reverse the train you are in"], {
		private _unit = call CBA_fnc_currentUnit;
		if ((driver vehicle _unit isEqualTo _unit) && (vehicle player getVariable "FLCSL_isTrain")) then {
			_thrust = (vehicle _unit) getVariable "FLCSL_trainThrust";
			(vehicle _unit) setVariable ["FLCSL_trainThrust",_thrust - 0.0001];
			(vehicle _unit) setVariable ["FLCSL_trainReversing", true, true];
		};
}, {
}, [DIK_S, [false, false, false]],true,1,false] call CBA_fnc_addKeybind;

["Last train home", "FLCSL_Forward_Train", ["Forward", "Accelerate the train you are in"], {
		private _unit = call CBA_fnc_currentUnit;
		if ((driver vehicle _unit isEqualTo _unit) && (vehicle player getVariable "FLCSL_isTrain")) then {
			_thrust = (vehicle _unit) getVariable "FLCSL_trainThrust";
			(vehicle _unit) setVariable ["FLCSL_trainThrust",_thrust + 0.0001, true];
			(vehicle _unit) setVariable ["FLCSL_trainReversing", false, true];
		};
}, {
}, [DIK_W, [false, false, false]],true,1,false] call CBA_fnc_addKeybind;

["Last train home", "FLCSL_Break_Train", ["Break", "Stop the train"], {
		private _unit = call CBA_fnc_currentUnit;
		trainthrust = 0;
}, {
}, [DIK_SPACE, [false, false, false]],true,1,false] call CBA_fnc_addKeybind;