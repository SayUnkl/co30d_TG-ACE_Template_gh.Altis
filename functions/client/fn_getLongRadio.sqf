//Get Long Radio Script by |TG189| Unkl for TacticalGamer.com
//saving of backpack contents added by hedgehog

_caller = _this select 1;
_backpackcontents = [];

_backpack = backpack player;
if (_backpack != "" && _backpack != "B_Parachute" ) then {
	_backpackcontents = backpackItems player;	
	removeBackpack _caller;
};
if (isNil "tg_backpackRadio") then {
	tg_backpackRadio = "tf_rt1523g_big";
	if (side player == WEST) then {tg_backpackRadio = "tf_rt1523g_green"};
	if (side player == INDEPENDENT) then {tg_backpackRadio = "tf_anprc155_coyote";};
	if (side player == EAST) then {tg_backpackRadio = "tf_mr3000_rhs";};
}; //set default if not set in initPlayerLocal.sqf
_caller addBackpack tg_backpackRadio; //this is set in initPlayerLocal.sqf

if ( _backpack != "" && _backpack != "B_Parachute" ) then {	
	clearAllItemsFromBackpack player;
	{player addItemToBackpack _x } foreach _backpackcontents;
};

systemChat "A long range radio backpack has replaced your backpack.";
[false, true, true] spawn TG_fnc_reprogramRadios;

/*
TASK FORCE RADIOS CLASSNAMES AND USES

Classname,			Side,			SR,		LR,		Airborne,
tf_anarc164,		Independent,	,		Y,		Y,
tf_anarc210,		Blufor,			,		Y,		Y,
tf_anprc155,		Independent,	,		Y,		,
tf_anprc155_coyote,	Independent,	,		Y,		,
tf_bussole,			Opfor,			,		,		,	??
tf_mr3000,			Opfor,			,		Y,		,
tf_mr3000_bwmod,	Opfor,			,		Y,		,
tf_mr3000_bwmod_tropen,	Opfor,		,		Y,		,
tf_mr3000_multicam,	Opfor,			,		Y,		,
tf_mr3000_rhs,		Opfor,			,		Y,		,
tf_mr6000l,			Opfor,			,		Y,		Y,
tf_rt1523g,			Blufor,			,		Y,		,
tf_rt1523g_big,		Blufor,			,		Y,		,
tf_rt1523g_big_bwmod,	Blufor,		,		Y,		,
tf_rt1523g_big_bwmod_tropen,Blufor,	,		Y,		,
tf_rt1523g_big_rhs,	Blufor,			,		Y,		,
tf_rt1523g_black,	Blufor,			,		Y,		,
tf_rt1523g_bwmod,	Blufor,			,		Y,		,
tf_rt1523g_fabric,	Blufor,			,		Y,		,
tf_rt1523g_green,	Blufor,			,		Y,		,
tf_rt1523g_rhs,		Blufor,			,		Y,		,
tf_rt1523g_sage,	Blufor,			,		Y,		,
tf_microdagr,		TFAR Radio Programmer,,,,
tf_anprc148jem,		Independent,	Y,		,		,
tf_anprc152,		Blufor,			Y,		,		,
tf_anprc154,		Independent,	Y,		,		,
tf_fadak,			Opfor,			Y,		,		,
tf_pnr1000a,		Opfor,			Y,		,		,
ItemRadio,			Vanilla,,,,
tf_rf7800st,		Blufor ,		Y,		,		,
/*