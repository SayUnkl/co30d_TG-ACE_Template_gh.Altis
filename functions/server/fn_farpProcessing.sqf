if !(isServer) exitWith {};
params ["_repairObject","_Caller"];

//systemChat format ["passed was: %1", _repairObject];
_repairCenter = getposASL _repairObject;

_VehiclesAround = (vehicles inAreaArray [_repairCenter, 20, 20] select {(_x isKindOf "LandVehicle" or _x isKindOf "Air" or _x isKindOf "Ship") AND speed _x < 1 AND Alive _x}); //speed needs to be < 1 because there is a small bug were the vehicle can move micro slower but its higher than 0

//add to the aray if there is vehicles to repair, rearm, refuel.
_VehiclesToCount = _VehiclesAround select {
	//get the full damage of the vehicle since the command Damage does not seems to count some hit points damge that are not the hull or engine 
	_FullDamage = 0;
	{_FullDamage = _x + _FullDamage} forEach (getAllHitPointsDamage _x select 2); 
	//
	_IsLoaded = 1; 
	{  
		_CurrentAmmo =  (_x select 1);  
		_CurrentMagazine =  (_x select 0);  
		_OriginalAmmoAmout = (getNumber(configFile >> "CfgMagazines" >> _CurrentMagazine >> "count")); 
		if !(_CurrentAmmo == _OriginalAmmoAmout and _IsLoaded == 1) then {_IsLoaded = 0}; 
	} forEach magazinesAmmo _x; 
	
	damage _x > 0 or fuel _x < 1 or _FullDamage > 0 or _IsLoaded == 0
};
//

//Cancel Repairs if there is no vehicles to repair
_IsInProgress = (!isNil {_repairObject getVariable "IsInProgress"});
if (_IsInProgress) exitWith {
	[(format ["Vehicle service is unavailable. The facilities are being used by %1",(_repairObject getVariable "IsInProgress")])] remoteExec ["systemChat",_Caller];
};
if (count _VehiclesToCount == 0) exitWith {
	["No vehicles to service. Work order is canceled."] remoteExec ["systemChat",_Caller];
};
//

//add a variable to avoid use the action twice
_repairObject setVariable ["IsInProgress", (name player), true];
["Ensuring vehicles have no passengers..."] remoteExec ["systemChat",_Caller];

{
	_OldCrew = (crew _x); 
	["You have been removed from the vehicle while it is being serviced."] remoteExec ["systemChat", _OldCrew]; //give notification for the crew
	{moveOut _x} forEach (crew _x);
	waitUntil {count (crew _x) == 0}; //this is to avoid possible lag
	sleep .2;
	[_x, 2] remoteExec ["setOwner",2];
	sleep .5;
	[_x, 0] remoteExec ["setFuel", 2, false];
	[_x, "LOCKED"] remoteExec ["setVehicleLock", 0]; //locked
	_x engineOn false; //turn off engine
} forEach _VehiclesToCount;

//string of the vehicles that will be repaired
_VehiclesThatWereRepaired = "";
{
	_className = typeOf _x;
	_displayName = getText (configFile >>  "CfgVehicles" >>
	_className >> "displayName");
	_stuff = "";
	if (count _VehiclesThatWereRepaired == 0) then {_stuff = "."} else {_stuff = ", "}; //DAMN SON! WHERE'D YOU FIND THIS?!  I dont know but it works
	_VehiclesThatWereRepaired = format ["%1%2",_displayName, _stuff] + _VehiclesThatWereRepaired;
} forEach _VehiclesToCount;
if (count _VehiclesThatWereRepaired == 0) then {_VehiclesThatWereRepaired = "None"};
//
_systemchatstring = (format ["Servicing:  %1",_VehiclesThatWereRepaired]);
[_systemchatstring] remoteExec ["systemChat",_Caller];

sleep 5; //another delay to avoid lag

["Repairing vehicles..."] remoteExec ["systemChat",_Caller];
sleep 10;
{
	sleep .2;
	[objNull, _x] call ace_repair_fnc_doFullRepair;
} forEach _VehiclesToCount;
["Rearming vehicles..."] remoteExec ["systemChat",_Caller];
sleep 10;
{
	_vehicle = _x;
	_OldVehicleWeapons = weapons _vehicle;
	_x setVehicleAmmodef 1;
	sleep 2; //need another delay to the ammo be set
	_newvehicleWeapons = weapons _vehicle;
	_WeaponsAdded = _newvehicleWeapons - _OldVehicleWeapons;
	{_vehicle removeWeaponGlobal _x} forEach _WeaponsAdded;
	if (_x getVariable "ace_rearm_isSupplyVehicle") then {
		[_x, 1000] remoteExec ["ace_rearm_fnc_setSupplyCount", 2, false];
	};
	if (_x getVariable "isAceRefuelVic") then {					//these variable are setup in the initServer.sqf
		[_x, _x getVariable "aceRefuelCapacity"] remoteExec ["ace_refuel_fnc_setFuel", 2, false];
	};
	[_x, 1] remoteExec ["setRepairCargo", 2, false];
} forEach _VehiclesToCount;

["Refueling vehicles..."] remoteExec ["systemChat",_Caller];
sleep 10;
{
	[_x, 1] remoteExec ["setFuel", 2, false];
} forEach _VehiclesToCount;


["Operations completed at FARP."] remoteExec ["systemChat",_Caller];

{
	[_x, "UNLOCKED"] remoteExec ["setVehicleLock", 0, false];
} forEach _VehiclesToCount;

sleep 1;
_stringTosystenchat = (format ["Vehicles Serviced:  %1",_VehiclesThatWereRepaired]);
[_stringTosystenchat] remoteExec ["systemChat",_Caller];

//remove public variable to allow to be used again
_repairObject setVariable ["IsInProgress", nil, true];