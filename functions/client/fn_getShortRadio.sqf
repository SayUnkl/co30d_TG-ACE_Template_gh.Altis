//Get Short Radio Script by |TG189| Unkl for TacticalGamer.com
_caller = _this select 1;
_callerSide = side player;
if !(player getVariable "sideOfThisPlayer" isEqualTo "") then {_callerSide = player getVariable "sideOfThisPlayer";};

_srRadio = "tf_rf7800st"; //default rifleman radio for blufor
if (_callerSide == WEST) then {_srRadio = "tf_anprc152";};
if (_callerSide == INDEPENDENT) then {_srRadio = "tf_anprc148jem";};
if (_callerSide == EAST) then {_srRadio = "tf_fadak";};

_caller addItem _srRadio;
_caller assignItem _srRadio;

//systemChat format ["Your short range radio is a: %1", _srRadio];

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