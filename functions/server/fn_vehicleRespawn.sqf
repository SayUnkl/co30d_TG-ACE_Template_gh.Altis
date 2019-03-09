//Vehicle Respawn Script by |TG189| Unkl for TacticalGamer.com
//Reworked by Roque_THE_GAMER
//usage is in init of vehicles
//[this, <number of seconds to respawn>, <tickets>] spawn TG_fnc_vehicleRespawn; //for example below
//this - OBJECT - can be passed as the actual object name or by any magic variable such as "this" within an object init
//number of seconds to respawn - NUMBER - yes it's the number of seconds before the vehicle will respawn 300 = 5 min and allows wrecks
//										to finish burning
//tickets - NUMBER - how many times should this vehicle be allowed to respawn - use 999 for unlimited
//[this, 300, 999] spawn TG_fnc_vehicleRespawn; //where 300 seconds will make the respawn wait for 5 min, unlimited times

if !(isServer) exitWith {};  //exit if called by a client and not the server

//initialization section*******************************************************************************************************

//variables
_thisVehicle = _this select 0;
_timeToRespawn = _this select 1;
_tgTickets = _this select 2;
_thisVehicle setVariable ["timeToRespawn", _timeToRespawn, true];
_thisVehicle setVariable ["TgTickets", _tgTickets, true];
_thisVehicle setVariable ["Pos", (getPosATL _thisVehicle), true];
_thisVehicle setVariable ["Direction", (getDir _thisVehicle), true];

_weapons = [[],[]];
_magazines = [[],[]];
_items = [[],[]];
_backpacks = [[],[]];
//get all loaded inventory items and store for replacement
_weapons = getWeaponCargo _thisVehicle;
_magazines = getMagazineCargo _thisVehicle;
_items = getItemCargo _thisVehicle;
_backpacks = getBackpackCargo _thisVehicle;
_thisVehicle setVariable ["customCargo", [_weapons, _magazines, _items, _backpacks], true];


// add the event handle
_thisVehicle removeAllMPEventHandlers "mpKilled"; //this is to avoid add another event handle
_thisVehicle addMPEventHandler ["mpKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	if !(isServer) exitWith {};
	_unit removeAllMPEventHandlers "mpkilled";
	_unit spawn RTG_RespawnCode;
}];

if (count ((missionConfigFile >> "MissionSQM" >> "Mission" >> "Entities" ) call BIS_fnc_returnChildren select {getText (_x >> "Attributes" >> "name") == (str _thisVehicle)}) == 0) exitWith {
	sleep 2;
	Hint "WARNING MISSION MAKER. THERE IS A VEHICLE WITH OUT VARIABLE, TO AVOID ERRORS GIVE VARIABLES TO ALL VEHICLES";
};

//Roque_THE_GAME respawn code
if (!isNil {RTG_RespawnCode}) exitWith {}; //dont need to make the code more than once

RTG_RespawnCode = {
//exit if the mission maker forget to place a variable
_thisVehicle = _this;
_className = typeOf _thisVehicle;
_displayName = getText (configFile >>  "CfgVehicles" >>_className >> "displayName");
if (count ((missionConfigFile >> "MissionSQM" >> "Mission" >> "Entities" ) call BIS_fnc_returnChildren select {getText (_x >> "Attributes" >> "name") == (str _this)}) == 0) exitWith {
	Hint format ["%1 WILL NOT RESPAWN! HE HAS NO VARIABLE SET",(_displayName)];
};

//set
_thisVehicle = _this;
_newVehicleString = str _thisVehicle;
_timeToRespawn = 600; //default of 5 min
_timeToRespawn = _thisVehicle getVariable "timeToRespawn";
_tgTickets = _thisVehicle getVariable "TgTickets";
_classnameOfThisVehicle = typeOf _thisVehicle;
_safeSpawnLocation = getPosATL safeVehicleSpawnPoint; //this is a helipad located somewhere out of the way and is flat and clear
_positionToPlaceAt = _thisVehicle getVariable "Pos";
_directionToPlaceAt = _thisVehicle getVariable "Direction";
_mssg = "";
_weapons = [[],[]];
_magazines = [[],[]];
_items = [[],[]];
_backpacks = [[],[]];
//get all loaded inventory items and store for replacement
_allCargo = _thisVehicle getVariable "customCargo";
_weapons = _allCargo select 0;
_magazines = _allCargo select 1;
_items = _allCargo select 2;
_backpacks = _allCargo select 3;

///execute
if ((damage _thisVehicle) == 1) then {
		_className = typeOf _thisVehicle;
		_displayName = getText (configFile >>  "CfgVehicles" >>_className >> "displayName");
		_doRespawn = false;
		_currentTickets = _tgTickets;
		_currentTickets = _tgTickets - 1; // is this supouse to start from 0 or 1?
		if (_currentTickets > 0) then {
			_doRespawn = true;
			_plural = "";
			if (_currentTickets > 1) then {_plural = "s"} else {_plural = ""};
			_mssg = format ["%1 will respawn in %2 Seconds (%3 ticket%4 left)",(_displayName),(_timeToRespawn),(_currentTickets),(_plural)];
			_mssg remoteExec ["systemChat", 0, false];
		} else {
			//this will stop this script and any further respawns
			_run = false;
			_mssg = format ["%1 has been destroyed. It will not replaced.",(_displayName)];
			_mssg remoteExec ["systemChat", 0, false];
		};
		if (_doRespawn) then {
			sleep _timeToRespawn;
			_object = (str _thisVehicle);
			_configWithName = ((missionConfigFile >> "MissionSQM" >> "Mission" >> "Entities" ) call BIS_fnc_returnChildren select {getText (_x >> "Attributes" >> "name") == _object});
			_ObjectInitString = getText ((_configWithName select 0) >> "Attributes" >> "init");
			_VehicleModifications = [_thisVehicle,""] call BIS_fnc_exportVehicle;
			deleteVehicle _thisVehicle;
			sleep 1;//In case the vehicle is in the same place
			_newVehicle = _classnameOfThisVehicle createVehicle _safeSpawnLocation;
			missionNamespace setVariable [_newVehicleString, _newVehicle, true];
			[_newVehicle, _newVehicleString] remoteExec ["setVehicleVarName",0];
			sleep 1;
			_instalVehicleModifications = ("_this = " + (str _newVehicle)+ ";"+_VehicleModifications);
			_Init = ("this = " + (str _newVehicle)+ ";" + _ObjectInitString);
			call compileFinal _instalVehicleModifications;
			[(compileFinal _Init)] remoteExec ["call",0,true];
			_newVehicle setDir _directionToPlaceAt;
			_newVehicle setPosATL _positionToPlaceAt;
			//replace gear with gear loaded in editor
			clearWeaponCargoGlobal _newVehicle;
			clearMagazineCargoGlobal _newVehicle;
			clearItemCargoGlobal _newVehicle;
			clearBackpackCargoGlobal _newVehicle;


			if (count (_weapons select 0) > 0) then {
				{_newVehicle addWeaponCargoGlobal [_weapons select 0 select _forEachIndex, _weapons select 1 select _forEachIndex];} forEach _weapons;
			};
			if (count (_magazines select 0) > 0) then {
				{_newVehicle addMagazineCargoGlobal [_magazines select 0 select _forEachIndex, _magazines select 1 select _forEachIndex];} forEach _magazines;
			};
			if (count (_items select 0) > 0) then {
				{_newVehicle addItemCargoGlobal [_items select 0 select _forEachIndex, _items select 1 select _forEachIndex];} forEach _items;
			};
			if (count (_backpacks select 0) > 0) then {
				{_newVehicle addBackpackCargoGlobal [_backpacks select 0 select _forEachIndex, _backpacks select 1 select _forEachIndex];} forEach _backpacks;
			};
			_mssg = format ["%1 Has Respawned",(_displayName)];
			_mssg remoteExec ["systemChat", 0, false];
			[_newVehicle, _timeToRespawn, _currentTickets] spawn TG_fnc_vehicleRespawn;
		};
	};
};
