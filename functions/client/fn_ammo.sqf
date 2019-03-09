/***************************************************
Role based restricted arsenal by hedgehog.
The class based ammobox is created on client side.
Usage: [ammobox] call TG_fnc_ammo;
where ammobox is an editor object name.
****************************************************/

/*****************************************************************************
TODO for mission makers to customize this script for your mission:
1. Change the classnames for the roles as it is for your mission
			EX: _medics = ["B_medic_F"]
2. Add weapons, magazines in the correct array. You may also delete certain arrays or combine them
But in the end there needs to be four different arrays:
		I. 		_magazines
		II. 	_items
		III. 	_weapons
		IV. 	_backpacks
All these other arrays are doing is organizing different items which eventually becomes part of one of the above four arrays.

Role based restriction happens in the switch statement. If the role is medic then only certain items are added to their _items array. etc...
*****************************************************************************/
//+++++++++++++++++++++++++++++CONFIG+++++++++++++++++++++++++++++++++++++++++

/******************************************************
Weapons: Classnames for the weapons to be in the arsenal.
In Arsenal you may export to get the classnames of wepaons.
*******************************************************/
_rifles = ["arifle_MX_Black_F",	"arifle_MXC_Black_F"];
_gls = ["arifle_MX_GL_Black_F", "arifle_MX_GL_F"];
_autorifles = ["arifle_MX_SW_Black_F",	"arifle_MX_SW_F"];
_dmrs = ["arifle_MXM_Black_F", "arifle_MXM_F"];

_lats = ["launch_NLAW_F",	"launch_MRAWS_sand_rail_F"];
_pistols = ["hgun_P07_F", "hgun_Pistol_heavy_01_F"];
_binoc = ["Binocular"];
_rangefinder = ["Rangefinder"];

/******************************************************
Scopes and sights: Classnames for the different sights.
Might be useful when limiting high powered scopes to
sniper roles only.
*******************************************************/
_sights 	= ["optic_Holosight_blk_F", "optic_Holosight", "optic_Aco"];
_optics 	= ["optic_Hamr", "optic_ERCO_blk_F", "optic_ERCO_snd_F"];
_dmss	= ["optic_DMS", "optic_AMS", "optic_AMS_snd", "optic_NVS"];

_medikit = ["Medikit"];
_toolkit = ["ToolKit"];

_helmets = ["H_Watchcap_blk", "H_Bandanna_mcamo", "H_HelmetSpecB"];
_crewHelmets = ["H_HelmetCrew_B"];

_vests = ["V_PlateCarrier1_rgr", "V_PlateCarrier2_rgr"];

_vestsLight = ["V_BandollierB_rgr", "V_Rangemaster_belt"];

/*******************************************************
Items to be in the restricted arsenal.
Silencers, bipods, gun attachements, facewear, combat uniforms,
mic items, nvgs, maps, gps, etc...
*******************************************************/
_items   = ["muzzle_snds_H",
			"muzzle_snds_H_khk_F",

			"bipod_01_F_snd",
			"bipod_01_F_blk",

			"acc_flashlight",
			"acc_pointer_IR",

			"acc_flashlight_pistol",
			"optic_MRD",

			"G_Balaclava_blk",
			"G_Balaclava_combat",

			"U_B_CombatUniform_mcam",
			"U_B_CombatUniform_mcam_tshirt",

			"ItemMap",
			"ItemRadio",
			"ItemWatch",
			"ItemCompass",
			"ItemGPS",
			//ace specific items.
			"ACE_fieldDressing", "ACE_bloodIV", "ACE_bloodIV_250", "ACE_bloodIV_500", "ACE_bodyBag",
			"ACE_CableTie", "ACE_DefusalKit", "ACE_EarPlugs", "ACE_EntrenchingTool", "ACE_epinephrine",
			"ACE_HuntIR_monitor", "ACE_Kestrel4500", "ACE_M26_Clacker",	"ACE_Clacker", "ACE_Flashlight_XL50",
			"ACE_MapTools", "ACE_microDAGR", "ACE_morphine", "MineDetector", "ACE_RangeCard", "ACE_Sandbag_empty",
			"ACE_SpottingScope", "ACE_Tripod", "ACE_UAVBattery", "ACE_wirecutter",

			"NVGoggles"];

//Magazines to be available in the restricted arsenal. Add classnames for the magazines to be avaiable in the arsenal.
_magazines =["30Rnd_65x39_caseless_mag",
			"30Rnd_65x39_caseless_mag_Tracer"];

//Different backpacks separated to allow certain roles bigger backpacks
_legpacks = ["B_LegStrapBag_coyote_F"];
_backpacksLight = ["B_AssaultPack_mcamo", "B_AssaultPack_rgr", "B_AssaultPack_Kerry"];
_backpacksMedium = ["B_Kitbag_mcamo", "B_Kitbag_rgr"];
_backpacksHeavy = ["B_Bergen_mcamo_F", "B_Carryall_mcamo"];

//Bare minimum allowed gears for everybody
_weapons = _rifles + _pistols + _binoc; //everybody gets rifles, pistols and binocs. Lists defined previously
_backpacks = _legpacks; //everybody at least has legpacks as available backpack in the arsenal

/******************************************************
Roles: Classnames for the roles. In Eden editor place
down a unit and right click and log classes to get the
classname. If you delete one of these arrays, make sure to
delete the switch case as well.
*******************************************************/
_medics		= ["B_medic_F"]; //if needed change the classname to the model you are using for the medics
_engis    	= ["B_soldier_repair_F", "B_engineer_F"];//if needed change the classname to the model you are using for the engineers
_marksmen 	= ["B_soldier_M_F"];//if needed change the classname to the model you are using for the marksmen
_crewmen  	= ["B_crew_F", "B_Helipilot_F"];//if needed change the classname to the model you are using for the crewmen
_leaders	= ["B_Soldier_SL_F", "B_Soldier_TL_F", "B_officer_F"];//if needed change the classname to the model you are using for the leaders
_grenadier 	= ["B_Soldier_GL_F"];//if needed change the classname to the model you are using for the grenadiers
_ars 		= ["B_soldier_AR_F"];//if needed change the classname to the model you are using for the ars
_lat		= ["B_soldier_LAT_F", "B_soldier_LAT2_F"];//if needed change the classname to the model you are using for the light ats
_mule		= ["B_Soldier_A_F"];//if needed change the classname to the model you are using for the ammo bearers

/******************************************************
Add items as you see fit in the following switch statement
There are four lists that must be constructed
	1. _items
	2. _backpacks
	3. _weapons
	4. _magazines
*******************************************************/
_type = typeOf player;
switch (true) do
{
	case (_type IN _medics): //What gear should the medics have
	{
		_items = _items + _sights + _medikit + _helmets + _vests;
		_backpacks = 	_backpacksLight + _legpacks;
	};

	case (_type IN _engis): //What gear should the engineers be able to acces
	{
		_items = _items + _sights + _toolkit + _helmets + _vests;;
		_backpacks = 	_backpacksLight + _legpacks;
	};

	case (_type IN _marksmen): //What gear should the marksmen be able to access
	{
		_weapons = _dmrs + _pistols + _rangefinder + _binoc;
		_items = _items + _dmss + _helmets + _vests;
	};
	case (_type IN _crewmen):
	{
		_items = _items + _sights + _crewHelmets + _vestsLight;
		_backpacks = [];
	};
	case (_type IN _leaders):
	{
		_weapons = _rifles + _gls + _pistols + _rangefinder + _binoc;
		_items = _items + _sights + _optics + _helmets + _vests;;
	};
	case (_type IN _grenadier):
	{
		_weapons = _gls + _pistols + _binoc;
		_items = _items + _sights + _helmets + _vests;
	};
	case (_type IN _ars):
	{
		_weapons = _autorifles + _pistols + _binoc;
		_items = _items + _sights + _helmets + _vests;
	};
	case (_type IN _lat):
	{
		_weapons = _rifles + _pistols + _binoc + _lats;
		_items = _items + _sights + _helmets + _vests;
		_backpacks = _backpacksLight + _legpacks + _backpacksMedium;
	};
	case (_type IN _mule):
	{
		_items = _items + _sights + _helmets + _vests;
		_backpacks = _backpacksHeavy;
	};
    default {false};
};

//++++++++++++++++++++++++++++DO NOT EDIT BELOW THIS LINE++++++++++++++++++++++++++++++++++++++
_obj = _this select 0;

_obj removeAction (_obj getVariable ["bis_fnc_arsenal_action", 0]);

//Remove everything from the _obj
[_obj, [_obj] call BIS_fnc_getVirtualBackpackCargo] call BIS_fnc_removeVirtualBackpackCargo;
[_obj, [_obj] call BIS_fnc_getVirtualItemCargo] call BIS_fnc_removeVirtualItemCargo;
[_obj, [_obj] call BIS_fnc_getVirtualMagazineCargo] call BIS_fnc_removeVirtualMagazineCargo;
[_obj, [_obj] call BIS_fnc_getVirtualWeaponCargo] call BIS_fnc_removeVirtualWeaponCargo;

//Add the new ones to the object
[_obj, _backpacks] call BIS_fnc_addVirtualBackpackCargo;
[_obj, _items] call BIS_fnc_addVirtualItemCargo;
[_obj, _magazines] call BIS_fnc_addVirtualMagazineCargo;
[_obj, _weapons] call BIS_fnc_addVirtualWeaponCargo;

_action = _obj addaction [
	"Arsenal",
	{
		_box = _this select 0;
		_unit = _this select 1;
		["Open",[nil,_box]] call bis_fnc_arsenal;
	},
	[],
	6,
	true,
	false,
	"",
	"
		_cargo = _target getvariable ['bis_addVirtualWeaponCargo_cargo',[[],[],[],[]]];
		if ({count _x > 0} count _cargo == 0) then {
			_target removeaction (_target getvariable ['bis_fnc_arsenal_action',-1]);
			_target setvariable ['bis_fnc_arsenal_action',nil];
		};
		_condition = _target getvariable ['bis_fnc_arsenal_condition',{true}];
		alive _target && {_target distance _this < 8} && {call _condition}
	"
];
_obj setVariable ["bis_fnc_arsenal_action", _action];
