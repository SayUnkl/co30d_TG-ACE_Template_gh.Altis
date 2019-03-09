//If All Players Dead Script by |TG189| Unkl for TacticalGamer.com
if !(isServer) exitWith {};

_playersToCheck = allPlayers - entities "HeadlessClient_F";
_numberOfPlayers = count _playersToCheck;
if (_numberOfPlayers < 1) then {_numberOfPlayers = 1;};  //playableUnits sometimes returns 0 while respawn is in progress
_numberOfPlayersDeadAndOutOfRespawns = 0;

{
	if (_x getVariable "isDead") then {
		if (!alive _x) then {
			_numberOfPlayersDeadAndOutOfRespawns = _numberOfPlayersDeadAndOutOfRespawns + 1;
		};
	};
} forEach _playersToCheck;

if (_numberOfPlayers <= _numberOfPlayersDeadAndOutOfRespawns) then {
	"Mission failed." remoteExec ["Hint", 0, false];
	[false] remoteExec ["ace_spectator_fnc_setSpectator", -2, false];
	sleep 10;
	"End2" call BIS_fnc_endMissionServer;
	_run = false;
};
