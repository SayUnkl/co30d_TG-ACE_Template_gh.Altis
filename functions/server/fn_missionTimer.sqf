//Mission Timer Script by |TG189| Unkl for TacticalGamer.com
//mission timer runs on server only 
if !(isServer) exitWith {};

_timeInMinutesForMissionToEnd = 75;
_timeInSeconds = _timeInMinutesForMissionToEnd * 60;
_thirtyMinuteWarningMssg = "There is 30 minutes left to complete the mission.";
_tenMinuteWarningMssg = "There is only ten minutes to complete the mission.";
_fiveMinuteWarningMssg = "There is only five minutes to complete the mission.";
_thirtyMinuteTime = _timeInSeconds - 1800;
//_tenMinTime = _timeInSeconds - 600;

sleep _thirtyMinuteTime;
_thirtyMinuteWarningMssg remoteExec ["Hint", 0, false];

sleep 1200;
_tenMinuteWarningMssg remoteExec ["Hint", 0, false];

sleep 300;
_fiveMinuteWarningMssg remoteExec ["Hint", 0, false];

waitUntil {time > _timeInSeconds};
"End3" call BIS_fnc_endMissionServer;