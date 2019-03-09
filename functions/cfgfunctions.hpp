class TG
{
	tag = "TG";	
	class client
	{
		file = "functions\client";				
		class getShortRadio {};
		class getLongRadio {};
		class teleportToSL {};
		class reprogramRadios {};
		class squadUI {};
		class ammo {};
		class farpAction {};
		class healAllBox {};
	};
	
	class server
	{
		file = "functions\server";
		class vehicleRespawn {};
		class assetMarkers {};
		class zeusAddAction {};
		class TgAceArsenal {};
		class missionTimer {};
		class ifAllPlayersDead {};
		class ambientAirTraffic {};
		class farpProcessing {};
	};
};