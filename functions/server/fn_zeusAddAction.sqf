//Zues Add Actions Script by hedgehog with edits by |TG189| Unkl for TacticalGamer.com
//Must have a zeus modules named zeus & zeus1 in the editor
TGZ_FNC_PlayerActions = 
{
	player addAction ["<t color='#0000cd'>Log in as ZEUS</t>", "call TGZ_FNC_handleAction", ["action_login"], -91, false, true, "", "call TGZ_FNC_CheckLogInAction"];
	player addAction ["<t color='#bebebe'>Log out of ZEUS</t>", "call TGZ_FNC_handleAction", ["action_logout"], -92, false, true, "", "call TGZ_FNC_CheckLogOutAction"];
	
	player addAction ["<t color='#686959'>Log in as assistant zeus</t>", "call TGZ_FNC_handleAction", ["action_login1"], -93, false, true, "", "call TGZ_FNC_CheckLogInAction1"];
	player addAction ["<t color='#bebebe'>Log out of assistant zeus</t>", "call TGZ_FNC_handleAction", ["action_logout1"], -94, false, true, "", "call TGZ_FNC_CheckLogOutAction1"];
};

TGZ_FNC_handleAction = 
{
	private ["_params", "_action"];

	// Parameters passed by the action
	_params = _this select 3;
	_action = _params select 0;

	////////////////////////////////////////////////
	// Handle actions
	////////////////////////////////////////////////
	if (_action == "action_login") then
	{
		[player, zeus] remoteExec ["assignCurator",2];
	};

	if (_action == "action_logout") then
	{
		zeus remoteExec ["unassignCurator",2];
	};
	
	if (_action == "action_login1") then
	{
		[player, zeus1] remoteExec ["assignCurator",2];
	};

	if (_action == "action_logout1") then
	{
		zeus1 remoteExec ["unassignCurator",2];
	};
};

TGZ_FNC_CheckLogInAction = 
{
	_return = false;	
	if (player != getAssignedCuratorUnit zeus && player != getAssignedCuratorUnit zeus1 && isNull (getAssignedCuratorUnit zeus)) then {_return = true};
	_return
};

TGZ_FNC_CheckLogOutAction = 
{
	_return = false;
	if (player == getAssignedCuratorUnit zeus) then {_return = true;};	
	_return
};

TGZ_FNC_CheckLogInAction1 = 
{
	_return = false;	
	if (player != getAssignedCuratorUnit zeus1 && player != getAssignedCuratorUnit zeus && isNull (getAssignedCuratorUnit zeus1)) then {_return = true};
	_return
};

TGZ_FNC_CheckLogOutAction1 = 
{
	_return = false;
	if (player == getAssignedCuratorUnit zeus1) then {_return = true;};	
	_return
};

[] spawn 
{
    waitUntil { !isNull player };	
	_UID = getPlayerUID player;
	_isHost = false;
	
	tgZeus = [];
	if (isServer && hasInterface) then {
	  tgZeus = [_UID];
	  systemChat "Local host detected. Zeus access is enabled for server host.";
	} else {
	  "\TG_Scripts\tgZeus.sqf" remoteExec ["execVM",2,false];
	};
	waitUntil {count tgZeus > 0}; //ensure wait for broadcast from server list
	if !(_UID in tgZeus) exitWith{}; //exit on all other clients.		
	
	[] spawn TGZ_FNC_PlayerActions;

	// Event Handlers
	player addEventHandler 
	[
		"Respawn", 
		{			
			[] spawn TGZ_FNC_PlayerActions;
		}
	];
};