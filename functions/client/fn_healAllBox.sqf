if (!isNil {_this select 0}) then {
	_useClassBasedHealAll = _this select 0;
} else {
	_useClassBasedHealAll = false;
};

_boxes = [];
_moreHeaLBoxes = ((entities "") select {_x getVariable "IsHealingBox"});
if (_useClassBasedHealAll) then {
	_classBoxes = entities [["Box_C_IDAP_UAV_06_medical_F","Box_B_UAV_06_medical_F","Box_C_UAV_06_medical_F","Box_O_UAV_06_medical_F","Box_I_UAV_06_medical_F"], [], false, false];
	_boxes = _boxes + _classBoxes;
};
if (count _moreHealBoxes > 0) then {
	_boxes = _boxes + _moreHeaLBoxes;
};
if (count _boxes == 0) exitWith {};

{
_action = _x addaction ["Heal All players from ACE",{
player playAction "medic";
_PlayesInRange = allPlayers inAreaArray [(getPosATL player), 25, 25, 0, false, 10];
_playernames = "";
{_playernames = (name _x) + "," + _playernames} forEach _PlayesInRange;
systemChat format ["Players in range: %1",_playernames];
[[player],{
systemChat format ["You got fully healed by %1", (name (_this select 0))];
[objNull, player] call ace_medical_fnc_treatmentAdvanced_fullHealLocal;
}] remoteExec ["call",_PlayesInRange];
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
_x setUserActionText [_action , "Heal All players in 25 metters around you", "<img size='2' image='\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca' color='#0015FF'/>"];
} forEach _boxes;