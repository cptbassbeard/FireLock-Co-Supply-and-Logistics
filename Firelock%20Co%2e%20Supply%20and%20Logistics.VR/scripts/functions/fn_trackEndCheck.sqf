params ["_trainObj"];
if ((_trainobj getVariable "FLCSL_isCarriage") == true) exitwith {};
_objects = lineIntersectsObjs [_trainObj, (getPosASL _trainObj vectorAdd (vectorDir _trainObj vectorMultiply 1))]

_collisionbox = boundingBoxReal [_trainObj,"GEOMETRY"];

if (_objectFiltered inArea [])
inAreaArray





[[xmin, ymin, zmin], [xmax, ymax, zmax], boundingSphereRadius]