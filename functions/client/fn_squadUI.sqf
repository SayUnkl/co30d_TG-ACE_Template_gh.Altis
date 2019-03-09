/************************************************
version: 2017_04_12

Credits: Code segments taken from Dslyecxi's STHUD
mod to color map markers based on assigned team.
*************************************************/


if (isDedicated) exitWith {};
#define  HUD_ASSIGNEDTEAM "ST_STHud_assignedTeam"

// unit call ST_STHud_assignedTeam -> "MAIN" etc.
ST_STHud_assignedTeam = {
    private "_unit";
    _unit = _this;

    // Nothing to do in SP
    if (!isMultiplayer) exitWith {assignedTeam(_unit)};

    // Assume MAIN if not defined, which avoids any complex behaviour
    _assigned_team = _unit getVariable [HUD_ASSIGNEDTEAM, "MAIN"];

    // Early exit if not using teams
    if (_assigned_team == "MAIN") exitWith {"MAIN"};

    // Special behaviour when checking the unit colour of the player
    if (_unit == player) then {
        // If we've changed groups since last check, discard our existing team
        private "_last_group";
        _last_group = player getVariable ["ST_STHud_lastGroup", grpNull];
        if (group(player) != _last_group) then {
            _last_group = group(player);
            player setVariable ["ST_STHud_lastGroup", _last_group, false];

            // TODO: Should we broadcast this or just let the clients figure
            // this out independently?
            _unit setVariable [HUD_ASSIGNEDTEAM, "MAIN", true];
            _assigned_team = "MAIN";
        };
    };
    _assigned_team;
};

ST_STHud_AssignedTeamWatcher = {
    // Nothing to do in SP
    if (!isMultiplayer) exitWith {};

    // Before we start the main loop, check to see if any units have had their
    // team assigned e.g. via unit init and push that into our system.
    if (leader(player) == player) then {
        {
            private "_unit";
            _unit = _x;

            // Update the shared data if it doesn't match the data from the engi
            if (assignedTeam(_unit) != (_unit call ST_STHud_assignedTeam)) then
            {
                _unit setVariable [HUD_ASSIGNEDTEAM, assignedTeam(_unit), true];
            };
        } forEach(units(player));
    };

    while {true} do {
        // Wait until player is group leader
        waitUntil {sleep 2; leader(player) == player};

        // Ensure the engine is using the latest values from the shared version
        // This preserves team assignments when the group's leader changes
        {
            private "_unit";
            _unit = _x;

            _unit assignTeam (_unit call ST_STHud_assignedTeam);
        } forEach(units(player));

        // While the unit remains the group leader, ensure all other team
        // members are using the values set locally.
        while {leader(player) == player} do {
            {
                private "_unit";
                _unit = _x;

                // Update the shared data if doesn't match the from the engine
                if (assignedTeam(_unit) != (_unit call ST_STHud_assignedTeam)) then
                {
                    _unit setVariable [HUD_ASSIGNEDTEAM, assignedTeam(_unit), true];
                };
            } forEach(units(player));
            sleep 5;
        };
    };
};

FN_TG_SQUAD_UI_MAPMARKERS = {
  private ["_marker","_markerNumber", "_markerName", "_getNextMarker",
            "_vehicle", "_str", "_txt"];

	_getNextMarker = {//Function to create or update position of the marker.
		private ["_marker"];

		_markerNumber = _markerNumber + 1;
		_marker = format["um%1",_markerNumber];

		if(getMarkerType _marker == "") then {
            createMarkerLocal [_marker, _this];
        }
		else {
            _marker setMarkerPosLocal _this;
        };

		_marker;
	};

	while {true} do { //The Main loop
		waitUntil {sleep 1;	(visibleMap or visibleGPS);};//wait until map or gps
		_markerNumber = 0;
        _ctrl = (findDisplay 12) displayCtrl 51;
        _zoom = ctrlMapScale _ctrl;

		_occupiedVics = [];
		{
			_vehicle = vehicle _x;

			if(_vehicle != _x) then	{//if the _x is in a vehicle create a list
				if (!(_vehicle in _occupiedVics)) then {_occupiedVics pushBack _vehicle;};
			}
			else {
				_pos = getPosATL _vehicle;
                _txt = name _x;
                if (_zoom > 0.05) then {_txt = "";};

				_marker = _pos call _getNextMarker;
				_colorName = "ColorBrown";
				_markerType = "mil_dot";
				_markerSize = 0.4;

				if ( _x in (units group player)) then {
					_markerType = "mil_dot";

					if (_x == leader player) then {
						_markerType = "mil_circle";
						_markerSize = 0.5;
					};

					switch (_x call ST_STHud_assignedTeam) do {
						case "MAIN":{_colorName = "Default";};
						case "RED": {_colorName = "ColorRed";};
						case "GREEN":{_colorName = "ColorGreen";};
						case "BLUE":{_colorName = "ColorBlue";};
						case "YELLOW":{_colorName = "ColorYellow";};
						default	{_colorName = "Default";}; //sometimes returns null
					};
				}
				else {
					if (_x == (leader group _x)) then {
						_markerType = "mil_box";
						_markerSize = 0.5;

                        if (_zoom > 0.05) then {_txt = format["[%1]", groupID (group _x)];}
                        else                   {_txt = format["%1 [%2]", name(leader _x), groupID (group _x)];};
					};
				};

				if(!visibleGPS || visibleMap) then  {_marker setMarkerTextLocal _txt;}
                else                                {_marker setMarkerTextLocal "";};

				_marker setMarkerColorLocal _colorName;
				_marker setMarkerTypeLocal _markerType;
				_marker setMarkerSizeLocal [_markerSize, _markerSize];
			};
		} forEach playableUnits;

		{
			_aVic = _x;
			_str = ""; _txt = "";

			{
				if(_foreachindex == ((count (crew (vehicle _x))) - 1)) then {
					_str = format["%1",name _x];
				}
				else {
					_str = format["%1, ",name _x];
				};
                _txt = _txt + _str;
			}forEach crew (_aVic);
            if (_zoom > 0.05) then {_txt = ""};

			_pos = getPosATL _aVic;
			_marker = _pos call _getNextMarker;
			if(!visibleGPS || visibleMap) then {
                _marker setMarkerTextLocal _txt;
            }
            else {
                _marker setMarkerTextLocal "";
            };

			_marker setMarkerColorLocal "ColorOrange";
			_marker setMarkerSizeLocal [0.7, 0.7];
			_marker setMarkerTypeLocal "n_inf";
		}forEach _occupiedVics;

		_markerNumber = _markerNumber + 1;
		_marker = format["um%1",_markerNumber];

		while {(getMarkerType _marker) != ""} do {
			deleteMarkerLocal _marker;
			_markerNumber = _markerNumber + 1;
			_marker = format["um%1",_markerNumber];
		};
	};
};

[] spawn ST_STHud_AssignedTeamWatcher;
[] spawn FN_TG_SQUAD_UI_MAPMARKERS;
