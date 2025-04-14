params ["_trainObj"];

_reversing = _trainObj getvariable "FLCSL_trainReversing";
if (_reversing) then {}
_trainobj setVelocityModelSpace []
