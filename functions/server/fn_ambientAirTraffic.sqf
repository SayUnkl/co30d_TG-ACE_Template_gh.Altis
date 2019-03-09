//fn_ambientAirTraffic.sqf by |TG189| Unkl for TacticalGamer.com

_run = true;
_upOrDown = 0;
_start = 0;
_end = 0;
_height = 0;
_ambientVic = "B_Heli_Attack_01_F"; //sets a default

//USER SET VARIABLES **************************************************************************************************
//
//Below is an array of all possible air vehicles to be used in the ambient traffic									 **
_possibleVic = ["B_Heli_Attack_01_F","B_Heli_Transport_01_camo_F","B_Heli_Light_01_armed_F","B_Plane_CAS_01_F","B_Heli_Transport_03_black_F"];
//																													 **
//Below set the maximum coordinate value for your map. For Altis we use 29900;										 **
_maxCoordinate = 29900;				//																				 **
//																													 **
/**********************************************************************************************************************/



/*********************************************************************************************************************************
DO NOT EDIT BELOW THIS LINE
**********************************************************************************************************************************/

while {_run} do {
	//ambient fly by
	if (floor random 700 < 10) then	{
		_upOrDown = random 10;
		if (_upOrDown < 5) then
		{
			_start = 10;
			_end = _maxCoordinate;
		} else {
			_start = _maxCoordinate;
			_end = 10;
		};
		_height = ((floor random 5) + 1) * 100;
		_ambientVic = _possibleVic select (floor random (count _possibleVic));		
		[[random _maxCoordinate,_start,200],[random _maxCoordinate, _end, 200], _height, "FULL", _ambientVic, WEST] call BIS_fnc_ambientFlyBy;
	};
	sleep 4;
};