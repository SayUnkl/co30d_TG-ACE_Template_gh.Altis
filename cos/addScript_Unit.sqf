/*
Add Script to individual units spawned by COS.
_unit = unit. Refer to Unit as _unit.
*/

_unit =(_this select 0);
//[_unit,["Hello", {hint "I don't want trouble."}]] remoteExec ["addAction", 0, true];;// EXAMPLE SCRIPT

_unit addEventHandler ["Killed",{_theKiller = [_this select 0,_this select 1, _this select 2] call TG_fnc_civilianKilled;}];
