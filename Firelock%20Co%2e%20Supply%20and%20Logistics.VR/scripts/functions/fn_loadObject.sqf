params ["_object","_carriage"];
_carriagePoints = []
{
	createVehicleLocal "" //vr cube
	
} forEach _carriage selectionNames "Memory";
waitUntil { _loopComplete; };
_object attachTo