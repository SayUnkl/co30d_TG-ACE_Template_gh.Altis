_playerLivesLeft = ([player, 0] call BIS_fnc_respawnTickets);

if (_playerLivesLeft == 0) then
{
    systemChat "You have died your final time. Please spectate until the mission is over.";
	player setVariable ["isDead", true, true];
	[true] call ace_spectator_fnc_setSpectator;
    //check if all players are dead and end mission if necessary
    [] remoteExec ["TG_fnc_ifAllPlayersDead", 2];
} else {
	if (enableSavingLoadoutsOnDeath) then {[player, [missionnamespace, "VirtualInventory"]] call BIS_fnc_saveInventory;};
};