//FARP Action Script By Roque_THE_GAMER
//adapted by |TG189| Unkl for TacticalGamer.com
//USAGE: [_repairObject] spawn TG_fnc_farpAction;
player playAction "PutDown";

_repairObject = _this select 0;
_Caller = player;
//addapted to execute on server
[[_repairObject, _Caller], TG_fnc_farpProcessing] remoteExec ["spawn", 2, false];//passed the work to the server