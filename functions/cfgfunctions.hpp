class TG
{
	tag = "TG";	
	class client
	{
		file = "functions\client";				
		class teleportToSL {};
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
		class missionTimer {};
		class ifAllPlayersDead {};
		class ambientAirTraffic {};
		class farpProcessing {};
	};
};