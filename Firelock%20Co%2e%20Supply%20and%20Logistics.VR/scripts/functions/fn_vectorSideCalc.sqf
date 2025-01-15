params ["_TrainObj", "_left"];
_vectorSide = vectorside _trainObj;
if (_left) then {
	_value = 1;
} else { _value = -1;}
_vectorside = _vectorside vectorMultiply _value;
_vectorsides