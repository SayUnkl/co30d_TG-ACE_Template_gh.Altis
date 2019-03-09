//TG ACE Arsenal Script by hedgehog & |TG189| Unkl for TacticalGamer.com
//contributions by |TG189| DMZ Scout and many more on the items and bug fixing
//usage
//[boxToLoadUp] call TG_fnc_TGArsenal;

if !(isServer) exitWith {};
_box = _this select 0;

_weapons = 	["rhs_weap_hk416d10_m320","rhs_weap_hk416d10_LMT","rhs_weap_hk416d10_LMT_d","rhs_weap_hk416d145","rhs_weap_hk416d145_m320",				"rhs_weap_hk416d145_d","rhs_weap_m240B","rhs_weap_m240G","rhs_weap_m249",
			"rhs_weap_m249_pip_L","rhs_weap_m249_pip_S","rhs_weap_m27iar","rhs_weap_m27iar_grip","rhs_weap_m4a1_blockII",		"rhs_weap_m4a1_blockII_bk","rhs_weap_m4a1_blockII_M203_bk","rhs_weap_m4a1_blockII_d",
			"rhs_weap_m4a1_blockII_M203_d","rhs_weap_m4a1_blockII_M203","rhs_weap_m4a1_m320","rhs_weap_M590_8RD","rhs_weap_M590_5RD","rhs_weap_mk18_bk","rhs_weap_mk18_d","rhs_weap_mk18_m320",
            "rhs_weap_mk18_KAC_d","rhs_weap_mk18_KAC_bk","srifle_EBR_F","rhs_weap_m4a1_m203s_d","rhs_weap_m4a1","rhs_weap_m4a1_d","rhs_weap_m4a1_m203","rhs_weap_m4a1_m203s","rhs_weap_m4a1_blockII_KAC_d",
            "rhs_weap_m4a1_blockII_KAC_bk","rhs_weap_m249_pip_S_para","rhs_weap_m249_pip_L_para","rhs_weap_m14ebrri", "rhs_weap_sr25","rhs_weap_sr25_d"];

_magazines =	["rhs_mag_M441_HE","rhs_mag_M433_HEDP","rhs_mag_M397_HET","ACE_HuntIR_M203","rhs_mag_m4009","rhs_mag_maaws_HEAT",				"rhs_mag_maaws_ILLUM","rhs_mag_maaws_HEDP",
				"rhs_mag_maaws_SMOKE","rhs_mag_maaws_HE","Laserbatteries","rhs_LaserMag","rhs_LaserFCSMag","LOP_LaserMag","rhsusf_8Rnd_Slug","rhsusf_8Rnd_00Buck","rhsusf_5Rnd_Slug",
				"rhsusf_5Rnd_00Buck","1Rnd_HE_Grenade_shell","rhs_mag_30Rnd_556x45_Mk318_PMAG_Tan","rhs_mag_30Rnd_556x45_Mk318_PMAG","rhs_mag_30Rnd_556x45_Mk262_PMAG_Tan",
				"rhs_mag_30Rnd_556x45_Mk262_PMAG","rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan_Tracer_Red","rhs_mag_30Rnd_556x45_M855A1_PMAG_Tracer_Red","rhs_mag_30Rnd_556x45_M855_PMAG_Tan_Tracer_Red",
				"rhs_mag_30Rnd_556x45_M855_PMAG_Tracer_Red","rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan","rhs_mag_30Rnd_556x45_M855A1_PMAG","rhs_mag_30Rnd_556x45_M855_PMAG",
				"rhs_mag_30Rnd_556x45_M855_PMAG_Tan","rhsusf_mag_17Rnd_9x19_JHP","rhsusf_mag_17Rnd_9x19_FMJ","rhsusf_mag_15Rnd_9x19_JHP","rhsusf_mag_15Rnd_9x19_FMJ","rhsusf_20Rnd_762x51_m62_Mag",
				"rhsusf_20Rnd_762x51_m118_special_Mag","rhsusf_20Rnd_762x51_m993_Mag","rhs_mag_m576","rhs_mag_M585_white","rhs_mag_m661_green","rhs_mag_m662_red","rhs_mag_m713_Red","rhs_mag_m714_White",
				"rhs_mag_m715_Green","rhs_mag_m716_yellow","rhsusf_200rnd_556x45_mixed_box","rhsusf_200rnd_556x45_M855_mixed_box","rhsusf_100Rnd_762x51_m80a1epr",
				"rhsusf_100Rnd_762x51_m62_tracer","rhsusf_100Rnd_556x45_mixed_soft_pouch","rhsusf_100Rnd_556x45_M855_mixed_soft_pouch","rhsusf_100Rnd_762x51_m61_ap",
				"rhsusf_mag_7x45acp_MHP","ACE_20Rnd_762x51_Mag_Tracer","ACE_20Rnd_762x51_Mag_SD","20Rnd_762x51_Mag", 
				"rhsusf_20Rnd_762x51_SR25_m62_Mag","rhsusf_20Rnd_762x51_SR25_m118_special_Mag","rhsusf_20Rnd_762x51_SR25_m993_Mag",
				"rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", "rhs_mag_30Rnd_556x45_M855_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red",
				"rhs_mag_30Rnd_556x45_Mk318_Stanag", "rhs_mag_30Rnd_556x45_Mk262_Stanag", "rhs_mag_30Rnd_556x45_M200_Stanag", "rhs_mag_100Rnd_556x45_M855A1_cmag", 
				"rhs_mag_100Rnd_556x45_M855A1_cmag_mixed", "rhs_mag_100Rnd_556x45_M855_cmag", "rhs_mag_100Rnd_556x45_M855_cmag_mixed", "rhs_mag_100Rnd_556x45_Mk318_cmag", 
				"rhs_mag_100Rnd_556x45_Mk262_cmag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag_Tracer_Red", "30Rnd_556x45_Stanag_Tracer_Green", "30Rnd_556x45_Stanag_Tracer_Yellow",
				"rhsusf_mag_7x45acp_MHP", "rhsusf_50Rnd_762x51", "rhsusf_50Rnd_762x51_m61_ap", "rhsusf_100Rnd_762x51_m62_tracer", "rhsusf_100Rnd_762x51_m80a1epr", "rhsusf_100Rnd_762x51",
				"rhsusf_100Rnd_762x51_m61_ap", "rhsusf_50Rnd_762x51_m62_tracer", "ACE_20Rnd_762x51_Mag_Tracer_Dim", "ACE_20Rnd_762x51_Mk316_Mod_0_Mag", "ACE_20Rnd_762x51_M118LR_Mag",
				"ACE_20Rnd_762x51_Mk319_Mod_0_Mag", "ACE_20Rnd_762x51_M993_AP_Mag", "ACE_20Rnd_762x51_Mag_SD"];

_launchers = ["rhs_weap_m72a7","rhs_weap_maaws","rhs_weap_M136","rhs_weap_M136_hedp"];

_pitols		 = ["rhsusf_weap_m1911a1","rhs_weap_M320","rhsusf_weap_m9","rhsusf_weap_glock17g4","rhs_weap_rsp30_white",						"rhs_weap_rsp30_green","rhs_weap_rsp30_red"];

_weaponAttachments = ["rhsusf_acc_anpeq15side","rhsusf_acc_anpeq15_top","rhsusf_acc_anpeq15_wmx","rhsusf_acc_anpeq15_wmx_light",					"rhsusf_acc_anpeq15_bk_top","rhsusf_acc_anpeq15side_bk",
                     "rhsusf_acc_anpeq15","rhsusf_acc_anpeq15_light","rhsusf_acc_anpeq15_bk","rhsusf_acc_anpeq15_bk_light","rhsusf_acc_anpeq15A","rhsusf_acc_anpeq16a",
                     "rhsusf_acc_anpeq16a_light","rhsusf_acc_anpeq16a_top","rhsusf_acc_anpeq16a_light_top","rhsusf_acc_ACOG_RMR","rhsusf_acc_ACOG_d","rhsusf_acc_su230a_mrds_c","rhsusf_acc_su230a_mrds",
                     "rhsusf_acc_su230a_c","rhsusf_acc_su230a","rhsusf_acc_su230_mrds_c","rhsusf_acc_su230_mrds","rhsusf_acc_su230_c","rhsusf_acc_su230","rhs_weap_optic_smaw","rhsusf_acc_compm4",
                     "rhsusf_acc_eotech_552_d","rhsusf_acc_eotech_552","rhs_optic_maaws","rhsusf_acc_ACOG_anpvs27","rhsusf_acc_ACOG2","rhsusf_acc_ACOG",
                     "rhsusf_acc_ELCAN_ard","rhsusf_acc_ELCAN","rhsusf_acc_g33_xps3","rhsusf_acc_g33_xps3_tan","rhsusf_acc_g33_T1","rhsusf_acc_EOTECH","rhsusf_acc_ACOG2_USMC",
                     "rhsusf_acc_ACOG3_USMC","rhsusf_acc_ACOG_USMC","rhsusf_acc_anpvs27","rhsusf_acc_T1_high","rhsusf_acc_T1_low","rhsusf_acc_T1_low_fwd","rhsusf_acc_nt4_black",
                     "rhsusf_acc_nt4_tan","rhsusf_acc_grip2","rhsusf_acc_grip2_tan","rhsusf_acc_harris_bipod","rhsusf_acc_grip1","rhsusf_ach_bare","rhsusf_ach_bare_des","rhsusf_ach_bare_des_ess",
                     "muzzle_snds_B","rhsusf_acc_SR25S", "optic_SOS","rhsusf_acc_LEUPOLDMK4","rhsusf_acc_premier_low","optic_Hamr","optic_KHS_blk","optic_AMS","optic_Holosight_blk_F","optic_Holosight",
                     "ACE_optic_LRPS_2D","rhsusf_acc_eotech_xps3"];

_helmets = ["rhsusf_ach_bare_des_headset","rhsusf_ach_bare_des_headset_ess","rhsusf_ach_bare_ess","rhsusf_ach_bare_headset",				"rhsusf_ach_bare_headset_ess","rhsusf_ach_bare_tan",
           "rhsusf_ach_bare_tan_ess","rhsusf_ach_bare_tan_headset","rhsusf_ach_bare_tan_headset_ess","rhsusf_ach_helmet_ocp","rhsusf_ach_helmet_ESS_ocp",
           "rhsusf_ach_helmet_headset_ess_ocp","rhsusf_ach_helmet_ocp_norotos","rhsusf_ach_helmet_headset_ocp","rhsusf_ach_helmet_camo_ocp","rhsusf_cvc_green_helmet",
           "rhsusf_cvc_green_alt_helmet","rhsusf_cvc_green_ess","rhsusf_cvc_helmet","rhsusf_cvc_alt_helmet","rhsusf_cvc_ess","H_Watchcap_cbr","H_Watchcap_blk","rhs_Booniehat_ocp",
           "rhs_Booniehat_m81","H_Booniehat_tan","H_Booniehat_oli","rhsusf_opscore_fg_pelt_nsw","rhsusf_opscore_coy_cover_pelt","rhsusf_opscore_aor2_pelt_nsw",
           "rhsusf_opscore_aor2","rhsusf_opscore_aor1_pelt_nsw","rhsusf_opscore_aor1","rhsusf_opscore_fg","rhsusf_opscore_mc_cover","rhsusf_opscore_mc_cover_pelt_cam",
           "rhsusf_opscore_mc","rhsusf_opscore_mc_pelt_nsw","rhsusf_opscore_paint","rhsusf_opscore_paint_pelt_nsw_cam","rhsusf_opscore_rg_cover","rhsusf_opscore_rg_cover_pelt",
           "rhsusf_opscore_mar_fg","rhsusf_opscore_mar_fg_pelt","rhsusf_hgu56p_visor_mask_black_skull","rhsusf_hgu56p_visor_black","rhsusf_hgu56p_visor_mask_black",
           "rhsusf_hgu56p_visor_mask_Empire_black","rhsusf_hgu56p_green","rhsusf_hgu56p_mask_green","rhsusf_hgu56p_visor_green","rhsusf_hgu56p_visor_mask_green","rhsusf_hgu56p",
           "rhsusf_hgu56p_mask","rhsusf_hgu56p_mask_skull","rhsusf_hgu56p_visor","rhsusf_hgu56p_visor_mask","rhsusf_hgu56p_visor_mask_skull","rhsusf_mich_bare",
           "rhsusf_mich_bare_norotos_arc_alt_headset","rhsusf_mich_bare_norotos_arc_headset","rhsusf_mich_bare_norotos_headset","rhsusf_mich_bare_tan","rhsusf_mich_bare_alt_tan", 
           "rhsusf_mich_bare_norotos_alt_tan_headset","rhsusf_mich_bare_norotos_arc_alt_tan_headset","rhsusf_mich_bare_norotos_tan_headset"];

_uniforms = ["rhs_uniform_g3_m81","rhs_uniform_g3_mc","rhs_uniform_g3_rgr","rhs_uniform_g3_tan","rhs_uniform_cu_ocp_101st",					"rhs_uniform_cu_ocp_10th","rhs_uniform_cu_ocp"];

_vests = ["rhsusf_iotv_ocp_Grenadier","rhsusf_iotv_ocp_Medic","rhsusf_iotv_ocp_Repair","rhsusf_iotv_ocp_Rifleman","rhsusf_iotv_ocp_SAW",		"rhsusf_iotv_ocp_Squadleader",
         "rhsusf_iotv_ocp_Teamleader","rhsusf_mbav_grenadier","rhsusf_mbav_mg","rhsusf_mbav_medic","rhsusf_mbav_rifleman","rhsusf_spcs_ocp_crewman","rhsusf_spcs_ocp_grenadier",
         "rhsusf_spcs_ocp_machinegunner","rhsusf_spcs_ocp_medic","rhsusf_spcs_ocp","rhsusf_spcs_ocp_rifleman_alt","rhsusf_spcs_ocp_rifleman","rhsusf_spcs_ocp_saw",
         "rhsusf_spcs_ocp_sniper","rhsusf_spcs_ocp_squadleader","rhsusf_spcs_ocp_teamleader_alt","rhsusf_spcs_ocp_teamleader"];

_backpacks = ["rhs_TOW_Tripod_Bag","rhs_Tow_Gun_Bag","B_UAV_01_backpack_F","ACE_TacticalLadder_Pack","tf_rt1523g_rhs","tf_rt1523g_green",			"tf_rt1523g_black","tf_rt1523g_big_rhs",
             "tf_rt1523g_big","tf_rt1523g","RHS_Mk19_Tripod_Bag","RHS_Mk19_Gun_Bag","rhs_M252_Bipod_Bag","rhs_M252_Gun_Bag","RHS_M2_Tripod_Bag","RHS_M2_Gun_Bag","RHS_M2_MiniTripod_Bag",
             "B_Kitbag_rgr","B_Kitbag_cbr","B_Mortar_01_weapon_F","B_Mortar_01_support_F","rhsusf_falconii","rhsusf_falconii_coy","rhsusf_falconii_mc",
             "rhsusf_assault_eagleaiii_ocp","rhsusf_assault_eagleaiii_coy","B_Carryall_oli","B_Carryall_cbr","B_Carryall_khk","tf_anprc155","tf_anprc155_coyote",
             "B_AssaultPack_cbr","B_AssaultPack_rgr", "B_PARACHUTE"];

_glasses = ["rhsusf_shemagh_grn","rhsusf_shemagh_od","rhsusf_shemagh_tan","rhsusf_shemagh_white"];

_nvgs = ["rhsusf_ANPVS_14","rhsusf_ANPVS_15","ACE_NVG_Gen1","ACE_NVG_Gen2","NVGoggles_OPFOR","NVGoggles","NVGoggles_INDEP","ACE_NVG_Gen4",			"ACE_NVG_Wide"];

_binocs = ["rhsusf_bino_lrf_Vector21","ACE_Yardage450","ACE_Vector","ACE_VectorDay","Rangefinder","rhsusf_bino_m24_ARD",
           "rhsusf_bino_m24","rhsusf_bino_lerca_1200_tan","rhsusf_bino_lerca_1200_black", "Laserdesignator","Laserdesignator_03"];

//This array holds maps, watches, ACE medical items, radios, GPS, terminals etc...
_miscItems = ["tf_anprc152","ItemRadio","tf_microdagr","ItemWatch","ACE_Altimeter","ItemGPS","B_UavTerminal","ACE_wirecutter",				"ACE_UAVBattery","ToolKit",
              "ACE_morphine","MineDetector","ACE_microDAGR","ACE_MapTools","ACE_Flashlight_XL50","ACE_M26_Clacker","ACE_Kestrel4500",
             "ACE_IR_Strobe_Item","ACE_HuntIR_monitor","ACE_Flashlight_MX991","ACE_epinephrine","ACE_EntrenchingTool","ACE_EarPlugs","ACE_DefusalKit","ACE_DAGR",
             "ACE_Chemlight_Shield","ACE_CableTie","ACE_bodyBag","ACE_SpraypaintBlue","ACE_bloodIV","ACE_bloodIV_500","ACE_fieldDressing", 
             "ItemCompass","ItemMap", "ACE_ATragMX","ACE_RangeTable_82mm","ACE_DAGR","ACE_Kestrel4500","ACE_microDAGR","ACE_RangeCard","ACE_Tripod","ACE_SpottingScope"];

//This array hols the grenades and stachels and the simiar items
_throwablesAndPlaceables = ["ACE_M14","rhs_mag_an_m8hc","ACE_Chemlight_HiOrange","ACE_Chemlight_HiRed","ACE_Chemlight_HiWhite",							"ACE_Chemlight_HiYellow","ACE_Chemlight_IR","ACE_Chemlight_Orange",
                           "ACE_Chemlight_White","B_IR_Grenade","ACE_HandFlare_Green","ACE_HandFlare_Red","ACE_HandFlare_White","ACE_HandFlare_Yellow","rhs_mag_m18_green","rhs_mag_m18_purple",
                           "rhs_mag_m18_red","rhs_mag_m18_yellow","HandGrenade","ACE_M84","DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","ACE_VMM3","ACE_VMH3"];

//------------------------------------------------------Combining all the arrays into one for the arsenal loading---------------------------------------------------------------------------------
_itemsToLoad = _weapons + _magazines + _launchers + _pitols + _weaponAttachments + _helmets + _uniforms + _vests + _backpacks + _glasses + _nvgs + _binocs + _miscItems + _throwablesAndPlaceables;
  
//------------------------------------------------------------------Load combined array onto the arsenal-------------------------------------------------------------------------------------------
[_box, _itemsToLoad, true] call ace_arsenal_fnc_initBox;