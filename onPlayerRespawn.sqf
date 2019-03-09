if (time < 10) then {sleep .2;}; //add delay for when this script will run at the start of a mission
_playerLivesLeft = [player, 0] call BIS_fnc_respawnTickets;
																  

playerSpawns = playerSpawns + 1;
if (playerSpawns >= 1) then {
	sleep .2;
	[player, [missionnamespace, "VirtualInventory"]] call BIS_fnc_loadInventory;
};

if (_playerLivesLeft > 0) then {
	systemChat format ["You only have %1 respawns left.", _playerLivesLeft];
} else {
	systemChat "You have no additional lives left! Be careful!";
	[] spawn {
		waitUntil {!alive player};
		player setVariable ["playerRespawnsLeft", -1, true];
		systemChat "You have died your final time. You are now a spectator.";
		sleep 2;
		player setVariable ["isDead", true, true];
		[] remoteExec ["TG_fnc_ifAllPlayersDead", 2, false];
	};
};