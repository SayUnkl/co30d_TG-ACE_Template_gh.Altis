/*************************************************************************************
initPlayerLocal.sqf                                                                 **
This is designed so you can change what you want to use in your mission by          **
changing the values at the top of the file above the indicated line.                **
**************************************************************************************/

/* <<<<start of a comment paragraph

USAGE NOTES
-----------
-Comments-----------------------------------------------------------------------------------------
Lines that begin with // are comments. So is this paragraph. These lines are to help you.

-Boolean Values-----------------------------------------------------------------------------------
If a variable indicates that its value is expected to be BOOLEAN, this means it can either be TRUE or FALSE.

-Array Values-------------------------------------------------------------------------------------
An array is a list of values separated by commas which are enclosed in square brackets.
Lets say I have 3 ammo boxes I've placed in the editor named ammobox, ammobox2 and ammobox3. 
To put them in an array I would use:

_myArrayName = [ammobox, ammobox2, ammobox3];

This could also be broken up on multiple lines to make it easier to read and edit:
_myArrayName = [  ammobox,
                  ammobox1,
                  ammobox2
               ];
*note there is no comma after the last value!

-Empty Array---------------------------------------------------------------------------------------
Lets say you are not going to use a class based arsenal as below. Then the array that stores the items must still
exist and it must be empty. To make the array empty you would do the following:

_objectsForClassBasedArsenal = [];
or
_objectsForClassBasedArsenal = [
                               
							   ];

-Last Tips----------------------------------------------------------------------------------------
Comment lines or paragraphs are not process by the game engine.
I'm using them here to give new mission makers some help in using this file.
The line below marks the end of this comment paragraph.
*/

//HEDGHOGS LOCALIZED, CLASS BASED BIS ARSENAL ON A LIST OF OBJECTS  ********************************************************
// set the line below to true to use it and add the boxes you want the arsenal to the array                               **
//edit the values for the variables below                                                                                **
//                                                                                                                        **
_useClassBasedArsenal = true;                                   //BOOLEAN - can be TRUE or FALSE
//                                                                                                                      //**
//if _useClassBasedArsenal  is FALSE then _set to be as: objectsForClassBasedArsenal = [];                                            /**
_objectsForClassBasedArsenal =  [	classBasedBox,
                                    supplyRepairTruck
                                ];              //all objects you place in the editor you want class based arsenals on  //**
//
//Now you must edit the functions\client\fn_ammo.sqf file to create your custom class based arsenal.                      **
/***************************************************************************************************************************/

//ACE INTERACTION OPTIONS   ***************************************************************************
//Reset TFR programming via ace self interaction                                                     **
//                                                                                                   **
_enableResetTFR = true;                                     //BOOLEAN - can be TRUE or FALSE
/******************************************************************************************************/

//SELF ACE ACTION - GET SR *****************************************************************************
//Add an option to get SR radio from self (radio bug work around where radios disappear in arsenal!)  **
//                                                                                                    **
_enableSelfRadioGetOption = true;                           //BOOLEAN - can be TRUE or FALSE
/*******************************************************************************************************/

//VIEW DISTANCE ENABLED ***************************************************************************
//Put View Distance Dialog On Ace Self Menu                                                      **
//                                                                                               **
_enableViewDistance = true;                                 //BOOLEAN - can be TRUE or FALSE
/**************************************************************************************************/

//GET RADIO OBJECTS *****************************************************************************
//Add Get Tfr Short Range & Long Radios To Listed Objects                                      **
_enableGetSROnObjects = true;                               //BOOLEAN - can be TRUE or FALSE
_enableGetLROnObjects = true;                               //BOOLEAN - can be TRUE or FALSE
//                                                                                             **
//if both _enableGetLROnObjects or _enableGetSROnObjects are false then _objectsForRadios = [];**
_objectsForRadios =  [	radioBox,
                       supplyRepairTruck
                     ]; //objects you place in editor                                        //**
/************************************************************************************************/

//DEFAULT TFR BACKPACK RADIO ************************************************************
//Set Task Force Radio default backpack long range radio classname for this mission	   **
//must be the class name of a TFR backpack radio                                       **
//Blufor might be "tf_rt1523g_green" or other variations                               **
//Opfor might be "tf_mr3000_rhs"                                                       **
//Independents usually use "tf_anprc155_coyote"                                        **
//                                                                                     **
tg_backpackRadio = "tf_rt1523g_green";
/****************************************************************************************/
						
//ENABLE TELEPORT TO SL	**********
//                              **
_enableTeleportToSL = true;
/*********************************/

//ENABLE ZUES ACCESS FOR PATHFINDERS ****************************
//Must Have Zeus Game Master Modules Named: Zeus & Zeus1       **
//                                                             **
_enablePFZeus = true;
/****************************************************************/

//ENABLE HEDGEHOGS BLUFOR TRACKER MAP MARKERS ***********
//                                                     **
_enableMapMarkers = true;
/********************************************************/

//HOW MANY PLAYER RESPAWNS DO YOU WANT TO ALLOW FOR EACH PLAYER *****
//**TG standard is value of 2 respawns   (this should be 3 lives)  **
//                                                                 **
_numberOfPlayerRespawns = 2;
/********************************************************************/

//FARP ACTION ON REPAIR STATIONS ********************************
//                                                             **
_enableFarpAction = true;
                                                             //**
//if _enableFarpAction is FALSE then _farpActionObjects = [];  **
_farpActionObjects = [                                       //**
                       repairDepot     //edit this line as needed
                     ];                                      //**
/****************************************************************/

//ENABLE RESTORING A PLAYERS LOADOUT ON RESPAWN BACK TO WHAT THEY HAD WHEN KILLED *******
//TRUE will restore a loadout as is when killed                                        **
//FALSE will restore a loadout that was provided on the start of the mission           **
//                                                                                     **
enableSavingLoadoutsOnDeath = true;
/****************************************************************************************/

//RESPAWN ON START HANDLING ******************************************************************************************
//if you set players to repspawn on start OR to run the repawn script on start then change the line below to true	**
//respawnOnStart = 0 or 1 in the description.ext == below must be true!!!!                                          **
//respawnOnStart = -1; in the description.ext the below should be false                                             **
//                                                                                                                  **
_playersWillRespawnOnStart = false;
/*********************************************************************************************************************/

//CLASS BASED HEAL ALL BOXES********************************************************************
//TRUE will allow the LAW medical boxes to have heal all actions otherwise                    **
// ... you can add this function by putting "this setVariable ["isHealingBox", TRUE, TRUE];"  **
// ... to any object to make it a Heal All object                                             **
_useClassBasedHealAll = false; //default is FALSE
/***********************************************************************************************/

//END OF EDITABLE MISSION MAKER VARIABLES
//ENTER ANY ADDITIONAL CODE YOU NEED IN THE SECTION BELOW






//YOUR CODE GOES ABOVE THIS LINE ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

//***********************************************************************************************************************************
//DO NOT EDIT BELOW THIS LINE unless you know what your doing
//***********************************************************************************************************************************

["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;
_TGbrief = []execVM "TG\TGbriefing.sqf";
_missionBriefing = []execVM "briefing.sqf";
player setVariable ["isDead", false, true];
[player, _numberOfPlayerRespawns] call BIS_fnc_respawnTickets;
_is_tfr_enabled_locally = isClass(configFile/"CfgPatches"/"task_force_radio");
_mssg = "";
if (_is_tfr_enabled_locally) then {
	_mssg = format ["%1 is running Task Force Radio", profileName];
} else {
	_mssg = format ["%1 is NOT running Task Force Radio", profileName];
};
_mssg remoteExec ["systemChat", 0, false];

//wait until player is boots on ground
sleep 1;

//TFAR settings
//_is_tfr_enabled_locally = isClass(configFile/"CfgPatches"/"task_force_radio");
if (_is_tfr_enabled_locally) then {
	player setVariable ["tf_globalVolume", 0.8];
	//reprogramRadios when SR is issued
	["TGRadioID", "OnRadiosReceived", {[true, false, true] spawn TG_fnc_reprogramRadios;}, player] call TFAR_fnc_addEventHandler;
	[nil, player] spawn TG_fnc_getShortRadio;//add short range for all
};

//respawnOnStart handling
if (_playersWillRespawnOnStart) then {
	playerSpawns = -1;
	//onPlayerRepawn.sqf is not going to run so we can wait for radios to save loadout
	[] spawn {
		sleep 10; //wait until radio have been assigned!
		//Saved Loadouts
		[player, [missionnamespace, "VirtualInventory"]] call BIS_fnc_saveInventory;
	}; //spawn
} else {
	playerSpawns = 0;
	//onPlayerRespawn.sqf is going to run and try to load the saved inventory so it can't wait for radios to be assigned. 
	//this may require the mission maker to test and work around fyi!
	[player, [missionnamespace, "VirtualInventory"]] call BIS_fnc_saveInventory;
};

//set a variable to record the side of this player as when incapacitated you may be set to civilian side
player setVariable ["sideOfThisPlayer", side player, true];
//systemChat format ["You are on the %1 side.", sideOfThisPlayer];


//ACE self interaction items
//Reset TFR
//create radio sub-menu under equipment
if (_is_tfr_enabled_locally) then {
	if (_enableResetTFR || _enableSelfRadioGetOption) then {
		_tgRadioActions = ["tg_radioMenu", "TG Radios", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\radio_ca.paa", {}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _tgRadioActions] call ace_interact_menu_fnc_addActionToObject;
	};
	//Reset Radio menu items
	if (_enableResetTFR) then {
		_actionBoth = ["tg_radioSelfAction", "Reset Radios", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\radio_ca.paa", {[true, true, false] spawn TG_fnc_reprogramRadios;}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions", "ACE_Equipment", "tg_radioMenu"], _actionBoth] call ace_interact_menu_fnc_addActionToObject;
		
		_actionSR = ["tg_radioSelfAction", "Reset SR", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\radio_ca.paa", {[true, false, false] spawn TG_fnc_reprogramRadios;}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions", "ACE_Equipment", "tg_radioMenu"], _actionSR] call ace_interact_menu_fnc_addActionToObject;
		
		_actionLR = ["tg_radioSelfAction", "Reset LR", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\radio_ca.paa", {[false, true, false] spawn TG_fnc_reprogramRadios;}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions", "ACE_Equipment", "tg_radioMenu"], _actionLR] call ace_interact_menu_fnc_addActionToObject;
	};
	//Get TFR self action
	if (_enableSelfRadioGetOption) then {
		_action = ["tg_getRadioSelfAction", "Get SR", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\radio_ca.paa", {[player, player] spawn TG_fnc_getShortRadio;}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions", "ACE_Equipment", "tg_radioMenu"], _action] call ace_interact_menu_fnc_addActionToObject;
	};
} else {
	//give a self action that will give TeamSpeak details to player without TFAR
	_action = ["tg_getRadioSelfAction", "TG TeamSpeak", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\radio_ca.paa", {player  addItem "itemRadio"; player assignItem "itemRadio"; player vehicleChat "Join us on TeamSpeak. ts.tacticalgamer.com:9988"; hint "We are using Task Force Radio on our TeamSpeak. Join us.";}, {true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "ACE_Equipment", "tg_radioMenu"], _action] call ace_interact_menu_fnc_addActionToObject;

};// if _is_tfr_enabled_locally

//View Distance action
if (_enableViewDistance) then {
	_action3 = ["tg_chvd", "View Distance", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\scout_ca.paa", {chvd = [] spawn CHVD_fnc_openDialog;}, {true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions"], _action3] call ace_interact_menu_fnc_addActionToObject;
};

//ACE other interaction items
if (_is_tfr_enabled_locally) then {
	{
		if (_enableGetSROnObjects) then {
			_action1 = ["tg_radiosSRAction", "Get SR", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\radio_ca.paa", {[_target, player] spawn TG_fnc_getShortRadio;}, {true}] call ace_interact_menu_fnc_createAction;
			[_x, 0, ["ACE_MainActions"], _action1] call ace_interact_menu_fnc_addActionToObject;
		};
		if (_enableGetLROnObjects) then {
			_action2 = ["tg_radiosLRAction", "Get LR", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\radio_ca.paa", {[_target, player] spawn TG_fnc_getLongRadio;}, {true}] call ace_interact_menu_fnc_createAction;
			[_x, 0, ["ACE_MainActions"], _action2] call ace_interact_menu_fnc_addActionToObject;
		};
	} forEach _objectsForRadios;
} else {
	//if a player doesn't have TFAR running and they use this function they will get a regular radio and a notification.
	{
		_action2 = ["tg_radiosLRAction", "Get A Radio", "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\radio_ca.paa", {player  addItem "itemRadio"; player assignItem "itemRadio"; player vehicleChat "Join us on TeamSpeak. ts.tacticalgamer.com:9988";}, {true}] call ace_interact_menu_fnc_createAction;
		[_x, 0, ["ACE_MainActions"], _action2] call ace_interact_menu_fnc_addActionToObject;
	} forEach _objectsForRadios;
};
	
//hedghogs localized class based arsenal
if (_useClassBasedArsenal) then {
	{
		[_x] call TG_fnc_ammo;
	} forEach _objectsForClassBasedArsenal;
};
	
//reprogram radio notifications when ACE arsenal is closed
["ace_arsenal_displayClosed",{systemChat "Check your radio programming!!";}] call CBA_fnc_addEventHandler;
["ace_arsenal_displayOpened",{systemChat "Welcome to the TG Arsenal.";}] call CBA_fnc_addEventHandler;
//BIS arsenal reprogram long range radio notification
[ missionNamespace, "arsenalClosed",{systemChat "Check your radio programming!!";}] call BIS_fnc_addScriptedEventHandler;

//Teleport To Squad Leader
if (_enableTeleportToSL) then {
	[] spawn TG_fnc_teleportToSL;
};

//Pathfinder Zeus Access //edited by Roque_THE_GAMER
if (_enablePFZeus) then {
	call TG_fnc_zeusAddAction;
};

//Player Blufor Tracker by hedgehog
if (_enableMapMarkers) then {
	[] spawn TG_fnc_squadUI;
};

//FARP Actions
if (_enableFarpAction) then {
	{
	_action = _x addaction ["Repair All",{
	params ["_target", "_caller", "_actionId", "_arguments"];
	[_target] spawn TG_fnc_farpAction;
	},
    [],
    1, 
    true, 
    true, 
    "",
    "true",
    3,
    false,
    "",
    ""
	];
	_x setUserActionText [_action , "Repair all vehicles around you", "<img size='2' image='\a3\ui_f\data\IGUI\Cfg\Actions\repair_ca' color='#FFFFFF'/>"];
	
	} forEach _farpActionObjects;
};


//Roque's Heal all players boxes
if (_useClassBasedHealAll) then {
	[true] call TG_fnc_healAllBox;
} else {
	[false] call TG_fnc_healAllBox;
};
