AntiDeAMX2() {
	new a[][] = {
		"Unarmed (Fist)",
		"Brass K"
	};
	#pragma unused a
}
#define STREAMER_OBJECT_SD 350.0
#define STREAMER_OBJECT_DD 275.0
// ======================== < [ Include ] > ====================== //
#pragma tabsize 0
#include <a_samp>
#include <crashdetect>
#include <a_mysql>
#include <sscanf2>
#include <streamer>
#include <Pawn.CMD>
#include <mxINI>
#include <progress>
#include <a_http>
#include <float>
#include <fixobject>
#include <sampvoice>
#include <newdialogstyle>
#include <NewCallbacks>
#include <dropgun>
#pragma dynamic 9999
// ======================== < [ Defines ] > ================================ //
#define 	dbHost							"host.csworld.ge"
#define 	dbBase 							"user29739"
#define 	dbUser 							"user29739"
#define 	dbPass 							"58sMVEZAdeep"

#define 	srvMode 						"[Zer0] v0.0.2"

#define 	publics:%0(%1) 					forward %0(%1); public %0(%1)
#define 	NONE_3D_TEXT 					(Text3D:-1)

#define     TEAM_HIT_COLOR                  0xFFFFFFFF

#if !defined IsValidVehicle
	native IsValidVehicle(vehicleid);
#endif
// ======================== < [ New ] >
new SV_GSTREAM:gstream = SV_NULL;
new SV_LSTREAM:lstream[MAX_PLAYERS] = { SV_NULL, ... };
//------------------------------
new MySQL:connects;
//------------------------------
#include "../../library/enums/userdata"
#include "../../library/enums/carinfo"
new MyCarID[MAX_PLAYERS][25];
//------------------------------
new tmpobjid;
//------------------------------
new FreshTimer;
//------------------------------
new bool:Login[MAX_PLAYERS];
new LoginTime[MAX_PLAYERS];
new LoginSec[MAX_PLAYERS];
//------------------------------
new LoginWarning[MAX_PLAYERS];
//------------------------------
new TotalJobMaterials = 0;
new Text3D:TotalJobMat;
//------------------------------
new AFK[MAX_PLAYERS];
new AFKTime[MAX_PLAYERS];
//------------------------------
new bool:AdminDuty[MAX_PLAYERS];
//------------------------------
new createdvehs;
new admincar[MAX_PLAYERS];
new shopcar[MAX_PLAYERS];
new vehicleidtp[MAX_PLAYERS];
new vehcreat[MAX_VEHICLES];
new CreatedCars[100];
new CreatedCar = 0;
new cleanercar[MAX_PLAYERS];
//------------------------------
new PlayerCuffed[MAX_PLAYERS];
new PlayerCuffedTime[MAX_PLAYERS];
new gotome[MAX_PLAYERS];
//------------------------------
new policedoor[4];
//------------------------------
new engine,carlights,alarm,cardoors,bonnet,boot,objective;
enum e_vehicleInfo {
	vID,
	bool:vEngine,
	Float:vFuel,
	bool:vLights,
};
new vInfo[MAX_VEHICLES][e_vehicleInfo];
//------------------------------
#include "../../library/enums/cleanfloat"
new CleanerJob[MAX_PLAYERS];
new CleanerCP[MAX_PLAYERS];
//------------------------------
new WarehouseJob[MAX_PLAYERS];
new WarehousePic;
new WarehouseSuc[MAX_PLAYERS];
new WareCP[MAX_PLAYERS];
//------------------------------
new MtvirtaviJob[MAX_PLAYERS];
new MtvirtaviPic;
new MtvirtaviCP[MAX_PLAYERS];
//------------------------------
new Materials[MAX_PLAYERS];
new Drugs[MAX_PLAYERS];
//------------------------------
new Payment[MAX_PLAYERS];
//------------------------------
new DMArena[MAX_PLAYERS];
new Float:DmRandom[9][3] = {
	{-346.9080,2210.1492,42.4844},
	{-421.7599,2204.8752,42.4297},
	{-378.2790,2221.5044,42.0938},
	{-443.1659,2221.4031,42.4297},
	{-372.9104,2273.1995,41.7706},
	{-346.9080,2210.1492,42.4844},
	{-421.6016,2226.1008,42.4297},
	{-374.9994,2267.2522,42.4146},
	{-364.1501,2203.3845,42.4844}
};
//------------------------------
new TotalHouse;
new HouseCP[990] = {-1, ...};
new Text3D:House3DText[990] = {NONE_3D_TEXT, ...};

enum houses {
	Float:hEnterX,
	Float:hEnterY,
	Float:hEnterZ,
	Float:hExitX,
	Float:hExitY,
	Float:hExitZ,
	hOwner[MAX_PLAYER_NAME],
	hOwned,
	hPrice,
	hLock,
	hClass,
	hInt,
	hID,
	hIcon,
	Float:hSpawnX,
	Float:hSpawnY,
	Float:hSpawnZ,
	Float:hSpawnF,
	hGarage,
	Float:hCarx,
	Float:hCary,
	Float:hCarz,
	Float:hCarc,

}
new HouseData[990][houses];
//------------------------------

static const stock JoinShopF[][2] = {
	{65, 455},
	{192, 500},
	{219, 610},
	{93, 650},
	{211, 675},
	{233, 700},
	{148, 710},
	{169, 725},
	{141, 750},
	{76, 775},
	{150, 815},
	{214, 900}
};
new Text:enable_skin_TD[8];
new SelectCharPlace[MAX_PLAYERS];


static const stock JoinShopM[][2] = {
	{25,250},
	{15,325},
	{36,462},
	{50,500},
	{95,517},
	{96,550},
	{136,600},
	{143,625},
	{155,678},
	{2,700},
	{14,750},
	{24,776},
	{58,800},
	{7,819},
	{23,850},
	{33,900},
	{60,950},
	{67,1000},
	{73,1125},
	{184,1150},
	{21,1175},
	{22,1200},
	{30,1250},
	{183,1300},
	{255,1325},
	{4,1350},
	{6,1397},
	{8,1400},
	{42,1420},
	{273,1450},
	{17,1500},
	{45,1700},
	{82,1900},
	{83,2000},
	{185,2150},
	{290,2250},
	{291,3000},
	{28,3150},
	{29,3200},
	{248,3500},
	{247,3740},
	{254,3800},
	{249,3955},
	{18,4000},
	{19,4150},
	{47,4200},
	{48,4217},
	{101,4250},
	{299,4300},
	{289,4400},
	{61,4450},
	{121,4500},
	{227,4515},
	{228,4525},
	{292,4535},
	{293,4550},
	{297,4600},
	{122,4612},
	{111,4618},
	{117,4650},
	{118,4750},
	{126,5000},
	{127,5100},
	{296,5200},
	{3,5300},
	{119,5400},
	{208,5500},
	{295,5600},
	{46,5700},
	{294,5800}
};
//------------------------------
new TotalBizz;
new BizzIcon[990] = {-1, ...};
new BizzCP[990] = {-1, ...};
new Text3D:BizzText[990] = {NONE_3D_TEXT, ...};
new Text3D:BuyText[990] = {NONE_3D_TEXT, ...};

enum business {
	Float:bEnterX,
	Float:bEnterY,
	Float:bEnterZ,
	Float:bExitX,
	Float:bExitY,
	Float:bExitZ,
	Float:bBuyX,
	Float:bBuyY,
	Float:bBuyZ,
	bOwner[MAX_PLAYER_NAME],
	bOwned,
	bPrice,
	bLock,
	bType,
	bTypeID,
	bInt,
	bID,
	bIcon,
	bBank,
}
new BizzData[990][business];
//------------------------------
new TotalFractions;
enum fractions {
	wID,
	wAmmo,
	wBank,
	wDrug,
	wStatus,
	wInviteRank,
	wSkin[6],
}
new FractionData[50][fractions];
new Text3D:FractionPosText[5];
//------------------------------
new eventtime;
new Float:eventpos[3];
new eventint, eventvw;
new Text:TeleportEvent[14] = {Text:INVALID_TEXT_DRAW, ...};

//------------------------------
new TotalBullet;
enum bulletss {
	BulletID,
	bPlayerID,
	bName[MAX_PLAYER_NAME],
	bWeapone[100],
	Float:BulletX,
	Float:BulletY,
	Float:BulletZ,
	bUsed,
	bVW,
}
new BulletInfo[5999][bulletss];
#define BulletName(%1) BulletInfo[%1][bName]
new Text3D:BulletText[5999] = {NONE_3D_TEXT, ...};
//------------------------------
new bool:AGun[MAX_PLAYERS][48];
new AGunAmmo[MAX_PLAYERS][14];
//------------------------------
new ghour = 0;
new realtime = 1;
new timeshift = 0;
new shifthour;
//------------------------------
new bool:AnimOn[MAX_PLAYERS];
//------------------------------
new SpecAd[MAX_PLAYERS], SpecID[MAX_PLAYERS];
new Float:TeleportDest[MAX_PLAYERS][3];
new TeleportDestNoFloat[MAX_PLAYERS][2];
new gSpectateID[MAX_PLAYERS];
new svatonabil[MAX_PLAYERS];
//------------------------------
enum knock {
	kID,
	kActive,
	Float:kX,
	Float:kY,
	Float:kZ,
	dTimer,
	kInt,
	kVW,
}
new KnocInfo[MAX_PLAYERS][knock];
new Text3D:KnocText[MAX_PLAYERS];
//------------------------------
new ActorWR;
new ActorMtvirtavi;
//------------------------------
new Rent_Num[MAX_PLAYERS];
new rentID[MAX_PLAYERS] = {-1,...},
bool: RentTD_Used[MAX_PLAYERS], Rent_Choose[MAX_PLAYERS], Rent_Price[MAX_PLAYERS];
//------------------------------
new Text: RentTD_G[8];
new PlayerText:PressTD[MAX_PLAYERS][7];
new PlayerText:QuestTD[MAX_PLAYERS][5];
new PlayerText:PaymentTD[MAX_PLAYERS][2];
new PlayerText:RentTD_P[MAX_PLAYERS][5];
new PlayerText:CaptureTextDraw_PTD[MAX_PLAYERS][4];
//------------------------------
new bool:Tazer[MAX_PLAYERS], bool:Tazed[MAX_PLAYERS], Spark[MAX_PLAYERS];
//------------------------------
#include "../../library/enums/gangfloat"
//------------------------------
new sapdcar[19], lvpdcar[17], grovecar[10], ballascar[10], coronoscar[8], vagoscar[10], rifacar[10];
//------------------------------
new Peds[57][1] = {
	{79},
	{254},{259},{249},{248},{247},{242},{239},{228},
	{185},{184},{160},{155},{135},{126},{122},{121},{101},
	{100},{96},{82},{83},{84},{294},{94},{73},{67},
	{28},{29},{24},{23},{22},{21},
	{20},{19},{18},{17},{15},
	{7},{2},{299},{297},{296},{293},{46},
	{198},{197},{196},
	{190},{193},{243},{178},{192},{199},{201},{214},
	{224}
};
new cobj[2];
//------------------------------
new govfractions[] = {1,2,3,4,6};
//------------------------------
new TotalHouseCar;
new attachedcar[900];
new attachedcarobb[900];
new MyCarHouse[MAX_PLAYERS];
//------------------------------
new DamageInfo[MAX_PLAYERS];
#include <weapon-config>
// ======================== [ GPS ] =============================
new gps[MAX_PLAYERS];
//
new s_string[32];
new VehicleNames[212][] = {
	"Landstalker","Bravura","Buffalo","Linerunner","Perrenial","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus",
	"Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat","Mr.Whoopee","BF Injection",
	"Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie",
	"Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
	"Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Barron","RC Raider",
	"Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","Zr-350","Walton","Regina",
	"Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo","Greenwood",
	"Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa","RC Goblin","Hotring A","Hotring B",
	"Bloodring Banger","Rancher","Super GT","Elegant","Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain",
	"Nebula","Majestic","Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover",
	"Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A",
	"Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight","Trailer",
	"Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer A","Emperor",
	"Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","Police Car","Police Car",
	"Police Car","Police Ranger","Picador","S.W.A.T.","Alpha","Phoenix","Glendale","Sadler","L Trailer A","L Trailer B",
	"Stair Trailer","Boxville","Farm Plow","U Trailer"
};

new Text:AutoShopText[12];
new PlayerText:ShopText[MAX_PLAYERS];

new ShopCar[][2] =
{
	{400,130000},//n 0
	{567,200000},
	{549,120000},
	{547,110000},
	{546,140000},
	{543,100000},
	{527,100000},
	{526,110000},
	{518,170000},
	{517,150000},
	{516,140000},
	{492,140000},
	{479,110000},
	{478,100000},
	{475,190000},
	{466,110000},
	{458,120000},
	{439,150000},
	{436,100000},
	{404,100000}, //n 19
	{419,800000},//c 20
	{586,800000},
	{581,1000000},
	{461,1000000},
	{418,700000},
	{603,750000},
	{589,770000},
	{580,1000000},
	{579,940000},
	{561,910000},
	{555,940000},
	{554,840000},
	{534,760000},
	{533,920000},
	{505,880000},
	{491,800000},
	{489,880000},
	{445,810000},
	{421,830000},//c 38
	{401,340000},//d 39
	{600,420000},
	{585,360000},
	{576,350000},
	{575,460000},
	{566,340000},
	{551,480000},
	{550,480000},
	{540,330000},
	{536,400000},
	{529,440000},
	{507,450000},
	{474,370000},
	{467,390000},
	{426,420000},
	{422,310000},
	{412,390000},
	{405,400000},//d 56
	{477,220000},//b 57
	{471,2100000},
	{468,1900000},
	{463,2000000},
	{521,1900000},
	{602,2000000},
	{587,2100000},
	{565,2100000},
	{562,2200000},
	{560,2250000},
	{559,2200000},
	{558,2100000},
	{545,1900000},
	{535,2000000},
	{480,2400000},//b 71
	{402,4800000},//a 72
	{503,6000000},
	{502,6000000},
	{494,6000000},
	{495,5800000},
	{424,5000000},
	{434,4800000},
	{522,4600000},
	{541,6000000},
	{506,5100000},
	{451,6000000},
	{429,5400000},
	{415,5600000},
	{411,6000000}//a 85
};



#define MAX_OWNABLECARS 1000

stock ShowCarMenu(playerid) {
    new query[256];
    format(query, sizeof(query), "SELECT * FROM `cars` WHERE Owner = '%s'",Name(playerid));
    mysql_query(connects, query);
    new rows;
    cache_get_row_count(rows);
    if(!rows) return error(playerid, "Tkven ar gyavt manqana");
    new CarCount = 0, listCount = 0;
    for new i = 0;i < rows; i++ do {
        cache_get_value_name_int(i, "Model", MyCarID[playerid][CarCount]);
        CarCount ++;
    }
    for(new i = 0; i < 25; i ++) if(MyCarID[playerid][i]) listCount ++;
    new DialogStr[2056], dialogstr[100];
    DialogStr = "{F0A45D}Daarespawnet tkveni avtomobili\n";
    for(new i = 0; i < listCount; i ++) {
        format(dialogstr, sizeof(dialogstr),  "{F0A45D}[%d] {FFFFFF}- %s\n",(i+1),VehicleNames[MyCarID[playerid][i]-400]);
        strcat(DialogStr, dialogstr);
    }
    ShowPlayerDialog(playerid, 900, DIALOG_STYLE_TABLIST_HEADERS, "Cars", DialogStr, "Spawn", "Gasvla");
    return true;
}
stock GivePlayerCar(playerid, carid) {
    new query[256];
    format(query, sizeof(query), "INSERT INTO `cars` (`Owner`, `Model`) VALUES ('%s', '%d')",Name(playerid),carid);
    mysql_query(connects, query);
    return true;
}

stock GetString(param1[],param2[]) {
	return !strcmp(param1, param2, false);
}
stock Getplayerid(string[]) {
	foreach(new i:Player) {
		new testname[MAX_PLAYER_NAME];
		GetPlayerName(i, testname, sizeof(testname));
		if(strcmp(testname, string, true, strlen(string)) == 0) return i;
	}
	return INVALID_PLAYER_ID;
}

stock IsOnline(name[]) {
    new Pname[24];
    for(new i; i<MAX_PLAYERS; i++) {
        if(!IsPlayerConnected(i)) continue;
        GetPlayerName(i, Pname, 24);
        if(!strcmp(Pname, name, true)) return 1;
    }
    return 0;
}

stock SetPlayerArmourAC(playerid, Float: Arm) {
	if(IsPlayerConnected(playerid)) SetPlayerArmour(playerid, Arm);
	return true;
}
stock ShowEvent(playerid, name[]) {
	new event_name[100];
	format(event_name, 100, "%s",name);
	for(new i = 0; i < 14; i ++) TextDrawShowForPlayer(playerid, TeleportEvent[i]);
	TextDrawSetString(TeleportEvent[0], event_name);
	return 1;
}
stock UpdateEvent() {
	new event_name[100];
	format(event_name, 100, "%s_~W~-_/GOTP",Convert(eventtime));
	return TextDrawSetString(TeleportEvent[1], event_name);
}
stock HideEvent(playerid) {
    for(new i = 0; i < 14; i ++) TextDrawHideForPlayer(playerid, TeleportEvent[i]);
	return 1;
}
/* -------------------------------------------------------------------------- */
stock isCarInShop(modelid) {
	for(new i = 0; i < OWNABLECARS; i++) {
		if(GetString(CarInfo[i][cOwner],"Iyideba") && CarInfo[i][cModel] == modelid)
		{
		    return i;
		}
	}

	return 0;
}

stock isAvailableCars() {
	new availableCars = 0;

	for(new i = 0; i < OWNABLECARS; i++) {
		if(GetString(CarInfo[i][cOwner],"Iyideba"))
		{
		    availableCars++;
		}
	}

	return availableCars;
}

stock LoadOwnableCars() {
	new rows;
	new Cache:result = mysql_query(connects, "SELECT * FROM `cars`");
	cache_get_row_count(rows);
	for(new i = 0;i < rows; i++) {
		cache_get_value_name_int	(i,	"ID", 			CarInfo[i][cID]);
		cache_get_value_name_int	(i,	"Model", 		CarInfo[i][cModel]);
		cache_get_value_name		(i,	"Owner", 		CarInfo[i][cOwner],32);

		cache_get_value_name_int	(i,	"Color_1", 		CarInfo[i][cColor_1]);
		cache_get_value_name_int	(i,	"Color_2", 		CarInfo[i][cColor_2]);
		/* ------------------------------------------------------------------ */
		cache_get_value_name_int(i,	"Spoiler", 			CarInfo[i][cSpoiler]);
		cache_get_value_name_int(i,	"Hood", 			CarInfo[i][cHood]);
		cache_get_value_name_int(i,	"Sides", 			CarInfo[i][cSideskirt]);
		cache_get_value_name_int(i,	"Nitro", 			CarInfo[i][cNitro]);
		cache_get_value_name_int(i,	"Lamps", 			CarInfo[i][cLamps]);
		cache_get_value_name_int(i,	"Exhaust", 			CarInfo[i][cExhaust]);
		cache_get_value_name_int(i,	"Wheels", 			CarInfo[i][cWheels]);
		cache_get_value_name_int(i,	"Roof", 			CarInfo[i][cRoof]);
		cache_get_value_name_int(i,	"Hydraulics", 		CarInfo[i][cHydraulics]);
		cache_get_value_name_int(i,	"Bullbar", 			CarInfo[i][cBullbar]);
		cache_get_value_name_int(i,	"RBullbars", 		CarInfo[i][cRearBullbars]);
		cache_get_value_name_int(i,	"FSign", 			CarInfo[i][cFrontSign]);
		cache_get_value_name_int(i,	"FBullbars", 		CarInfo[i][cFrontBullbars]);
		cache_get_value_name_int(i,	"FBumper", 			CarInfo[i][cFrontBumper]);
		cache_get_value_name_int(i,	"RBumper", 			CarInfo[i][cRearBumper]);
		cache_get_value_name_int(i,	"Vents", 			CarInfo[i][cVents]);
		cache_get_value_name_int(i,	"PaintJob", 		CarInfo[i][cPaintJob]);
		OWNABLECARS++;
	}
	cache_delete(result);
	return true;
}

UpdateCarInfo(vehicleid) {
	if(IsAOwnableCar(vehicleid)) {
		new number = GetVehicleID(vehicleid);
		new string[200];
		if(IsASellCar(vehicleid)) format(string,sizeof(string),"{FF9900} Manqana iyideba {FFFFFF}\n\nModeli {AFAFAF}%s (%d){FFFFFF}\nSafasuri: {AFAFAF}$%d", VehicleNames[GetVehicleModel(vehicleid)-400],GetVehicleModel(vehicleid),GetCarPrice(number));
		else format(string,sizeof(string)," ");
		UpdateDynamic3DTextLabelText(CarText[number],-1,string);
	}
	return true;
}

stock SaveOwnableCar(carid) {
	new string[4556];
	format(string, sizeof(string), "UPDATE `cars` SET \
		`Model` = '%d',\
		`Owner` = '%s',  `Color_1` = '%d',`Color_2` = '%d',\
		`Spoiler` = '%d',`Hood` = '%d',`Sides` = '%d',`Nitro` = '%d',`Lamps` = '%d',`Exhaust` = '%d',`Wheels` = '%d', \
		`Roof` = '%d',`Hydraulics` = '%d',`Bullbar` = '%d',`RBullbars` = '%d', \
		`FSign` = '%d',`FBullbars` = '%d', \
		`FBumper` = '%d',`RBumper` = '%d',`Vents` = '%d',`PaintJob` = '%d' WHERE `ID` = '%i'",

  		CarInfo[carid][cModel],
		CarInfo[carid][cOwner],
		CarInfo[carid][cColor_1],
		CarInfo[carid][cColor_2],
		CarInfo[carid][cSpoiler],
		CarInfo[carid][cHood],
		CarInfo[carid][cSideskirt],
		CarInfo[carid][cNitro],
		CarInfo[carid][cLamps],
		CarInfo[carid][cExhaust],
		CarInfo[carid][cWheels],
		CarInfo[carid][cRoof],
		CarInfo[carid][cHydraulics],
		CarInfo[carid][cBullbar],
		CarInfo[carid][cRearBullbars],
		CarInfo[carid][cFrontSign],
		CarInfo[carid][cFrontBullbars],
		CarInfo[carid][cFrontBumper],
		CarInfo[carid][cRearBumper],
		CarInfo[carid][cVents],
		CarInfo[carid][cPaintJob],
		carid+1);
	mysql_query(connects, string, false);


	string[0] = EOS;

	format(string, sizeof(string), "UPDATE `cars` SET \
		`Interior` = '%d', `VirtualWorld` = '%d' WHERE `ID` = '%i'",

		CarInfo[carid][cInterior],
		CarInfo[carid][cVirtualWorld],
		carid+1);
	mysql_query(connects, string, false);

	return true;
}

stock SaveOwnableCars() {
	for (new i = 0;i < OWNABLECARS;i ++) SaveOwnableCar(i);
	return true;
}
stock GetVehicleID(carid) {
	return carid - OwnableCar[0];
}
stock IsPlayersCar(playerid, vehicleid) {
    if(IsAOwnableCar(vehicleid)) {
	    new number = GetVehicleID(vehicleid);
		if(GetString(CarInfo[number][cOwner], Name(playerid))) return 1;
	}
	return 0;
}
stock IsPlayerInOwnedVehicle(playerid) {
	if(IsPlayerInAnyVehicle(playerid)) {
	    if(IsPlayersCar(playerid,GetPlayerVehicleID(playerid))) return true;
	}
	return false;
}
stock IsAOwnableCar(carid) {
	return (OwnableCar[0] <= carid <= OwnableCar[OWNABLECARS-1]);
}
stock GetNumberCars(playerid,&number) {
	new cars;
	for(new i = 0; i < OWNABLECARS; i++) {
	    if(IsPlayersCar(playerid,OwnableCar[i])) cars++;
	}
	number = cars;
}
stock SetString(param_1[], param_2[], size = 256) {
    return strmid(param_1, param_2, 0, strlen(param_2), size);
}
stock SetCarOwner(carid,name[]) {
	return SetString(CarInfo[carid][cOwner],name);
}
stock IsASellCar(carid) {
    if(IsAOwnableCar(carid)) {
	    new number = GetVehicleID(carid);
	    if(GetString(CarInfo[number][cOwner],"Iyideba")) return true;
	}
	return false;
}
stock SetDoorsStatus(carid, status) {
	GetVehicleParamsEx(carid,engine,carlights,alarm,cardoors,bonnet,boot,objective);
    SetVehicleParamsEx(carid,engine,carlights,alarm,status,bonnet,boot,objective);
	return 1;
}
stock GetCarPrice(carid) {
	new cost;
	switch(CarInfo[carid][cModel]) {
		case 541: cost = 350000;
		case 411: cost = 500000;
		case 560: cost = 250000;
		case 451: cost = 300000;
		case 429: cost = 150000;
		case 415: cost = 125000;
		case 562: cost = 120000;
		case 559: cost = 100000;
		case 579: cost = 100000;
		case 506: cost = 160000;
		case 522: cost = 180000;
		case 480: cost = 130000;
		case 603: cost = 60000;
  		case 402: cost = 85000;
		case 602: cost = 52500;
		case 489: cost = 29000;
		case 554: cost = 6000;
		case 400: cost = 6500;
		case 540: cost = 6000;
		case 445: cost = 8500;
		case 549: cost = 8000;
		case 521: cost = 18000;
		case 461: cost = 16500;
		case 581: cost = 16000;
		case 468: cost = 15000;
		case 463: cost = 15000;
		case 589: cost = 11500;
		case 565: cost = 65000;
		case 586: cost = 4000;
		case 534: cost = 25000;
		case 405: cost = 27000;
		case 426: cost = 25000;
		case 421: cost = 22000;
		case 535: cost = 11000;
		case 496: cost = 10000;
		case 462: cost = 1500;
		case 510: cost = 1500;
		case 481: cost = 1500;
		case 509: cost = 1500;
		case 475: cost = 9000;
		case 542: cost = 8000;
		case 558: cost = 85000;
		case 551: cost = 13000;
		case 500: cost = 9500;
		case 533: cost = 40000;
		case 477: cost = 58000;
		case 587: cost = 38000;
		case 492: cost = 12000;
		case 495: cost = 80000;
		case 561: cost = 60000;
		case 401: cost = 9000;
		case 404: cost = 60000;
		case 410: cost = 65000;
		case 422: cost = 60000;
		case 436: cost = 68000;
		case 478: cost = 85000;
		case 507: cost = 115000;
		case 526: cost = 90000;
		case 527: cost = 49000;
		case 529: cost = 98000;
		case 546: cost = 82000;
		case 547: cost = 88000;
		case 494: cost = 600000;
		case 502: cost = 600000;
		case 503: cost = 600000;
		///////
		case 487: cost = 120000;
		case 469: cost = 100000;
		///////
		default: cost = 10000;
	}
	return cost;
}

stock SellCar(carid)
{
	new number = GetVehicleID(carid);
	CarInfo[number][cColor_1] = 1;
	CarInfo[number][cColor_2] = 1;
	CarInfo[number][cVirtualWorld] = 0;
	CarInfo[number][cInterior] = 0;
	SetString(CarInfo[number][cOwner], "Iyideba");
	CarInfo[number][cLock] = 1;
	SetVehicleHealth(carid, 1000);
	//DelTunCar(number);
	DestroyVehicle(carid);
	SaveOwnableCar(number);
	return 1;
}

stock error(playerid, text[]) {
	PlayerPlaySound(playerid, 1055, 0.0, 0.0, 0.0);
	format(YCMDstr, sizeof(YCMDstr), "* ERROR  {FFFFFF}- %s", text);
	SendClientMessage(playerid, 0x903838FF, YCMDstr);
	return true;
}

stock success(playerid, text[]) {
	PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
	format(YCMDstr, sizeof(YCMDstr), "* INFO {FFFFFF}- %s", text);
	SendClientMessage(playerid, 0xF0A45DFF, YCMDstr);
	return true; 
}

stock formatmsg(playerid, text[]) {
	format(YCMDstr, sizeof(YCMDstr), "* TYPE {FFFFFF}- %s", text);
	SendClientMessage(playerid, 0x4B83CAFF, YCMDstr);
	return true; 
}

stock ShowStats(playerid,targetid) {
	if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid)) {
		new atext[32];
		switch(UserData[targetid][pSex])
		{
		    case 1: atext = "Mamakaci";
		    case 2: atext = "Qalbatoni";
		}
        new level = UserData[targetid][pLevel];
		new exp = UserData[targetid][pExp];
		
		new cash = UserData[targetid][pCash];
		new bank = UserData[targetid][pBank];

		new wanted = UserData[targetid][pWantedLevel];
		new str[512],stats[1024];
		format(str, sizeof(str),
			"{FFFFFF}Saxeli :{F0A45D}\t[ %s ]\n\
			{FFFFFF}Sqesi :{F0A45D}\t[ %s ]\n\n\
			{FFFFFF}Leveli :{F0A45D}\t[ %d/%d ]\n\n\
			{FFFFFF}Fuli xelze :{F0A45D}\t[ %d$ ]\n\
			{FFFFFF}Fuli bankshi :{F0A45D}\t[ %d$ ]\n\n\
			{FFFFFF}Dzebnis done :{F0A45D}\t[ %d ]\n\n\
			{FFFFFF}Samsaxuri :{F0A45D}\t[ %s ]\n\
			{FFFFFF}Rank :{F0A45D}\t[ %d$ ]\n\n",
		Name(targetid), atext, level, exp, cash, bank, wanted, GetFractionName(UserData[targetid][pMember]), UserData[targetid][pRank]);
		strcat(stats, str);
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Personajis statistika", stats, "Cancel", "");
	}
}
stock ReturnUser(name[]) {
	foreach(new i: Player) {
		if(strcmp(Name(i), name, true, strlen(name)) == 0) return i;
	}
	return INVALID_PLAYER_ID;
}
stock IsAPlane(carid){switch(GetVehicleModel(carid)){case 592,577,511,512,593,520,553,476,519,460,513,548,417,487,488,497,563,447,469:return true;}return false;}
stock IsABoat(carid){switch(GetVehicleModel(carid)){case 472,473,493,595,484,430,452..454,446:return true;}return false;}
stock IsABike(carid){switch(GetVehicleModel(carid)){case 448,435,449,450,457,462,464,465,481,485,501,509,510,530,564,569,570,584,594,606,607,608,610,611:return true;}return false;}

stock CreateTrailer(playerid, Float:X, Float:Y, Float:Z) {
	TotalHouseCar++;
    attachedcar[TotalHouseCar] = CreateVehicle(607, X, Y, Z, 181.701, -1, -1, -1, 0);
    attachedcarobb[TotalHouseCar] = CreateDynamicObject(3171,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(attachedcarobb[TotalHouseCar], attachedcar[TotalHouseCar], 0, -1.700, -1, 0.100, 0.000, 180.00);
    MyCarHouse[playerid] = TotalHouseCar;
}
stock RandomCash(num, avg) {
	new minus = num -= avg;
	new plus = num += avg;
	new cash = Random(minus, plus);
	return cash;
}
DamageActive(playerid) {
	if(DamageInfo[playerid]) return true;
	return false;
}
stock PayDay() {
	new string[268];
	ClearTotalGz();
	for(new i = 0; i < 20; i++) FrakCD[i] = 0;
	for(new i = 0; i < sizeof(ZoneInfo); i++) {
		if(ZoneInfo[i][gFrakVlad] == 7) TotalGzB++;
		if(ZoneInfo[i][gFrakVlad] == 8) TotalGzV++;
		if(ZoneInfo[i][gFrakVlad] == 9) TotalGzG++;
		if(ZoneInfo[i][gFrakVlad] == 10) TotalGzA++;
		if(ZoneInfo[i][gFrakVlad] == 11) TotalGzR++;
	}
	foreach(new i:Player) {
		if(Login[i] == false) return true;

        DestroyVehicle(rentID[i]);
		rentID[i] = -1;
		SetPVarInt(i, "veh_rent", -1);

	  	SendClientMessage(i, -1, "{F0A45D}- - - - - - - - - [ PAYDAY ] - - - - - - - - -");
	  	// Level Up
		UserData[i][pExp][0]++;
		if(UserData[i][pExp][0] >= UserData[i][pExp][1]) {
			UserData[i][pExp][0] = 0;
			UserData[i][pExp][1] = UserData[i][pExp][1]*2;
			UserData[i][pLevel]++;
			format(string, sizeof(string), "{F0A45D}[LEVEL UP] -{FFFFFF} Tkveni leveli gaxda: {F0A45D}%d", UserData[i][pLevel]), SendClientMessage(i, -1, string);
		}
		UpdateUserData(i, "pExp1", UserData[i][pExp][0]);
		UpdateUserData(i, "pExp2", UserData[i][pExp][1]);
		UpdateUserData(i, "pLevel", UserData[i][pLevel]);
		SetPlayerScore(i, UserData[i][pLevel]);
		// Give fraction payment
		new fpayment[MAX_PLAYERS] = 0;
		new gpayment[MAX_PLAYERS] = 0;
		if(UserData[i][pMember] != 0) {
			switch(UserData[i][pMember]) {
				case 1: fpayment[i] = RandomCash(1500, 50)*UserData[i][pRank];
				case 2: fpayment[i] = RandomCash(1300, 200)*UserData[i][pRank];
				case 3: fpayment[i] = RandomCash(1900, 20)*UserData[i][pRank];
				case 4: fpayment[i] = RandomCash(800, 00)*UserData[i][pRank];

				case 7: gpayment[i] = RandomCash(200, 50)*TotalGzB;
				case 8: gpayment[i] = RandomCash(200, 50)*TotalGzV;
				case 9: gpayment[i] = RandomCash(200, 50)*TotalGzG;
				case 10: gpayment[i] = RandomCash(200, 50)*TotalGzA;
				case 11: gpayment[i] = RandomCash(200, 50)*TotalGzR;
			}
		}
		if(fpayment[i] != 0) {
			UserData[i][pBank] += fpayment[i];
			UpdateUserData(i, "pBank", UserData[i][pBank]);
			format(string, sizeof(string), "{F0A45D}[PAYMENT] -{FFFFFF} Tkveni xelfasi aris: {F0A45D}%d$", fpayment[i]), SendClientMessage(i, -1, string);
		}
		if(gpayment[i] != 0) {
			UserData[i][pBank] += fpayment[i];
			UpdateUserData(i, "pBank", UserData[i][pBank]);
			format(string, sizeof(string), "{F0A45D}[PAYMENT] -{FFFFFF} Tkveni xelfasi aris: {F0A45D}%d$", gpayment[i]), SendClientMessage(i, -1, string);
		}
		// Check bank account
		format(string, sizeof(string), "{F0A45D}[BANK] -{FFFFFF} Tkvens angarishze aris: {F0A45D}%d$", UserData[i][pBank]), SendClientMessage(i, -1, string);
		SendClientMessage(i, -1, "{F0A45D}- - - - - - - - - [ PAYDAY ] - - - - - - - - -");
		LoginTime[i] = 0;
	}
	// Fraction monay
	new fractionPayment[5], goverementPayment[5];
	goverementPayment[0] = RandomCash(300000, 500);
	goverementPayment[1] = RandomCash(200000, 500);
	goverementPayment[2] = RandomCash(350000, 500);
	goverementPayment[3] = RandomCash(250000, 500);

	FractionData[1][wBank] += goverementPayment[0];
	FractionData[2][wBank] += goverementPayment[1];
	FractionData[3][wBank] += goverementPayment[2];
	FractionData[4][wBank] += goverementPayment[3];

	goverementPayment[4] = RandomCash(20000, 500);
	FractionData[5][wBank] += goverementPayment[4];

	fractionPayment[0] = RandomCash(20000, 500);
	fractionPayment[1] = RandomCash(20000, 500);
	fractionPayment[2] = RandomCash(20000, 500);
	fractionPayment[3] = RandomCash(20000, 500);
	fractionPayment[4] = RandomCash(20000, 500);

	FractionData[7][wBank] += fractionPayment[0];
	FractionData[8][wBank] += fractionPayment[1];
	FractionData[9][wBank] += fractionPayment[2];
	FractionData[10][wBank] += fractionPayment[3];
	FractionData[11][wBank] += fractionPayment[4];

	for(new f; f < TotalFractions; f++) SaveFraction(f);
	return true;
}
stock UpdateFractions() {
	new FRAC_WH_TEXT[256];
	
	format(FRAC_WH_TEXT,500,"{FFFFFF}Materialebis sawyobi : {F0A45D}Ballas\n{FFFFFF}Tyviebi : {F0A45D}%d\n{FFFFFF}Narkotikebi : {F0A45D}%d\n{FFFFFF}Mdgomareoba : %s\n{FFFFFF}Press : {F0A45D}(ALT)"
	,FractionData[7][wAmmo],FractionData[7][wDrug],FractionData[7][wStatus]?("{F0A45D}gaxsnilia"):("{F0A45D}chaketilia"));
	Update3DTextLabelText(FractionPosText[0],-1,FRAC_WH_TEXT);
	
	format(FRAC_WH_TEXT,500,"{FFFFFF}Materialebis sawyobi : {F0A45D}Vagos\n{FFFFFF}Tyviebi : {F0A45D}%d\n{FFFFFF}Narkotikebi : {F0A45D}%d\n{FFFFFF}Mdgomareoba : %s\n{FFFFFF}Press : {F0A45D}(ALT)"
	,FractionData[8][wAmmo],FractionData[8][wDrug],FractionData[8][wStatus]?("{F0A45D}gaxsnilia"):("{F0A45D}chaketilia"));
	Update3DTextLabelText(FractionPosText[1],-1,FRAC_WH_TEXT);
	
	format(FRAC_WH_TEXT,500,"{FFFFFF}Materialebis sawyobi : {F0A45D}Grove\n{FFFFFF}Tyviebi : {F0A45D}%d\n{FFFFFF}Narkotikebi : {F0A45D}%d\n{FFFFFF}Mdgomareoba : %s\n{FFFFFF}Press : {F0A45D}(ALT)"
	,FractionData[9][wAmmo],FractionData[9][wDrug],FractionData[9][wStatus]?("{F0A45D}gaxsnilia"):("{F0A45D}chaketilia"));
	Update3DTextLabelText(FractionPosText[2],-1,FRAC_WH_TEXT);
	
	format(FRAC_WH_TEXT,500,"{FFFFFF}Materialebis sawyobi : {F0A45D}Aztecas\n{FFFFFF}Tyviebi : {F0A45D}%d\n{FFFFFF}Narkotikebi : {F0A45D}%d\n{FFFFFF}Mdgomareoba : %s\n{FFFFFF}Press : {F0A45D}(ALT)"
	,FractionData[10][wAmmo],FractionData[10][wDrug],FractionData[10][wStatus]?("{F0A45D}gaxsnilia"):("{F0A45D}chaketilia"));
	Update3DTextLabelText(FractionPosText[3],-1,FRAC_WH_TEXT);

	format(FRAC_WH_TEXT,500,"{FFFFFF}Materialebis sawyobi : {F0A45D}Rifa\n{FFFFFF}Tyviebi : {F0A45D}%d\n{FFFFFF}Narkotikebi : {F0A45D}%d\n{FFFFFF}Mdgomareoba : %s\n{FFFFFF}Press : {F0A45D}(ALT)"
	,FractionData[11][wAmmo],FractionData[11][wDrug],FractionData[11][wStatus]?("{F0A45D}gaxsnilia"):("{F0A45D}chaketilia"));
	Update3DTextLabelText(FractionPosText[4],-1,FRAC_WH_TEXT);
}
stock SaveFraction(id) {
	new query[600];
	new string[128];
	query = "UPDATE `fractions` SET ";
	acc_int_strcat(query, sizeof(query), "wAmmo", FractionData[id][wAmmo]);
	acc_int_strcat(query, sizeof(query), "wBank", FractionData[id][wBank]);
	acc_int_strcat(query, sizeof(query), "wDrug", FractionData[id][wDrug]);
	acc_int_strcat(query, sizeof(query), "wStatus", FractionData[id][wStatus]);
	acc_int_strcat(query, sizeof(query), "wInviteRank", FractionData[id][wInviteRank]);

	acc_int_strcat(query, sizeof(query), "wSkin1", FractionData[id][wSkin][0]);
	acc_int_strcat(query, sizeof(query), "wSkin2", FractionData[id][wSkin][1]);
	acc_int_strcat(query, sizeof(query), "wSkin3", FractionData[id][wSkin][2]);
	acc_int_strcat(query, sizeof(query), "wSkin4", FractionData[id][wSkin][3]);
	acc_int_strcat(query, sizeof(query), "wSkin5", FractionData[id][wSkin][4]);
	acc_int_strcat(query, sizeof(query), "wSkin6", FractionData[id][wSkin][5]);

	strdel(query, strlen(query)-1, strlen(query));
	format(string,sizeof(string)," WHERE `wID` = '%d'", id);
	strcat(query, string);
	mysql_tquery(connects, query, "", "");
}
stock SendFractionMessage(member, string[]) {
	foreach(new i:Player) {
		if(UserData[i][pMember] == member || UserData[i][pLeader] == member) SendClientMessage(i, -1, string);
	}
}
stock SetPressNumber(playerid, int) {
	new str2[50];
	switch(int) {
		case 1: str2 = "Y";
		case 2: str2 = "H";
		case 3: str2 = "N";
		case 4: str2 = "Error";
	}
	new string[500];
	format(string, sizeof(string), "%s", str2);
	PlayerTextDrawSetString(playerid, PressTD[playerid][4], string);
	PlayerTextDrawShow(playerid, PressTD[playerid][4]);
}
stock MomentWarehouse(playerid) {
	TogglePlayerControllable(playerid, 0);
	RemovePlayerAttachedObject(playerid, 0);
	RemovePlayerAttachedObject(playerid, 1);
	SetTimerEx("SetAnimationWare", 100, false, "i", playerid);
	SetTimerEx("SetAnimationWare", 500, false, "i", playerid);
	SetPlayerAttachedObject(playerid,0,18644,5,0.078999,0.042999,-0.012999,-3.299995,0.000000,0.000000);
	SetPlayerAttachedObject(playerid,1,18635,6);
	SetPVarInt(playerid, "Warehouse", 1);
	SetPVarInt(playerid, "WareNumber", 3);
}
stock SuccessWarehouse(playerid) {
	TogglePlayerControllable(playerid, 1);
	RemovePlayerAttachedObject(playerid, 0);
	RemovePlayerAttachedObject(playerid, 1);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	SetPlayerAttachedObject(playerid,0,2358,6,0.0,0.10,-0.2, -110.0,0.0,78.0);
	SetPVarInt(playerid, "Warehouse", 2);
	WarehouseSuc[playerid] = 0;
}
stock IsInAllowed(playerid) {
	for(new i = 0; i < sizeof(allowedfactions); i++) {
		if(UserData[playerid][pMember] == allowedfactions[i] && UserData[playerid][pRank] > 0) return true;
	}
	return false;
}
stock IsInGoverement(playerid) {
	for(new i = 0; i < sizeof(govfractions); i++) {
		if(UserData[playerid][pMember] == govfractions[i] && UserData[playerid][pRank] > 0) return true;
	}
	return false;
}
stock Trigger(Float:x,Float:y,Float:z) {
	new Triggers = CreateObject(1317, x, y, z-1.8, 0.0, 0.0, 0.0);
	SetObjectMaterial(Triggers, 0, 18646, "matcolours", "red", 0xFF808000);
}
stock CreateTrigger(Float:x,Float:y,Float:z, text[]) {
	new Trigger2 = CreateObject(1317, x, y, z-1.8, 0.0, 0.0, 0.0);
	SetObjectMaterial(Trigger2, 0, 18646, "matcolours", "red", 0xFF808000);

	new frm[500];
	format(frm, sizeof(frm), "{F0A45D}[ %s ]\n{FFFFFF}Press : {F0A45D}(ALT)", text);
	CreateDynamic3DTextLabel(frm, -1, x, y, z-1, 5.0);
}
stock LoadDoors() {
	CreateTrigger(1555.5001,-1675.6489,16.1953, "Enter"); // PD
	CreateTrigger(246.3353,107.2993,1003.2188, "Exit"); // PD

	CreateTrigger(626.9648,-571.7481,17.9207, "Enter"); // PD
	CreateTrigger(-701.9442,2607.5820,1006.1084, "Exit"); // PD

	CreateTrigger(-709.2562,2592.2473,1006.1143, "Floor 2"); // PD
	CreateTrigger(-334.4215,2842.4087,940.1276, "Floor 1"); // PD

	CreateTrigger(-333.2097,2843.3577,940.1276, "Exit"); // PD
	CreateTrigger(610.9418,-583.4946,18.2109, "Enter"); // PD
	CreateTrigger(-322.7158,2841.7778,943.2977, "Roof"); // PD

	CreateTrigger(1172.5022,-1323.4323,15.4032, "Enter"); // Hospital
	CreateTrigger(1982.1182,212.5493,1501.0859, "Exit"); // Hospital

	CreateTrigger(1481.0323,-1771.4735,18.7958, "Enter"); // Meria
	CreateTrigger(390.7699,173.8612,1008.3828, "Exit"); // Meria

	CreateTrigger(1298.5022,-798.3752,84.1406, "Enter"); // Meria
	CreateTrigger(1298.8999,-796.8135,1084.0078, "Exit"); // Meria

	CreateTrigger(318.5814,1114.4794,1083.8828, "Exit"); // GangExit

	CreateTrigger(854.5874,-605.2051,18.4219, "Enter"); // Warehouse job enter
	CreateTrigger(2531.3191,-1281.9058,1048.2891, "Exit"); // warehouse job exit

	CreateTrigger(2000.0381,-1114.5784,27.1250, "Enter"); // Ballas
	CreateTrigger(2756.3967,-1182.8093,69.4035, "Enter"); // Vagos
	CreateTrigger(2495.3989,-1691.1401,14.7656, "Enter"); // Grove
	CreateTrigger(1667.4960,-2106.9409,14.0723, "Enter"); // Aztecas
	CreateTrigger(2787.0764,-1926.0674,13.5469, "Enter"); // Rifa
	
	CreateTrigger(553.3617,-1293.4238,17.2483, "Enter"); // Autosalon enter
	CreateTrigger(1401.7775,-21.3760,1000.8630, "Exit"); // Autosalon enter

	Trigger(320.9207,1116.8724,1083.8828);
}
Convert(number) {
	new hours = 0, mins = 0, secs = 0, string[100];
	hours = floatround(number / 3600);
	mins = floatround((number / 60) - (hours * 60));
	secs = floatround(number - ((hours * 3600) + (mins * 60)));
	if(hours > 0) format(string, 100, "%d:%02d:%02d", hours, mins, secs);
	else format(string, 100, "%d:%02d", mins, secs);
	return string;
}
stock UsingAdress(playerid, text[]) {
	if(IsIP(text)) {
		new ip[MAX_PLAYER_NAME];
		GetPlayerIp(playerid,ip,sizeof(ip));
		new string[126];
		format(string, sizeof(string), "%s shesadzloa apiarebdes servers",Name(playerid));
		SendAdminMessage(0xEF545DFF, string);
		format(string, sizeof(string), "ID: %d | IP: [%s]",playerid, ip);
		SendAdminMessage(0xEF545DFF, string);
	  	return true;
	}
	return true;
}
stock GetGangZoneColor(zone) {
	new zx;
	switch(ZoneInfo[zone][gFrakVlad]) {
		case 7: zx = 0xD200FF99; 
		case 8: zx = 0xFFCD00AA; 
		case 9: zx = 0x009900AA;
		case 10: zx = 0x00F5FFAA;
		case 11: zx = 0x6666ffAA;
		default: zx = 0xC0C0C0AA;
	}
	return zx;
}

stock GetGZColorF(fnumber) {
	new zx;
	switch(fnumber) {
		case 7: zx = 0xFF0000AA;
		case 8: zx = 0xFF0000AA;
		case 9: zx = 0xFF0000AA;
		case 10: zx = 0xFF0000AA;
		case 11: zx = 0xFF0000AA;
	}
	return zx;
}
stock StopSpectate(playerid) {
	SpawnPlayer(playerid);

    SetPlayerPosEx(playerid, TeleportDest[playerid][0],TeleportDest[playerid][1],TeleportDest[playerid][2]);
    SetPlayerInterior(playerid, TeleportDestNoFloat[playerid][0]);
    SetPlayerVirtualWorld(playerid, TeleportDestNoFloat[playerid][1]);
    SetCameraBehindPlayer(playerid);

	TogglePlayerSpectating(playerid, false);
	gSpectateID[playerid] = INVALID_PLAYER_ID;

    if(AdminDuty[playerid] == true) {
		GivePlayerServerWeapon(playerid, 38, 99999);
	}

    svatonabil[playerid] = 1;
	return true;
}
stock StartSpectate(playerid, specid) {
    if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING) {
  		GetPlayerPos(playerid, TeleportDest[playerid][0],TeleportDest[playerid][1],TeleportDest[playerid][2]);
    	TeleportDestNoFloat[playerid][0] = GetPlayerInterior(playerid);
     	TeleportDestNoFloat[playerid][1] = GetPlayerVirtualWorld(playerid);
  	}
	if(IsPlayerInAnyVehicle(specid)) {
		SetPlayerInterior(playerid,GetPlayerInterior(specid));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(specid));
		TogglePlayerSpectating(playerid, true);
		PlayerSpectateVehicle(playerid, GetPlayerVehicleID(specid));
		gSpectateID[playerid] = specid;
	}
	else {
		SetPlayerInterior(playerid,GetPlayerInterior(specid));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(specid));
		TogglePlayerSpectating(playerid, true);
		PlayerSpectatePlayer(playerid, specid);
		gSpectateID[playerid] = specid;
	}
	SpecAd[playerid] = specid;
	SpecID[specid] = playerid;
	return true;
}
stock IsIP(text[]) {
	new numbers;
	for(new i = 0;i < strlen(text); i++)  {
	    if('0' <= text[i] <= '9') {
	        if(!('0' <= text[i+1] <= '9')) {
	            numbers ++;
	        }
	    }
	}
	if(numbers > 4) return true;
	return false;
}
stock DataConnect() {
	connects = mysql_connect(dbHost, dbUser, dbPass, dbBase);
	switch(mysql_errno()) {
		case 0: printf("<> Database connected successful");
		default: printf("<> Database connection errror");
	}
	mysql_log(ERROR | WARNING);
	mysql_set_charset("cp1251");
	// ============
	mysql_tquery(connects, "SELECT * FROM `house`", "LoadHouse", "");
	mysql_tquery(connects, "SELECT * FROM `business`", "LoadBizz", "");
 	mysql_tquery(connects, "SELECT * FROM `fractions`", "LoadFractions", "");
	// ============
}
stock ShowLoginDialog(playerid) {
    new string[1300];
    format(string, sizeof(string), "{FFFFFF}- Mogesalmebit serverze - {F0A45D}Genuine Role Play\
    \n\n{FFFFFF}Sasiamovnoa tkveni naxva isev serverze\
    \n{FFFFFF}Avtorizaciisatvis gtxovt miutitot paroli, romelic daayenet registraciis dros\
    \n\n{F0A45D}* Rodesac miutitebt parols daachiret 'Next' gilaks");
	ShowPlayerDialog(playerid, 100, DIALOG_STYLE_PASSWORD, "{FFFFFF}Avtorizacia", string, "Next", "Cancel");
}
stock ShowRegisterDialog(playerid) {
    new string[1300];
    format(string, sizeof(string), "{FFFFFF}- Mogesalmebit serverze - {F0A45D}Genuine Role Play\
   	\n\n{FFFFFF}Tkven shemoxvedit rogorc axali motamashe, amitom sachiroa registracia\
    \n{FFFFFF}Registraciisatvis gtxovt miutitot paroli, romelsac gamoiyenebt\
    \n{F0A45D}[1]{FFFFFF} Paroli unda iyos daculi da dzlieri\
    \n{F0A45D}[2]{FFFFFF} Paroli unda iyos latinuri asoebit\
    \n{F0A45D}[3]{FFFFFF} Parolis sigrdze unda iyos 8'dan 32 simbolomde\
    \n\n{F0A45D}* Rodesac miutitebt parols daachiret 'Next' gilaks");
	ShowPlayerDialog(playerid, 101, DIALOG_STYLE_INPUT, "{FFFFFF}Registracia", string, "Next", "Cancel");
}
stock ShowEmailDialog(playerid) {
    new string[1300];
    format(string, sizeof(string), "{FFFFFF}- Tkven imyofebit serverze - {F0A45D}Genuine Role Play\
	\n\n{FFFFFF}Tu tkveni account gatyda shegedzlebat agdgena Email'is sashualebit\
    \n{FFFFFF}Usafrtxoebistvis savaldebuloa moqmedi Email'is mititeba\
    \n\n{F0A45D}* Rodesac miutitebt emails daachiret 'Next' gilaks");
	ShowPlayerDialog(playerid, 102, DIALOG_STYLE_INPUT, "{FFFFFF}Registracia", string, "Next", "Cancel");
}
stock ShowAdminDialog(playerid) {
	ShowPlayerDialog(playerid, 202, DIALOG_STYLE_INPUT, "{FFFFFF}Alogin",
	"{FFFFFF}- Mogesalmebat administration system -\n\n\
	{FFFFFF}Uflebebis misagebat sachiroa airchiot admin paroli\n\n\
	{F0A45D}* Miutitet tkveni sasurveli paroli da daachiret 'Next' gilaks",
	"Next", "Cancel");
}
stock UpdateUserData(playerid, field [], data) {
    new query[600];
	format(query, sizeof(query), "UPDATE `accounts` SET `%s` = '%d' WHERE `pName` = '%s' LIMIT 1",field, data, Name(playerid));
	mysql_tquery(connects, query, "", "");
	return 1;
}
stock OnPlayerLogin(playerid, password[]) {
    new mysql_query_[600];
    GetPlayerName(playerid, Name(playerid), MAX_PLAYER_NAME);
	mysql_format(connects, mysql_query_, sizeof(mysql_query_),"SELECT * FROM `accounts` WHERE `pName` = '%e' AND `pPassword` = '%e'", Name(playerid), password);
	mysql_tquery(connects, mysql_query_, "LoginReturn", "ds", playerid, password);
	return true;
}
stock OnAdminLogin(playerid, password[]) {
    new mysql_query_[600];
    GetPlayerName(playerid, Name(playerid), MAX_PLAYER_NAME);
	mysql_format(connects, mysql_query_, sizeof(mysql_query_),"SELECT * FROM `accounts` WHERE `pName` = '%e' AND `pDostup` = '%e'", Name(playerid), password);
	mysql_tquery(connects, mysql_query_, "AdminReturn", "ds", playerid, password);
	return true;	
}
static LoginServerBase(playerid) {	
	new string[600];
 	format(string, sizeof(string), "SELECT * FROM `accounts` WHERE `pName` = '%s'", Name(playerid));
	mysql_query(connects, string);
	new rows;
	cache_get_row_count(rows);
	for new i = 0; i < rows; i++ do {
		cache_get_value_name_int(i, "pID",  UserData[playerid][pID]);
		cache_get_value_name(i, "pName",  Name(playerid));
		cache_get_value_name(i, "pPassword",  UserData[playerid][pPassword]);
		cache_get_value_name(i, "pMail",  UserData[playerid][pMail]);
		cache_get_value_name_int(i, "pSex",  UserData[playerid][pSex]);
		cache_get_value_name_int(i, "pSkin",  UserData[playerid][pSkin]);
		cache_get_value_name_int(i, "pCash",  UserData[playerid][pCash]);
		cache_get_value_name_int(i, "pLevel",  UserData[playerid][pLevel]);
		cache_get_value_name_int(i, "pAdmin",  UserData[playerid][pAdmin]);
		cache_get_value_name_int(i, "pHouse",  UserData[playerid][pHouse]);
		cache_get_value_name_int(i, "pBizz",  UserData[playerid][pBizz]);
		cache_get_value_name_int(i, "pQuest1",  UserData[playerid][pQuest1]);
		cache_get_value_name_int(i, "pQuest2",  UserData[playerid][pQuest2]);
		cache_get_value_name_int(i, "pQuest3",  UserData[playerid][pQuest3]);
		cache_get_value_name_int(i, "pCars",  UserData[playerid][pCars]);

		cache_get_value_name_int(i, "pLeader",  UserData[playerid][pLeader]);
		cache_get_value_name_int(i, "pMember",  UserData[playerid][pMember]);
		cache_get_value_name_int(i, "pForma",  UserData[playerid][pForma]);
		cache_get_value_name_int(i, "pRank",  UserData[playerid][pRank]);

		cache_get_value_name_int(i, "pAdminLogin",  UserData[playerid][pAdminLogin]);
		cache_get_value_name_int(i, "pClock",  UserData[playerid][pClock]);
		cache_get_value_name_int(i, "pMobile",  UserData[playerid][pMobile]);

		cache_get_value_name_int(i, "pMute",  UserData[playerid][pMute]);
		cache_get_value_name_int(i, "pMuteTime",  UserData[playerid][pMuteTime]);

		cache_get_value_name_int(i, "pExp1",  UserData[playerid][pExp][0]);
		cache_get_value_name_int(i, "pExp2",  UserData[playerid][pExp][1]);

		cache_get_value_name_int(i, "pBank",  UserData[playerid][pBank]);

		cache_get_value_name_int(i, "pBan",  UserData[playerid][pBan]);
		cache_get_value_name_int(i, "pBanMounth",  UserData[playerid][pBanMounth]);
		cache_get_value_name_int(i, "pBanDay",  UserData[playerid][pBanDay]);

		cache_get_value_name(i, "pRegIP",  UserData[playerid][pRegIP]);
		cache_get_value_name(i, "pIP",  UserData[playerid][pIP]);

		cache_get_value_name_int(i, "pJailed",  UserData[playerid][pJailed]);
		cache_get_value_name_int(i, "pJailTime",  UserData[playerid][pJailTime]);
		cache_get_value_name_int(i, "pWantedLevel",  UserData[playerid][pWantedLevel]);
	}
	GetPlayerName(playerid, Name(playerid), MAX_PLAYER_NAME);
	SetPlayerToTeamColor(playerid);

	new current = getdate();
	new haj = UserData[playerid][pBanMounth]-current;
	if(haj > 300) {
		UserData[playerid][pBanMounth] = haj-365;
        UpdateUserData(playerid, "pBanMounth", UserData[playerid][pBanMounth]);
	} 
	if(UserData[playerid][pBanMounth] > current && UserData[playerid][pBan] == 1) {
	    format(string, sizeof(string), "Tkvens accounts adevs ban, ban avtomaturad agexsneba %d dgeshi", UserData[playerid][pBanMounth]-current);
	    SendClientMessage(playerid, 0xEF545DFF, string);
	    srvKick(playerid);
	    return true;
	}
	else if(UserData[playerid][pBanMounth] <= current && UserData[playerid][pBan] == 1) {
 		UserData[playerid][pBan] = 0;
 		UserData[playerid][pBanMounth] = 0;
 		UserData[playerid][pBanDay] = 0;

 		UpdateUserData(playerid, "pBan", UserData[playerid][pBan]);
 		UpdateUserData(playerid, "pBanMounth", UserData[playerid][pBanMounth]);
 		UpdateUserData(playerid, "pBanDay", UserData[playerid][pBanDay]);
	}
	else if(UserData[playerid][pBanMounth] > 0 && UserData[playerid][pBan] == 0 || UserData[playerid][pBanDay] > 0 && UserData[playerid][pBan] == 0) {
 		UserData[playerid][pBan] = 0;
 		UserData[playerid][pBanMounth] = 0;
 		UserData[playerid][pBanDay] = 0;

 		UpdateUserData(playerid, "pBan", UserData[playerid][pBan]);
 		UpdateUserData(playerid, "pBanMounth", UserData[playerid][pBanMounth]);
 		UpdateUserData(playerid, "pBanDay", UserData[playerid][pBanDay]);		
	}

	new ip[15]; GetPlayerIp(playerid,ip,15);
 	format(string, sizeof(string), "UPDATE `accounts` SET `pIP` = '%s' WHERE `pName` = '%s'", ip, Name(playerid));
	mysql_query(connects, string);

	SpawnPlayer(playerid);
	SetSpawnInfo(playerid, 0, 0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
    TogglePlayerSpectating(playerid, 0);
    Login[playerid] = true;
    LoginWarning[playerid] = 0;
	GetNumberCars(playerid,UserData[playerid][pCars]);
	for(new i = 0; i < OWNABLECARS; i++) {
		if(IsPlayersCar(playerid,OwnableCar[i]))
		{
		    new carid = GetVehicleID(OwnableCar[i]);
			SetVehicleVirtualWorld(OwnableCar[i], 0);
			SetVehicleToRespawn(OwnableCar[i]);
			CarInfo[carid][cLock] = 1;
			SetDoorsStatus(OwnableCar[i], 1);
		}
	}
    return true;
}
stock acc_int_strcat(query[], len, name[], number) {
	new string[100];
	format(string, sizeof(string), "`%s` = '%d',",name, number);
	strcat(query, string, len);
	return true;
}
stock acc_str_strcat(query[], len, name[], str[]) {
	new string[100];
	format(string, sizeof(string), "`%s` = '%s',",name, str);
	strcat(query, string, len);
	return true;
}
stock acc_float_strcat(query[], len, name[], Float:number) {
	new string[100];
	format(string, sizeof(string), "`%s` = '%f',", name, number);
	strcat(query, string, len);
	return true;
}
stock PlayerRegisterSetting(playerid) {
	UserData[playerid][pCash] = 1000; UpdateUserData(playerid, "pCash", UserData[playerid][pCash]);
	UserData[playerid][pLevel] = 1; UpdateUserData(playerid, "pLevel", UserData[playerid][pLevel]);
	UserData[playerid][pAdmin] = 0; UpdateUserData(playerid, "pAdmin", UserData[playerid][pAdmin]);
	UserData[playerid][pHouse] = -1; UpdateUserData(playerid, "pHouse", UserData[playerid][pHouse]);
	UserData[playerid][pBizz] = -1; UpdateUserData(playerid, "pBizz", UserData[playerid][pBizz]);
	UserData[playerid][pQuest1] = 0; UpdateUserData(playerid, "pQuest1", UserData[playerid][pQuest1]);
	UserData[playerid][pQuest2] = 0; UpdateUserData(playerid, "pQuest2", UserData[playerid][pQuest2]);
	UserData[playerid][pQuest3] = 0; UpdateUserData(playerid, "pQuest3", UserData[playerid][pQuest3]);
	UserData[playerid][pCars] = 0; UpdateUserData(playerid, "pCars", UserData[playerid][pCars]);


	UserData[playerid][pLeader] = 0; UpdateUserData(playerid, "pLeader", UserData[playerid][pLeader]);
	UserData[playerid][pMember] = 0; UpdateUserData(playerid, "pMember", UserData[playerid][pMember]);
	UserData[playerid][pForma] = 0; UpdateUserData(playerid, "pForma", UserData[playerid][pForma]);
	UserData[playerid][pRank] = 0; UpdateUserData(playerid, "pRank", UserData[playerid][pRank]);

	UserData[playerid][pAdminLogin] = 0; UpdateUserData(playerid, "pAdminLogin", UserData[playerid][pAdminLogin]);

	UserData[playerid][pClock] = 0; UpdateUserData(playerid, "pClock", UserData[playerid][pClock]);
	UserData[playerid][pMobile] = 0; UpdateUserData(playerid, "pMobile", UserData[playerid][pMobile]);

	UserData[playerid][pMute] = 0; UpdateUserData(playerid, "pMute", UserData[playerid][pMute]);
	UserData[playerid][pMuteTime] = 0; UpdateUserData(playerid, "pMuteTime", UserData[playerid][pMuteTime]);

	UserData[playerid][pExp][0] = 0; UpdateUserData(playerid, "pExp1", UserData[playerid][pExp][0]);
	UserData[playerid][pExp][1] = 2; UpdateUserData(playerid, "pExp2", UserData[playerid][pExp][1]);

	UserData[playerid][pBank] = 0; UpdateUserData(playerid, "pBank", UserData[playerid][pBank]);

	UserData[playerid][pBan] = 0; UpdateUserData(playerid, "pBan", UserData[playerid][pBan]);
	UserData[playerid][pBanMounth] = 0; UpdateUserData(playerid, "pBanMounth", UserData[playerid][pBanMounth]);
	UserData[playerid][pBanDay] = 0; UpdateUserData(playerid, "pBanDay", UserData[playerid][pBanDay]);

	UserData[playerid][pJailed] = 0; UpdateUserData(playerid, "pJailed", UserData[playerid][pJailed]);
	UserData[playerid][pJailTime] = 0; UpdateUserData(playerid, "pJailTime", UserData[playerid][pJailTime]);
	UserData[playerid][pWantedLevel] = 0; UpdateUserData(playerid, "pWantedLevel", UserData[playerid][pWantedLevel]);
}
stock ResetPlayer(playerid) {
	gFam[playerid] = 0;
	Login[playerid] = false;
	LoginTime[playerid] = 0;
	LoginSec[playerid] = 0;
	AdminDuty[playerid] = false;
	//---------------------
	PlayerCuffed[playerid] = 0;
	PlayerCuffedTime[playerid] = 0;
	gotome[playerid] = -1;
	//---------------------
	AFK[playerid] = 0;
	AFKTime[playerid] = 0;
	//---------------------
	admincar[playerid] = -1;
	shopcar[playerid] = -1;
	cleanercar[playerid] = -1;
	CleanerJob[playerid] = 0;
	CleanerCP[playerid] = 0;
	// --------------------
	rentID[playerid] = -1;
	//---------------------
	WarehouseJob[playerid] = 0;
	WarehouseSuc[playerid] = 0;
	WareCP[playerid] = 0;

	MtvirtaviJob[playerid] = 0;
	MtvirtaviCP[playerid] = 0;
	//---------------------
	Materials[playerid] = 0;
	Drugs[playerid] = 0;
	//---------------------
	LoginWarning[playerid] = 0;
	//---------------------
	AnimOn[playerid] = false;
	//---------------------
	Payment[playerid] = 0;
	//---------------------
	DMArena[playerid] = 0;
	//---------------------
	Tazer[playerid] = false;
	Tazed[playerid] = false;
	//---------------------
	svatonabil[playerid] = 0;
	//---------------------
	MyCarHouse[playerid] = -1;
	//---------------------
	KnocInfo[playerid][kID] = 0;
	KnocInfo[playerid][kActive] = 0;
	KnocInfo[playerid][kX] = 0;
	KnocInfo[playerid][kY] = 0;
	KnocInfo[playerid][kZ] = 0;
	KnocInfo[playerid][kInt] = 0;
	KnocInfo[playerid][kVW] = 0;
	KnocInfo[playerid][dTimer] = 0;
	//---------------------
	vehicleidtp[playerid] = INVALID_VEHICLE_ID;
}
stock SetPlayerSpawn(playerid) {
	if(GetPVarInt(playerid, "RegisterSpawn") == 1) {
		SetPlayerPosEx(playerid, 0.6863,25.3015,1199.5938);
		SetPlayerFacingAngle(playerid, 358.3350);
		SetPlayerInterior(playerid, 1);
		SetPlayerVirtualWorld(playerid, 0);
		AnimOn[playerid] = true;
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid,"PED","SEAT_down",4.1,0,0,0,1,1,1);
		new string[100];
		format(string, sizeof(string), "~w~Waiting...");
		GameTextForPlayer(playerid, string, 10000, 1);
		
		SetPlayerCameraPos(playerid, 1.8101,26.9155,1199.5938);
		SetPlayerCameraLookAt(playerid, 0.6863,25.3015,1199.5938);

		SetTimerEx("RegistrationComplate", 10000, false, "i", playerid);
	}
	else if(KnocInfo[playerid][kActive] > 0) {
		SetPlayerPosEx(playerid, KnocInfo[playerid][kX], KnocInfo[playerid][kY], KnocInfo[playerid][kZ]);
		SetPlayerInterior(playerid, KnocInfo[playerid][kInt]);
		SetPlayerVirtualWorld(playerid, KnocInfo[playerid][kVW]);

		TogglePlayerControllable(playerid, 0);
		SetTimerEx("SetAnimationKnock", 100, false, "i", playerid);
		SetTimerEx("SetAnimationKnock", 500, false, "i", playerid);

		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{FFFFFF}Status",
		"{FFFFFF}- Tkven xart {EF545D}sasikvdilod dachrili -\
	    \n\n{FFFFFF}Tkveni informacia daafiqsires kamerebma da sheuvidat hospitalshi\
	    \n\n{EF545D}Tu saswrafo daxmarebam ver mogiswrot tkven daiclebit sisxlisgan\
	    \n\n{FFFFFF}Tkven sisxlisgan daiclebit - {EF545D}3 wutshi", "Cancel", "");
	    return true;
	}
	else if(DMArena[playerid] == 1) {
 		new rand = random(sizeof(DmRandom));
		SetPlayerPosEx(playerid, DmRandom[rand][0], DmRandom[rand][1], DmRandom[rand][2]);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "dmVW"));

		GivePlayerServerWeapon(playerid, GetPVarInt(playerid,"DMGun1"), 1000);
  		GivePlayerServerWeapon(playerid, GetPVarInt(playerid,"DMGun2"), 1000);
  		SetPlayerHealth(playerid, GetPVarInt(playerid, "DmHealth"));
  		return true;
	}
	else if(UserData[playerid][pJailed] > 0) {
		SetPlayerPosEx(playerid, 215.4633,110.8372,999.0156);
		SetPlayerFacingAngle(playerid, 1.4125);
		SetPlayerInterior(playerid, 10);
		SetPlayerVirtualWorld(playerid, 0);		
	}
	else if(UserData[playerid][pMember] > 0) {
		switch(UserData[playerid][pMember]) {
			case 1: {
				SetPlayerPosEx(playerid, 273.3686,114.4585,1008.8203);
		    	SetPlayerFacingAngle(playerid, 92.4765);
		        SetPlayerInterior(playerid, 10);
		        SetPlayerVirtualWorld(playerid, 0);
		        return true;
			}
			case 2: {
				SetPlayerPosEx(playerid, 1959.1040,202.5674,1501.0859); // hospital gachena fraqcia
		    	SetPlayerFacingAngle(playerid, 293.2269);
		        SetPlayerInterior(playerid, 3);
		        SetPlayerVirtualWorld(playerid, 1);
		        return true;
			}
			case 3: {
				SetPlayerPosEx(playerid, 370.5760,176.6910,1019.9844);
		    	SetPlayerFacingAngle(playerid, 92.2578);
		        SetPlayerInterior(playerid, 3);
		        SetPlayerVirtualWorld(playerid, 0);
		        return true;
			}
			case 5: {
				SetPlayerPosEx(playerid, 1257.2319,-795.0659,1084.2344);
				SetPlayerFacingAngle(playerid, 272.7161);
				SetPlayerInterior(playerid, 5);
		        SetPlayerVirtualWorld(playerid, 5);
			}
			case 6: {
				SetPlayerPosEx(playerid, -331.1997,2835.9875,943.3176);
				SetPlayerFacingAngle(playerid, 309.4511);
				SetPlayerInterior(playerid, 0);
		        SetPlayerVirtualWorld(playerid, 0);
			}
			case 7: {
				SetPlayerPosEx(playerid, 324.1671,1122.8752,1083.8828);
		    	SetPlayerFacingAngle(playerid, 141.0339);
		        SetPlayerInterior(playerid, 5);
		        SetPlayerVirtualWorld(playerid, 7);
		        return true;
			}
			case 8: {
				SetPlayerPosEx(playerid, 324.1671,1122.8752,1083.8828);
		    	SetPlayerFacingAngle(playerid, 141.0339);
		        SetPlayerInterior(playerid, 5);
		        SetPlayerVirtualWorld(playerid, 8);
		        return true;
			}
			case 9: {
				SetPlayerPosEx(playerid, 324.1671,1122.8752,1083.8828);
		    	SetPlayerFacingAngle(playerid, 141.0339);
		        SetPlayerInterior(playerid, 5);
		        SetPlayerVirtualWorld(playerid, 9);
		        return true;
			}
			case 10: {
				SetPlayerPosEx(playerid, 324.1671,1122.8752,1083.8828);
		    	SetPlayerFacingAngle(playerid, 141.0339);
		        SetPlayerInterior(playerid, 5);
		        SetPlayerVirtualWorld(playerid, 10);
		        return true;
			}
			case 11: {
				SetPlayerPosEx(playerid, 324.1671,1122.8752,1083.8828);
		    	SetPlayerFacingAngle(playerid, 141.0339);
		        SetPlayerInterior(playerid, 5);
		        SetPlayerVirtualWorld(playerid, 11);
		        return true;
			}
		}
	}
	else if(UserData[playerid][pHouse] != -1) {
		SetPlayerInterior(playerid, HouseData[UserData[playerid][pHouse]][hInt]);
		SetPlayerVirtualWorld(playerid, UserData[playerid][pHouse] + 50);
		SetPlayerPosEx(playerid, HouseData[UserData[playerid][pHouse]][hSpawnX], HouseData[UserData[playerid][pHouse]][hSpawnY], HouseData[UserData[playerid][pHouse]][hSpawnZ]);
		SetPlayerFacingAngle(playerid, HouseData[UserData[playerid][pHouse]][hSpawnF]);
		return true;
	}
	else if(UserData[playerid][pLevel] > 0) {
		SetPlayerPosEx(playerid, 1685.2493,-2332.3391,-2.6797);
		SetPlayerFacingAngle(playerid, 0.9397);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetCameraBehindPlayer(playerid);
		return true;	
	}
	return true;
}
stock SetPlayerPosEx(playerid, Float:x, Float:y, Float:z) {
    TogglePlayerControllable(playerid, 0);
	SetPlayerPos(playerid, x, y, z);
	SetTimerEx("UnFreeze", 2000, false, "i", playerid);
	SetCameraBehindPlayer(playerid);
}
stock PutPlayerInVehicleEx(playerid,vehicleid,seatid) {
	vehicleidtp[playerid] = vehicleid;
	PutPlayerInVehicle(playerid,vehicleid,seatid);
}
stock GiveUserMoney(playerid, money) {
	UserData[playerid][pCash] += money;
	UpdateUserData(playerid, "pCash", UserData[playerid][pCash]);
	new string[60 + MAX_PLAYER_NAME - 4 + 20];
	if(money > 0) format(string, sizeof(string), "~g~+%d$", money);
	else format(string, sizeof(string), "~r~%d$", money);
	GameTextForPlayer(playerid, string, 1000, 1);
}
stock CaptureTextDraws(playerid) {
	#include "../../library/txd/capture"
}
stock LoadTextdraws() {
	#include "../../library/txd/rent"
	#include "../../library/txd/skin"
	#include "../../library/txd/carshop"
}
stock LoadPlayerTextdraws(playerid) {
	#include "../../library/txd/quest"
	#include "../../library/txd/press"
	#include "../../library/txd/payment"
	#include "../../library/txd/rent_p"
	#include "../../library/txd/event"
}
stock LoadMaps() {
	#include "../../library/map/spray"
	#include "../../library/map/grotti"
	#include "../../library/map/garage"
	#include "../../library/map/police"
	#include "../../library/map/hospital"

	#include "../../library/map/Sheriff1"
	#include "../../library/map/Sheriff2"
}
stock LoadMapIcons() {
	CreateDynamicMapIcon(1610.8766,-1893.8865,13.5469, 56, 0); // Cleaner
	CreateDynamicMapIcon(854.5874,-605.2051,18.4219, 56, 0); // Warehouse

	CreateDynamicMapIcon(1555.5001,-1675.6489,16.1953, 30, 0); // Police
	CreateDynamicMapIcon(626.9648,-571.7481,17.9207, 30, 0); // Sheriff

	CreateDynamicMapIcon(2650.7002,-2021.7686,14.1766, 59, 0); // Ballas
	CreateDynamicMapIcon(2756.3967,-1182.8093,69.4035, 60, 0); // Vagos
	CreateDynamicMapIcon(2495.3989,-1691.1401,14.7656, 62, 0); // Grove
	CreateDynamicMapIcon(1667.4960,-2106.9409,14.0723, 58, 0); // Aztecas
	CreateDynamicMapIcon(1885.8810,-1113.6509,26.2758, 61, 0); // Rifa
}
stock Load3DTexts() {
	CreateDynamic3DTextLabel("{FFFFFF}Press : {F0A45D}(ALT)", -1, 2539.5708,-1299.5469,1044.1250, 10.0); // Iaraghis Qarxana
	CreateDynamic3DTextLabel("{FFFFFF}Press : {F0A45D}(ALT)", -1, 2175.9668,-2259.2197,14.7734, 10.0); // Warehouse actor


	FractionPosText[0] = Create3DTextLabel("_", 0x36A8CFAA, 320.9207,1116.8724,1083.8828, 10.0, 7, 1);
    FractionPosText[1] = Create3DTextLabel("_", 0x36A8CFAA, 320.9207,1116.8724,1083.8828, 10.0, 8, 1);
    FractionPosText[2] = Create3DTextLabel("_", 0x36A8CFAA, 320.9207,1116.8724,1083.8828, 10.0, 9, 1);
    FractionPosText[3] = Create3DTextLabel("_", 0x36A8CFAA, 320.9207,1116.8724,1083.8828, 10.0, 10, 1);
    FractionPosText[4] = Create3DTextLabel("_", 0x36A8CFAA, 320.9207,1116.8724,1083.8828, 10.0, 11, 1);
}
stock LoadAcotrs() {
	ActorWR = CreateActor(30, 2539.5708,-1299.5469,1044.1250,359.5016);
	SetActorVirtualWorld(ActorWR, 0);
	SetActorFacingAngle(ActorWR, 359.5016);
	SetActorInvulnerable(ActorWR, true);


	ActorMtvirtavi = CreateActor(30, 2175.9668,-2259.2197,14.7734,269.5703);
	SetActorVirtualWorld(ActorMtvirtavi, 0);
	SetActorFacingAngle(ActorMtvirtavi, 269.5703);
	SetActorInvulnerable(ActorMtvirtavi, true);
}
stock CreatePickupAlt(modelid, type, Float:x, Float:y, Float:z, virtualworld, plus) {
	CreateDynamicPickup(modelid, type, x, y, z, virtualworld, -1, -1, 50.0);
	CreateDynamic3DTextLabel("{FFFFFF}Press : {F0A45D}(ALT)", -1, x, y, z+plus, 5.0);
}
stock LoadePickups() {
	CreatePickupAlt(1210, 23, 1610.8766,-1893.8865,13.5469, 0, 0); 
	CreatePickupAlt(19134,23, 1685.6632,-2312.7805,-2.6686, 0, 0); // Rent car
	
	CreatePickupAlt(1210,23, 1391.6912,-27.4429,1000.8630, -1, -1); // Autosalon enter
	
	// ----- //
	CreatePickupAlt(18635, 23, 2558.5356,-1295.8503,1044.1250-1, 0, 1); // Warehouses
	CreatePickupAlt(18635, 23, 2556.1470,-1295.8507,1044.1250-1, 0, 1); // Warehouses
	CreatePickupAlt(18635, 23, 2553.7817,-1295.8510,1044.1250-1, 0, 1); // Warehouses
	// ----- // Changeskin for gangs ----- //
	CreatePickupAlt(1275, 23, 306.3511,1120.5734,1083.8828, -1, 0);
	// ----- //
	WarehousePic = CreateDynamicPickup(19832, 23, 2564.7886,-1293.0100,1044.1250-0.5, 0, -1, -1, 50.0);

	MtvirtaviPic = CreateDynamicPickup(19832, 23, 2172.4861,-2255.8503,13.3043-0.5, 0, -1, -1, 50.0);

	CreatePickupAlt(2060, 23, 2231.8831,-2284.7131,14.3751-1, 0, 1); // Warehouses


	new str[500];
	format(str, sizeof(str), "{FFFFFF}Materialebis raodenoba : {F0A45D}%d\
	\n{FFFFFF}Sashualod titouli materialis fasi : {F0A45D}150$");
	TotalJobMat = CreateDynamic3DTextLabel(str, -1, 2564.7886,-1293.0100,1044.1250, 5.0);
}
stock UpdateJobMaterials() {
	new str[500];
	format(str, sizeof(str), "{FFFFFF}Materialebis raodenoba : {F0A45D}%d\
	\n{FFFFFF}Sashualod titouli materialis fasi : {F0A45D}150$", TotalJobMaterials);
	UpdateDynamic3DTextLabelText(TotalJobMat, -1, str);
}
stock UpdateHouse(h) {
	new hclass[50];
	switch(HouseData[h][hClass]) {
	    case 1: hclass = "N";
	    case 2: hclass = "C";
	    case 3: hclass = "B";
	    case 4: hclass = "A";
	}
	if(!HouseData[h][hOwned]) {
		DestroyDynamicMapIcon(HouseData[h][hIcon]);
		HouseData[h][hIcon] = CreateDynamicMapIcon(HouseData[h][hEnterX], HouseData[h][hEnterY], HouseData[h][hEnterZ], 31, 0);
		DestroyDynamicPickup(HouseCP[h]);
		HouseCP[h] = CreateDynamicPickup(1273, 23, HouseData[h][hEnterX], HouseData[h][hEnterY], HouseData[h][hEnterZ], 0, -1, -1, 50.0);
		new string[200];
		format(string,sizeof(string), "\
			{2ECC71} Saxli iyideba \n\n\
			{F0A45D}Saxlis nomeri : {FFFFFF}%d\n\
			{F0A45D}Saxlis klasi : {FFFFFF}%s\n\
			{F0A45D}Safasuri : {FFFFFF}$%d",
			HouseData[h][hID],
			hclass,
			HouseData[h][hPrice]
		);
		UpdateDynamic3DTextLabelText(House3DText[h], -1, string);
	}
	if(HouseData[h][hOwned]) {
		DestroyDynamicMapIcon(HouseData[h][hIcon]);
		HouseData[h][hIcon] = CreateDynamicMapIcon(HouseData[h][hEnterX], HouseData[h][hEnterY], HouseData[h][hEnterZ], 32, 0);
		DestroyDynamicPickup(HouseCP[h]);
		HouseCP[h] = CreateDynamicPickup(19522, 23, HouseData[h][hEnterX], HouseData[h][hEnterY], HouseData[h][hEnterZ], 0, -1, -1, 50.0);
		static const dour_status[2][40 + 1] = {
		"{FFFFFF}Gaxsnilia",
		"{FFFFFF}Daxurulia"
		};
		
		new string[200];
		format(string,sizeof(string), "\
			{EF545D} Saxli dakavebulia \n\n\
			{F0A45D}Saxlis nomeri : {FFFFFF}%d\n\
			{F0A45D}Saxlis klasi : {FFFFFF}%s\n\
			{F0A45D}Mflobeli : {FFFFFF}%s\n\
			{F0A45D}Karebi : %s",
			HouseData[h][hID],
			hclass,
			HouseData[h][hOwner],
			dour_status[HouseData[h][hLock]]
		);
		UpdateDynamic3DTextLabelText(House3DText[h], -1, string);
	}
	return 1;
}
stock SaveHouse(house) {
    new query[600];
	new string[128];
	query = "UPDATE `house` SET ";
	acc_float_strcat(query, sizeof(query), "hEnterX", HouseData[house][hEnterX]);
	acc_float_strcat(query, sizeof(query), "hEnterY", HouseData[house][hEnterY]);
	acc_float_strcat(query, sizeof(query), "hEnterZ", HouseData[house][hEnterZ]);
	acc_float_strcat(query, sizeof(query), "hExitX", HouseData[house][hExitX]);
	acc_float_strcat(query, sizeof(query), "hExitY", HouseData[house][hExitY]);
	acc_float_strcat(query, sizeof(query), "hExitZ", HouseData[house][hExitZ]);
	acc_str_strcat(query, sizeof(query), "hOwner", HouseData[house][hOwner]);
	acc_int_strcat(query, sizeof(query), "hPrice", HouseData[house][hPrice]);
	acc_int_strcat(query, sizeof(query), "hInt", HouseData[house][hInt]);
	acc_int_strcat(query, sizeof(query), "hLock", HouseData[house][hLock]);
	acc_int_strcat(query, sizeof(query), "hOwned", HouseData[house][hOwned]);
	acc_int_strcat(query, sizeof(query), "hClass", HouseData[house][hClass]);
	acc_float_strcat(query, sizeof(query), "hSpawnX", HouseData[house][hSpawnX]);
	acc_float_strcat(query, sizeof(query), "hSpawnY", HouseData[house][hSpawnY]);
	acc_float_strcat(query, sizeof(query), "hSpawnZ", HouseData[house][hSpawnZ]);
	acc_float_strcat(query, sizeof(query), "hSpawnF", HouseData[house][hSpawnF]);
	acc_int_strcat(query, sizeof(query), "hGarage", HouseData[house][hGarage]);
	acc_float_strcat(query, sizeof(query), "hCarx", HouseData[house][hCarx]);
	acc_float_strcat(query, sizeof(query), "hCary", HouseData[house][hCary]);
	acc_float_strcat(query, sizeof(query), "hCarz", HouseData[house][hCarz]);
	acc_float_strcat(query, sizeof(query), "hCarc", HouseData[house][hCarc]);
	strdel(query, strlen(query)-1, strlen(query));
	format(string,sizeof(string),"WHERE `hID` = '%d'", HouseData[house][hID]);
	strcat(query, string);
	mysql_tquery(connects, query, "", "");
}
stock SaveBizz(bizz) {
    new query[600];
	new string[128];
	query = "UPDATE `business` SET ";
	acc_float_strcat(query, sizeof(query), "bEnterX", BizzData[bizz][bEnterX]);
	acc_float_strcat(query, sizeof(query), "bEnterY", BizzData[bizz][bEnterY]);
	acc_float_strcat(query, sizeof(query), "bEnterZ", BizzData[bizz][bEnterZ]);
	acc_float_strcat(query, sizeof(query), "bExitX", BizzData[bizz][bExitX]);
	acc_float_strcat(query, sizeof(query), "bExitY", BizzData[bizz][bExitY]);
	acc_float_strcat(query, sizeof(query), "bExitZ", BizzData[bizz][bExitZ]);
	acc_float_strcat(query, sizeof(query), "bBuyX", BizzData[bizz][bBuyX]);
	acc_float_strcat(query, sizeof(query), "bBuyY", BizzData[bizz][bBuyY]);
	acc_float_strcat(query, sizeof(query), "bBuyZ", BizzData[bizz][bBuyZ]);
	acc_str_strcat(query, sizeof(query), "bOwner", BizzData[bizz][bOwner]);
	acc_int_strcat(query, sizeof(query), "bPrice", BizzData[bizz][bPrice]);
	acc_int_strcat(query, sizeof(query), "bInt", BizzData[bizz][bInt]);
	acc_int_strcat(query, sizeof(query), "bLock", BizzData[bizz][bLock]);
	acc_int_strcat(query, sizeof(query), "bOwned", BizzData[bizz][bOwned]);
	acc_int_strcat(query, sizeof(query), "bType", BizzData[bizz][bType]);
	acc_int_strcat(query, sizeof(query), "bTypeID", BizzData[bizz][bTypeID]);
	acc_int_strcat(query, sizeof(query), "bIcon", BizzData[bizz][bIcon]);
	acc_int_strcat(query, sizeof(query), "bBank", BizzData[bizz][bBank]);
	strdel(query, strlen(query)-1, strlen(query));
	format(string,sizeof(string),"WHERE `bID` = '%d'", BizzData[bizz][bID]);
	strcat(query, string);
	mysql_tquery(connects, query, "", "");
}
stock AnRepairVehicle(vehicleid) {
	RepairVehicle(vehicleid);
	SetVehicleHealth(vehicleid, 1300);
	return true;
}
stock QuestMessage(playerid, job[], value[]) { 
    PlayerTextDrawSetString(playerid, QuestTD[playerid][2], job);
    PlayerTextDrawSetString(playerid, QuestTD[playerid][4], value);
	for(new i = 0; i < 5; i++) PlayerTextDrawShow(playerid, QuestTD[playerid][i]);
	SetTimerEx("UnHideQuest", 10000, false, "i", playerid);
}
stock GetWeaponSlot(weaponid) {
 	new slot;
 	switch(weaponid) {
   		case 0,1: slot = 0;
   		case 2..9: slot = 1;
   		case 22..24: slot = 2;
   		case 25..27: slot = 3;
   		case 28,29,32: slot = 4;
   		case 30,31: slot = 5;
   		case 33,34: slot = 6;
   		case 35..38: slot = 7;
   		case 16..18,39: slot = 8;
   		case 41..43: slot = 9;
   		case 10..15: slot = 10;
		case 44..46: slot = 11;
	 	case 40: slot = 12;
	 	default: slot = -1;
 	}
 	return slot;
}
stock GivePlayerServerWeapon(playerid, weapid, ammo) {
	new weap = GetWeaponSlot(weapid);
	AGun[playerid][weapid] = true;
	AGunAmmo[playerid][weap] += ammo;
	GivePlayerWeapon(playerid, weapid, ammo);
	return true;
}
stock GetWeaponeName(weaponid) {
	new wtext[50];
	switch(weaponid) {
		case 22: wtext = "Colt 45";
		case 24: wtext = "Desert Eagle";
		case 25: wtext = "Shotgun";
		case 28: wtext = "UZI";
		case 29: wtext = "MP5";
		case 30: wtext = "AK-47";
		case 31: wtext = "MP4";
		case 32: wtext = "TEC9";
		case 33: wtext = "Rifle";
		default: wtext = "Unknown";
	}
	return wtext;
}
stock SendAdminMessage(color, string[]) {
    foreach(new i:Player) {
		if(!Login[i]) continue;
		if(!UserData[i][pAdmin] && !UserData[i][pAdminLogin]) continue;
		SendClientMessage(i, color, string);
    }
}
stock FixHour(hour) {
	hour = timeshift+hour;
	if (hour < 0) { hour = hour+24; }
	else if (hour > 23) { hour = hour-24; }
	shifthour = hour;
	return 1;
}
stock CheckHour() {
	new hour, minute, second, tmphour, tmpminute, tmpsecond;
	gettime(hour, minute, second);
	gettime(tmphour, tmpminute, tmpsecond);
	FixHour(tmphour);
	tmphour = shifthour;
	if ((tmphour > ghour) || (tmphour == 0 && ghour == 23)) {
		ghour = tmphour;
		new string[100];
		format(string, sizeof(string), "Mimdinare dro aris {F0A45D}%d:00{FFFFFF} saati", ghour);
		SendClientMessageToAll(-1, string);
		if (realtime) SetWorldTime(tmphour);
		ClearTotalGz();
		for(new i = 0; i < 20; i++) FrakCD[i] = 0;
		for(new i = 0; i < sizeof(ZoneInfo); i++) {
			if(ZoneInfo[i][gFrakVlad] == 7) TotalGzB++;
			if(ZoneInfo[i][gFrakVlad] == 8) TotalGzV++;
			if(ZoneInfo[i][gFrakVlad] == 9) TotalGzG++;
			if(ZoneInfo[i][gFrakVlad] == 10) TotalGzA++;
			if(ZoneInfo[i][gFrakVlad] == 11) TotalGzR++;
		}
		SetTimer("start_capture", 1000, 0);
		SetTimer("stop_capture", 300000, 0);
		PayDay();
    }
}
stock ClearTotalGz() {
	TotalGzR = 0;
	TotalGzA = 0;
	TotalGzB = 0;
	TotalGzG = 0;
	TotalGzV = 0;
}
stock srvKick(playerid) {
	SendClientMessage(playerid, -1, "Tkven gaikiket serveridan, gasasvlelad gamoiyenet - /q(uit)");
	SetTimerEx("kick", 80, false, "i", playerid);
}
stock Developer(playerid) {
	new ip[MAX_PLAYER_NAME];
	GetPlayerIp(playerid,ip,sizeof(ip));
	if (!strcmp(ip, "46.49.61.103", true)
	|| !strcmp(ip, "31.146.127.111", true)
	|| !strcmp(ip, "192.168.50.44", true)
	|| !strcmp(ip, "94.43.98.114", true)) {
		return true;
	}
	return false;
}
stock split(const strsrc[], strdest[][], delimiter) {
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)) {
		if(strsrc[i] == delimiter || i == strlen(strsrc)) {
			len = strmid(strdest[aNum], strsrc, li, i, 128);
			strdest[aNum][len] = 0;
			li = i+1;
			aNum++;
		}
		i++;
	}
	return true;
}
stock GetFractionName(fnumbwer){
	new string[30];
	switch(fnumbwer) {
		case 1: format(string,sizeof(string), "Police Departament");
		case 2: format(string,sizeof(string), "Hospital Departament");
		case 3: format(string,sizeof(string), "City Hall");
		case 4: format(string,sizeof(string), "Armed Forces");
		case 5: format(string,sizeof(string), "Sacra Dennaro Unita");
		case 6: format(string,sizeof(string), "Sheriff Station");
		case 7: format(string,sizeof(string), "The Ballas");
		case 8: format(string,sizeof(string), "Los Santos Vagos");
		case 9: format(string,sizeof(string), "Grove Street");
		case 10: format(string,sizeof(string), "Varios Los Aztecas");
		case 11: format(string,sizeof(string), "The Rifa");
	}
	return string;
}
stock CreateVehicles(){
	#include "../../library/vehicles/veh_ghetto"
	#include "../../library/vehicles/veh_gov"
	return true;
}
stock GetGangName(fnumbwer) {
	new string[30];
	switch(fnumbwer) {
		case 7: format(string,sizeof(string), "The Ballas");
		case 8: format(string,sizeof(string), "Los Santos Vagos");
		case 9: format(string,sizeof(string), "Grove Street");
		case 10: format(string,sizeof(string), "Varios Los Aztecas");
		case 11: format(string,sizeof(string), "The Rifa");
	}
	return string;
}
stock NextCar(playerid) {
    if (UserData[playerid][SalonTime] > gettime()) return GameTextForPlayer(playerid, "Loading...", 1000, 3);

    new currentCar = GetPVarInt(playerid, "SelectAvto");

    if (currentCar < sizeof(ShopCar) - 1) {
        SetPVarInt(playerid, "SelectAvto", currentCar + 1);
    } else {
        SetPVarInt(playerid, "SelectAvto", 0);
    }
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
    return ShowingCar(playerid);
}

stock BackCar(playerid) {
    if (UserData[playerid][SalonTime] > gettime()) return GameTextForPlayer(playerid, "Loading...", 1000, 3);

    new currentCar = GetPVarInt(playerid, "SelectAvto");

    if (currentCar > 0) {
        SetPVarInt(playerid, "SelectAvto", currentCar - 1);
    } else {
        SetPVarInt(playerid, "SelectAvto", sizeof(ShopCar) - 1); 
    }
	PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
    return ShowingCar(playerid);
}
stock ShowingCar(playerid) {
	if(UserData[playerid][SalonCar] != INVALID_VEHICLE_ID) DestroyVehicle(UserData[playerid][SalonCar]);
	UserData[playerid][SalonCar] = CreateVehicle(ShopCar[GetPVarInt(playerid, "SelectAvto")][0],-1658.7123,1212.8981,20.9499,285.2443,1,1,-1);
	SetVehicleParamsEx(UserData[playerid][SalonCar],false,false,false,false,false,false,false);
	SetVehicleVirtualWorld(UserData[playerid][SalonCar], GetPlayerVirtualWorld(playerid));
	PutPlayerInVehicle(playerid,UserData[playerid][SalonCar],0);
	SetPlayerInterior(playerid, 0);
	LinkVehicleToInterior(ShopCar[GetPVarInt(playerid, "SelectAvto")][0], 0);
	SetPlayerCameraPos(playerid,-1654.097045,1218.596679,22.708799);
	SetPlayerCameraLookAt(playerid,-1659.106201,1210.380737,19.987318);
	SetPVarInt(playerid,"BuyColor",0);
	SetPVarInt(playerid,"BuyColor1",0);
	new string[1024];
	format(string,128,"~n~~n~~n~~n~~n~~n~~n~~n~~b~NAME: ~w~%s~n~~g~COST: ~w~%i~n~~y~COLOR1: ~w~-1 ~y~COLOR2: ~w~-1",VehicleNames[ShopCar[GetPVarInt(playerid, "SelectAvto")][0]-400],ShopCar[GetPVarInt(playerid, "SelectAvto")][1]);
	GameTextForPlayer(playerid,string, 5000, 3);
	format(string,128,"Model: %s~n~Cost: %i",VehicleNames[ShopCar[GetPVarInt(playerid, "SelectAvto")][0]-400],ShopCar[GetPVarInt(playerid, "SelectAvto")][1]);
	PlayerTextDrawSetString(playerid,ShopText[playerid],string);
	UserData[playerid][SalonTime] = gettime()+1;
	return 1;
}

stock NextColor(playerid,whocolor) {
	if(whocolor == 0) {
		SetPVarInt(playerid,"BuyColor",GetPVarInt(playerid,"BuyColor")+1);
		if(GetPVarInt(playerid,"BuyColor") > 125) SetPVarInt(playerid,"BuyColor",0);
	}
	else {
		SetPVarInt(playerid,"BuyColor1",GetPVarInt(playerid,"BuyColor1")+1);
		if(GetPVarInt(playerid,"BuyColor1") > 125) SetPVarInt(playerid,"BuyColor1",0);
	}
	ChangeVehicleColor(GetPlayerVehicleID(playerid),GetPVarInt(playerid,"BuyColor"),GetPVarInt(playerid,"BuyColor1"));
	new string[1024];
	format(string,128,"~n~~n~~n~~n~~n~~n~~n~~n~~b~NAME: ~w~%s~n~~g~COST: ~w~%i~n~~y~COLOR1: ~w~%i ~y~COLOR2: ~w~%i",VehicleNames[ShopCar[GetPVarInt(playerid, "SelectAvto")][0]-400],ShopCar[GetPVarInt(playerid, "SelectAvto")][1],GetPVarInt(playerid,"BuyColor"),GetPVarInt(playerid,"BuyColor1"));
	GameTextForPlayer(playerid,string, 5000, 3);
	return 1;
}
stock BackColor(playerid,whocolor) {
	if(whocolor == 0) {
		SetPVarInt(playerid,"BuyColor",GetPVarInt(playerid,"BuyColor")-1);
		if(GetPVarInt(playerid,"BuyColor") < 0) SetPVarInt(playerid,"BuyColor",125);
	}
	else {
		SetPVarInt(playerid,"BuyColor1",GetPVarInt(playerid,"BuyColor1")-1);
		if(GetPVarInt(playerid,"BuyColor1") < 0) SetPVarInt(playerid,"BuyColor1",125);
	}
	ChangeVehicleColor(GetPlayerVehicleID(playerid), GetPVarInt(playerid,"BuyColor"),GetPVarInt(playerid,"BuyColor1"));
	new string[1024];
	format(string,128,"~n~~n~~n~~n~~n~~n~~n~~n~~b~NAME: ~w~%s~n~~g~COST: ~w~%i~n~~y~COLOR1: ~w~%i ~y~COLOR2: ~w~%i",VehicleNames[ShopCar[GetPVarInt(playerid, "SelectAvto")][0]-400],ShopCar[GetPVarInt(playerid, "SelectAvto")][1],GetPVarInt(playerid,"BuyColor"),GetPVarInt(playerid,"BuyColor1"));
	GameTextForPlayer(playerid,string, 5000, 3);
	return 1;
}
stock ShowBuyCar(playerid) {
	SetPVarInt(playerid, "SelectAvto", 0);
	switch(GetPVarInt(playerid,"CarShop")) {
		case 1: SetPVarInt(playerid, "SelectAvto", 20);//c
		case 2: SetPVarInt(playerid, "SelectAvto", 39);//d
		case 3: SetPVarInt(playerid, "SelectAvto", 72);//a
		case 4: SetPVarInt(playerid, "SelectAvto", 57);//b
	}
	PlayerTextDrawShow(playerid, ShopText[playerid]);
	for(new x; x < 12; x++) TextDrawShowForPlayer(playerid, AutoShopText[x]);
	SetPlayerVirtualWorld(playerid,playerid+1);
	SelectTextDraw(playerid, 0x0080FFFF);
 	return ShowingCar(playerid);
}
stock ExitCar(playerid) {
    for(new x; x < 12; x++) TextDrawHideForPlayer(playerid, AutoShopText[x]);
	PlayerTextDrawHide(playerid, ShopText[playerid]);
	if(UserData[playerid][SalonCar] != INVALID_VEHICLE_ID) DestroyVehicle(UserData[playerid][SalonCar]);
	UserData[playerid][SalonCar] = INVALID_VEHICLE_ID;
	SetPVarInt(playerid,"SelectAvto",-1);
	CancelSelectTextDraw(playerid);
	PlayerPlaySound(playerid, 31202, 0.0, 0.0, 0.0);
	SetPosAutos(playerid,1391.6912,-27.4429,1000.8630,178.9013,1,333);
	return true;
}

stock SetPosAutos(playerid,Float:x,Float:y,Float:z,Float:angle,Interiorid,worldid) {
	SetPlayerPosEx(playerid,x,y,z);
	SetPlayerInterior(playerid,Interiorid);
	SetPlayerVirtualWorld(playerid,worldid);
    SetPlayerFacingAngle(playerid,angle);
	SetCameraBehindPlayer(playerid);
	return 1;
}
// ======================== < [ Publics ] >
publics: IsVehicleOccupied(vehicleid) {
    foreach(new i:Player)
    {
        if(IsPlayerInVehicle(i,vehicleid)) return true;
    }
    return false;
}
publics: CarSpawn() {
	for(new i = 0;i<MAX_VEHICLES;i++) {
    	if(!IsVehicleOccupied(i))
		{
			SetVehicleToRespawn(i);
		}
	}
	return true;
}
publics: checkBan(playerid) {
	new rows;
	cache_get_row_count(rows);
	if(rows) {
		new gtp;
		new current = getdate();
		cache_get_value_name_int(0, "BanDay", gtp);
		new dg = gtp-current;
		if(gtp > current) {
			format(YCMDstr, sizeof(YCMDstr), "{B40431}Tkven gadevt ip bani! axsnamde darcha: %i dge", dg);
			SendClientMessage(playerid, -1, YCMDstr);
			srvKick(playerid);
		}
		if(gtp <= current) {
		    new pup[16]; GetPlayerIp(playerid,pup,sizeof(pup));
		    format(YCMDstr,sizeof(YCMDstr), "DELETE FROM `banip` WHERE `IP` = '%s'", pup);
			mysql_tquery(connects, YCMDstr, "", "");
		}
	}
}

publics: LoadMemberData(id) {
	format(YCMDstr, sizeof(YCMDstr), "SELECT * FROM `accounts` WHERE `pMember` = '%d'", id);
	mysql_query(connects, YCMDstr);
	new rows;
	cache_get_row_count(rows);
	if(!rows) return 0;
	return rows;
}
publics: SendGangMessage(string[]) {
	foreach(new i:Player) {
		if(UserData[i][pMember] == 7 || UserData[i][pMember] == 8 || UserData[i][pMember] == 9 || UserData[i][pMember] == 10 || UserData[i][pMember] == 11) {
			if(!gFam[i]) SendClientMessage(i, -1, string);
		}
	}
}
publics: SendGovMessage(color, string[]) {
	foreach(new i:Player) {
		if(UserData[i][pMember] == 1 || UserData[i][pMember] == 2 || UserData[i][pMember] == 3 || UserData[i][pMember] == 4) {
			SendClientMessage(i, -1, string);
		}
	}
}
publics: PlayerToKvadrat(playerid,Float:min_x,Float:min_y,Float:max_x,Float:max_y) {
	new Float:xxp,Float:yyp,Float:zzp;
	GetPlayerPos(playerid, xxp, yyp, zzp);
	if((xxp <= max_x && xxp >= min_x) && (yyp <= max_y && yyp >= min_y)) return true;
	return false;
}
publics: IsAGang(playerid) {
	if(!IsPlayerConnected(playerid)) return false;
	new leader = UserData[playerid][pLeader];
	new member = UserData[playerid][pMember];
	if(member==7 || member==8 || member==9 || member==10 || member==11) return true;
	if(leader==7 || leader==8 || leader==9 || leader==10 || leader==11) return true;
	return false;
}
publics: start_capture() {
    foreach(new i:Player) {
        if(UserData[i][pMember] == 7 || UserData[i][pMember] == 8 || UserData[i][pMember] == 9 || UserData[i][pMember] == 10 || UserData[i][pMember] == 11) {
            startcapture = 1;
            success(i, "Am wamidan tkven shegedzlebat daiwyot teritoriisatvis brdzola bandebtan");
		}
	}
	return true;
}
publics: stop_capture() return startcapture = 0;
publics: GzCheck() {
	for(new i = 0; i < sizeof(ZoneInfo); i++) {
		if(ZoneOnBattle[i] == 1) {
			if(GZSafeTime[i] > 0) GZSafeTime[i] --;
            foreach(new x:Player) {
				new string[128];
				new y = UserData[x][pMember];
				if(y == ZoneInfo[i][gNapad] || y == ZoneInfo[i][gFrakVlad]) {
					if(CaptureOn[x] == 0) {
						CaptureTextDraws(x);
						for(new c; c < 4; c++) PlayerTextDrawShow(x, CaptureTextDraw_PTD[x][c]);
						CaptureOn[x] = 1;
					}
					if(GZSafeTime[i] > 0) format(string,sizeof(string),"Time: %s",Convert(GZSafeTime[i]));
					PlayerTextDrawSetString(x, CaptureTextDraw_PTD[x][2], string);
					format(string,120,"%s ~r~%d",GetGangName(ZoneInfo[i][gNapad]),CountOnZone[ZoneInfo[i][gNapad]]);
					PlayerTextDrawSetString(x, CaptureTextDraw_PTD[x][1], string);
					format(string,120,"%s ~r~%d",GetGangName(ZoneInfo[i][gFrakVlad]),CountOnZone[ZoneInfo[i][gFrakVlad]]);
					PlayerTextDrawSetString(x, CaptureTextDraw_PTD[x][3], string);
				}
			}
			if(GZSafeTime[i] <= 0) {
			    new highscore = -1;
				new highscoreowner = INVALID_PLAYER_ID;
				foreach(new p:Player) {
				    new g = UserData[p][pMember];
					if(g == ZoneInfo[i][gNapad] || g == ZoneInfo[i][gFrakVlad]) {
						if(KillCounter[p] > highscore) {
							highscore = KillCounter[p];
							highscoreowner = p;
						}
					}
				}
				if(CountOnZone[ZoneInfo[i][gFrakVlad]] > CountOnZone[ZoneInfo[i][gNapad]]) {
				    foreach(new x:Player)
				    {
				        new y = UserData[x][pMember];
						if(y == ZoneInfo[i][gNapad] || y == ZoneInfo[i][gFrakVlad]) {
							for(new c; c < 4; c++) PlayerTextDrawDestroy(x, CaptureTextDraw_PTD[x][c]);
							KillCounter[x] = 0;
							CaptureOn[x] = 0;
						}
					}
					SendFractionMessage(ZoneInfo[i][gFrakVlad], "{FFFFFF}Gilocavt, tkven sheinarchunet tkveni {F0A45D}teritoria");
					SendFractionMessage(ZoneInfo[i][gNapad], "{FFFFFFF}Samwuxarod tkven ver daipyarit axali {F0A45D}teritoria");
					format(YCMDstr, 256, "Capture's sauketeso motamashe iyo: %s[%d]. man mokla %d kaci", Name(highscoreowner), highscoreowner, highscore);
					SendFractionMessage(ZoneInfo[i][gFrakVlad], YCMDstr);
					SendFractionMessage(ZoneInfo[i][gNapad], YCMDstr);
					CountOnZone[ZoneInfo[i][gFrakVlad]] = 0;
					CountOnZone[ZoneInfo[i][gNapad]] = 0;
				}
				else if(CountOnZone[ZoneInfo[i][gFrakVlad]] < CountOnZone[ZoneInfo[i][gNapad]]) {
				    foreach(new x:Player) {
				        new y = UserData[x][pMember];
						if(y == ZoneInfo[i][gNapad] || y == ZoneInfo[i][gFrakVlad]) {
							for(new c; c < 4; c++) PlayerTextDrawDestroy(x, CaptureTextDraw_PTD[x][c]);
							KillCounter[x] = 0;
							CaptureOn[x] = 0;
						}
					}
					CountOnZone[ZoneInfo[i][gFrakVlad]] = 0;
					CountOnZone[ZoneInfo[i][gNapad]] = 0;
					SendFractionMessage(ZoneInfo[i][gNapad], "{FFFFFF}Gilocavt, tkven daipyarit axali {F0A45D}teritoria");
					SendFractionMessage(ZoneInfo[i][gFrakVlad] ,"{FFFFFF}Samwuxarod tkven dakarget kontroli tkven {F0A45D}teritoriaze");
					format(YCMDstr, 256, "{ffffff}Teritoriisatvis brdzolashi sauketeso motamashe iyo: {F0A45D}%s[%d], {FFFFFF}man mokla {F0A45D}%d {FFFFFF}kaci", Name(highscoreowner), highscoreowner, highscore);
					SendFractionMessage(ZoneInfo[i][gFrakVlad] ,YCMDstr);
					SendFractionMessage(ZoneInfo[i][gNapad] ,YCMDstr);
					ZoneInfo[i][gFrakVlad] = ZoneInfo[i][gNapad];
					ZoneInfo[i][gNapad] = 0;
				}
				else if(CountOnZone[ZoneInfo[i][gFrakVlad]] == CountOnZone[ZoneInfo[i][gNapad]]) {
				    GZSafeTime[i] = 1;
				    foreach(new x:Player) {
		 				new y = UserData[x][pMember];
						if(y == ZoneInfo[i][gNapad] || y == ZoneInfo[i][gFrakVlad]) {
							PlayerTextDrawSetString(x, CaptureTextDraw_PTD[x][2], "~y~Golden Score");
						}
					}
				    return 1;
				}
				captures--;
				ItsWar[ZoneInfo[i][gNapad]] = -1;
				ItsWar[ZoneInfo[i][gFrakVlad]] = -1;
				ClearTotalGz();
				ZoneOnBattle[i] = 0;
				GangZoneStopFlashForAll(ZoneInfo[i][gID]);
				GangZoneHideForAll(ZoneInfo[i][gID]);
				GangZoneShowForAll(ZoneInfo[i][gID],GetGangZoneColor(i));
				SaveGZ();
				if(captures == 0) KillTimer(GzCheckTimer), GzCheckOn = 0;
				break;
			}
		}
	}
	return true;
}
publics: RemovePlayerFromVehicleAC(playerid) {
	RemovePlayerFromVehicle(playerid);
	return true;
}
publics: PlayerInZone(playerid,Float:min_x,Float:min_y,Float:max_x,Float:max_y) {
	new Float:xxp,Float:yyp,Float:zzp;
	GetPlayerPos(playerid, xxp, yyp, zzp);
	if((xxp <= max_x && xxp >= min_x) && (yyp <= max_y && yyp >= min_y)) return true;
	return false;
}
publics: LoadGZ() {
	new string[50];
	new File = ini_openFile("gangzone.ini");
	new l[2048];
	new asd[5][10];
	for(new i =0;i<sizeof(ZoneInfo);i++) {
		format(string,sizeof(string), "Zone%d",i);
		new x = ini_getString(File,string,l);
		if(x < 0) {
			ZoneInfo[i][gCoords][0] = STANDARTGangZone[i][0];
			ZoneInfo[i][gCoords][1] = STANDARTGangZone[i][1];
			ZoneInfo[i][gCoords][2] = STANDARTGangZone[i][2];
			ZoneInfo[i][gCoords][3] = STANDARTGangZone[i][3];
		}
		else {
			split(l,asd,'|');
			ZoneInfo[i][gCoords][0] = floatstr(asd[0]);
			ZoneInfo[i][gCoords][1] = floatstr(asd[1]);
			ZoneInfo[i][gCoords][2] = floatstr(asd[2]);
			ZoneInfo[i][gCoords][3] = floatstr(asd[3]);
		}
		ZoneInfo[i][gFrakVlad] = strval(asd[4]);
		if(ZoneInfo[i][gFrakVlad] == 0) ZoneInfo[i][gFrakVlad] = allowedfactions[random(sizeof(allowedfactions))];
		ZoneInfo[i][gID] = GangZoneCreate(ZoneInfo[i][gCoords][0],ZoneInfo[i][gCoords][1],ZoneInfo[i][gCoords][2],ZoneInfo[i][gCoords][3]);
		ZoneOnBattle[i] = 0;
		GZSafeTime[i] = 0;
	}
	ini_closeFile(File);
}
publics: SaveGZ() {
	new string[400];
	new File = ini_openFile("gangzone.ini");
	new l[10];
	for(new i =0;i<sizeof(ZoneInfo);i++) {
		format(l,sizeof(l), "Zone%d",i);
		format(string,sizeof(string), "%f|%f|%f|%f|%d",ZoneInfo[i][gCoords][0], ZoneInfo[i][gCoords][1],ZoneInfo[i][gCoords][2],ZoneInfo[i][gCoords][3],ZoneInfo[i][gFrakVlad]);
		ini_setString(File,l,string);
	}
	ini_closeFile(File);
}
publics: UnFreeze(playerid) {
    TogglePlayerControllable(playerid, 1);
    AnimOn[playerid] = false;
}
publics: UnHideQuest(playerid) {
    for(new i = 0; i < 5; i++) PlayerTextDrawHide(playerid, QuestTD[playerid][i]);
}
publics: RemoveBullet(playerid, bulletid) {
	BulletInfo[bulletid][bUsed] = 1;
	Delete3DTextLabel(BulletText[bulletid]);
}
publics: BulletTimer(playerid) {
	SetPVarInt(playerid, "BulletUsed", 0);
}
publics: SetAnimationBullet(playerid) {
	AnimOn[playerid] = true;
	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 1, 1, 1, 0, 0);
}
publics: SetAnimationKnock(playerid) {
	AnimOn[playerid] = true;
	ApplyAnimation(playerid, "PED", "floor_hit_f", 4.1, 0, 1, 1, 1, 0, 1);
}
publics: SetAnimationWare(playerid) {
	AnimOn[playerid] = true;
	ApplyAnimation(playerid, "CAR_CHAT", "CAR_Sc4_BL", 4.1, 0, 1, 1, 1, 0, 1);
}
publics: RegistrationComplate(playerid) {
	new string[100];
	format(string, sizeof(string), "~g~Registration completed");
	SetPVarInt(playerid, "RegisterSpawn", 0);
	success(playerid, "Tkven warmatebit chamofrindit shtatshi");
	SpawnPlayer(playerid);
}
publics: KnockAnimation(playerid) {
	ApplyAnimation(playerid, "CARRY", "crry_prtial",4.0,0,0,0,0,0,1);
	TogglePlayerControllable(playerid, 1);

	KnocInfo[playerid][kID] = 0;
	KnocInfo[playerid][kActive] = 0;
	KnocInfo[playerid][kX] = 0;
	KnocInfo[playerid][kY] = 0;
	KnocInfo[playerid][kZ] = 0;
	KnocInfo[playerid][kInt] = 0;
	KnocInfo[playerid][kVW] = 0;
	Delete3DTextLabel(KnocText[playerid]);
}
publics: LoginReturn(playerid, password[]) {
    new rows;
	cache_get_row_count(rows);
	if(rows) {
		LoginServerBase(playerid);
		success(playerid, "Tkven warmatebit gaiaret avtorizacia serverze");
	}
	if(!rows) {
		LoginWarning[playerid]++;
		if(LoginWarning[playerid] > 2) {
			error(playerid, "Tkven 3jer arasworad miutetet paroli");
			srvKick(playerid);
			return true;
		}
		new fstr[500];
		format(fstr, sizeof(fstr), "Tkven dagrchat %d cda, tu sworad ar miutitebt parols gaikikebit", 3 - LoginWarning[playerid]);
		SendClientMessage(playerid, 0xEF545DFF, fstr);

		error(playerid, "Paroli miutitet arasworad, sheiyvanet swori paroli");
		ShowLoginDialog(playerid);
		return true;
	}
	return true;
}
publics: AdminReturn(playerid, password) {
	new rows;
	cache_get_row_count(rows);
	if(rows) {
		UserData[playerid][pAdminLogin] = 1;
		UpdateUserData(playerid, "pAdminLogin", UserData[playerid][pAdminLogin]);
		success(playerid, "Tkven warmatebit gaiaret admin avtorizacia");
	}
	if(!rows) {
		error(playerid, "Paroli miutitet arasworad, sheiyvanet swori paroli");
		PC_EmulateCommand(playerid, "/alogin");
		return true;		
	}
	return true;
}
publics: ClosePDGate0() { MoveObject(policedoor[0], 253.16051, 109.06970, 1003.45581, 0.7, 0.00000, 0.00000, 90.00000); }
publics: ClosePDGate1() { MoveObject(policedoor[1], 253.21300, 125.25500, 1003.45581, 0.7, 0.00000, 0.00000, 90.00000); }
publics: ClosePDGate2() { MoveObject(policedoor[2], 239.54539, 125.07250, 1003.45581, 0.7, 0.00000, 0.00000, 90.00000); }
publics: ClosePDGate3()	{ MoveObject(policedoor[3], 239.63510, 117.56120, 1003.45581, 0.7, 0.00000, 0.00000, 90.00000); }

publics: Fresh() {
    for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) {
		if(UserData[i][pCash] != GetPlayerMoney(i)) {
			ResetPlayerMoney(i);
			GivePlayerMoney(i, UserData[i][pCash]);
		}
		if(UserData[i][pWantedLevel] != GetPlayerWantedLevel(i)) {
			SetPlayerWantedLevel(i, UserData[i][pWantedLevel]);
		}
		if(Login[i]) {
			LoginSec[i]++;
			if(LoginSec[i] > 60) {
				LoginTime[i]++;
				LoginSec[i] = 0;
			}
		}
		if(AFK[i] > 0) {
			AFKTime[i]++;
            if(AFKTime[i] > 1) {
            	new string[500];
                format(string,sizeof(string), "{FFFFFF}AFK : {FF0000}[ %s sec ]", Convert(AFKTime[i]));
                SetPlayerChatBubble(i, string, -1, 30.0, 1200);
            }
            else {
                SetPVarInt(i, "ont", GetPVarInt(i, "ont") + 1);
            }			
		}
		if(eventtime > 0) {
		    eventtime --;
		    UpdateEvent();
		}
		else if(eventtime <= 0) HideEvent(i);
		if(UserData[i][pJailed] > 0) {
			UserData[i][pJailTime]--;
			if(UserData[i][pJailTime] < 1) {
				UserData[i][pJailed] = 0;
				UserData[i][pJailTime] = 0;
				UserData[i][pWantedLevel] = 0;
				UpdateUserData(i, "pJailed", UserData[i][pJailed]);
				UpdateUserData(i, "pJailTime", UserData[i][pJailTime]);
				UpdateUserData(i, "pWantedLevel", UserData[i][pWantedLevel]);
				SpawnPlayer(i);
				success(i, "Tkven moixadet sasjeli da ukve tavisufali xart");
			}
		}
	    if(KnocInfo[i][kActive] == 1) {
	    	KnocInfo[i][dTimer]++;
	    	// Textdraw
			if(!PlayerToPoint(5.0, i, KnocInfo[i][kX], KnocInfo[i][kY], KnocInfo[i][kZ])) {
		 		SetPlayerPosEx(i, KnocInfo[i][kX], KnocInfo[i][kY], KnocInfo[i][kZ]);
				SetPlayerInterior(i, KnocInfo[i][kInt]);
				SetPlayerVirtualWorld(i, KnocInfo[i][kVW]);

				TogglePlayerControllable(i, 0);
				SetTimerEx("SetAnimationKnock", 100, false, "i", i);
				SetTimerEx("SetAnimationKnock", 500, false, "i", i);		
			}
			if(KnocInfo[i][dTimer] > 180) {
				KnocInfo[i][kID] = 0;
				KnocInfo[i][kActive] = 0;
				KnocInfo[i][kX] = 0;
				KnocInfo[i][kY] = 0;
				KnocInfo[i][kZ] = 0;
				KnocInfo[i][kInt] = 0;
				KnocInfo[i][kVW] = 0;
				Delete3DTextLabel(KnocText[i]);
				SendClientMessage(i, -1, "{F0A45D}- Tkven aravin gadagarchinat, amitomac tkven mokvdit");
				SpawnPlayer(i);
			}
    	}
        if(gotome[i] != -1) {
		    new Float:x, Float:y, Float:z;
		    GetPlayerPos(gotome[i], x, y, z);
		    SetPlayerPosEx(i, x, y+1, z);
			SetPlayerInterior(i, GetPlayerInterior(gotome[i]));
			SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(gotome[i]));
		}
    	SetPlayerToTeamColor(i);
    }
    ClearTotalGz();
	for(new i =0;i<sizeof(ZoneInfo);i++) {
		if(ZoneInfo[i][gFrakVlad] == 11) TotalGzR++;
		if(ZoneInfo[i][gFrakVlad] == 10) TotalGzA++;
		if(ZoneInfo[i][gFrakVlad] == 9) TotalGzG++;
		if(ZoneInfo[i][gFrakVlad] == 8) TotalGzV++;
		if(ZoneInfo[i][gFrakVlad] == 7) TotalGzB++;
	}
	foreach(new i:Player){
		if(UserData[i][pMuteTime] > 0) UserData[i][pMuteTime] -= 1;
		if(UserData[i][pMuteTime] < 1 && UserData[i][pMute] == 1) UserData[i][pMute] = 0, success(i, "Tkven mogexsnat mute");
	}
    return true;
}
publics: PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z) {
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi))) return true;
	return false;
}
publics: ProxDetector(Float:radi, playerid, string[], col1) {
	if(IsPlayerConnected(playerid)) {
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		foreach(new i:Player) {
			if(IsPlayerConnected(i)) {
				if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)) {
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);
					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16))) {
						SendClientMessage(i, col1, string);
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8))) {
						SendClientMessage(i, col1, string);
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4))) {
						SendClientMessage(i, col1, string);
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2))) {
						SendClientMessage(i, col1, string);
					}
				}
			}
			else {
				SendClientMessage(i, col1, string);
			}
		}
	}
	return true;
}
publics: ClearAnim(playerid) {
	ApplyAnimation(playerid, "CARRY", "crry_prtial",4.0,0,0,0,0,0,1);
	SetPlayerSpecialAction(playerid, 0);
	AnimOn[playerid] = false;
}
publics: kick(giveplayerid) {
	Kick(giveplayerid);
	return true;
}
publics: Random(min, max) {
	new a = random(max - min) + min;
	return a;
}
publics: DestroySpark(playerid) {
	DestroyObject(Spark[playerid]);
    return true;
}
publics: TazedRemove(playerid) {
	TogglePlayerControllable(playerid, 1);
 	ApplyAnimation(playerid, "CARRY", "crry_prtial",4.0,0,0,0,0,0,1);
  	Tazed[playerid] = false;
   	return true;
}
publics: SetPlayerToTeamColor(playerid) {
	if(DMArena[playerid] == 1) SetPlayerColor(playerid, 0x5A5C5CFF);
	else {
		switch(UserData[playerid][pMember]) {
			case 0: SetPlayerColor(playerid, 0xFFFFFFFF);
			case 1: SetPlayerColor(playerid, 0x423FF4FF);
			case 2: SetPlayerColor(playerid, 0xEF545DFF);
			case 3: SetPlayerColor(playerid, 0x34495EFF);
			case 4: SetPlayerColor(playerid, 0xE67E22FF);
			case 5: SetPlayerColor(playerid, 0x008FFFFF);
			case 6: SetPlayerColor(playerid, 0x423FF4FF);
			case 7: SetPlayerColor(playerid, 0xD200FFFF);
			case 8: SetPlayerColor(playerid, 0xFFCD00FF);
			case 9: SetPlayerColor(playerid, 0x009900FF);
			case 10: SetPlayerColor(playerid, 0x00F5FFFF);
			case 11: SetPlayerColor(playerid, 0x6666FFFF);
			default: SetPlayerColor(playerid, 0xFFFFFFFF);
		}
	}
	return true;
}
// ======================== < [ Public ] >
forward LoadFractions();
public LoadFractions() {
    new rows, time = GetTickCount();
    TotalFractions = 0;
	cache_get_row_count(rows);
	if(rows) {
	    for(new i = 0; i < rows; i++) {
		    cache_get_value_name_int(i, "wID", FractionData[i][wID]);
		    cache_get_value_name_int(i, "wAmmo", FractionData[i][wAmmo]);
		    cache_get_value_name_int(i, "wBank", FractionData[i][wBank]);
		    cache_get_value_name_int(i, "wDrug", FractionData[i][wDrug]);
			cache_get_value_name_int(i, "wStatus", FractionData[i][wStatus]);
			cache_get_value_name_int(i, "wInviteRank", FractionData[i][wInviteRank]);

			cache_get_value_name_int(i, "wSkin1", FractionData[i][wSkin][0]);
			cache_get_value_name_int(i, "wSkin2", FractionData[i][wSkin][1]);
			cache_get_value_name_int(i, "wSkin3", FractionData[i][wSkin][2]);
			cache_get_value_name_int(i, "wSkin4", FractionData[i][wSkin][3]);
			cache_get_value_name_int(i, "wSkin5", FractionData[i][wSkin][4]);
			cache_get_value_name_int(i, "wSkin6", FractionData[i][wSkin][5]);
			TotalFractions ++;
		}
		printf("<> Fractions loaded: %d | Time: %d (ms)", rows, GetTickCount() - time);
	}
}
forward OnPlayerUpdateTimer();
public OnPlayerUpdateTimer() {
	UpdateFractions();
	CheckHour();
}
forward LoadHouse();
public LoadHouse() {
    new rows, time = GetTickCount();
    TotalHouse = 0;
	cache_get_row_count(rows);
	if(rows) {
		for (new i = 0; i < rows; i ++) {
		    cache_get_value_name_int(i, "hID", HouseData[i][hID]);
		    cache_get_value_name(i, "hOwner", HouseData[i][hOwner], MAX_PLAYER_NAME);
			cache_get_value_name_float(i, "hEnterX", HouseData[i][hEnterX]);
			cache_get_value_name_float(i, "hEnterY", HouseData[i][hEnterY]);
			cache_get_value_name_float(i, "hEnterZ", HouseData[i][hEnterZ]);
			cache_get_value_name_float(i, "hExitX", HouseData[i][hExitX]);
			cache_get_value_name_float(i, "hExitY", HouseData[i][hExitY]);
			cache_get_value_name_float(i, "hExitZ", HouseData[i][hExitZ]);
            cache_get_value_name_int(i, "hOwned", HouseData[i][hOwned]);
            cache_get_value_name_int(i, "hInt", HouseData[i][hInt]);
            cache_get_value_name_int(i, "hLock", HouseData[i][hLock]);
            cache_get_value_name_int(i, "hClass", HouseData[i][hClass]);
            cache_get_value_name_int(i, "hPrice", HouseData[i][hPrice]);
			cache_get_value_name_float(i, "hSpawnX", HouseData[i][hSpawnX]);
			cache_get_value_name_float(i, "hSpawnY", HouseData[i][hSpawnY]);
			cache_get_value_name_float(i, "hSpawnZ", HouseData[i][hSpawnZ]);
			cache_get_value_name_float(i, "hSpawnF", HouseData[i][hSpawnF]);
			cache_get_value_name_int(i, "hGarage", HouseData[i][hGarage]);
			cache_get_value_name_float(i, "hCarx", HouseData[i][hCarx]);
			cache_get_value_name_float(i, "hCary", HouseData[i][hCary]);
			cache_get_value_name_float(i, "hCarz", HouseData[i][hCarz]);
			cache_get_value_name_float(i, "hCarc", HouseData[i][hCarc]);
            if(!HouseData[i][hOwned]) {
				HouseData[i][hIcon] = CreateDynamicMapIcon(HouseData[i][hEnterX], HouseData[i][hEnterY], HouseData[i][hEnterZ], 31, 0);
				HouseCP[i] = CreateDynamicPickup(1273, 23, HouseData[i][hEnterX], HouseData[i][hEnterY], HouseData[i][hEnterZ], 0, -1, -1, 50.0);
			}
			if(HouseData[i][hOwned]) {
				HouseData[i][hIcon] = CreateDynamicMapIcon(HouseData[i][hEnterX], HouseData[i][hEnterY], HouseData[i][hEnterZ], 32, 0);
				HouseCP[i] = CreateDynamicPickup(19522, 23, HouseData[i][hEnterX], HouseData[i][hEnterY], HouseData[i][hEnterZ], 0, -1, -1, 50.0);
			}
			House3DText[i] = CreateDynamic3DTextLabel(" PROPERTY ", -1, HouseData[i][hEnterX], HouseData[i][hEnterY],HouseData[i][hEnterZ], 25.0);
			UpdateHouse(i);
			TotalHouse ++;
		}
		printf("<> Houses loaded: %d | Time: %d (ms)", TotalHouse, GetTickCount() - time);
	}
}
forward LoadBizz();
public LoadBizz() {
    new rows, time = GetTickCount();
    TotalBizz = 0;
	cache_get_row_count(rows);
	if(rows) {
		for (new i = 0; i < rows; i ++) {
		    cache_get_value_name_int(i, "bID", BizzData[i][bID]);
		    cache_get_value_name(i, "bOwner", BizzData[i][bOwner], MAX_PLAYER_NAME);
			cache_get_value_name_float(i, "bEnterX", BizzData[i][bEnterX]);
			cache_get_value_name_float(i, "bEnterY", BizzData[i][bEnterY]);
			cache_get_value_name_float(i, "bEnterZ", BizzData[i][bEnterZ]);
			cache_get_value_name_float(i, "bExitX", BizzData[i][bExitX]);
			cache_get_value_name_float(i, "bExitY", BizzData[i][bExitY]);
			cache_get_value_name_float(i, "bExitZ", BizzData[i][bExitZ]);
			cache_get_value_name_float(i, "bBuyX", BizzData[i][bBuyX]);
			cache_get_value_name_float(i, "bBuyY", BizzData[i][bBuyY]);
			cache_get_value_name_float(i, "bBuyZ", BizzData[i][bBuyZ]);
            cache_get_value_name_int(i, "bOwned", BizzData[i][bOwned]);
            cache_get_value_name_int(i, "bInt", BizzData[i][bInt]);
            cache_get_value_name_int(i, "bLock", BizzData[i][bLock]);
            cache_get_value_name_int(i, "bType", BizzData[i][bType]);
            cache_get_value_name_int(i, "bTypeID", BizzData[i][bTypeID]);
            cache_get_value_name_int(i, "bPrice", BizzData[i][bPrice]);
            cache_get_value_name_int(i, "bIcon", BizzData[i][bIcon]);
            cache_get_value_name_int(i, "bBank", BizzData[i][bBank]);

            BizzIcon[i] = CreateDynamicMapIcon(BizzData[i][bEnterX], BizzData[i][bEnterY], BizzData[i][bEnterZ], BizzData[i][bIcon], 0);
			BizzText[i] = CreateDynamic3DTextLabel("{FFFFFF}Press : {F0A45D}(ALT)", -1, BizzData[i][bEnterX], BizzData[i][bEnterY], BizzData[i][bEnterZ], 5.0);
			BizzCP[i] = CreateDynamicPickup(BizzData[i][bTypeID], 23, BizzData[i][bEnterX], BizzData[i][bEnterY], BizzData[i][bEnterZ], 0, -1, -1, 50.0);

			BuyText[i] = CreateDynamic3DTextLabel("{FFFFFF}Press : {F0A45D}(ALT)", -1, BizzData[i][bBuyX], BizzData[i][bBuyY], BizzData[i][bBuyZ], 5.0);
			TotalBizz ++;
		}
		printf("<> Business loaded: %d | Time: %d (ms)", TotalBizz, GetTickCount() - time);
	}
}

public SV_VOID:OnPlayerActivationKeyPress(SV_UINT:playerid, SV_UINT:keyid)  {
    if (keyid == 0x42 && lstream[playerid]) SvAttachSpeakerToStream(lstream[playerid], playerid);
}

public SV_VOID:OnPlayerActivationKeyRelease(SV_UINT:playerid, SV_UINT:keyid) {
    if (keyid == 0x42 && lstream[playerid]) SvDetachSpeakerFromStream(lstream[playerid], playerid);
}

public OnGameModeInit() {
	for(new i = 0; i <= sizeof(Peds)-1; i++) AddPlayerClass(Peds[i][0],1958.3783,1343.1572,1100.3746,269.1425,-1,-1,-1,-1,-1,-1);

	DataConnect(); // Connect

	LoadOwnableCars();

	// Visual settings
	SetGameModeText(srvMode);
	// Settings
	TotalBullet = 0;
	TotalHouseCar = 0;
	TotalJobMaterials = 0;
	AntiDeAMX2();
	ShowNameTags(1);
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_STREAMED);
	EnableVehicleFriendlyFire();
	SetNameTagDrawDistance(30.0);
	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();
	LimitPlayerMarkerRadius(13.0);
	ManualVehicleEngineAndLights();
	AllowInteriorWeapons(1);
	gstream = SvCreateGStream(0xffff0000, "Global");
	// Loading
 	LoadDoors();
	LoadTextdraws();
	LoadMapIcons();
	Load3DTexts();
	LoadAcotrs();
	LoadePickups();
	LoadMaps();
	LoadGZ();
	CreateVehicles();
	// Move objects
	policedoor[0] = CreateObject(19302, 253.16051, 109.06970, 1003.45581,   0.00000, 0.00000, 90.00000);
	policedoor[1] = CreateObject(19302, 253.21300, 125.25500, 1003.45581,   0.00000, 0.00000, 90.00000);
	policedoor[2] = CreateObject(19302, 239.54539, 125.07250, 1003.45581,   0.00000, 0.00000, 90.00000);
	policedoor[3] = CreateObject(19302, 239.63510, 117.56120, 1003.45581,   0.00000, 0.00000, 90.00000);
	// Vehicles
	for(new i = 0; i < sizeof(CreatedCars); i++) CreatedCars[i] = 0;
	for(new Vehicles = 0; Vehicles < MAX_VEHICLES; Vehicles++) {
		// Engine broken system
		SetVehicleHealth(Vehicles, 1300.0);
		vehcreat[Vehicles] = 0;
		SetVehicleNumberPlate(Vehicles, "SA:LIFE");
	}
	// Timers
	FreshTimer = SetTimer("Fresh", 1000, 1); // 1.0 Sec
	SetTimer("OnPlayerUpdateTimer", 1000, 1);

	// Regalias
	PC_RegAlias("admin", "a");
	PC_RegAlias("jetpack", "jp");
	PC_RegAlias("spawn", "sp");
	PC_RegAlias("shout", "s");
	PC_RegAlias("recon", "re");
	PC_RegAlias("reconoff", "reoff");
	PC_RegAlias("goto", "g");
	PC_RegAlias("ooc", "o");
	PC_RegAlias("ooc", "ao");
	PC_RegAlias("megaphone", "m");
	PC_RegAlias("suspect", "su");
	return 1;
}

public OnGameModeExit() {
	for(new i; i < TotalHouse; i++) SaveHouse(i);
	for(new i; i < TotalFractions; i++) SaveFraction(i);
	KillTimer(FreshTimer);
	SaveGZ();
	if (gstream) SvDeleteStream(gstream);
	SaveOwnableCars();
	foreach(new i:Player) {
		if(caridhouse[i] != -1) {
			DestroyVehicle(caridhouse[i]);
			caridhouse[i] =-1;
		}
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid) {
	if(IsPlayerNPC(playerid)) return true;
	GetPlayerName(playerid, Name(playerid), MAX_PLAYER_NAME);
	new pup[16]; GetPlayerIp(playerid,pup,sizeof(pup));
	// ---------- //
	new hgh[156];
	format(hgh, sizeof(hgh), "SELECT * FROM `banip` WHERE `IP` = '%s'", pup);
	mysql_tquery(connects, hgh, "checkBan", "i", playerid);
	// --------- //
	InterpolateCameraPos(playerid, 768.572875, 2642.529785, 16.942920, 948.353942, 2583.556640, 12.205818, 8000);
	InterpolateCameraLookAt(playerid, 773.501037, 2642.359130, 16.115917, 952.617919, 2580.950195, 12.362361, 8000);
	UserData[playerid][pCash] = 0;
    GivePlayerMoney(playerid, -GetPlayerMoney(playerid));
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,  playerid);
	TogglePlayerControllable(playerid,0);
    ResetPlayer(playerid);

	new get_player_info_string[256];
	format(get_player_info_string, sizeof(get_player_info_string), "SELECT `pID` FROM `accounts` WHERE `pName` = '%s'",Name(playerid));
	mysql_query(connects,get_player_info_string);
	new rows;
	cache_get_row_count(rows);
	if(rows) {
		ShowLoginDialog(playerid);
	}
	else {
		ShowRegisterDialog(playerid);
	}

	return 1;
}

public OnPlayerConnect(playerid) {
	GetPlayerName(playerid, Name(playerid), MAX_PLAYER_NAME);
	printf("<> %s - joined to server", Name(playerid));

	DisablePlayerCheckpoint(playerid);
	LoadPlayerTextdraws(playerid);
	SetPlayerToTeamColor(playerid);
	// Remove Objects
	#include "../../library/map/remove"
	for(new i = 0; i < 100; i ++) SendClientMessage(playerid, -1, "");
	// Voice
    if (SvGetVersion(playerid) == SV_NULL) {
        SendClientMessage(playerid, 0xF0A45DFF, "[Voice] - {FFFFFF}Tkven ar giyeniat voice GTA'shi");
    }
    else if (SvHasMicro(playerid) == SV_FALSE) {
        SendClientMessage(playerid, 0xF0A45DFF, "[Voice] - {FFFFFF}Tkven ar gaqvt sheertebuli mikrofoni");
    }
    else if ((lstream[playerid] = SvCreateDLStreamAtPlayer(40.0, SV_INFINITY, playerid, 0xFF0000FF, "Local"))) {
        SendClientMessage(playerid, 0xF0A45DFF, "[Voice] - {FFFFFF}Voiceshi sasaubrod gamoiyenet 'B' gilaks");

        if(gstream) SvAttachListenerToStream(gstream, playerid);
        SvAddKey(playerid, 0x42);
    }
    format(YCMDstr, sizeof(YCMDstr), "[INFO] - {FFFFFF}Serverze shemodis motamashe: {F4D03F}%s (ID: %d)", Name(playerid), playerid);
	SendAdminMessage(0xF4D03FFF, YCMDstr);
	// Gangzone
	for(new i = 0; i < 130; i++) GangZoneShowForPlayer(playerid,ZoneInfo[i][gID],GetGangZoneColor(i));
	RentTD_Used[playerid] = false;
	SetPVarInt(playerid, "veh_rent", -1);
	KillCounter[playerid] = 0;
	gps[playerid] = false;
	UserData[playerid][SalonCar] = INVALID_VEHICLE_ID;
	UserData[playerid][SalonTime] = 0;
	caridhouse[playerid] = -1;
	return 1;
}

public OnPlayerDisconnect(playerid, reason) {
	GetPlayerName(playerid, Name(playerid), MAX_PLAYER_NAME);
	printf("<> %s - left form server", Name(playerid));
	ResetPlayer(playerid);
	if(UserData[playerid][pAdminLogin] > 0) UserData[playerid][pAdminLogin] = 0, UpdateUserData(playerid, "pAdminLogin", 0);
	if(KnocInfo[playerid][kActive] > 0) Delete3DTextLabel(KnocText[playerid]);
    if(lstream[playerid]) SvDeleteStream(lstream[playerid]), lstream[playerid] = SV_NULL;
	if(rentID[playerid] != -1) DestroyVehicle(rentID[playerid]), rentID[playerid] = -1;
	if(cleanercar[playerid] != -1) DestroyVehicle(cleanercar[playerid]), cleanercar[playerid] = -1;
	if(admincar[playerid] != -1) DestroyVehicle(admincar[playerid]), admincar[playerid] = -1;
	if(shopcar[playerid] != -1) DestroyVehicle(shopcar[playerid]), shopcar[playerid] = -1;
	if(CaptureOn[playerid] == 1) {
		CaptureOn[playerid] = 0;
		for(new c; c < 4; c++) PlayerTextDrawDestroy(playerid, CaptureTextDraw_PTD[playerid][c]);
	}
   	for(new i = 0; i < OWNABLECARS; i++) {
		if(IsPlayersCar(playerid,OwnableCar[i]))
	   	{
			SetVehicleVirtualWorld(OwnableCar[i], 1);
		}
	}
	if(caridhouse[playerid] != -1) {
		DestroyVehicle(caridhouse[playerid]);
		caridhouse[playerid] =-1;
	}
	return 1;
}

public OnPlayerSpawn(playerid) {
	if(Login[playerid]) {
		PlayerCuffed[playerid] = 0;
		PlayerCuffedTime[playerid] = 0;
		gotome[playerid] = -1;

		SetPlayerWorldBounds(playerid,20000.0000,-20000.0000,20000.0000,-20000.0000);
		ApplyAnimation(playerid, "CARRY", "crry_prtial",4.0,0,0,0,0,0,1);
		if(IsInAllowed(playerid)) {
			SetPlayerHealth(playerid, 160);
		}
		else SetPlayerHealth(playerid, 100);
		SetPlayerScore(playerid, UserData[playerid][pLevel]);
		if(UserData[playerid][pMember] > 0) SetPlayerSkin(playerid, UserData[playerid][pForma]);
		else SetPlayerSkin(playerid, UserData[playerid][pSkin]);
		SetPlayerSpawn(playerid);
		if(CaptureOn[playerid] == 1) {
			CaptureOn[playerid] = 0;
  			for(new c; c < 4; c++) PlayerTextDrawDestroy(playerid, CaptureTextDraw_PTD[playerid][c]);
		}
		if(GetPlayerSkin(playerid) == 74) {
			new randskin = Random(2,100);
			UserData[playerid][pSkin] = randskin;
			UpdateUserData(playerid, "pSkin", UserData[playerid][pSkin]);
			SetPlayerSkin(playerid, randskin);
		}
	}
	else srvKick(playerid);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason) {
	if(AnimOn[playerid] == true) {
	 	AnimOn[playerid] = false;
	}
	for(new i =0;i<sizeof(ZoneInfo);i++) {
		if(ZoneOnBattle[i] == 1 && killerid != INVALID_PLAYER_ID) {
		    if(UserData[killerid][pMember] == ZoneInfo[i][gNapad] && UserData[killerid][pMember] != UserData[playerid][pMember] ||
		    UserData[killerid][pMember] == ZoneInfo[i][gFrakVlad] && UserData[killerid][pMember] != UserData[playerid][pMember]) {
				if(UserData[playerid][pMember] == ZoneInfo[i][gNapad] || UserData[playerid][pMember] == ZoneInfo[i][gFrakVlad]) { {
				 		CountOnZone[UserData[killerid][pMember]] += 1;
				 		KillCounter[killerid] += 1;
				 		foreach(new n:Player) {
				 		    if(UserData[n][pMember] == ZoneInfo[i][gNapad] || UserData[n][pMember] == ZoneInfo[i][gFrakVlad]) {
				 				SendDeathMessageToPlayer(n, killerid, playerid, reason);
							}
						}
					}
				}
			}
		}
	}
	if(!IsInAllowed(playerid) && !AdminDuty[playerid]) {
		AnimOn[playerid] = true;

		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		KnocInfo[playerid][kID] = killerid;
		KnocInfo[playerid][kActive] = 1;
		KnocInfo[playerid][kX] = x;
		KnocInfo[playerid][kY] = y;
		KnocInfo[playerid][kZ] = z;
		KnocInfo[playerid][dTimer] = 0;
		KnocInfo[playerid][kInt] = GetPlayerInterior(playerid);
		KnocInfo[playerid][kVW] = GetPlayerVirtualWorld(playerid);

		KnocText[playerid] = Create3DTextLabel("{EF545D}(( Es motamashe aris dzlierad dachrili\n{EF545D}Gadasarchenad - /cure [ID] ))", -1, x, y, z-1, 5.0, GetPlayerVirtualWorld(playerid));
		SpawnPlayer(playerid);
	}
	new weapon = GetPlayerWeapon(playerid), ammo = GetPlayerAmmo(playerid);
	if(weapon && ammo)
	{
	    dg_DropGun(playerid, weapon, ammo);
	}
	return 1;
}

public OnPlayerPause(playerid) {
	AFK[playerid] = 1;
	AFKTime[playerid] = 0;
	return 1;
}

public OnPlayerResume(playerid, time) {
	AFK[playerid] = 0;
	AFKTime[playerid] = 0;
	return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid) {
	if(pickupid == WarehousePic && GetPVarInt(playerid, "Warehouse") == 2 && WarehouseJob[playerid] == 1) {
		AnimOn[playerid] = true;
		ApplyAnimation(playerid,"CARRY","putdwn",4.0,0,1,1,0,0,1);
		RemovePlayerAttachedObject(playerid, 0);
		RemovePlayerAttachedObject(playerid, 1);
		SetTimerEx("ClearAnim", 1000, false, "i", playerid);
		SetPVarInt(playerid, "Warehouse", 0);
		new i = Random(500, 1500);
		Payment[playerid] += i;
		TotalJobMaterials += i;
		UpdateJobMaterials();
		new string[500];
		format(string, sizeof(string), "%d$", Payment[playerid]);
		PlayerTextDrawSetString(playerid, PaymentTD[playerid][1], string);
		PlayerTextDrawShow(playerid, PaymentTD[playerid][1]);
		if(UserData[playerid][pQuest2] == 0) {
			WareCP[playerid]++;
			if(WareCP[playerid] > 19) {
				WareCP[playerid] = 0;
				UserData[playerid][pQuest2] = 1;
				UpdateUserData(playerid, "pQuest2", UserData[playerid][pQuest2]);
				QuestMessage(playerid, "Warehouse Job", "+10000$");
				GiveUserMoney(playerid, 10000);
				success(playerid, "Tkven sheasrulet quest: {FEEDC2}materialebis dammzadebeli");
			} 
		}
	}
	if(pickupid == MtvirtaviPic && GetPVarInt(playerid, "Mtvirtavi") == 1 && MtvirtaviJob[playerid] == 1) {
		ApplyAnimation(playerid,"CARRY","putdwn",4.0,0,1,1,0,0,1);
		RemovePlayerAttachedObject(playerid, 0);
		RemovePlayerAttachedObject(playerid, 1);
		SetTimerEx("ClearAnim", 1000, false, "i", playerid);
		SetPVarInt(playerid, "Mtvirtavi", 0);
		new i = Random(500, 1500);
		Payment[playerid] += i;
		new string[500];
		format(string, sizeof(string), "%d$", Payment[playerid]);
		PlayerTextDrawSetString(playerid, PaymentTD[playerid][1], string);
		PlayerTextDrawShow(playerid, PaymentTD[playerid][1]);
		if(UserData[playerid][pQuest3] == 0) {
			MtvirtaviCP[playerid]++;
			if(MtvirtaviCP[playerid] > 9) {
				MtvirtaviCP[playerid] = 0;
				UserData[playerid][pQuest3] = 1;
				UpdateUserData(playerid, "pQuest3", UserData[playerid][pQuest3]);
				QuestMessage(playerid, "Mtvirtavi", "+20000$");
				GiveUserMoney(playerid, 20000);
				success(playerid, "Tkven sheasrulet quest: {FEEDC2}mtvirtavi");
			} 
		}
	}
	return 1;
}

public OnVehicleSpawn(vehicleid) {
	if(IsAOwnableCar(vehicleid)) {
	    UpdateCarInfo(vehicleid);
    	//ModCar(vehicleid);
	}
	return 1;
}

public OnVehicleDeath(vehicleid, killerid) {
	return 1;
}

public OnPlayerText(playerid, text[]) {
	GetPlayerName(playerid, Name(playerid), MAX_PLAYER_NAME);
	if(Login[playerid] == false) return false;
	if(Login[playerid]) {
		if(AnimOn[playerid] == false) ApplyAnimation(playerid, "PED", "IDLE_CHAT", 4.1, 0, 1, 1, 1, 1, 1), SetTimerEx("ClearAnim", 2000, false, "i", playerid);
		UsingAdress(playerid, text);
		new str[1200];
		if(AdminDuty[playerid]) format(str, sizeof(str), "{FF0000}%s{FFFFFF}: (( %s ))",Name(playerid), text);
		else if(UserData[playerid][pMute] > 0) {
			error(playerid, "Tkven gadevt chatis bani");
			return false;
		} 
		else if(KnocInfo[playerid][kActive] > 0) format(str, sizeof(str), "- %s[%d]: {FEEDC2}%s {EF545D}(Dachrili)", Name(playerid), playerid, text);
		else format(str, sizeof(str), "- %s[%d]: {FEEDC2}%s", Name(playerid), playerid, text);				
		ProxDetector(20.0, playerid, str, -1);
		return false;
	}
	return true;
}

public OnPlayerDamage(&playerid, &Float:amount, &issuerid, &weapon, &bodypart) {
	if(weapon == 41) return false;
	if(KnocInfo[playerid][kActive] == 1) return false;
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ) {
	if(!IsInAllowed(playerid) && !IsInGoverement(playerid)) {
		if(weaponid == 22 || weaponid == 23 || weaponid == 24 || weaponid == 25 || weaponid == 26
		|| weaponid == 27 || weaponid == 28 || weaponid == 29 || weaponid == 30 || weaponid == 31
		|| weaponid == 32 || weaponid == 33 || weaponid == 34) {
			if(GetPVarInt(playerid, "BulletUsed") == 0) {
				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				TotalBullet++;
				if(TotalBullet > 5998) {
					for(new i; i < TotalBullet; i ++) {
						Delete3DTextLabel(BulletText[i]);
						BulletInfo[i][bUsed] = 1;

						BulletInfo[i][BulletX] = 0;
						BulletInfo[i][BulletY] = 0;
						BulletInfo[i][BulletZ] = 0;

						TotalBullet = 1;

						printf("<> Max bullet value, refreshed");
					}
				}

				BulletInfo[TotalBullet][BulletID] = TotalBullet;
				BulletInfo[TotalBullet][bPlayerID] = playerid;
				strmid(BulletInfo[TotalBullet][bName], Name(playerid), 0, strlen(Name(playerid)), MAX_PLAYER_NAME);
				strmid(BulletInfo[TotalBullet][bWeapone], GetWeaponeName(weaponid), 0, strlen(GetWeaponeName(weaponid)), 100);
				BulletInfo[TotalBullet][BulletX] = x;
				BulletInfo[TotalBullet][BulletY] = y;
				BulletInfo[TotalBullet][BulletZ] = z;
				BulletInfo[TotalBullet][bUsed] = 0;
				BulletInfo[TotalBullet][bVW] = GetPlayerVirtualWorld(playerid);

				new bstring[500];
				format(bstring, sizeof(bstring), "{FFFFFF}Dzirs aris davardnili - {F0A45D} Iaragis tyvia\
					\n{FFFFFF}Gasrolili tyviis ID : [ {F0A45D}%d{FFFFFF} ]\
					\n{FFFFFF}Rom daiwyot tyviis eqspertiza gamoiyenet - {F0A45D}/fbullet", BulletInfo[TotalBullet][BulletID]);
				BulletText[TotalBullet] = Create3DTextLabel(bstring, -1, x, y, z-1, 5.0, GetPlayerVirtualWorld(playerid));
				SetPVarInt(playerid, "BulletUsed", 1);
				SetTimerEx("BulletTimer", 30000, false, "i", playerid);
				SetTimerEx("RemoveBullet", 300000, false, "id", playerid, TotalBullet);
			}
		}
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) {
	AFK[playerid] = 0;
	AFKTime[playerid] = 0;
	if(CleanerJob[playerid] == 1 && vehicleid == cleanercar[playerid] && !ispassenger) {
		SetPlayerCheckpoint(playerid, CleanerPos[CleanerCP[playerid]][0], CleanerPos[CleanerCP[playerid]][1], CleanerPos[CleanerCP[playerid]][2], 4.0);
	}
	if(KnocInfo[playerid][kActive] > 0) {
		TogglePlayerControllable(playerid, 0);
		SetTimerEx("SetAnimationKnock", 100, false, "i", playerid);
		SetTimerEx("SetAnimationKnock", 500, false, "i", playerid);	
        return false;
	}
	if(UserData[playerid][pMember] == 1) {
		foreach(new i:Player) {
		    if(gotome[i] == playerid) {
		        ClearAnimations(playerid);
		        error(playerid, "Tkven miatrevt damnashaves da ver chajdebit manqanashi");
		        return true;
			}
		}
	}
	if(IsAOwnableCar(vehicleid)) {
	    new carid = GetVehicleID(vehicleid);
	    if(CarInfo[carid][cLock])
		{
		   	ClearAnimations(playerid);
		   	SendClientMessage(playerid,-1,"Transporti daketilia!");
		}
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid) {
	AFK[playerid] = 0;
	AFKTime[playerid] = 0;
	if(CleanerJob[playerid] == 1 && vehicleid == cleanercar[playerid] && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
		DisablePlayerCheckpoint(playerid);
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate) {
	if(newstate == PLAYER_STATE_DRIVER) {
		new newcar = GetPlayerVehicleID(playerid);
		if(newcar >= sapdcar[0] && newcar <= sapdcar[18]) {
			if(UserData[playerid][pLeader] == 1 || UserData[playerid][pMember] == 1) { }
			else {
				error(playerid, "Tkven ver dajdebit am manqanashi, es manqana ekutvnis: {F0A45D}\"Police\"{FFFFFF}-s");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		/* ------------------------------------------------------------------ */
		if(newcar >= lvpdcar[0] && newcar <= lvpdcar[16]) {
			if(UserData[playerid][pLeader] == 6 || UserData[playerid][pMember] == 6) { }
			else {
				error(playerid, "Tkven ver dajdebit am manqanashi, es manqana ekutvnis: {F0A45D}\"Sheriff Station\"{FFFFFF}-s");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		/* ------------------------------------------------------------------ */
		if(newcar >= ballascar[0] && newcar <= ballascar[9]) {
			if(UserData[playerid][pLeader] == 7 || UserData[playerid][pMember] == 7) { }
			else {
				error(playerid, "Tkven ver dajdebit am manqanashi, es manqana ekutvnis: {F0A45D}\"The Ballas Gang\"{FFFFFF}-s");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		/* ------------------------------------------------------------------ */
		if(newcar >= grovecar[0] && newcar <= grovecar[9]) {
			if(UserData[playerid][pLeader] == 9 || UserData[playerid][pMember] == 9) { }
			else {
				error(playerid, "Tkven ver dajdebit am manqanashi, es manqana ekutvnis: {F0A45D}\"The Grove Gang\"{FFFFFF}-s");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if(newcar >= coronoscar[0] && newcar <= coronoscar[7]) {
			if(UserData[playerid][pLeader] == 10 || UserData[playerid][pMember] == 10) { }
			else {
				error(playerid, "Tkven ver dajdebit am manqanashi, es manqana ekutvnis: {F0A45D}\"The Aztecas Gang\"{FFFFFF}-s");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if(newcar >= vagoscar[0] && newcar <= vagoscar[9]) {
			if(UserData[playerid][pLeader] == 8 || UserData[playerid][pMember] == 8) { }
			else {
				error(playerid, "Tkven ver dajdebit am manqanis sachestan es manqana ekutvnis: {F0A45D}\"The Vagos Gang\"{FFFFFF}-s");
				RemovePlayerFromVehicleAC(playerid);
			}
		}
		if(newcar >= rifacar[0] && newcar <= rifacar[9]) {
			if(UserData[playerid][pLeader] == 11 || UserData[playerid][pMember] == 11) { }
			else {
				error(playerid, "Tkven ver dajdebit am manqanashi, es manqana ekutvnis: {F0A45D}\"The Rifa Gang\"{FFFFFF}-s");
				RemovePlayerFromVehicleAC(playerid);
  			}
		}
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid) {
	if(CleanerJob[playerid] == 1) {
		DisablePlayerCheckpoint(playerid);
		CleanerCP[playerid]++;
		new int = Random(300, 700);
		Payment[playerid] += int;
		new string[500];
		format(string, sizeof(string), "%d$", Payment[playerid]);
		PlayerTextDrawSetString(playerid, PaymentTD[playerid][1], string);
		PlayerTextDrawShow(playerid, PaymentTD[playerid][1]);
		if(CleanerCP[playerid] > 27 && UserData[playerid][pQuest1] == 0) {
			UserData[playerid][pQuest1] = 1;
			UpdateUserData(playerid, "pQuest1", UserData[playerid][pQuest1]);
			QuestMessage(playerid, "Cleaner Job", "+12000$");
			GiveUserMoney(playerid, 12000);
			success(playerid, "Tkven sheasrulet quest: {F0A45D}dasuftavebis tanamshromeli");
		} 
		if(CleanerCP[playerid] > 27) CleanerCP[playerid] = 0;
		SetPlayerCheckpoint(playerid, CleanerPos[CleanerCP[playerid]][0], CleanerPos[CleanerCP[playerid]][1], CleanerPos[CleanerCP[playerid]][2], 4.0);
	}
	if(gps[playerid]) {
	    gps[playerid] = false;
	    DisablePlayerCheckpoint(playerid);
	}
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid) {
	return 1;
}

public OnObjectMoved(objectid) {
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid) {	
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid) {
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid) {
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2) {
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row) {
	return 1;
}

public OnPlayerExitedMenu(playerid) {
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid) {
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	if(newkeys == 2) {
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
			if(PlayerToPoint(50.0, playerid, 2355.1125,789.9174,1009.1552)) {
	        	SetVehiclePos(caridhouse[playerid], HouseData[UserData[playerid][pHouse]][hCarx], HouseData[UserData[playerid][pHouse]][hCary], HouseData[UserData[playerid][pHouse]][hCarz]);
	            SetVehicleZAngle(caridhouse[playerid], HouseData[UserData[playerid][pHouse]][hCarc]);
			   	LinkVehicleToInterior(caridhouse[playerid], 0);
			   	SetPlayerInterior(playerid, 0);
	        	SetVehicleVirtualWorld(caridhouse[playerid], 0);
	        	SetPlayerVirtualWorld(playerid, 0);
	        	SetCameraBehindPlayer(playerid);
	        	success(playerid, "Tkven gamoxvedit garajidan");
	        }
			if(PlayerToPoint(10.0, playerid, HouseData[UserData[playerid][pHouse]][hCarx], HouseData[UserData[playerid][pHouse]][hCary], HouseData[UserData[playerid][pHouse]][hCarz])) {
				new h = UserData[playerid][pHouse];
				RemovePlayerFromVehicleAC(playerid);
 				SetPlayerPosEx(playerid, 2370.6304,789.5767,1013.4380);
        		SetPlayerFacingAngle(playerid, 95.1928);
        		SetPlayerVirtualWorld(playerid, h);
        		SetPlayerInterior(playerid, h);
				SetVehiclePos(caridhouse[playerid], 2355.1125,789.9174,1009.1552);
	            SetVehicleZAngle(caridhouse[playerid], 90.2700);
			 	LinkVehicleToInterior(caridhouse[playerid], h);
			 	SetVehicleVirtualWorld(caridhouse[playerid], h);
			 	SetCameraBehindPlayer(playerid);
			 	success(playerid, "Tkven shexvedit garajshi");
	        }
		}
   	}
    if(newkeys == KEY_SUBMISSION) { // 2
	    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
			PC_EmulateCommand(playerid, "/engine");
		}
	}
	if(newkeys == 4) { // Alt
        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
        	PC_EmulateCommand(playerid, "/carlights");
		}
	}
	if(newkeys == KEY_YES) {
		if(GetPVarInt(playerid, "InviteFraction") == 1) {
			UserData[playerid][pMember] = GetPVarInt(playerid, "InvFractionID");
			UserData[playerid][pForma] = GetPVarInt(playerid, "InvFractionSkin");
			UserData[playerid][pRank] = 1;
			SetPlayerSkin(playerid, UserData[playerid][pForma]);
			UpdateUserData(playerid, "pMember", UserData[playerid][pMember]);
			UpdateUserData(playerid, "pForma", UserData[playerid][pForma]);
			UpdateUserData(playerid, "pRank", UserData[playerid][pRank]);
			success(playerid, "Tkven datanxmdit fraqciashi gawevrianebas");
		}
		if(GetPVarInt(playerid, "Warehouse") == 1 && GetPVarInt(playerid, "WareNumber") == 1) {
			new int = Random(1, 4);
			SetPVarInt(playerid, "WareNumber", int);
			if(int == GetPVarInt(playerid, "WareNumber")) {
				int = Random(1, 4);
				SetPVarInt(playerid, "WareNumber", int);
			}
			SetPressNumber(playerid, int);
			WarehouseSuc[playerid]++;
			if(WarehouseSuc[playerid] > 7) {
				SuccessWarehouse(playerid);
				for(new i = 0; i < 7; i++) PlayerTextDrawHide(playerid, PressTD[playerid][i]);
			}
		}
		else if(GetPVarInt(playerid, "Warehouse") == 1 && GetPVarInt(playerid, "WareNumber") != 1) {
			WarehouseSuc[playerid]--;
			new int = Random(1, 4);
			SetPVarInt(playerid, "WareNumber", int);
			if(int == GetPVarInt(playerid, "WareNumber")) {
				int = Random(1, 4);
				SetPVarInt(playerid, "WareNumber", int);
			}
			SetPressNumber(playerid, int);
		}
	}
	if(newkeys == KEY_CTRL_BACK) {
		if(GetPVarInt(playerid, "Warehouse") == 1 && GetPVarInt(playerid, "WareNumber") == 2) {
			new int = Random(1, 4);
			SetPVarInt(playerid, "WareNumber", int);
			if(int == GetPVarInt(playerid, "WareNumber")) {
				int = Random(1, 4);
				SetPVarInt(playerid, "WareNumber", int);
			}
			SetPressNumber(playerid, int);
			WarehouseSuc[playerid]++;
			if(WarehouseSuc[playerid] > 7) {
				SuccessWarehouse(playerid);
				for(new i = 0; i < 7; i++) PlayerTextDrawHide(playerid, PressTD[playerid][i]);
			}
		}
		else if(GetPVarInt(playerid, "Warehouse") == 1 && GetPVarInt(playerid, "WareNumber") != 2) {
			WarehouseSuc[playerid]--;
			new int = Random(1, 4);
			SetPVarInt(playerid, "WareNumber", int);
			if(int == GetPVarInt(playerid, "WareNumber")) {
				int = Random(1, 4);
				SetPVarInt(playerid, "WareNumber", int);
			}
			SetPressNumber(playerid, int);			
		}
	}
	if(newkeys == KEY_NO) {
		if(GetPVarInt(playerid, "InviteFraction") == 1) {
			DeletePVar(playerid, "InviteFraction");
			DeletePVar(playerid, "InvFractionID");
			DeletePVar(playerid, "InvFractionSkin");		
			success(playerid, "Tkven uari fraqciashi gawevrianebaze");
		}
		if(GetPVarInt(playerid, "Warehouse") == 1 && GetPVarInt(playerid, "WareNumber") == 3) {
			new int = Random(1, 4);
			SetPVarInt(playerid, "WareNumber", int);
			if(int == GetPVarInt(playerid, "WareNumber")) {
				int = Random(1, 4);
				SetPVarInt(playerid, "WareNumber", int);
			}
			SetPressNumber(playerid, int);
			WarehouseSuc[playerid]++;
			if(WarehouseSuc[playerid] > 7) {
				SuccessWarehouse(playerid);
				for(new i = 0; i < 7; i++) PlayerTextDrawHide(playerid, PressTD[playerid][i]);
			}
		}
		else if(GetPVarInt(playerid, "Warehouse") == 1 && GetPVarInt(playerid, "WareNumber") != 3) {
			WarehouseSuc[playerid]--;
			new int = Random(1, 4);
			SetPVarInt(playerid, "WareNumber", int);
			if(int == GetPVarInt(playerid, "WareNumber")) {
				int = Random(1, 4);
				SetPVarInt(playerid, "WareNumber", int);
			}
			SetPressNumber(playerid, int);			
		}
	}
	if(newkeys == KEY_WALK) {
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
			if(PlayerToPoint(2.0, playerid, 252.7787, 109.0276, 1003.2188)) {
				if(UserData[playerid][pMember] != 1) return true;
				MoveObject(policedoor[0], 253.16051, 107.20970, 1003.45581, 0.7, 0.00000, 0.00000, 90.00000);
				SetTimer("ClosePDGate0", 2000, 0);
			}
			if(PlayerToPoint(2.0, playerid, 253.21300, 125.25500, 1003.45581)) {
				if(UserData[playerid][pMember] != 1) return true;
				MoveObject(policedoor[1], 253.21300, 123.25500, 1003.45581, 0.7, 0.00000, 0.00000, 90.00000);
				SetTimer("ClosePDGate1", 2000, 0);
			}
			if(PlayerToPoint(2.0, playerid, 239.5454, 125.0725, 1003.4558)) {
				if(UserData[playerid][pMember] != 1) return true;
				MoveObject(policedoor[2], 239.54539, 123.07250, 1003.45581, 0.7, 0.00000, 0.00000, 90.00000);
				SetTimer("ClosePDGate2", 2000, 0);
			}
			if(PlayerToPoint(2.0, playerid, 239.6351, 117.5612, 1003.2148)) {
				if(UserData[playerid][pMember] != 1) return true;
				MoveObject(policedoor[3], 239.63510, 115.70120, 1003.45581, 0.7, 0.00000, 0.00000, 90.00000);
				SetTimer("ClosePDGate3", 2000, 0);
			}
			if(PlayerToPoint(1.0, playerid, 1610.8766,-1893.8865,13.5469)) {
				if(CleanerJob[playerid] == 0) {
					ShowPlayerDialog(playerid, 301, DIALOG_STYLE_MSGBOX, "{FFFFFF}Samsaxuri",
					"{FFFFFF}- Tkven iwyebt mushaobas - {F0A45D}Dasuftavebis samsaxurshi\
	    			\n\n{FFFFFF}Tkveni movaleobaa daasuftovot qalaqi, amistvis miyevit witel checkpointebs\
	    			\n\n{F0A45D}* Tu gsurt mushaoba daachiret 'Next' gilaks", "Next", "Cancel");
					return true;
				}
				if(CleanerJob[playerid] == 1) {
					ShowPlayerDialog(playerid, 301, DIALOG_STYLE_MSGBOX, "{FFFFFF}Samsaxuri",
					"{FFFFFF}- Tkven asrulebt mushaobas - {F0A45D}Dasuftavebis samsaxurshi\
	    			\n\n{FFFFFF}Tu tvlit rom daasrulet daasuftaveba, gamoicvalet tansacmeli da aiget avansi\
	    			\n\n{F0A45D}* Tu gsurt daasrulot mushaoba daachiret 'Next' gilaks", "Next", "Cancel");
	    			return true;			
				}
			}
			if(PlayerToPoint(1.0, playerid, 2539.5708,-1299.5469,1044.1250)) {
				if(WarehouseJob[playerid] == 0) {
					ShowPlayerDialog(playerid, 305, DIALOG_STYLE_MSGBOX, "{FFFFFF}Samsaxuri",
					"{FFFFFF}- Tkven iwyebt mushaobas - {F0A45D}Materialebis dammzadebeli\
		    		\n\n{FFFFFF}Tkveni movaleobaa gaaketot materialebi, amistvis midit pickuptan da daachiret 'ALT's\
		    		\n\n{F0A45D}* Tu gsurt mushaoba daachiret 'Next' gilaks", "Next", "Cancel");
		    		return true;
	    		}
	    		if(WarehouseJob[playerid] == 1) {
					ShowPlayerDialog(playerid, 305, DIALOG_STYLE_MSGBOX, "{FFFFFF}Samsaxuri",
					"{FFFFFF}- Tkven asrulebt mushaobas - {F0A45D}Materialebis dammzadebeli\
		    		\n\n{FFFFFF}Tu tvlit rom daasrulet materialebis gaketeba, gamoicvalet tansacmeli da aiget avansi\
		    		\n\n{F0A45D}* Tu gsurt daasrulot mushaoba daachiret 'Next' gilaks", "Next", "Cancel");
		    		return true;
	    		}
			}
			if(PlayerToPoint(1.0, playerid, 2175.9668,-2259.2197,14.7734)) {
				if(MtvirtaviJob[playerid] == 0) {
					ShowPlayerDialog(playerid, 306, DIALOG_STYLE_MSGBOX, "{FFFFFF}Samsaxuri",
					"{FFFFFF}- Tkven iwyebt mushaobas - {F0A45D}Mtvirtavi\
		    		\n\n{FFFFFF}Tkveni movaleobaa gadazidot tvirti, amistvis midit pickuptan da daachiret 'ALT's\
		    		\n\n{F0A45D}* Tu gsurt mushaoba daachiret 'Next' gilaks", "Next", "Cancel");
		    		return true;
	    		}
	    		if(MtvirtaviJob[playerid] == 1) {
					ShowPlayerDialog(playerid, 306, DIALOG_STYLE_MSGBOX, "{FFFFFF}Samsaxuri",
					"{FFFFFF}- Tkven asrulebt mushaobas - {F0A45D}Mtvirtavi\
		    		\n\n{FFFFFF}Tu tvlit rom daasrulet materialebis gaketeba, gamoicvalet tansacmeli da aiget avansi\
		    		\n\n{F0A45D}* Tu gsurt daasrulot mushaoba daachiret 'Next' gilaks", "Next", "Cancel");
		    		return true;
	    		}
			}
			for(new i; i < TotalHouse; i ++) {
				if(i < TotalHouse && PlayerToPoint(1.0, playerid, HouseData[i][hEnterX], HouseData[i][hEnterY], HouseData[i][hEnterZ])) {
		            new string[300];
		            if(!HouseData[i][hOwned]) {
		            	format(string, sizeof(string), "{FFFFFF} - Saxlis informacia - {F0A45D}[ %d ]\
		            	\n\n{FFFFFF}Namdvilad gsurt sheidzinot mocemuli saxli?\
		            	\n{FFFFFF}Tkven mogiwevt gadaixadot: {F0A45D}[ %d$ ]{FFFFFF}\
		            	\n\n{F0A45D}* Tu gsurt sheidzinot saxli daachiret 'Next' gilaks", HouseData[i][hID], HouseData[i][hPrice]);
		 				ShowPlayerDialog(playerid, 401, DIALOG_STYLE_MSGBOX, "{FFFFFF}Saxli", string, "Next", "Cancel");
			    	}
				    else {
				    	static const dour_status[2][40 + 1] = {
							"Gaxsnili",
							"Daxuruli"
						};
				    	format(string, sizeof(string), "{FFFFFF} - Saxlis informacia - {F0A45D}[ %d ]\
		            	\n\n{FFFFFF}Gsurt shexvidet mocemul saxlshi?\
		            	\n{FFFFFF}Saxli mflobeli aris: {F0A45D}[ %s ]{FFFFFF}\
		            	\n{FFFFFF}Saxlis karebi aris: {F0A45D}[ %s ]{FFFFFF}\
		            	\n\n{F0A45D}* Tu gsurt shexvidet saxlshi daachiret 'Next' gilaks", HouseData[i][hID], HouseData[i][hOwner], dour_status[HouseData[i][hLock]]);
		      			ShowPlayerDialog(playerid, 402, DIALOG_STYLE_MSGBOX, "{FFFFFF}Saxli", string, "Next", "Cancel");
				    }
				}
			}
			for(new i; i < TotalBizz; i ++) {
				if(i < TotalBizz && PlayerToPoint(1.0, playerid, BizzData[i][bEnterX], BizzData[i][bEnterY], BizzData[i][bEnterZ])) {
		            new string[300];
		            if(!BizzData[i][bOwned]) {
		            	format(string, sizeof(string), "{FFFFFF} - Biznesis informacia - {F0A45D}[ %d ]\
		            	\n\n{FFFFFF}Namdvilad gsurt sheidzinot mocemuli biznesi?\
		            	\n{FFFFFF}Tkven mogiwevt gadaixadot: {F0A45D}[ %d$ ]{FFFFFF}\
		            	\n\n{F0A45D}* Tu gsurt sheidzinot biznesi daachiret 'Next' gilaks", BizzData[i][bID], BizzData[i][bPrice]);
		 				ShowPlayerDialog(playerid, 410, DIALOG_STYLE_MSGBOX, "{FFFFFF}Business", string, "Next", "Cancel");
			    	}
				    else {
				    	format(string, sizeof(string), "{FFFFFF} - Biznesis informacia - {F0A45D}[ %d ]\
		            	\n\n{FFFFFF}Mflobeli aris: {F0A45D}[ %s ]{FFFFFF}\
		            	\n{FFFFFF}Shesvlis fasi: {F0A45D}[ 500$ ]{FFFFFF}\
		            	\n\n{F0A45D}* Tu gsurt shexvidet daachiret 'Next' gilaks", BizzData[i][bID], BizzData[i][bOwner]);
		      			ShowPlayerDialog(playerid, 411, DIALOG_STYLE_MSGBOX, "{FFFFFF}Business", string, "Next", "Cancel");
				    }
				}
				if(PlayerToPoint(2.0, playerid, BizzData[i][bExitX], BizzData[i][bExitY], BizzData[i][bExitZ])) {
					if(GetPlayerVirtualWorld(playerid) == i + 50) {
						SetPlayerInterior(playerid, 0);
						SetPlayerVirtualWorld(playerid, 0);
						SetPlayerPosEx(playerid, BizzData[i][bEnterX], BizzData[i][bEnterY], BizzData[i][bEnterZ]);
						DeletePVar(playerid, "BUSINESS_ID");
						return true;
					}
				}
				if(PlayerToPoint(2.0, playerid, BizzData[i][bBuyX], BizzData[i][bBuyY], BizzData[i][bBuyZ])) {
					if(GetPlayerVirtualWorld(playerid) == i + 50) {
						if(BizzData[i][bType] == 1) {
							new string[500];
							format(string, sizeof(string), "{FFFFFF}Product\t{FFFFFF}Price\
							\n{F0A45D}[1]{FFFFFF} Mobiluri telefoni\t{F0A45D}[ 1000$ ]\
							\n{F0A45D}[2]{FFFFFF} Saati\t{F0A45D}[ 700$ ]");
				      		ShowPlayerDialog(playerid, 415, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Business", string, "Next", "Cancel");
			   				return true;
			      		}
			      		if(BizzData[i][bType] == 2) {
					 		SetPlayerPosEx(playerid, 206.5813,-4.0898,1001.2109);
					 		SetPlayerFacingAngle(playerid, 213.4595);
							SetPlayerInterior(playerid, 5);
							SetPlayerVirtualWorld(playerid, i + 550);

							TogglePlayerControllable(playerid, 0);

							SetPlayerCameraPos(playerid, 208.9160,-6.8391,1001.2109);
							SetPlayerCameraLookAt(playerid, 206.5813,-4.0898,1001.2109);

							SetPVarInt(playerid, "Choose_Skin", 1);

							for(new x; x < 8; x++) TextDrawShowForPlayer(playerid, enable_skin_TD[x]);
							SelectTextDraw(playerid, 0xFFCC00FF);
							if(UserData[playerid][pSex] == 1) {
								new string[500];
								SelectCharPlace[playerid] = 0;
								SetPlayerSkin(playerid, JoinShopM[SelectCharPlace[playerid]][0]);
								format(string, sizeof(string), "~w~~n~~n~~n~~n~~n~~n~COST: ~g~%i$", JoinShopM[SelectCharPlace[playerid]][1]);
							}
							else {
								new string[500];
								SelectCharPlace[playerid] = 0;
								SetPlayerSkin(playerid, JoinShopF[SelectCharPlace[playerid]][0]);
								format(string, sizeof(string), "~w~~n~~n~~n~~n~~n~~n~COST: ~g~%i$", JoinShopF[SelectCharPlace[playerid]][1]);
							}
							new string[128];
							GameTextForPlayer(playerid, string, 3000, 3);
			      			return true;
			      		}
		      		}
				}
			}
			if(PlayerToPoint(1.0, playerid, 854.5874,-605.2051,18.4219)) {
				SetPlayerPosEx(playerid, 2533.0220,-1284.7275,1048.2891);
			   	SetPlayerFacingAngle(playerid, 181.3583);
			    SetPlayerInterior(playerid, 2);
			    SetPlayerVirtualWorld(playerid, 0);
			    return true;
			}
			if(PlayerToPoint(1.0, playerid, 2531.3191,-1281.9058,1048.2891)) {
				SetPlayerPosEx(playerid, 853.9070,-601.9465,18.4219);
			   	SetPlayerFacingAngle(playerid, 22.2235);
			    SetPlayerInterior(playerid, 0);
			    SetPlayerVirtualWorld(playerid, 0);
			    return true;
			}
			// 1 = Y || 2 = H || 3 = N
			if(PlayerToPoint(1.0, playerid, 2558.5356,-1295.8503,1044.1250) && WarehouseJob[playerid] == 1) {		
				SetPlayerPosEx(playerid, 2558.5356,-1295.8503,1044.1250);
				SetPlayerFacingAngle(playerid, 356.2001);
				MomentWarehouse(playerid);
				for(new i = 0; i < 7; i++) PlayerTextDrawShow(playerid, PressTD[playerid][i]);
				new int = Random(1, 4);
				SetPVarInt(playerid, "WareNumber", int);
				SetPressNumber(playerid, int);
				return true;
			}
			if(PlayerToPoint(1.0, playerid, 2556.1470,-1295.8507,1044.1250) && WarehouseJob[playerid] == 1) {
				SetPlayerPosEx(playerid, 2556.1470,-1295.8507,1044.1250);
				SetPlayerFacingAngle(playerid, 357.1401);
				MomentWarehouse(playerid);
				for(new i = 0; i < 7; i++) PlayerTextDrawShow(playerid, PressTD[playerid][i]);
				new int = Random(1, 4);
				SetPVarInt(playerid, "WareNumber", int);
				SetPressNumber(playerid, int);
				return true;
			}
			if(PlayerToPoint(1.0, playerid, 2553.7817,-1295.8510,1044.1250) && WarehouseJob[playerid] == 1) {
				SetPlayerPosEx(playerid, 2553.7817,-1295.8510,1044.1250);
				SetPlayerFacingAngle(playerid, 1.2135);
				MomentWarehouse(playerid);
				for(new i = 0; i < 7; i++) PlayerTextDrawShow(playerid, PressTD[playerid][i]);
				new int = Random(1, 4);
				SetPVarInt(playerid, "WareNumber", int);
				SetPressNumber(playerid, int);
				return true;
			}
			if(PlayerToPoint(1.0, playerid, 2231.8831,-2284.7131,14.3751) && MtvirtaviJob[playerid] == 1) {
				AnimOn[playerid] = true;
				TogglePlayerControllable(playerid, 1);
				RemovePlayerAttachedObject(playerid, 0);
				RemovePlayerAttachedObject(playerid, 1);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
				SetPlayerAttachedObject(playerid,0,2060,6,0.0,0.10,-0.2, -110.0,0.0,78.0);
				SetPVarInt(playerid, "Mtvirtavi", 1);
			}
			if(PlayerToPoint(1.0, playerid, 320.9207,1116.8724,1083.8828)) {
				if(!IsInAllowed(playerid)) return error(playerid, "Tkven ar xart bandis wevri");
				new string[500];
				format(string, sizeof(string),
				"{F0A45D}[1]{FFFFFF} - Materialebis ageba\n\
				{F0A45D}[2]{FFFFFF} - Narkotikebis ageba");
				ShowPlayerDialog(playerid, 600, DIALOG_STYLE_LIST, "{FFFFFF}Gang", string, "Next", "Cancel");	
				if(GetPlayerVirtualWorld(playerid) == 7) {
					if(UserData[playerid][pMember] != 7) return true;
				}
				if(GetPlayerVirtualWorld(playerid) == 8) {
					if(UserData[playerid][pMember] != 8) return true;
				}
				if(GetPlayerVirtualWorld(playerid) == 9) {
					if(UserData[playerid][pMember] != 9) return true;
				}
				if(GetPlayerVirtualWorld(playerid) == 10) {
					if(UserData[playerid][pMember] != 10) return true;		
				}
				if(GetPlayerVirtualWorld(playerid) == 11) {
					if(UserData[playerid][pMember] != 11) return true;
				}
			}
			if(PlayerToPoint(1.0, playerid, 1555.5001,-1675.6489,16.1953)) {
				SetPlayerPosEx(playerid, 246.3712,110.5032,1003.2188);
		    	SetPlayerFacingAngle(playerid, 0.1991);
		        SetPlayerInterior(playerid, 10);
		        SetPlayerVirtualWorld(playerid, 0);
		        return true;
			}
			if(PlayerToPoint(1.0, playerid, 246.3353,107.2993,1003.2188)) {	
				SetPlayerPosEx(playerid, 1553.0751,-1675.7882,16.1953);
		    	SetPlayerFacingAngle(playerid, 89.4768);
		        SetPlayerInterior(playerid, 0);
		        SetPlayerVirtualWorld(playerid, 0);
		        return true;
			}
			if(PlayerToPoint(1.0, playerid, 626.9648,-571.7481,17.9207)) {
				SetPlayerPosEx(playerid, -703.3984,2607.0349,1006.1084);
		    	SetPlayerFacingAngle(playerid, 87.0058);
		        SetPlayerInterior(playerid, 0);
		        SetPlayerVirtualWorld(playerid, 0);
		        SetCameraBehindPlayer(playerid);				
			}
			if(PlayerToPoint(1.0, playerid, -701.9442,2607.5820,1006.1084)) {
				SetPlayerPosEx(playerid, 630.0365,-571.7982,16.3359);
		    	SetPlayerFacingAngle(playerid, 271.5445);
		        SetPlayerInterior(playerid, 0);
		        SetPlayerVirtualWorld(playerid, 0);
		        SetCameraBehindPlayer(playerid);				
			}

			if(PlayerToPoint(1.0, playerid, -709.2562,2592.2473,1006.1143)) {
				SetPlayerPosEx(playerid, -332.5941,2842.2227,940.1276);
		    	SetPlayerFacingAngle(playerid, 269.0541);
		        SetPlayerInterior(playerid, 0);
		        SetPlayerVirtualWorld(playerid, 0);
		        SetCameraBehindPlayer(playerid);				
			}

			if(PlayerToPoint(1.0, playerid, -334.4215,2842.4087,940.1276)) {
				SetPlayerPosEx(playerid, -709.1099,2594.4775,1006.1143);
		    	SetPlayerFacingAngle(playerid, 1.4649);
		        SetPlayerInterior(playerid, 0);
		        SetPlayerVirtualWorld(playerid, 0);
		        SetCameraBehindPlayer(playerid);				
			}

			if(PlayerToPoint(1.0, playerid, -333.2097,2843.3577,940.1276)) { // exit garage
				SetPlayerPosEx(playerid, 611.0287,-585.2182,17.2266);
		    	SetPlayerFacingAngle(playerid, 177.9038);
		        SetPlayerInterior(playerid, 0);
		        SetPlayerVirtualWorld(playerid, 0);
		        SetCameraBehindPlayer(playerid);				
			}


			if(PlayerToPoint(1.0, playerid, -322.7158,2841.7778,943.2977)) { // exit roof
				SetPlayerPosEx(playerid, 616.8169,-566.9755,26.1432);
		    	SetPlayerFacingAngle(playerid, 89.2530);
		        SetPlayerInterior(playerid, 0);
		        SetPlayerVirtualWorld(playerid, 0);
		        SetCameraBehindPlayer(playerid);				
			}

			if(PlayerToPoint(1.0, playerid, 610.9418,-583.4946,18.2109)) {
				SetPlayerPosEx(playerid, -332.5941,2842.2227,940.1276);
		    	SetPlayerFacingAngle(playerid, 269.0541);
		        SetPlayerInterior(playerid, 0);
		        SetPlayerVirtualWorld(playerid, 0);
		        SetCameraBehindPlayer(playerid);				
			}
			if(PlayerToPoint(1.0, playerid, 1172.5022,-1323.4323,15.4032)) { // hospital shesasvleli
				SetPlayerPosEx(playerid, 1977.7086,212.8602,1501.0859);
		    	SetPlayerFacingAngle(playerid, 91.8866);
		        SetPlayerInterior(playerid, 3);
		        SetPlayerVirtualWorld(playerid, 1);
		        SetCameraBehindPlayer(playerid);
		        return true;
			}
			if(PlayerToPoint(1.0, playerid, 1982.1182,212.5493,1501.0859)) {	//hospital gasasvleli
				SetPlayerPosEx(playerid, 1178.4241,-1323.9761,14.1194);
		    	SetPlayerFacingAngle(playerid, 270.1202);
		        SetPlayerInterior(playerid, 0);
		        SetPlayerVirtualWorld(playerid, 0);
		        SetCameraBehindPlayer(playerid);
		        return true;
			}
			if(PlayerToPoint(1.0, playerid, 1391.6912,-27.4429,1000.8630)) { // autosalon yidva
				PC_EmulateCommand(playerid, "/buycar");
		        return true;
			}
			if(PlayerToPoint(1.0, playerid, 553.3617,-1293.4238,17.2483)) { // autosalon shesvla
				SetPlayerPosEx(playerid, 1401.1182,-23.4513,1000.8630);
		    	SetPlayerFacingAngle(playerid, 176.6814);
			    SetPlayerInterior(playerid,1);
			    SetPlayerVirtualWorld(playerid, 333);
		        SetCameraBehindPlayer(playerid);
		        return true;
			}
			if(PlayerToPoint(1.0, playerid, 1401.7775,-21.3760,1000.8630)) {	//autosalon gamosvla
				SetPlayerPosEx(playerid, 553.6948,-1290.7292,17.2483);
		    	SetPlayerFacingAngle(playerid, 357.9434);
		        SetPlayerInterior(playerid, 0);
		        SetPlayerVirtualWorld(playerid, 0);
		        SetCameraBehindPlayer(playerid);
		        return true;
			}
			if(PlayerToPoint(1.0, playerid, 1481.0323,-1771.4735,18.7958)) {
				SetPlayerPosEx(playerid, 388.1274,173.7521,1008.3828);
		    	SetPlayerFacingAngle(playerid, 90.3778);
		        SetPlayerInterior(playerid, 3);
		        SetPlayerVirtualWorld(playerid, 0);	
		        return true;			
			}
			if(PlayerToPoint(1.0, playerid, 390.7699,173.8612,1008.3828)) {	
				SetPlayerPosEx(playerid, 1481.1017,-1766.6605,18.7958);
		    	SetPlayerFacingAngle(playerid, 358.5830);
		        SetPlayerInterior(playerid, 0);
		        SetPlayerVirtualWorld(playerid, 0);
		        return true;
			}
			if(PlayerToPoint(1.0, playerid, 318.5814,1114.4794,1083.8828)) {
				if(GetPlayerVirtualWorld(playerid) == 7) {
					SetPlayerPosEx(playerid, 2000.2141,-1119.5122,26.7813);
			    	SetPlayerFacingAngle(playerid, 180.3209);
			        SetPlayerInterior(playerid, 0);
			        SetPlayerVirtualWorld(playerid, 0);
			        return true;
		    	}
			}
			if(PlayerToPoint(1.0, playerid, 318.5814,1114.4794,1083.8828)) {
				if(GetPlayerVirtualWorld(playerid) == 8) {
					SetPlayerPosEx(playerid, 2756.0842,-1180.6396,69.3949);
			    	SetPlayerFacingAngle(playerid, 359.8600);
			        SetPlayerInterior(playerid, 0);
			        SetPlayerVirtualWorld(playerid, 0);
			        return true;
		    	}
			}
			if(PlayerToPoint(1.0, playerid, 318.5814,1114.4794,1083.8828)) {
				if(GetPlayerVirtualWorld(playerid) == 9) {
					SetPlayerPosEx(playerid, 2495.2117,-1689.4341,14.4285);
			    	SetPlayerFacingAngle(playerid, 359.9833);
			        SetPlayerInterior(playerid, 0);
			        SetPlayerVirtualWorld(playerid, 0);
			        return true;
		    	}
			}
			if(PlayerToPoint(1.0, playerid, 318.5814,1114.4794,1083.8828)) {
				if(GetPlayerVirtualWorld(playerid) == 10) {
					SetPlayerPosEx(playerid, 1667.4188,-2108.2886,13.8906);
			    	SetPlayerFacingAngle(playerid, 180.0285);
			        SetPlayerInterior(playerid, 0);
			        SetPlayerVirtualWorld(playerid, 0);
			        return true;
		    	}
			}
			if(PlayerToPoint(1.0, playerid, 318.5814,1114.4794,1083.8828)) {
				if(GetPlayerVirtualWorld(playerid) == 11) {
					SetPlayerPosEx(playerid, 2783.1860,-1924.3845,13.5469);
			    	SetPlayerFacingAngle(playerid, 89.0775);
			        SetPlayerInterior(playerid, 0);
			        SetPlayerVirtualWorld(playerid, 0);
			        return true;
		    	}
			}
			if(PlayerToPoint(1.0, playerid, 1298.8999,-796.8135,1084.0078)) {
				if(GetPlayerVirtualWorld(playerid) == 5) {
					SetPlayerPosEx(playerid, 1298.4120,-800.9894,84.1406);
			    	SetPlayerFacingAngle(playerid, 181.5821);
			        SetPlayerInterior(playerid, 0);
			        SetPlayerVirtualWorld(playerid, 0);
			        return true;
		    	}
			}
			if(PlayerToPoint(1.0, playerid, 1298.5022,-798.3752,84.1406)) {
				SetPlayerPosEx(playerid, 1299.3728,-794.2172,1084.0078);
			    SetPlayerFacingAngle(playerid, 346.0602);
			    SetPlayerInterior(playerid, 5);
			    SetPlayerVirtualWorld(playerid, 5);
			    return true;
			}
			if(PlayerToPoint(1.0, playerid, 2000.0381,-1114.5784,27.1250)) {
				SetPlayerPosEx(playerid, 318.8350,1116.7539,1083.8828);
			    SetPlayerFacingAngle(playerid, 351.8858);
			    SetPlayerInterior(playerid, 5);
			    SetPlayerVirtualWorld(playerid, 7);
			    return true;
			}
			if(PlayerToPoint(1.0, playerid, 2756.3967,-1182.8093,69.4035)) {
				SetPlayerPosEx(playerid, 318.8350,1116.7539,1083.8828);
			    SetPlayerFacingAngle(playerid, 351.8858);
			    SetPlayerInterior(playerid, 5);
			    SetPlayerVirtualWorld(playerid, 8);
			    return true;
			}
			if(PlayerToPoint(1.0, playerid, 2495.3989,-1691.1401,14.7656)) {
				SetPlayerPosEx(playerid, 318.8350,1116.7539,1083.8828);
			    SetPlayerFacingAngle(playerid, 351.8858);
			    SetPlayerInterior(playerid, 5);
			    SetPlayerVirtualWorld(playerid, 9);
			    return true;
			}
			if(PlayerToPoint(1.0, playerid, 1667.4960,-2106.9409,14.0723)) {
				SetPlayerPosEx(playerid, 318.8350,1116.7539,1083.8828);
			    SetPlayerFacingAngle(playerid, 351.8858);
			    SetPlayerInterior(playerid, 5);
			    SetPlayerVirtualWorld(playerid, 10);
			    return true;
			}
			if(PlayerToPoint(1.0, playerid, 2787.0764,-1926.0674,13.5469)) {
				SetPlayerPosEx(playerid, 318.8350,1116.7539,1083.8828);
			    SetPlayerFacingAngle(playerid, 351.8858);
			    SetPlayerInterior(playerid, 5);
			    SetPlayerVirtualWorld(playerid, 11);
			    return true;
			}
  			if(PlayerToPoint(1.0, playerid, 1685.6632,-2312.7805,-2.6686)) {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Faggio");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "420$");
				PlayerTextDrawSetPreviewRot(playerid, RentTD_P[playerid][2], 0.000000, 0.000000, -13.000000, 1.0);
				PlayerTextDrawSetPreviewRot(playerid, RentTD_P[playerid][3], 0.000000, 0.000000, 0.000000, 1.0);
				PlayerTextDrawSetPreviewRot(playerid, RentTD_P[playerid][4], 0.000000, 0.000000, 13.000000, 1.0);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 439);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 462);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 410);
				for(new i = 0; i < 8; i ++) {
					if(i < 5) {
						PlayerTextDrawSetPreviewVehCol(playerid, RentTD_P[playerid][i], 145, 145);
						PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
					}
					TextDrawShowForPlayer(playerid, RentTD_G[i]);
				}
				RentTD_Used[playerid] = true;
				Rent_Choose[playerid] = 462;
				Rent_Price[playerid] = 420;
				SelectTextDraw(playerid, -1);
				Rent_Num[playerid] = 5;
			    return true;
			}
			if(PlayerToPoint(1.0, playerid, 306.3511,1120.5734,1083.8828)) {
		    	PC_EmulateCommand(playerid, "/changeskin");
				return true;
			}
		}
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success) {
	return 1;
}


public OnPlayerUpdate(playerid) {
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid) {
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid) {
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid) {
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid) {
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	if(dialogid == 5015) {
	    if(response) {
			new carid = GetPlayerVehicleID(playerid);
			if(IsAOwnableCar(carid)) {
				if(IsPlayerInOwnedVehicle(playerid))
				{
					new cost = GetCarPrice(carid)/2;
					GiveUserMoney(playerid, cost);
					format(s_string, sizeof(s_string), "~g~+%d$", cost);
					GameTextForPlayer(playerid, s_string, 5000, 1);

					UserData[playerid][pCars] -= 1;
					UpdateUserData(playerid, "pCars", UserData[playerid][pCars]);
					SellCar(carid);

                    RemovePlayerFromVehicleAC(playerid);

				  	format(YCMDstr, sizeof(YCMDstr), "[A] [CARSHOP] Motamashe %s[%d] gayida avtomobili (Model: %s, ID: %d).",Name(playerid),playerid,VehicleNames[GetVehicleModel(carid)-400],carid);
					SendAdminMessage(-1, YCMDstr);
				}
			}
	    }
	}
	if(dialogid == 9000) {
 		if(response) return true;
		else {
			if(FrakCD[UserData[playerid][pMember]] != 0) return error(playerid,"Tkven bandas ukve qonda brdzola am saatshi");
			if(!startcapture) return error(playerid,"Am dros teritoriis dapyroba daushvebelia, daelodet paydays");
   			for(new i = 0; i < 104; i++) {
      			if(PlayerToKvadrat(playerid,ZoneInfo[i][gCoords][0], ZoneInfo[i][gCoords][1],ZoneInfo[i][gCoords][2],ZoneInfo[i][gCoords][3]) && ZoneInfo[i][gFrakVlad] != UserData[playerid][pMember] && ZoneOnBattle[i]==0) {
					new playerss = 0;
					new playeri = 0;
					foreach(new m:Player) {
						if(UserData[m][pMember] == ZoneInfo[i][gFrakVlad]) playerss++;
						if(UserData[m][pMember] == UserData[playerid][pMember]) playeri++;
					}
					if(FrakCD[ZoneInfo[i][gFrakVlad]] != 0) return error(playerid,"Bandam romelsac tkven captavt ukve ibrdzola am saatshi");
					if(FrakCD[ZoneInfo[i][gFrakVlad]] != 0) return error(playerid,"Bandam romelsac tkven captavt ukve ibrdzola am saatshi");
	    			FrakCD[ZoneInfo[i][gFrakVlad]] = 1;
					FrakCD[UserData[playerid][pMember]] = 1;
					GZSafeTime[i] = 901;
					ZoneInfo[i][gNapad] = UserData[playerid][pMember];
					ZoneOnBattle[i] = 1;
					captures++;
					format(YCMDstr, 256, "Banda {F0A45D}%s{FFFFFF}-m daiwyo teritoriisatvis brdzola banda {F0A45D}%s{FFFFFF}-stan. Capter: {F0A45D}%s", GetFractionName(ZoneInfo[i][gNapad]), GetFractionName(ZoneInfo[i][gFrakVlad]), Name(playerid));
					SendGangMessage(YCMDstr);
					SendAdminMessage(-1, YCMDstr);
					GangZoneFlashForAll(ZoneInfo[i][gID],GetGZColorF(UserData[playerid][pMember]));
					if(GzCheckOn == 0) {
						GzCheckTimer = SetTimer("GzCheck", 1000,1);
						GzCheckOn = 1;
					}
					break;
			    }
			}
		}
	}
	switch(dialogid) {
		case 900: {
            if(!response) return true;
            if(caridhouse[playerid] != -1) DestroyVehicle(caridhouse[playerid]);
            caridhouse[playerid] = AddStaticVehicle(MyCarID[playerid][listitem], 2355.1125,789.9174,1009.1552,90.2700, 0, 0);
           	SetVehicleNumberPlate(caridhouse[playerid], "GENUINE");
			SetVehicleHealth(caridhouse[playerid], 1500.0);
		 	LinkVehicleToInterior(caridhouse[playerid], GetPlayerInterior(playerid));
		 	SetVehicleVirtualWorld(caridhouse[playerid], GetPlayerVirtualWorld(playerid));
		 	GiveUserMoney(playerid, -100);
		 	success(playerid, "Tkven warmatebit daarespawnet tkveni mankana");
            return true;
        }
		case 100: {
			if(response) {
				if(!strlen(inputtext)) {
	           		ShowLoginDialog(playerid);
	             	return true;
	           	}	
	          	for(new i = strlen(inputtext)-1; i != -1; i--) {
		            switch(inputtext[i]) {
		                case '0'..'9', 'a'..'z', 'A'..'Z': continue;
		                default: {
		                	ShowLoginDialog(playerid);
		                	error(playerid, "Paroli unda iyos sheyvanili latinuri asoebit");
		                	return true;
		                }
		            }
	        	}
	        	OnPlayerLogin(playerid, inputtext);
	        }
			else srvKick(playerid);
		}
		case 101: {
			if(response) {
				if(!strlen(inputtext)) {
	           		ShowRegisterDialog(playerid);
	             	return true;
	           	}
				else if(strlen(inputtext) < 8 || strlen(inputtext) > 32) {
					error(playerid, "Parolis sigrdze unda iyos 8'dan 32'amde");
	   				ShowRegisterDialog(playerid);
	       			return true;
				}
				for(new i = strlen(inputtext)-1; i != -1; i--) {
	     			switch(inputtext[i]) {
	        			case '0'..'9', 'a'..'z', 'A'..'Z': continue;
	           			default: {
		   					ShowRegisterDialog(playerid);
						   	error(playerid, "Paroli unda iyos sheyvanili latinuri asoebit");
						   	return true;
			   			}
	              	}
	          	}
	          	strmid(UserData[playerid][pPassword], inputtext, 0, strlen(inputtext), 32);
	          	UpdateUserData(playerid, "pPassword", UserData[playerid][pPassword]);
	          	ShowEmailDialog(playerid);
			}
			else srvKick(playerid);
		}
		case 102: {
			if(response) {
				if(!strlen(inputtext)) {
	           		ShowEmailDialog(playerid);
	             	return true;
	           	}
				if(strfind(inputtext, "@gmail.com", true) == -1) {
					ShowEmailDialog(playerid);
	 				error(playerid, "Emails aucileblad unda gaachndes @gmail.com daboloeba");
	 				return true;
				}
			 	strmid(UserData[playerid][pMail], inputtext, 0, strlen(inputtext), 64);
		 		UpdateUserData(playerid, "pMail", UserData[playerid][pMail]);
		 		ShowPlayerDialog(playerid, 103, DIALOG_STYLE_MSGBOX, "{FFFFFF}Registracia",
		 		"{FFFFFF}- Tkven imyofebit serverze - {F0A45D}Genuine Role Play\n\n\
		 		{FFFFFF}Airchiet tkveni personajis sqesi\n\n\
		 		{F0A45D}* Mamakaci - Male | Qalbatoni - Female",
		 		"Male", "Female");
			}
			else srvKick(playerid);
		}
		case 103: {
			if(response) {
				UserData[playerid][pSex] = 1;
				UserData[playerid][pSkin] = 3;
			} else {
				UserData[playerid][pSex] = 2;
				UserData[playerid][pSkin] = 6;
			}
			UpdateUserData(playerid, "pSex", UserData[playerid][pSex]);
			UpdateUserData(playerid, "pSkin", UserData[playerid][pSkin]);

		 	ShowPlayerDialog(playerid, 104, DIALOG_STYLE_MSGBOX, "{FFFFFF}Registracia",
			"{FFFFFF}- tkven imyofebit serverze - {F0A45D}Genuine Role Play\n\n\
		 	{FFFFFF}Aris tu ara tkvens mier mititebuli informacia swori?\n\n\
		 	{F0A45D}* Tu yvelaferi sworad miutetet daachiret 'Yes'",
		 	"Yes", "No");
		}
		case 104: {
			if(response) {
				new sql_str[2000];
				new ip[15]; GetPlayerIp(playerid, ip, 15);
	            mysql_format(connects, sql_str, sizeof(sql_str), "INSERT INTO `accounts` (`pName`, `pPassword`, `pMail`, `pSex`, `pSkin`, `pRegIP`) VALUES ('%e', '%e', '%e', '%d', '%d', '%s')",
	            Name(playerid), UserData[playerid][pPassword], UserData[playerid][pMail], UserData[playerid][pSex], UserData[playerid][pSkin], ip);
	            mysql_query(connects, sql_str);

	            Login[playerid] = true;

	         	SetPVarInt(playerid, "RegisterSpawn", 1);
	            PlayerRegisterSetting(playerid);

	           	SetSpawnInfo(playerid, 0, 0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
	            TogglePlayerSpectating(playerid, 0);
	            SpawnPlayer(playerid);

	            success(playerid, "Gilocavt, tkven warmatebit gaiaret registracia");
	            printf("<> %s - new account created", Name(playerid));
	        }
	        else ShowRegisterDialog(playerid);	
		}
		case 201: {
			if(response) {
				if(!strlen(inputtext)) {
	           		PC_EmulateCommand(playerid, "/alogin");
	             	return true;
	           	}	
	          	for(new i = strlen(inputtext)-1; i != -1; i--) {
		            switch(inputtext[i]) {
		                case '0'..'9', 'a'..'z', 'A'..'Z': continue;
		                default: {
		                	PC_EmulateCommand(playerid, "/alogin");
		                	error(playerid, "Paroli unda iyos sheyvanili latinuri asoebit");
		                	return true;
		                }
		            }
	        	}
	        	OnAdminLogin(playerid, inputtext);				
			}
			else return true;
		}
		case 202: {
			if(response) {
				if(!strlen(inputtext)) {
	             	return true;
	           	}
				else if(strlen(inputtext) < 4 || strlen(inputtext) > 30) {
					error(playerid, "Parolis sigrdze unda iyos 4'dan 30'amde");
	   				ShowAdminDialog(playerid);
	       			return true;
				}
				for(new i = strlen(inputtext)-1; i != -1; i--) {
	     			switch(inputtext[i]) {
	        			case '0'..'9', 'a'..'z', 'A'..'Z': continue;
	           			default: {
		   					ShowAdminDialog(playerid);
						   	error(playerid, "Paroli unda iyos sheyvanili latinuri asoebit");
						   	return true;
			   			}
	              	}
	          	}
				UserData[playerid][pAdmin] = GetPVarInt(playerid, "AdminLVL");
				UpdateUserData(playerid, "pAdmin", UserData[playerid][pAdmin]);

			    new query[600];
				format(query, sizeof(query), "UPDATE `accounts` SET `pDostup` = '%s' WHERE `pName` = '%s' LIMIT 1", inputtext, Name(playerid));
				mysql_tquery(connects, query, "", "");

				success(playerid, "Tkven warmatebit sheiyvanet admin paroli");
				PC_EmulateCommand(playerid, "/alogin");
			}
			else return true;
		}
		case 203: {
			if(response) {
				new id = GetPVarInt(playerid, "LeaderID");
				switch(listitem) {
					case 0: { UserData[id][pLeader] = 1; UserData[id][pMember] = 1; UserData[id][pRank] = 15; UserData[id][pForma] = 288; }
					case 1: { UserData[id][pLeader] = 2; UserData[id][pMember] = 2; UserData[id][pRank] = 9; UserData[id][pForma] = 70; } // Hospital
					case 2: { UserData[id][pLeader] = 3; UserData[id][pMember] = 3; UserData[id][pRank] = 9; UserData[id][pForma] = 147; } // Governot
					case 3: { UserData[id][pLeader] = 4; UserData[id][pMember] = 4; UserData[id][pRank] = 9; UserData[id][pForma] = 61; } // Army
				}
				UpdateUserData(id, "pLeader", UserData[id][pLeader]);
				UpdateUserData(id, "pMember", UserData[id][pMember]);
				UpdateUserData(id, "pRank", UserData[id][pRank]);
				UpdateUserData(playerid, "pForma", UserData[id][pForma]);

				new string[500];
				format(string, sizeof(string), "Administratorma: {F0A45D}%s{FFFFFF}'m(a) dagnishnat {F0A45D}%s{FFFFFF}'is liderad", Name(playerid), GetFractionName(UserData[id][pLeader]));
				SendClientMessage(id, -1, string);
				format(string, sizeof(string), "Tkven danishnet motamashe {F0A45D}%s[%d]{FFFFFF} - {F0A45D}%s{FFFFFF}'is liderad", Name(id), id, GetFractionName(UserData[id][pLeader]));
				SendClientMessage(playerid, -1, string);

				SpawnPlayer(id);
			}
			else return true;
		}
		case 204: {
			if(response) {
				new id = GetPVarInt(playerid, "LeaderID");
				switch(listitem) {
					case 0: { UserData[id][pLeader] = 7; UserData[id][pMember] = 7; UserData[id][pRank] = 9; UserData[id][pForma] = 104; }
					case 1: { UserData[id][pLeader] = 8; UserData[id][pMember] = 8; UserData[id][pRank] = 9; UserData[id][pForma] = 110; } 
					case 2: { UserData[id][pLeader] = 9; UserData[id][pMember] = 9; UserData[id][pRank] = 9; UserData[id][pForma] = 270; }
					case 3: { UserData[id][pLeader] = 10; UserData[id][pMember] = 10; UserData[id][pRank] = 9; UserData[id][pForma] = 292; }
					case 4: { UserData[id][pLeader] = 11; UserData[id][pMember] = 11; UserData[id][pRank] = 9; UserData[id][pForma] = 273; }
				}
				UpdateUserData(id, "pLeader", UserData[id][pLeader]);
				UpdateUserData(id, "pMember", UserData[id][pMember]);
				UpdateUserData(id, "pRank", UserData[id][pRank]);
				UpdateUserData(playerid, "pForma", UserData[id][pForma]);

				new string[500];
				format(string, sizeof(string), "Administratorma: {F0A45D}%s{FFFFFF}'m(a) dagnishnat {F0A45D}%s{FFFFFF}'is liderad", Name(playerid), GetFractionName(UserData[id][pLeader]));
				SendClientMessage(id, -1, string);
				format(string, sizeof(string), "Tkven danishnet motamashe {F0A45D}%s[%d]{FFFFFF} - {F0A45D}%s{FFFFFF}'is liderad", Name(id), id, GetFractionName(UserData[id][pLeader]));
				SendClientMessage(playerid, -1, string);

				SpawnPlayer(id);
			}
			else return true;
		}
		case 205: {
			if(response) {
				new id = GetPVarInt(playerid, "LeaderID");
				switch(listitem) {
					case 0: { UserData[id][pLeader] = 5; UserData[id][pMember] = 5; UserData[id][pRank] = 9; UserData[id][pForma] = 290; }
					case 1: { UserData[id][pLeader] = 6; UserData[id][pMember] = 6; UserData[id][pRank] = 9; UserData[id][pForma] = 288; }
				}
				UpdateUserData(id, "pLeader", UserData[id][pLeader]);
				UpdateUserData(id, "pMember", UserData[id][pMember]);
				UpdateUserData(id, "pRank", UserData[id][pRank]);
				UpdateUserData(playerid, "pForma", UserData[id][pForma]);

				new string[500];
				format(string, sizeof(string), "Administratorma: {F0A45D}%s{FFFFFF}'m(a) dagnishnat {F0A45D}%s{FFFFFF}'is liderad", Name(playerid), GetFractionName(UserData[id][pLeader]));
				SendClientMessage(id, -1, string);
				format(string, sizeof(string), "Tkven danishnet motamashe {F0A45D}%s[%d]{FFFFFF} - {F0A45D}%s{FFFFFF}'is liderad", Name(id), id, GetFractionName(UserData[id][pLeader]));
				SendClientMessage(playerid, -1, string);

				SpawnPlayer(id);
			}
			else return true;
		}
		case 301: {
			if(response) {
				if(CleanerJob[playerid] == 0) {
					if(UserData[playerid][pMember] > 0) return error(playerid, "Tkven xart gawevrianebuli organizaciashi, amitom ar shegidzliat mushaoba");
					success(playerid, "Rodesac daamtavrebt samsaxurs dabrundit ukan da gamoicvalet forma");
					
					SetPlayerSkin(playerid, 42);
					createdvehs ++;
	 				cleanercar[playerid] = CreateVehicle(574, 1623.8069, -1894.1139, 13.2754, 359.6696, 1, 1, 60000);
					SetVehicleHealth(cleanercar[playerid], 1300.0);
					PutPlayerInVehicleEx(playerid, cleanercar[playerid], 0);
					SetPlayerArmedWeapon(playerid, 0);
					vehcreat[cleanercar[playerid]] = 1;
					CreatedCars[CreatedCar] = cleanercar[playerid];

					CleanerJob[playerid] = 1;
					CleanerCP[playerid] = 0;
					Payment[playerid] = 0;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, CleanerPos[CleanerCP[playerid]][0],CleanerPos[CleanerCP[playerid]][1],CleanerPos[CleanerCP[playerid]][2], 4.0);
					CleanerCP[playerid]++;

					new string[500];
					format(string, sizeof(string), "%d$", Payment[playerid]);
					PlayerTextDrawSetString(playerid, PaymentTD[playerid][1], string);
					PlayerTextDrawShow(playerid, PaymentTD[playerid][1]);
					for(new i = 0; i < 2; i++) PlayerTextDrawShow(playerid, PaymentTD[playerid][i]);

					return true;
				}
				if(CleanerJob[playerid] == 1) {
					success(playerid, "Tkven daasrulet mushaoba dasuftavebis samsaxurshi");
					CleanerJob[playerid] = 0;
					CleanerCP[playerid] = 0;

					GiveUserMoney(playerid, Payment[playerid]);
					Payment[playerid] = 0;
					DisablePlayerCheckpoint(playerid);
					SetPlayerSkin(playerid, UserData[playerid][pSkin]);

					for(new i = 0; i < 2; i++) PlayerTextDrawHide(playerid, PaymentTD[playerid][i]);
					if(cleanercar[playerid] != -1) {
						DestroyVehicle(cleanercar[playerid]);
						cleanercar[playerid] = -1;
					}
					return true;
				}
			}
			else return true;
		}
		case 305: {
			if(response) {
				if(WarehouseJob[playerid] == 0) {
					if(UserData[playerid][pMember] > 0) return error(playerid, "Tkven xart gawevrianebuli organizaciashi, amitom ar shegidzliat mushaoba");
					success(playerid, "Tkven daiwyet mushaoba materialebis dammzadeblad, midit pickuptan da daachiret 'ALT's");
					success(playerid, "Rodesac daamtavrebt samsaxurs dabrundit ukan da gamoicvalet forma");

					SetPlayerSkin(playerid, 27);
					WarehouseJob[playerid] = 1;
					Payment[playerid] = 0;

					new string[500];
					format(string, sizeof(string), "%d$", Payment[playerid]);
					PlayerTextDrawSetString(playerid, PaymentTD[playerid][1], string);
					PlayerTextDrawShow(playerid, PaymentTD[playerid][1]);
					for(new i = 0; i < 2; i++) PlayerTextDrawShow(playerid, PaymentTD[playerid][i]);
					return true;
				}
				if(WarehouseJob[playerid] == 1) {
					success(playerid, "Tkven daasrulet mushaoba rogorc materialebis dammzadebeli");
					WarehouseJob[playerid] = 0;

					GiveUserMoney(playerid, Payment[playerid]);
					SetPlayerSkin(playerid, UserData[playerid][pSkin]);

					Payment[playerid] = 0;
					for(new i = 0; i < 2; i++) PlayerTextDrawHide(playerid, PaymentTD[playerid][i]);
					return true;
				}
			}
			else return true;
		}
		case 306: {
			if(response) {
				if(MtvirtaviJob[playerid] == 0) {
					if(UserData[playerid][pMember] > 0) return error(playerid, "Tkven xart gawevrianebuli organizaciashi, amitom ar shegidzliat mushaoba");
					success(playerid, "Tkven daiwyet mushaoba mtvirtavad, midit pickuptan da daachiret 'ALT's");
					success(playerid, "Rodesac daamtavrebt samsaxurs dabrundit ukan da gamoicvalet forma");

					SetPlayerSkin(playerid, 27);
					MtvirtaviJob[playerid] = 1;
					Payment[playerid] = 0;

					new string[500];
					format(string, sizeof(string), "%d$", Payment[playerid]);
					PlayerTextDrawSetString(playerid, PaymentTD[playerid][1], string);
					PlayerTextDrawShow(playerid, PaymentTD[playerid][1]);
					for(new i = 0; i < 2; i++) PlayerTextDrawShow(playerid, PaymentTD[playerid][i]);
					return true;
				}
				if(MtvirtaviJob[playerid] == 1) {
					success(playerid, "Tkven daasrulet mushaoba mtvirtavad");
					MtvirtaviJob[playerid] = 0;

					GiveUserMoney(playerid, Payment[playerid]);
					SetPlayerSkin(playerid, UserData[playerid][pSkin]);

					Payment[playerid] = 0;
					for(new i = 0; i < 2; i++) PlayerTextDrawHide(playerid, PaymentTD[playerid][i]);
					return true;
				}
			}
			else return true;
		}
		case 401: {
			if(response) {
				for(new h = 0; h <= TotalHouse; h ++) {
					if(PlayerToPoint(2.0, playerid, HouseData[h][hEnterX], HouseData[h][hEnterY], HouseData[h][hEnterZ])) {
						if(UserData[playerid][pHouse] != -1 && strcmp(Name(playerid), HouseData[UserData[playerid][pHouse]][hOwner], true) == 0) return error(playerid, "Tkven ukve gaqvt shedzenili saxli");
						if(UserData[playerid][pCash] < HouseData[h][hPrice]) return error(playerid, "Tkven ar gaqvt sakmarisi tanxa");

						UserData[playerid][pHouse] = h;
					    UpdateUserData(playerid, "pHouse", UserData[playerid][pHouse]);
					    HouseData[h][hOwned] = 1;
					    strmid(HouseData[h][hOwner], Name(playerid), 0, strlen(Name(playerid)), MAX_PLAYER_NAME);
						GiveUserMoney(playerid,  -HouseData[h][hPrice]);

						new house = UserData[playerid][pHouse];
					    UpdateHouse(house);
					    SaveHouse(house);

					    success(playerid, "Tkven warmatebit sheidzinet saxli. Ar dagaviwyet saxlis angarishis shevseba");
						success(playerid, "Saxlis panelis samartavad gamoiyenet brdzaneba: {2ECC71}/hpanel");
					}	
				}
			}
			else return true;
		}
		case 402: {
			if(response) {
				for(new h = 0; h <= TotalHouse; h ++) {
					if(PlayerToPoint(2.0, playerid, HouseData[h][hEnterX], HouseData[h][hEnterY], HouseData[h][hEnterZ])) {
						if(UserData[playerid][pHouse] == h || HouseData[h][hLock] == 0) {
             				SetPlayerInterior(playerid, HouseData[h][hInt]);
							SetPlayerVirtualWorld(playerid, h);
							SetPlayerPosEx(playerid, HouseData[h][hExitX], HouseData[h][hExitY], HouseData[h][hExitZ]);
						}
						else return GameTextForPlayer(playerid, "~r~Locked", 1000, 1);
					}
				}
			}
			else return true;
		}
		case 403: {
			if(response) {
				new h = UserData[playerid][pHouse];
				if(h == -1) return error(playerid, "Tkven ar gaqvt saxli");
	    	    HouseData[h][hLock] = 0;
	    	    HouseData[h][hOwned] = 0;
	    	    HouseData[h][hGarage] = 0;
	    	    strmid(HouseData[h][hOwner], "The State", 0, strlen("The State"), 15);
	    	    GiveUserMoney(playerid, HouseData[h][hPrice]*3/4);
	    	    UpdateHouse(h);
	    	    SaveHouse(h);
	    	    UserData[playerid][pHouse] = -1;
	    	    UpdateUserData(playerid, "pHouse", UserData[playerid][pHouse]);	
	    	    success(playerid, "Tkven gayidet tkveni saxli");
			}
			else return true;
		}
		case 404: {
			if(response) {
				switch(listitem) {
					case 0: {
						new i = UserData[playerid][pHouse];
						new string[500];
						static const dour_status[2][40 + 1] = {
							"Gaxsnili",
							"Daxuruli"
						};

						static const garage_status[2][40 + 1] = {
							"Ar aqvs",
							"Aqvs"
						};

				    	format(string, sizeof(string), "{F0A45D}[1] {FFFFFF}- Saxlis ID: {F0A45D}[ %d ]\
		            	\n{F0A45D}[2] {FFFFFF}- Saxlis fasi aris: {F0A45D}[ %d$ ]{FFFFFF}\
		            	\n{F0A45D}[3] {FFFFFF}- Saxlis karebi aris: {F0A45D}[ %s ]{FFFFFF}\
						\n{F0A45D}[4] {FFFFFF}- Garajis statusi: {F0A45D}[ %s ]{FFFFFF}", HouseData[i][hID], HouseData[i][hPrice], dour_status[HouseData[i][hLock]], garage_status[HouseData[i][hGarage]]);
		      			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{FFFFFF}Saxli", string, "Cancel", "");
					}
					case 1: {
						new h = UserData[playerid][pHouse];
						if(HouseData[h][hLock] == 1) {
							HouseData[h][hLock] = 0;
							GameTextForPlayer(playerid,"~w~House ~g~UNLOCK", 1000, 1);
							PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
							UpdateHouse(h);
							SaveHouse(h);
							return true;
						}
						if(HouseData[h][hLock] == 0) {
							HouseData[h][hLock] = 1;
							GameTextForPlayer(playerid,"~w~House ~r~LOCK", 1000, 1);
							PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
							UpdateHouse(h);
							SaveHouse(h);
							return true;
						}
					}
					case 2: {
						PC_EmulateCommand(playerid, "/sellhouse");
					}
					case 3: {
						ShowPlayerDialog(playerid, 405, DIALOG_STYLE_MSGBOX, "{FFFFFF}Garajis yidva",
						"{F0A45D}- [ Jonathan ] {FFFFFF}- garajis yidva namdvilad kargi gadawyvetilebaa\
		    			\n\t\t{FFFFFF}Garajis yidva dagijdebat: {F0A45D}50.000{FFFFFF}$\
		    			\n\n\n{F0A45D}* Tu gsurt sheidzinot garaji daachiret {FFFFFF}'Next' {F0A45D}ghilaks", "Next", "Cancel");
						return true;
					}
				}
			}
			else return true;
		}
		case 405: {
			if(response) {
				new h = UserData[playerid][pHouse];
				if(HouseData[h][hGarage] == 1) return error(playerid, "Am saxls ukve aqvs garaji, veghar sheisyidit mas");
				if(UserData[playerid][pCash] < 50000) return error(playerid, "Tkven ar gakvt sakmarisi tanxa garajis shesadzenad");
				GiveUserMoney(playerid, -50000);
				HouseData[h][hGarage] = 1;
				SaveHouse(h);
				success(playerid, "Gilocavt, tkven axla shegidzliat daayenot manqana garajshi");
				return true;
			}
		}
		case 406:
	    {
	        if(response) {
				switch(listitem) {
				    case 0:{
				    	new h = UserData[playerid][pHouse];
                        SetPlayerInterior(playerid, 0);
						SetPlayerVirtualWorld(playerid, 0);
						SetPlayerPosEx(playerid, HouseData[h][hEnterX], HouseData[h][hEnterY], HouseData[h][hEnterZ]);
					}
				    case 1: {
    					new h = UserData[playerid][pHouse];
						if(HouseData[h][hGarage] == 0) return error(playerid, "Tkven saxls ar aqvs garaji");
		        		SetPlayerPosEx(playerid, 2370.6304,789.5767,1013.4380);
		        		SetPlayerFacingAngle(playerid, 95.1928);
		        		SetPlayerVirtualWorld(playerid, h);
		        		SetPlayerInterior(playerid, h);
					}
				}
	        }
		}
		case 410: {
			if(response) {
				for(new h = 0; h <= TotalBizz; h ++) {
					if(PlayerToPoint(2.0, playerid, BizzData[h][bEnterX], BizzData[h][bEnterY], BizzData[h][bEnterZ])) {
						if(UserData[playerid][pBizz] != -1 && strcmp(Name(playerid), BizzData[UserData[playerid][pBizz]][bOwner], true) == 0) return error(playerid, "Tkven ukve gaqvt shedzenili saxli");
						if(UserData[playerid][pCash] < BizzData[h][bPrice]) return error(playerid, "Tkven ar gaqvt sakmarisi tanxa");

						UserData[playerid][pBizz] = h;
					    UpdateUserData(playerid, "pBizz", UserData[playerid][pBizz]);
					    BizzData[h][bOwned] = 1;
					    strmid(BizzData[h][bOwner], Name(playerid), 0, strlen(Name(playerid)), MAX_PLAYER_NAME);
						GiveUserMoney(playerid,  -BizzData[h][bPrice]);

						new bizz = UserData[playerid][pBizz];
					    SaveBizz(bizz);

					    success(playerid, "Tkven warmatebit sheidzinet biznesi. Ar dagaviwyet produqciis shevseba");
						success(playerid, "Biznesis panelis samartavad gamoiyenet brdzaneba: {2ECC71}/bpanel");
					}	
				}
			}
			else return true;
		}
		case 411: {
			if(response) {
				for(new h = 0; h <= TotalBizz; h ++) {
					if(PlayerToPoint(2.0, playerid, BizzData[h][bEnterX], BizzData[h][bEnterY], BizzData[h][bEnterZ])) {
						if(UserData[playerid][pBizz] == h || BizzData[h][bLock] == 0) {
             				SetPlayerInterior(playerid, BizzData[h][bInt]);
							SetPlayerVirtualWorld(playerid, h + 50);
							SetPlayerPosEx(playerid, BizzData[h][bExitX], BizzData[h][bExitY], BizzData[h][bExitZ]);
							SetPVarInt(playerid, "BUSINESS_ID", h);
						}
						else return GameTextForPlayer(playerid, "~r~Locked", 1000, 1);
					}
				}
			}
			else return true;
		}

		case 412: {
			if(response) {
				switch(listitem) {
					case 0: {
						new i = UserData[playerid][pBizz];
						new string[500];
						static const dour_status[2][40 + 1] = {
							"Gaxsnili",
							"Daxuruli"
						};
				    	format(string, sizeof(string), "{FFFFFF} - Biznesis informacia - {F0A45D}[ %d ]\
		            	\n\n{FFFFFF}Biznesis fasi aris: {F0A45D}[ %d$ ]{FFFFFF}\
		            	\n{FFFFFF}Biznesis aris: {F0A45D}[ %s ]{FFFFFF}\
		            	\n{FFFFFF}Biznesis angarishze aris: {F0A45D}[ %d$ ]{FFFFFF}", BizzData[i][bID], BizzData[i][bPrice], dour_status[BizzData[i][bLock]], BizzData[i][bBank]);
		      			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{FFFFFF}Business", string, "Cancel", "");
					}
					case 1: {
						new h = UserData[playerid][pBizz];
						if(BizzData[h][bLock] == 1) {
							BizzData[h][bLock] = 0;
							GameTextForPlayer(playerid,"~w~Business ~g~UNLOCK", 1000, 1);
							PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
							SaveBizz(h);
							return true;
						}
						if(BizzData[h][bLock] == 0) {
							BizzData[h][bLock] = 1;
							GameTextForPlayer(playerid,"~w~Business ~r~LOCK", 1000, 1);
							PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
							SaveBizz(h);
							return true;
						}
					}
					case 2: {
						PC_EmulateCommand(playerid, "/sellbizz");
					}
					case 3: error(playerid, "Es funqcia ar aris jer damatebuli");
				}
			}
			else return true;
		}
		case 413: {
			if(response) {
				new h = UserData[playerid][pBizz];
				if(h == -1) return error(playerid, "Tkven ar gaqvt biznesi");
	    	    BizzData[h][bLock] = 0;
	    	    BizzData[h][bOwned] = 0;
	    	    strmid(BizzData[h][bOwner], "The State", 0, strlen("The State"), 15);
	    	    GiveUserMoney(playerid, BizzData[h][bPrice]*3/4);
	    	    SaveBizz(h);
	    	    UserData[playerid][pBizz] = -1;
	    	    UpdateUserData(playerid, "pBizz", UserData[playerid][pBizz]);
	    	    success(playerid, "Tkven gayidet tkveni biznesi");
			}
			else return true;
		}
		case 415: {
			if(response) {
				switch(listitem) {
					case 0: {
						for(new h = 0; h <= TotalBizz; h ++) {
							if(PlayerToPoint(2.0, playerid, BizzData[h][bBuyX], BizzData[h][bBuyY], BizzData[h][bBuyZ])) {
								if(GetPlayerVirtualWorld(playerid) == h + 50) {
									if(UserData[playerid][pCash] < 1000) return error(playerid, "Tkven ar gaqvt sakmarisi tanxa");
									if(UserData[playerid][pMobile] > 0) return error(playerid, "Tkven ukve nayidi gaqvt mobiluri telefoni");
									GiveUserMoney(playerid, -1000);
									UserData[playerid][pMobile] = 1;
									UpdateUserData(playerid, "pMobile", UserData[playerid][pMobile]);
									success(playerid, "Tkven sheidzinet mobiluri telefoni");

									BizzData[h][bBank] += 1000*3/4;
									SaveBizz(h);
								}
							}
						}
					}
					case 1: {
						for(new h = 0; h <= TotalBizz; h ++) {
							if(PlayerToPoint(2.0, playerid, BizzData[h][bBuyX], BizzData[h][bBuyY], BizzData[h][bBuyZ])) {
								if(GetPlayerVirtualWorld(playerid) == h + 50) {
									if(UserData[playerid][pCash] < 700) return error(playerid, "Tkven ar gaqvt sakmarisi tanxa");
									if(UserData[playerid][pClock] > 0) return error(playerid, "Tkven ukve nayidi gaqvt saati");
									GiveUserMoney(playerid, -700);
									UserData[playerid][pClock] = 1;
									UpdateUserData(playerid, "pClock", UserData[playerid][pClock]);
									success(playerid, "Tkven sheidzinet saati");

									BizzData[h][bBank] += 700*3/4;
									SaveBizz(h);
								}
							}
						}
					}
				}
			}
			else return true;
		}
		case 500: {
			if(response) {
				if(UserData[playerid][pMember] != 1) return error(playerid, "Tyviis informaciis misagebat sachiroa iyot samartaldamcavi");
				new int = GetPVarInt(playerid, "Bullet");
				TogglePlayerControllable(playerid, 0);
				SetTimerEx("SetAnimationBullet", 100, false, "i", playerid);
				SetTimerEx("SetAnimationBullet", 500, false, "i", playerid);
				SetTimerEx("UnFreeze", 10000, false, "i", playerid);
				new string[1500];
				format(string, sizeof(string),
				"{FFFFFF} - Tyviis informacia - {F0A45D}[ %d ]\
		        \n\n{FFFFFF}Gasrolili aris iaragit: {F0A45D}[ %s ]{FFFFFF}\
		        \n{FFFFFF}Gasrolili iaragis mflobeli: {F0A45D}[ %s ]{FFFFFF}", int, BulletInfo[int][bWeapone], BulletName(int));
				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{FFFFFF}Bullet", string, "Cancel", "");
				SetTimerEx("RemoveBullet", 10000, false, "id", playerid, GetPVarInt(playerid, "Bullet"));
			}
			else {
				TogglePlayerControllable(playerid, 0);
				SetTimerEx("SetAnimationBullet", 100, false, "i", playerid);
				SetTimerEx("SetAnimationBullet", 500, false, "i", playerid);
				SetTimerEx("UnFreeze", 10000, false, "i", playerid);
				SetTimerEx("RemoveBullet", 10000, false, "id", playerid, GetPVarInt(playerid, "Bullet"));
			}
		}
		case 600: {
			if(response) {
				if(!IsInAllowed(playerid)) return error(playerid, "Tkven ar xart bandis wevri");
				switch(listitem) {
					case 0: {
						ShowPlayerDialog(playerid, 601, DIALOG_STYLE_INPUT, "{FFFFFF}Gang",
						"{FFFFFF} - Materialebis ageba -\
		            	\n\n{FFFFFF} Chaweret im materialebis raodenoba ramdenis agebac gsurt\
		            	\n\n{F0A45D}* Miutitet materialebis raodenoba da daachiret 'Next' gilaks", "Next", "Cancel");
					}
					case 1: {
						ShowPlayerDialog(playerid, 602, DIALOG_STYLE_INPUT, "{FFFFFF}Gang",
						"{FFFFFF} - Narkotikebis ageba -\
		            	\n\n{FFFFFF} Chaweret im materialebis raodenoba ramdenis agebac gsurt\
		            	\n\n{F0A45D}* Miutitet materialebis raodenoba da daachiret 'Next' gilaks", "Next", "Cancel");
					}
				}
			}
			else return true;
		}
		case 601: {
			if(response) {
	          	for(new i = strlen(inputtext)-1; i != -1; i--) {
		            switch(inputtext[i]) {
		                case '0'..'9': continue;
		                default: return error(playerid, "Raodenoba unda iyos mititebuli mxolod da mxolod cifrebit");
		            }
	        	}
	        	new ammo = strval(inputtext);
				if(FractionData[UserData[playerid][pMember]][wAmmo] < ammo) return error(playerid, "Sawyobshi ar aris sakmarisi materiali");
				if(Materials[playerid] + ammo > 600) return error(playerid, "Tkven vegar dagetevat mititebuli materialebis raodenoba, max: 600");
				
				FractionData[UserData[playerid][pMember]][wAmmo] -= ammo;
				SaveFraction(UserData[playerid][pMember]);
				UpdateFractions();

				Materials[playerid] += ammo;

				new str[500];
				format(str, sizeof(str), "{6DA3B5}%s'm(a) aigo %d materiali sawyobidan", Name(playerid), ammo);
				SendFractionMessage(UserData[playerid][pMember], str);
			}
			else return true;
		}
		case 602: {
			if(response) {
	          	for(new i = strlen(inputtext)-1; i != -1; i--) {
		            switch(inputtext[i]) {
		                case '0'..'9': continue;
		                default: return error(playerid, "Raodenoba unda iyos mititebuli mxolod da mxolod cifrebit");
		            }
	        	}
	        	new ammo = strval(inputtext);
				if(FractionData[UserData[playerid][pMember]][wDrug] < ammo) return error(playerid, "Sawyobshi ar aris sakmarisi materiali");
				if(Drugs[playerid] + ammo > 100) return error(playerid, "Tkven vegar dagetevat mititebuli gramebis raodenoba, max: 100");
				
				FractionData[UserData[playerid][pMember]][wDrug] -= ammo;
				SaveFraction(UserData[playerid][pMember]);
				UpdateFractions();

				Drugs[playerid] += ammo;

				new str[500];
				format(str, sizeof(str), "{6DA3B5}%s'm(a) aigo %d narkotiki sawyobidan", Name(playerid), ammo);
				SendFractionMessage(UserData[playerid][pMember], str);
			}
			else return true;
		}
		case 604: {
			if(response)  {
				new hp;
				switch(listitem) {
					case 0: hp = 160, SetPVarInt(playerid, "dmVW", 100);
					case 1: hp = 100, SetPVarInt(playerid, "dmVW", 200);
					case 2: hp = 50, SetPVarInt(playerid, "dmVW", 300);
				}
				SetPVarInt(playerid, "DmHealth", hp);
				new string[500];
				format(string, sizeof(string),
				"{F0A45D}[1]{FFFFFF} - Deagle + Choose\n\
				{F0A45D}[2]{FFFFFF} - Deagle");
				ShowPlayerDialog(playerid, 605, DIALOG_STYLE_LIST, "{FFFFFF}DeathMatch", string, "Next", "Cancel");				
			}
			else return true;
		}
		case 605: {
			if(response) {
				switch(listitem) {
					case 0: ShowPlayerDialog(playerid, 606, DIALOG_STYLE_INPUT, "{FFFFFF}DeathMatch",
					"{FFFFFF}- Airchiet meore iaragi romelic gindat gqondet -\n\n\
					{FFFFFF}Miutitet tkventvis sasurveli iaragis ID:\n\
					1 - Deagle | 2 - Shotgun | 3 - M4 | 4 - AK-47 | 5 - Country rifle | 6 - MP5\n\n\
					{F0A45D}* Rodesac airchevt iarags daachiret 'Next' gilaks", "Next", "Cancel");
					case 1: {
						DMArena[playerid] = 1;
						SetPVarInt(playerid, "DMGun1", 24);
						SetPVarInt(playerid, "DMGun2", 0);
					    SpawnPlayer(playerid);					
					}
				}
			}
			else return true;
		}
		case 606: {
			if(response) {
	          	for(new i = strlen(inputtext)-1; i != -1; i--) {
		            switch(inputtext[i]) {
		                case '0'..'9': continue;
		                default: return error(playerid, "Raodenoba unda iyos mititebuli mxolod da mxolod cifrebit");
		            }
	        	}
				new gun = strval(inputtext);
				switch(gun) {
					case 1: gun = 24;
			   		case 2: gun = 25;
			   		case 3: gun = 31;
			   		case 4: gun = 30;
			   		case 5: gun = 33;
			   		case 6: gun = 29;
			   		default: {
			   			error(playerid, "Araswori iaragis ID");
			   			return true;
			   		}
				}
				DMArena[playerid] = 1;
				SetPVarInt(playerid, "DMGun1", 24);
				SetPVarInt(playerid, "DMGun2", gun);
			    SpawnPlayer(playerid);
			}
			else return true;
		}
		case 700: {
			if(response) {
				if(UserData[playerid][pLeader] == 0) return true;
				switch(listitem) {
					case 0: {
						new string[1200];
						new fracid = UserData[playerid][pMember];
						format(string, sizeof(string), "{FFFFFF}Fraqciis dasaxeleba:\t{F0A45D}[ %s ]\n\
		            	\n{FFFFFF}Fraqciis angarishze aris: {F0A45D}[ %d$ ]\
		            	\n{FFFFFF}Sawyobshi materialebis raodenoba: {F0A45D}[ %d ]\
		            	\n{FFFFFF}Materialebis sawyobi aris: {F0A45D}[ %s ]\
		            	\n{FFFFFF}Fraqciis wevrebis raodenoba: {F0A45D}[ %d ]", GetFractionName(fracid), FractionData[fracid][wBank], FractionData[fracid][wAmmo], FractionData[fracid][wStatus]?("gaxsnili"):("chaketili"), LoadMemberData(fracid));
		      			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{FFFFFF}Leader Menu", string, "Cancel", "");
					}
					case 1: return PC_EmulateCommand(playerid, "/members");
					case 2: {
					    new string[1300];
					    format(string, sizeof(string), "{FFFFFF}- Shecvalet migebis minimaluri ranki -\
						\n\n{FFFFFF}Daaweset tu ramden ranks sheedzlos migeba tkvens fraqciashi\
					    \n{FFFFFF}Gaitvaliswinet, ecadet miutitot gonivruli ranki\
					    \n\n{F0A45D}* Rodesac miutitebt cifrs daachiret 'Next' gilaks");
						ShowPlayerDialog(playerid, 704, DIALOG_STYLE_INPUT, "{FFFFFF}Leader Menu", string, "Next", "Cancel");
					}
					case 3: {
						new string[500];
						new fracid = UserData[playerid][pMember];
						format(string, sizeof(string),
						"{F0A45D}[1]{FFFFFF} - Pirveli skin - {F0A45D}[ %d ]\n\
						{F0A45D}[2]{FFFFFF} - Meore skin - {F0A45D}[ %d ]\n\
						{F0A45D}[3]{FFFFFF} - Mesame skin - {F0A45D}[ %d ]\n\
						{F0A45D}[4]{FFFFFF} - Meotxe skin - {F0A45D}[ %d ]\n\
						{F0A45D}[5]{FFFFFF} - Mexute skin - {F0A45D}[ %d ]\n\
						{F0A45D}[6]{FFFFFF} - Meeqvse skin - {F0A45D}[ %d ]",
						FractionData[fracid][wSkin][0], FractionData[fracid][wSkin][1], 
						FractionData[fracid][wSkin][2], FractionData[fracid][wSkin][3], 
						FractionData[fracid][wSkin][4], FractionData[fracid][wSkin][5]);
						ShowPlayerDialog(playerid, 705, DIALOG_STYLE_LIST, "{FFFFFF}Leader Menu", string, "Next", "Cancel");	
					}
				}
			}
			else return true;
		}
		case 704: {
			if(UserData[playerid][pLeader] == 0) return true;
			if(response) {
	          	for(new i = strlen(inputtext)-1; i != -1; i--) {
		            switch(inputtext[i]) {
		                case '0'..'9': continue;
		                default: return error(playerid, "Raodenoba unda iyos mititebuli mxolod da mxolod cifrebit");
		            }
	        	}
				new value = strval(inputtext);
				new fracid = UserData[playerid][pMember];
				if(value >= UserData[playerid][pRank]) return error(playerid, "Tkven ranks an tkvenze magals ver daayenebt");
				if(value < 4) return error(playerid, "Tkven miutitet zedmetad dabali ranki");

				FractionData[fracid][wInviteRank] = value;
				SaveFraction(fracid);

				success(playerid, "Tkven daayenet migebis minimaluri ranki");
			}
			else return true;	
		}
		case 705: {
			if(response) {
				if(UserData[playerid][pLeader] == 0) return true;
				switch(listitem) {
					case 0: SetPVarInt(playerid, "FractionSkinID", 0);
					case 1: SetPVarInt(playerid, "FractionSkinID", 1);
					case 2: SetPVarInt(playerid, "FractionSkinID", 2);
					case 3: SetPVarInt(playerid, "FractionSkinID", 3);
					case 4: SetPVarInt(playerid, "FractionSkinID", 4);
					case 5: SetPVarInt(playerid, "FractionSkinID", 5);
				}
				new string[1300];
				format(string, sizeof(string), "{FFFFFF}- Shecvalet tkveni fraqciis skinebi -\
				\n\n{FFFFFF}Miutitet romeli skinis dayeneba sheedzlot fraqciis wevrebs\
				\n{FFFFFF}Gaitvaliswinet, miutitet swori skinis id\
				\n\n{F0A45D}* Rodesac miutitebt skinis id's daachiret 'Next' gilaks");
				ShowPlayerDialog(playerid, 706, DIALOG_STYLE_INPUT, "{FFFFFF}Leader Menu", string, "Next", "Cancel");
			}
			else return true;
		}
		case 706: {
			if(response) {
	          	for(new i = strlen(inputtext)-1; i != -1; i--) {
		            switch(inputtext[i]) {
		                case '0'..'9': continue;
		                default: return error(playerid, "Raodenoba unda iyos mititebuli mxolod da mxolod cifrebit");
		            }
	        	}
	        	new fracid = UserData[playerid][pMember];
				new value = strval(inputtext);
				if(value > 311 || value < 1 || value == 74) return error(playerid, "Tkven miutitet araswori skinis id");

				new skinid = GetPVarInt(playerid, "FractionSkinID");

				FractionData[fracid][wSkin][skinid] = value;
				SaveFraction(fracid);

				success(playerid, "Tkven shecvalet tkveni fraqciis skinis id");
			}
			else return true;
		}
		case 710: {
			if(response) {
				if(UserData[playerid][pRank] < FractionData[UserData[playerid][pMember]][wInviteRank]) return true;
				new usid = GetPVarInt(playerid, "ChangeSkinUser");
				new fracid = UserData[playerid][pMember];
				new skinID;
				switch(listitem) {
					case 0: skinID = FractionData[fracid][wSkin][0];
					case 1: skinID = FractionData[fracid][wSkin][1];
					case 2: skinID = FractionData[fracid][wSkin][2];
					case 3: skinID = FractionData[fracid][wSkin][3];
					case 4: skinID = FractionData[fracid][wSkin][4];
					case 5: skinID = FractionData[fracid][wSkin][5];
				}
				if(skinID == 0) return error(playerid, "Am skinis nomerze ar aris mititebuli skinis id");
				SetPlayerSkin(usid, skinID);
				UserData[usid][pForma] = skinID;
				UpdateUserData(usid, "pForma", UserData[usid][pForma]);
			}
			else return true;
	    }
	    case 800: {
	    	if(response) {
	    		switch(listitem) {
	    			case 0: ShowStats(playerid, playerid);
	    			case 1: ShowPlayerDialog(playerid, 801, DIALOG_STYLE_LIST, "Personajis parametrebi", "Sqesis shecvla\nParolis shecvla\nDacvis dayeneba", "Next", "Back");
	    			case 2: ShowPlayerDialog(playerid, 802, DIALOG_STYLE_LIST, "Serveris brdzanebebi", "Chveulebrivi\nChat\nChemi Brdzanebebi\nLeader\nSaxli\nBiznesi\nAvtomobili", "Next", "Back");
	    			case 3: ShowPlayerDialog(playerid, 803, DIALOG_STYLE_INPUT, "Gaagzavne text admintan", "Tkven gzavnit reports\nReporti gamoiyenet danishnulemisamebr\nReportshi ganixileba mxolod rac aris servertan kavshirshi", "Next", "Back");
	    			case 4: return true;
	    			case 5: PC_EmulateCommand(playerid, "/quest");
	    		}
	    	}
	    	else return true;
	    }
	    case 801: {
	    	if(response) {
	    		switch(listitem) {
	    			case 0: {
						if(UserData[playerid][pSex] == 1)
						{
						    UserData[playerid][pSex] = 2;
						}
						else if(UserData[playerid][pSex] == 2)
						{
						    UserData[playerid][pSex] = 1;
						}
						UpdateUserData(playerid, "pSex", UserData[playerid][pSex]);
						success(playerid, "Tkven sheicvalet sqesi");
	    			}
	    			case 1: ShowPlayerDialog(playerid, 810, DIALOG_STYLE_INPUT, "Tkveni parolis shecvla", "{FFFFFF}Miutitet Tkventvis Misagebi Axali Paroli\nParoli Unda Shedgebodes Minimum: {FF9900}6{FFFFFF} Da Maxsimum: {FF9900}10{FFFFFF}Simbolosgan", "Next", "Back");
	    			case 2: return true;
	    		}
	    	}
	    	else PC_EmulateCommand(playerid, "/mm");
	    }
	    case 810: {
			if(response) {
				if(!strlen(inputtext)) return error(playerid, "Paroli ar unda shedgebodes mxolod asoebisgan");

				static const fmt_query[] = "UPDATE `accounts` SET `pPassword` = '%e' WHERE `pName` = '%e'";
				new query[sizeof(fmt_query)+(-2+32)+(-2+MAX_PLAYER_NAME)];
				mysql_format(connects, query, sizeof(query), fmt_query, inputtext, Name(playerid));
				mysql_tquery(connects, query);

				new string[500];
				format(string, sizeof(string), "{63BD4E}[Main Menu] {FFFFFF}tkveni accountis moqmedi parolia: {63BD4E}%s", inputtext);
				SendClientMessage(playerid, -1, string);
				return true;
			}
			else PC_EmulateCommand(playerid, "/mm");
	    }
	    case 802: {
			if(response) {
				switch(listitem) {
					case 0: {
						SendClientMessage(playerid,0x83BFBFAA, "<> /mm /gps /quest /time /leave");
					}
					case 1: {
						SendClientMessage(playerid,0x83BFBFAA, "<> (/o)oc - Saerto chati");
						SendClientMessage(playerid,0x83BFBFAA, "<> (/gov)ernment - Saxelmwifo siaxle");
						SendClientMessage(playerid,0x83BFBFAA, "<> (/f)amily - Organizaciis chati");
						SendClientMessage(playerid,0x83BFBFAA, "<> (/s)hout - Yvirili");
						SendClientMessage(playerid,0x83BFBFAA, "<> (/m)egaphone - Racia policiis manqanaze");
						SendClientMessage(playerid,0x83BFBFAA, "<> (/r)adio - Saxelmwifo organizaciebis chati");
						SendClientMessage(playerid,0x83BFBFAA, "<> (/d)epartments - Saxelmwifo organizaciebit saerto chati");
						SendClientMessage(playerid,0x83BFBFAA, "<> /me - moqmedeba, magalitad: /me icinis");
						return true;
					}
    				case 2: {
						if(UserData[playerid][pMember] == 1 || UserData[playerid][pLeader] == 1) {
							SendClientMessage(playerid,0x83BFBFAA, "<> (/r)adio (/d)epartments (/m)egaphone (/su)spect /arrest /wanted /cuff /tazer");
							SendClientMessage(playerid,0x83BFBFAA, "<> /frisk /take /spy (/gov)ernment /find /ticket /cput /ceject /fbullet");
						}
						else if (IsInAllowed(playerid)) {
							SendClientMessage(playerid,0x83BFBFAA, "<> (/f)amily /capture /changeskin /dm /exitdm");
							SendClientMessage(playerid,0x83BFBFAA, "<> /makegun /ginfo /lpanel /members /offmembers");

						}
					}
					case 3: {
						if (UserData[playerid][pLeader] >= 1) {
							SendClientMessage(playerid,0x83BFBFAA, "<> /lpanel /invite /uninvite /giverank /offmembers /offuninvite");
						}
						else {
							error(playerid, "Tkven ar xart arcerti organizaciis lideri");
						}
					}
					case 4: {
						SendClientMessage(playerid,0x83BFBFAA, "<> /sellhouse - Saxlis gayidva");
						SendClientMessage(playerid,0x83BFBFAA, "<> /hpanel - Saxlis menu");
					}
					case 5: {
						SendClientMessage(playerid,0x83BFBFAA, "<> /sellbizz - Biznesis gayidva");
						SendClientMessage(playerid,0x83BFBFAA, "<> /bpanel - Biznesis menu");
					}
					case 6: {
						SendClientMessage(playerid,0x83BFBFAA, "<> /cars - Transportis menu");
						SendClientMessage(playerid,0x83BFBFAA, "<> /cars - Transportis gagheba/daketva");

					}
				}
			}	    	
	    	else PC_EmulateCommand(playerid, "/mm");
	    }
	    case 803: {
	    	if(response) {
	    		new string[500];
	    		format(string, sizeof(string), "[REPORT] - %s(%d) : %s", Name(playerid),playerid,inputtext);
	    		SendAdminMessage(0xECFF00FF, string);
	    		success(playerid, "Tkven gaagzavnet report administratortan");
	    	}
	    	else PC_EmulateCommand(playerid, "/mm");
	    }
    	case 850:
		{
			if(response) {
				if(UserData[playerid][pCash] < ShopCar[GetPVarInt(playerid, "SelectAvto")][1]) return error(playerid,"Tkvens angarishze ar aris sakmarisi tanxa");
				GivePlayerCar(playerid,ShopCar[GetPVarInt(playerid, "SelectAvto")][0]);
				GiveUserMoney(playerid, -ShopCar[GetPVarInt(playerid, "SelectAvto")][1]);
				ExitCar(playerid);
				PlayerPlaySound(playerid, 20801, 0.0, 0.0, 0.0);
				success(playerid, "Gilocavt axal shenadzens, sul mwvaneze gevlot ! {F0A45D}[ USAGE: '/cars' ]");
			}
		}
	case 851:
		{
			if(response) ExitCar(playerid);
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source) {
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ) {
    if(UserData[playerid][pAdmin] > 0) {
		SetPlayerPosEx(playerid, fX, fY, fZ);
  		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
	}
	return 1;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags) {
	if(!PC_CommandExists(cmd)) return error(playerid, "Aseti brdzaneba ver moidzebna");
	return false;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid) {
	return 1;
}

publics: OnPlayerClickTextDraw(playerid, Text:clickedid) {
	if(GetPVarInt(playerid, "Choose_Skin") == 1) {
    	new string[128];
		if(clickedid == enable_skin_TD[6]) {
	        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
			if(UserData[playerid][pSex] == 1) {
  			    if(SelectCharPlace[playerid] == sizeof(JoinShopM)-1) SelectCharPlace[playerid] = 0;
				else SelectCharPlace[playerid]++;
				SetPlayerSkin(playerid, JoinShopM[SelectCharPlace[playerid]][0]);
				format(string, sizeof(string), "~w~~n~~n~~n~~n~~n~~n~COST: ~g~%i$", JoinShopM[SelectCharPlace[playerid]][1]);
			}
			else {
				if(SelectCharPlace[playerid] == sizeof(JoinShopF)-1) SelectCharPlace[playerid] = 0;
				else SelectCharPlace[playerid]++;
				SetPlayerSkin(playerid, JoinShopF[SelectCharPlace[playerid]][0]);
				format(string, sizeof(string), "~w~~n~~n~~n~~n~~n~~n~COST: ~g~%i$", JoinShopF[SelectCharPlace[playerid]][1]);
			}
			GameTextForPlayer(playerid, string, 3000, 3);
		}
		if(clickedid == enable_skin_TD[7]) {
		    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
			if(UserData[playerid][pSex] == 1) {
   			    if(SelectCharPlace[playerid] == 0) SelectCharPlace[playerid] = sizeof(JoinShopM)-1;
				else SelectCharPlace[playerid]--;
				SetPlayerSkin(playerid, JoinShopM[SelectCharPlace[playerid]][0]);
				format(string, sizeof(string), "~w~~n~~n~~n~~n~~n~~n~COST: ~g~%i$", JoinShopM[SelectCharPlace[playerid]][1]);
			}
			else {
				if(SelectCharPlace[playerid] == 0) SelectCharPlace[playerid] = sizeof(JoinShopF)-1;
				else SelectCharPlace[playerid]--;
				SetPlayerSkin(playerid, JoinShopF[SelectCharPlace[playerid]][0]);
				format(string, sizeof(string), "~w~~n~~n~~n~~n~~n~~n~COST: ~g~%i$", JoinShopF[SelectCharPlace[playerid]][1]);
			}
			GameTextForPlayer(playerid, string, 3000, 3);
		}
		if(clickedid == enable_skin_TD[3]) {
		    new bizid = GetPVarInt(playerid, "BUSINESS_ID");
		    new price = (UserData[playerid][pSex] == 1) ? (JoinShopM[SelectCharPlace[playerid]][1]) : (JoinShopF[SelectCharPlace[playerid]][1]);
			if(UserData[playerid][pCash] < price) return error(playerid, "Ar gaqvt sakmarisi tanxa");
			UserData[playerid][pSkin] = (UserData[playerid][pSex] == 1) ? (JoinShopM[SelectCharPlace[playerid]][0]) : (JoinShopF[SelectCharPlace[playerid]][0]);
			UpdateUserData(playerid, "pSkin", UserData[playerid][pSkin]);
   			GiveUserMoney(playerid, -price);
   			BizzData[bizid][bBank] += price/2;
   			SaveBizz(bizid);
			TogglePlayerControllable(playerid,true);

   			SetPlayerPosEx(playerid, BizzData[bizid][bBuyX], BizzData[bizid][bBuyY], BizzData[bizid][bBuyZ]);
			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerid) - 500);
			SetPlayerInterior(playerid, BizzData[bizid][bInt]);

			SelectCharPlace[playerid] = 0;
			SetCameraBehindPlayer(playerid);
			SetPlayerSkin(playerid, UserData[playerid][pSkin]);
			
			for(new i; i < 8; i++) TextDrawHideForPlayer(playerid, enable_skin_TD[i]);
		    CancelSelectTextDraw(playerid), SetPVarInt(playerid, "Choose_Skin", 0);
		   	success(playerid, "Tkven sheidzinet axali tansacmeli");
		}
	    if(clickedid == enable_skin_TD[4] || (clickedid == Text:INVALID_TEXT_DRAW)) {
	        new bizid = GetPVarInt(playerid, "BUSINESS_ID");
		    TogglePlayerControllable(playerid,true);

   			SetPlayerPosEx(playerid, BizzData[bizid][bBuyX], BizzData[bizid][bBuyY], BizzData[bizid][bBuyZ]);

			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerid) - 500);
			SetPlayerInterior(playerid, BizzData[bizid][bInt]);
			SetPlayerSkin(playerid, UserData[playerid][pSkin]);
			SelectCharPlace[playerid] = 0;
			SetCameraBehindPlayer(playerid);
			for(new i; i < 8; i++) TextDrawHideForPlayer(playerid, enable_skin_TD[i]);
		    CancelSelectTextDraw(playerid), SetPVarInt(playerid, "Choose_Skin", 0);
		    return true;
		}
	}
	if(clickedid == RentTD_G[2]) {
		switch(Rent_Choose[playerid]) {
			case 462: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Manana");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "550$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 462);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 410);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 542);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 410;
				Rent_Price[playerid] = 550;
			}
			case 410: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Clover");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "680$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 410);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 542);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 545);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 542;
				Rent_Price[playerid] = 680;
			}
			case 542: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Hustler");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "700$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 542);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 545);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 543);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 545;
				Rent_Price[playerid] = 700;
			}
			case 545: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Sadler");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "720$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 545);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 543);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 474);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 543;
				Rent_Price[playerid] = 720;
			}
			case 543: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Hermes");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "750$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 543);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 474);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 600);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 474;
				Rent_Price[playerid] = 750;
			}
			case 474: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Picador");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "800$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 474);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 600);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 404);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 600;
				Rent_Price[playerid] = 800;
			}
			case 600: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Perenniel");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "830$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 600);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 404);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 549);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 404;
				Rent_Price[playerid] = 830;
			}
			case 404: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Tampa");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "850$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 404);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 549);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 517);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 549;
				Rent_Price[playerid] = 850;
			}
			case 549: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Majestic");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "900$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 549);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 517);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 422);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 517;
				Rent_Price[playerid] = 900;
			}
			case 517: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Bobcat");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "970$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 517);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 422);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 466);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 422;
				Rent_Price[playerid] = 970;
			}
			case 422: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Glendale");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "1050$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 422);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 466);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 535);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 466;
				Rent_Price[playerid] = 1050;
			}
			case 466: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Slamvan");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "1100$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 466);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 535);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 439);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 535;
				Rent_Price[playerid] = 1100;
			}
			case 535: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Stallion");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "1300$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 535);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 439);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 462);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 439;
				Rent_Price[playerid] = 1300;
			}
			case 439: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Faggio");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "420$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 439);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 462);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 410);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 462;
				Rent_Price[playerid] = 420;
			}
		}
	}
	if(clickedid == RentTD_G[3]) {
		switch(Rent_Choose[playerid]) {
			case 462: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Stallion");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "1300$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 535);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 439);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 462);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 439;
				Rent_Price[playerid] = 1300;
			}
			case 439: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Slamvan");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "1100$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 466);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 535);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 439);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 535;
				Rent_Price[playerid] = 1100;
			}
			case 535: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Glendale");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "1050$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 422);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 466);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 535);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 466;
				Rent_Price[playerid] = 1050;
			}
			case 466: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Bobcat");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "970$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 517);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 422);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 466);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 422;
				Rent_Price[playerid] = 970;
			}
			case 422: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Majestic");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "900$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 549);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 517);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 422);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 517;
				Rent_Price[playerid] = 900;
			}
			case 517: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Tampa");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "850$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 404);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 549);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 517);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 549;
				Rent_Price[playerid] = 850;
			}
			case 549: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Perenniel");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "830$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 600);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 404);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 549);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 404;
				Rent_Price[playerid] = 830;
			}
			case 404: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Picador");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "800$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 474);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 600);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 404);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 600;
				Rent_Price[playerid] = 800;
			}
			case 600: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Hermes");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "750$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 543);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 474);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 600);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 474;
				Rent_Price[playerid] = 750;
			}
			case 474: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Sadler");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "720$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 545);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 543);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 474);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 543;
				Rent_Price[playerid] = 720;
			}
			case 543: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Hustler");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "700$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 542);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 545);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 543);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 545;
				Rent_Price[playerid] = 700;
			}
			case 545: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Clover");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "680$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 410);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 542);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 545);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 542;
				Rent_Price[playerid] = 680;
			}
			case 542: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Manana");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "550$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 462);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 410);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 542);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 410;
				Rent_Price[playerid] = 550;
			}
			case 410: {
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][0], "Faggio");
				PlayerTextDrawSetString(playerid, RentTD_P[playerid][1], "420$");
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][4], 439);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][3], 462);
				PlayerTextDrawSetPreviewModel(playerid, RentTD_P[playerid][2], 410);
				for(new i = 0; i < 5; i ++) {
					PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
					PlayerTextDrawShow(playerid, RentTD_P[playerid][i]);
				}
				Rent_Choose[playerid] = 462;
				Rent_Price[playerid] = 420;
			}
		}
	}
	if(clickedid == Text: INVALID_TEXT_DRAW && RentTD_Used[playerid]) {
		for(new i = 0; i < 8; i ++) {
			if(i < 5) PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
			TextDrawHideForPlayer(playerid, RentTD_G[i]);
		}
		RentTD_Used[playerid] = false;
		Rent_Choose[playerid] = 0;
		Rent_Price[playerid] = 0;
		CancelSelectTextDraw(playerid);
	}
	if(clickedid == RentTD_G[0]) {
		if(GetPVarInt(playerid, "veh_rent") != -1) {
			return error(playerid, "Tkven ukve naqiravebi gyavt avtomobili");
		}
		if(UserData[playerid][pCash] < Rent_Price[playerid])
			return error(playerid, "Tkven ar gaqvt sakmarisi tanxa");
		rentID[playerid] = CreateVehicle(Rent_Choose[playerid], 1685.9121,-2316.9607,-3.1776,89.2909, 145, 145, 86400);
		PutPlayerInVehicle(playerid, rentID[playerid], 0);
		GiveUserMoney(playerid, -Rent_Price[playerid]);
		SetPVarInt(playerid, "veh_rent", rentID[playerid]);
		for(new i = 0; i < 8; i ++) {
			if(i < 5) PlayerTextDrawHide(playerid, RentTD_P[playerid][i]);
			TextDrawHideForPlayer(playerid, RentTD_G[i]);
		}
		RentTD_Used[playerid] = false;
		CancelSelectTextDraw(playerid);
        Rent_Choose[playerid] = 0;
		Rent_Price[playerid] = 0;
        success(playerid, "Tkven iqiravet manqana");
	}
	if(GetPVarInt(playerid, "SelectAvto") != -1)
	{
    	if(clickedid == AutoShopText[0]) return BackCar(playerid);
    	else if(clickedid == AutoShopText[1]) return NextCar(playerid);
    	else if(clickedid == AutoShopText[2]) return NextColor(playerid,0);
    	else if(clickedid == AutoShopText[3]) return NextColor(playerid,1);
    	else if(clickedid == AutoShopText[4]) return BackColor(playerid,1);
    	else if(clickedid == AutoShopText[5]) return BackColor(playerid,0);
    	else if(clickedid == AutoShopText[6]) {
		  	ShowPlayerDialog(playerid, 850, DIALOG_STYLE_MSGBOX, "{FFFFFF}Autosaloni",
		  	"{F0A45D}[ Jerry ] {FFFFFF}- Mixaria rom mogewona es shesanishnavi avtomobili\
		  	\n\n{FFFFFF}Tu namdvilad mogewona manqana da fasic gighirs gavaformot xelshekruleba\
		  	\n{F0A45D}* Tu gsurt sheidzinot avtomobili, daachiret ghilaks 'BUY'", "Buy", "Cancel");
		  	return true;
    	}
    	else if(clickedid == AutoShopText[7]) {
		  	ShowPlayerDialog(playerid, 851, DIALOG_STYLE_MSGBOX, "{FFFFFF}Autosaloni",
		  	"{F0A45D}[ Jerry ] {FFFFFF}- Samwuxaroa...\
		  	\n\n{F0A45D}* Tu gsurt datovot avtomaghazia daachiret ghilaks 'exit'", "Exit", "Cancel");
		  	return true;
		}
    }
	return 1;
}
// ======================== < [ CMD ] >
CMD:tp(playerid){
	SetPlayerPosEx(playerid, 2368.573975, 779.558289, 1013.118286);
}
CMD:dropgun(playerid){
	if(Login[playerid] == false) return true;
	new weapon = GetPlayerWeapon(playerid), ammo = GetPlayerAmmo(playerid);
	if(weapon && ammo)
	{
	    dg_DropGun(playerid, weapon, ammo);
	} else {
		error(playerid, "Tkven ar gakvt iaraghi, ver daagdebt mas");
	}
	return true;
}
CMD:buycar(playerid, params[])
{
	if(Login[playerid] == false) return true;
	if(IsPlayerInRangeOfPoint(playerid,5.0, 1391.6912,-27.4429,1000.8630))
	{
		SetPVarInt(playerid,"AutoShop",1);
		return ShowBuyCar(playerid);
	}
	else error(playerid,"Tkven ar imyofebit avtosalonshi, gamoiyenet brdzaneba '/gps'");
	return 1;
}
CMD:event(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 3) return 1;
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(eventtime > 0) return error(playerid, "Event ukve tardeba");
    if(sscanf(params, "ds[100]",params[0],params[1])) return formatmsg(playerid, "/event [Second] [Name]");
    if(params[0] > 180 || params[0] < 20) return error(playerid, "Wamebi 20'dan 180'me");
    eventtime = params[0];
    GetPlayerPos(playerid, eventpos[0], eventpos[1], eventpos[2]);
	eventint = GetPlayerInterior(playerid);
	eventvw = GetPlayerVirtualWorld(playerid);
    SendClientMessageToAll(0xF4D03FFF, "{F4D03F}! - !{ffffff} Tardeba {F4D03F}event{ffffff} misasvlelad daweret: {F4D03F}/gotp");
	foreach(new i:Player) {
		ShowEvent(i, params[1]);
	}
	return 1;
}
CMD:gotp(playerid, params[]) {
    if(Login[playerid] == false) return true;
	if(eventtime <= 0) return error(playerid, "Am dros ar tardeba event");
	SetPlayerPosEx(playerid, eventpos[0], eventpos[1], eventpos[2]);
	SetPlayerInterior(playerid, eventint);
	SetPlayerVirtualWorld(playerid, eventvw);
	success(playerid, "Tkven mixvedit event'ze");
	return 1;
}
CMD:gps(playerid, params[]) {
	if(Login[playerid] == false) return true;
    ShowPlayerDialog(playerid, 900, DIALOG_STYLE_LIST, "Global Positioning System", "{F0A45D}[1] {FFFFFF}- Mnishvnelovani adgilebi\n{F0A45D}[2] {FFFFFF}- Samushao adgilebi\n{F0A45D}[3] {FFFFFF}- Auto servisebi", "Archeva", "Daxurva");
	return true;
}
CMD:setwammo(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 6 || !Developer(playerid)) return 1;
	if(sscanf(params, "dd",params[0], params[1])) return formatmsg(playerid, "/setwammo [ID] [Value]");
	FractionData[params[0]][wAmmo] = params[1];
	SaveFraction(params[0]);
	UpdateFractions();
	new string[500];
	format(string, sizeof(string), "Administratorma %s'm(a) dauyena fraqcias: %s materialebi : %d cali", Name(playerid), GetFractionName(params[0]), params[1]);
	SendAdminMessage(0xF4D03FFF, string);	
	return true;
}
CMD:setwbank(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 6 || !Developer(playerid)) return 1;
	if(sscanf(params, "dd",params[0], params[1])) return formatmsg(playerid, "/setwbank [ID] [Value]");
	FractionData[params[0]][wBank] = params[1];
	SaveFraction(params[0]);
	UpdateFractions();
	new string[500];
	format(string, sizeof(string), "Administratorma %s'm(a) dauyena fraqcias: %s biujeti : %d $", Name(playerid), GetFractionName(params[0]), params[1]);
	SendAdminMessage(0xF4D03FFF, string);	
	return true;
}
CMD:setwdrug(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 6 || !Developer(playerid)) return 1;
	if(sscanf(params, "dd",params[0], params[1])) return formatmsg(playerid, "/setwdrug [ID] [Value]");
	FractionData[params[0]][wDrug] = params[1];
	SaveFraction(params[0]);
	UpdateFractions();
	new string[500];
	format(string, sizeof(string), "Administratorma %s'm(a) dauyena fraqcias: %s narkotiki : %d grami", Name(playerid), GetFractionName(params[0]), params[1]);
	SendAdminMessage(0xF4D03FFF, string);	
	return true;
}
CMD:leave(playerid) {
	if(Login[playerid] == false) return true;
    if(UserData[playerid][pMember] > 0) {
	    if(UserData[playerid][pLeader] == 0) {
	        format(YCMDstr, 256, "%s[%d] gavida organizaciidan tavisi survilit", Name(playerid), playerid);
			SendAdminMessage(0xF4D03FFF, YCMDstr);	
			UserData[playerid][pLeader] = 0;
			UserData[playerid][pMember] = 0;
			UserData[playerid][pForma] = 0;
			UserData[playerid][pRank] = 0;

			UpdateUserData(playerid, "pLeader" ,UserData[playerid][pLeader]);
			UpdateUserData(playerid, "pMember" ,UserData[playerid][pMember]);
			UpdateUserData(playerid, "pForma" ,UserData[playerid][pForma]);
			UpdateUserData(playerid, "pRank" ,UserData[playerid][pRank]);

			SetPlayerSkin(playerid, UserData[playerid][pSkin]);
			SetPlayerArmour(playerid,0);
			SetPlayerColor(playerid, TEAM_HIT_COLOR);
			SetPlayerSkin(playerid, UserData[playerid][pSkin]);
		}
		else {
		    error(playerid, "Tkven xart organizaciis lideri, gtxovt tavis moxsnamde miswerot administracias");
		}
	}
	return true;
}
CMD:lock(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(sscanf(params,"d",params[0])) return SendClientMessage(playerid,-1,"Gamoiyenet: /lock [transportis id]");
	if(!IsPlayersCar(playerid,params[0])) return SendClientMessage(playerid,-1,"Es transporti ar gekutvnit tkven.");
	new Float:X,Float:Y,Float:Z;
	GetVehiclePos(params[0],X,Y,Z);
	if(!IsPlayerInRangeOfPoint(playerid,8.0,X,Y,Z)) return SendClientMessage(playerid,-1,"Ar xart transporttan axlos");
	new number = GetVehicleID(params[0]);
	if(CarInfo[number][cLock]) {
		CarInfo[number][cLock] = 0;
		SetDoorsStatus(params[0], 0);
		GameTextForPlayer(playerid,"~w~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~CAR~g~ UNLOCKED",3000,3);
	}
	else
	{
		CarInfo[number][cLock] = 1;
		SetDoorsStatus(params[0], 1);
		GameTextForPlayer(playerid,"~w~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~CAR~r~ LOCKED",3000,3);
	}
	return 1;
}
CMD:cars(playerid, params[]) {
	if(Login[playerid] == false) return true;
    ShowCarMenu(playerid);
    return true;
}
CMD:park(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if (UserData[playerid][pHouse] != -1) {
		if(!PlayerToPoint(100.0, playerid, HouseData[UserData[playerid][pHouse]][hEnterX], HouseData[UserData[playerid][pHouse]][hEnterY], HouseData[UserData[playerid][pHouse]][hEnterZ])) return error(playerid, "Shearchiet adgili saxltan axlos");
		new Float: lwx, Float:lwy, Float:lwz,Float:a;
		GetPlayerPos(playerid, lwx, lwy, lwz);
		GetPlayerFacingAngle(playerid, a);
		HouseData[UserData[playerid][pHouse]][hCarx] = lwx;
		HouseData[UserData[playerid][pHouse]][hCary]= lwy;
		HouseData[UserData[playerid][pHouse]][hCarz] = lwz;
		HouseData[UserData[playerid][pHouse]][hCarc] = a;
		success(playerid, "Tkven warmatebit shearchiet garajidan manqanis gamoyvanis adgili");
		SaveHouse(UserData[playerid][pHouse]);
	}
	return true;
}
CMD:sellcar(playerid) {
	if(Login[playerid] == false) return true;
    new carid = GetPlayerVehicleID(playerid);
	if(!IsAOwnableCar(carid)) return 1;
	if(!IsPlayerInOwnedVehicle(playerid)) return SendClientMessage(playerid, -1, "Tkven ar zixart tkvens transportshi");
	ShowPlayerDialog(playerid,5015,0,"Sellcar","{FFFFFF}Namdvilad gsurt transportis gayidva?","Sell","Cancel");
	return 1;
}
CMD:pm(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 1) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "ds[64]",params[0], params[1])) return formatmsg(playerid, "/pm [ID] [Text]");

	new string[500];
	format(string, sizeof(string), "Administratorma: %s'm(a) gagcat pasuxi : %s", Name(playerid), params[1]); SendClientMessage(params[0], 0xECFF00FF, string);
	
	format(string, sizeof(string), "[PM] -> %s gasca pasuxi %s[%d]'s : %s", Name(playerid), Name(params[0]), params[0], params[1]);
	SendAdminMessage(0xF4D03FFF, string);
	return true;
}
CMD:unbanip(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 5) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "s[64]", params[0])) return formatmsg(playerid, "/unbanip [IP]");

	// ---------- //
	format(YCMDstr,sizeof(YCMDstr),"SELECT `IP` FROM `banip` WHERE `IP` = '%s' ", params[0]);
	mysql_query(connects,YCMDstr);
	new rows;
	cache_get_row_count(rows);
	if(!rows) return error(playerid, "Aset ips ar adevs ban");
	// ---------- /

	format(YCMDstr, sizeof(YCMDstr), "%s'm(a) moxsna banip ip: %s's", Name(playerid), params[1], params[0], params[2]);
	SendAdminMessage(0xEF545DFF, YCMDstr);

	format(YCMDstr,sizeof(YCMDstr), "DELETE FROM `banip` WHERE `IP` = '%s'", params[0]);
	mysql_tquery(connects, YCMDstr, "", "");
	return true;
}
CMD:banip(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 5) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "ds[32]",params[0], params[1])) return formatmsg(playerid, "/banip [Day] [IP]");

	format(YCMDstr, sizeof(YCMDstr), "%s'm(a) daado banip %d dgit ip: %s's", Name(playerid), params[0], params[1]);
	SendAdminMessage(0xEF545DFF, YCMDstr);

	new year, month,day; getdate(year, month, day);
	new strstre[500]; format(strstre,sizeof(strstre), "%d/%d/%d",day,month,year);

	format(YCMDstr, sizeof(YCMDstr), "INSERT INTO `banip` (`BanDay`, `IP`, `AdminName`, `BanTime`) VALUES ('%d', '%s', '%s', '%s')",getdate()+params[0], params[1], Name(playerid), strstre);
	mysql_query(connects,YCMDstr);
	
 	return true;
}
CMD:banlist(playerid) {
	new AleadersString[8000], Names[MAX_PLAYER_NAME], GetBan;
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 3) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
    format(YCMDstr, sizeof(YCMDstr), "SELECT * FROM `accounts` WHERE `pBan` = '1'");
	mysql_query(connects,YCMDstr);
	new bnacc = 0, banstr[120];
	new rows;
	cache_get_row_count(rows);
	new CurrentBan = getdate();
	for new i = 0; i < rows; i++ do {
	    cache_get_value_name(i,"pName", Names);
	    cache_get_value_name_int(i,"pBanMounth", GetBan);
		format(YCMDstr, sizeof(YCMDstr), "%s [ darchenilia - %d dge ]\n",Names, GetBan-CurrentBan);
		strcat(AleadersString, YCMDstr);
		bnacc += 1;
	}
	SendClientMessage(playerid, -1, AleadersString);
	format(banstr, sizeof(banstr), "Sul %d motamashes adevs ban", bnacc); SendClientMessage(playerid, 0xEF545DFF, banstr);
	return true;
}
CMD:unban(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 3) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "s[128]",params[0])) return formatmsg(playerid, "/unban [Username]");
	// ---------- //
	format(YCMDstr,sizeof(YCMDstr),"SELECT `pName` FROM `accounts` WHERE `pName` = '%s' ", params[0]);
	mysql_query(connects,YCMDstr);
	new rows;
	cache_get_row_count(rows);
	if(!rows) return error(playerid, "Aseti account ver moidzebna");
	// ---------- //
	new unbnstr[256];
	format(unbnstr, sizeof(unbnstr), "UPDATE `accounts` SET `pBan` = '0' WHERE `pName` = '%s'", params[0]);
	mysql_query(connects, unbnstr);

	format(unbnstr, sizeof(unbnstr), "%s'm(a) moxsna bani: %s's", Name(playerid), params[0]); SendAdminMessage(0xEF545DFF, unbnstr);
	return true;
}
CMD:ban(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 3) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "uds[64]", params[0], params[1], params[2])) return formatmsg(playerid, "/ban [ID] [Day] [Reason]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");

	UserData[params[0]][pBan] = 1;
	UserData[params[0]][pBanDay] = getdate();
	UserData[params[0]][pBanMounth] = getdate()+params[1];

	UpdateUserData(params[0], "pBan", UserData[params[0]][pBan]);
	UpdateUserData(params[0], "pBanDay", UserData[params[0]][pBanDay]);
	UpdateUserData(params[0], "pBanMounth", UserData[params[0]][pBanMounth]);

	format(YCMDstr, sizeof(YCMDstr), "%s'm(a) daado ban %d dgit %s's mizezi: %s", Name(playerid), params[1], Name(params[0]), params[2]); SendClientMessage(params[0], -1, YCMDstr);
	SendAdminMessage(0xEF545DFF, YCMDstr);

	new ip[15]; GetPlayerIp(params[0], ip, 15);
	format(YCMDstr, sizeof(YCMDstr), "Saxeli: %s | IP misamarti: %s |",Name(params[0]), ip); SendAdminMessage(0xEF545DFF, YCMDstr);	

	SendClientMessage(params[0], 0xEF545DFF, "Tkven dagedot ban! tu tvlit, rom arasworad dagades gadaiget screen da atvirtet jgufshi - {FFFFFF}[ F8 ]");

	srvKick(params[0]);
 	return true;
}
CMD:offban(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 3) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "s[128]",params[0])) return formatmsg(playerid, "/offban [Motamashis Saxeli]");
	format(YCMDstr,sizeof(YCMDstr),"SELECT `pName` FROM `accounts` WHERE pName = '%s' ", params[0]);
	mysql_query(connects,YCMDstr);
	new rows;
	cache_get_row_count(rows);
	if(!rows) return error(playerid, "Account ver moidzebna");
	new test = getdate()+4;
	format(YCMDstr, sizeof(YCMDstr), "UPDATE accounts SET pBan = '1', pBanMounth = '%d' WHERE pName = '%s'",test,params[0]);
	mysql_query(connects,YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), "<OffBan> [Admin: %s] [Saxeli: %s]",Name(playerid), params[0]);
	SendAdminMessage(0xEF545DFF,YCMDstr);	
	return true;
}
CMD:offleader(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 4) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "s[128]",params[0])) return formatmsg(playerid, "/offleader [Motamashis Saxeli]");
	format(YCMDstr,sizeof(YCMDstr),"SELECT `pName` FROM `accounts` WHERE pName = '%s' ", params[0]);
	mysql_query(connects,YCMDstr);
	new rows;
	cache_get_row_count(rows);
	if(!rows) return error(playerid, "Account ver moidzebna");
	new test = getdate()+4;
	format(YCMDstr, sizeof(YCMDstr), "UPDATE accounts SET pLeader = '0', pMember = '0', pRank = '0' WHERE pName = '%s'",test,params[0]);
	mysql_query(connects,YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), "<Offleader> [Admin: %s] [Moxsna: %s]",Name(playerid), params[0]);
	SendAdminMessage(0xEF545DFF,YCMDstr);	
	return true;
}
CMD:offadmin(playerid, params[]) {
	if(Developer(playerid)) {
		if(Login[playerid] == false) return true;
		if(sscanf(params, "s[128]",params[0])) return formatmsg(playerid, "/offadmin [Motamashis Saxeli]");
		format(YCMDstr, sizeof(YCMDstr), "UPDATE accounts SET pAdmin = '0' WHERE pName = '%s'",params[0]);
		mysql_query(connects,YCMDstr);
		format(YCMDstr, sizeof(YCMDstr), "Administratorma %s moxsna offline admini %s",Name(playerid),params[0]);
		SendAdminMessage(0xEF545DFF, YCMDstr);
		SendClientMessage(playerid, -1, "Motamashe moxsnilia administratoris postidan");
	}
	return true;
}
CMD:getip(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 4) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "d",params[0])) return formatmsg(playerid, "/getip [ID]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe aseti ar moidzebna");
	new ip[15]; GetPlayerIp(params[0],ip,15);
	format(YCMDstr, sizeof(YCMDstr), "Saxeli: %s | IP misamarti: %s | registraciis ip misamarti: %s",Name(params[0]), ip, UserData[params[0]][pRegIP]); SendClientMessage(playerid, 0xEF545DFF, YCMDstr);
	return true;
}
CMD:setskin(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 3) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "ud", params[0], params[1])) return formatmsg(playerid, "/setskin [ID] [Skin ID]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
	if(params[1] > 311 || params[1] < 1 || params[1] == 74) return error(playerid, "Tkven miutitet araswori skinis id");
	SetPlayerSkin(params[0], params[1]);
	UserData[params[0]][pSkin] = params[1];
	UpdateUserData(params[0], "pSkin", UserData[params[0]][pSkin]);
	format(YCMDstr, sizeof(YCMDstr), "{F0A45D}Administratorma %s'm(a) shegicvalat skin", Name(playerid)); SendClientMessage(params[0], -1, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), "{F0A45D}Tqven %s's shecvalet skin", Name(params[0])); SendClientMessage(playerid, -1, YCMDstr);
	return true;
}
CMD:setlvl(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 6) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "ud",params[0], params[1])) return formatmsg(playerid, "/setlvl [ID] [LVL]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
	UserData[params[0]][pLevel] = params[1];
	UpdateUserData(params[0], "pLevel", UserData[params[0]][pLevel]);
	format(YCMDstr, sizeof(YCMDstr), "{F0A45D}Administratorma %s'm(a) shegicvalat lvl, tkveni lvl gaxda: %d", Name(playerid), params[1]); SendClientMessage(params[0], -1, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), "{F0A45D}Tqven %s's shecvalet level", Name(params[0])); SendClientMessage(playerid, -1, YCMDstr);
	return true;
}
CMD:unsampban(playerid, params[]) {
    if(Login[playerid] == false) return true;
	if(Developer(playerid)) {
		if(sscanf(params, "s[64]",params[0])) return formatmsg(playerid, "/unsampban [IP]");
		format(YCMDstr,sizeof(YCMDstr), "unbanip %s", params[0]);
		SendRconCommand(YCMDstr);
		format(YCMDstr, 256, "%s'm(a) moxsna hostban ips: %s",Name(playerid), params[0]);
		SendAdminMessage(0xEF545DFF, YCMDstr);
	}
	return true;
}
CMD:reloadbans(playerid, params[]) {
    if(Login[playerid] == false) return true;
	if(Developer(playerid)) {
		SendRconCommand("reloadbans");
		SendClientMessage(playerid, 0xEF545DFF, "Ban list gasuftavebulia");
	}
	return true;
}
CMD:hostname(playerid, params[]) {
    if(Login[playerid] == false) return true;
	if(Developer(playerid)) {
		if(sscanf(params, "s[128]",params[0])) return formatmsg(playerid, "/hostname [Name]");
		format(YCMDstr,sizeof(YCMDstr), "hostname %s",params[0]);
		SendRconCommand(YCMDstr);
	}
	return true;
}
CMD:asellhouse(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(Developer(playerid)) {
		if(sscanf(params, "d",params[0])) return formatmsg(playerid, "/asellhouse [House ID]");
		new target;
		target = ReturnUser(HouseData[params[0]][hOwner]);
		if(target != INVALID_PLAYER_ID) {
		    UserData[params[0]][pHouse] = -1;
			UpdateUserData(params[0], "pHouse", UserData[params[0]][pHouse]);
		}
		else {
			new b_string[500];
			format(b_string, sizeof(b_string), "UPDATE `accounts` SET `pHouse` = '-1' WHERE `pName` = '%s'", HouseData[params[0]][hOwner]);
			mysql_query(connects, b_string);
		}
		HouseData[params[0]][hLock] = 1;
		HouseData[params[0]][hOwned] = 0;
		strmid(HouseData[params[0]][hOwner], "The State", 0, strlen("The State"), MAX_PLAYER_NAME);
		SaveHouse(params[0]);
		UpdateHouse(params[0]);
	}
	return true;
}
CMD:asellbizz(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(Developer(playerid)) {
		if(sscanf(params, "d",params[0])) return formatmsg(playerid, "/asellbizz [Business ID]");
		new target;
		target = ReturnUser(BizzData[params[0]][bOwner]);
		if(target != INVALID_PLAYER_ID) {
		    UserData[params[0]][pBizz] = -1;
			UpdateUserData(params[0], "pBizz", UserData[params[0]][pBizz]);
		}
		else {
			new b_string[500];
			format(b_string, sizeof(b_string), "UPDATE `accounts` SET `pBizz` = '-1' WHERE `pName` = '%s'", BizzData[params[0]][bOwner]);
			mysql_query(connects, b_string);
		}
		BizzData[params[0]][bLock] = 1;
		BizzData[params[0]][bOwned] = 0;
		strmid(BizzData[params[0]][bOwner], "The State", 0, strlen("The State"), MAX_PLAYER_NAME);
		SaveBizz(params[0]);
	}
	return true;
}
CMD:sampban(playerid, params[]) {
    if(Login[playerid] == false) return true;
	if(Developer(playerid)) {
		if(sscanf(params, "s[64]",params[0])) return formatmsg(playerid, "/sampban [IP]");
		format(YCMDstr,sizeof(YCMDstr), "banip %s",params[0]);
		SendRconCommand(YCMDstr);
		format(YCMDstr, 256, "%s'm(a) daado hostban ips: %s",Name(playerid), params[0]);
		SendAdminMessage(0xEF545DFF, YCMDstr);
	}
	return true;
}
CMD:asetpass(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(Developer(playerid)) {
		if(sscanf(params, "s[128]s[128]",params[0],params[1])) return formatmsg(playerid, "/asetpass [Saxeli] [Paroli]");
		format(YCMDstr, sizeof(YCMDstr), "UPDATE accounts SET pPassword = '%s' WHERE pName = '%s'",params[1],params[0]);
		mysql_query(connects,YCMDstr);
		format(YCMDstr, sizeof(YCMDstr), "Tkven Sheucvalet %s's Paroli Da Dauyenet: %s",params[0],params[1]);
		SendClientMessage(playerid, -1, YCMDstr);
	}
	return true;
}
CMD:agetpass(playerid, params[]) {
    if(Login[playerid] == false) return true;
	if(Developer(playerid)) {
		if(sscanf(params, "s[42]",params[0])) return formatmsg(playerid, "/agetpass [Saxeli]");
		format(YCMDstr, sizeof(YCMDstr), "SELECT * FROM `accounts` WHERE pName = '%s'",params[0]);
		mysql_query(connects,YCMDstr);
		new rows;
		cache_get_row_count(rows);
		for new i = 0;i < rows; i++ do {
			cache_get_value_name(i,"pPassword",YCMDstr);
		    format(YCMDstr, sizeof(YCMDstr), "Motamashis Saxeli: %s - Paroli: %s",params[0],YCMDstr);
			SendClientMessage(playerid, 0x6BB3FFAA, YCMDstr);
		}
		if(!rows) return error(playerid, "Aseti angarishi ar moidzebna");
	}
	return true;
}
CMD:delacc(playerid, params[0]) {
    if(Login[playerid] == false) return true;
	if(Developer(playerid)) {
		if(sscanf(params, "s[64]",params[0])) return formatmsg(playerid, "/sampban [IP]");
		// ---------- //
		format(YCMDstr,sizeof(YCMDstr),"SELECT `pName` FROM `accounts` WHERE `pName` = '%s' ", params[0]);
		mysql_query(connects,YCMDstr);
		new rows;
		cache_get_row_count(rows);
		if(!rows) return error(playerid, "Aseti angarishi ar moidzebna");
		// ---------- /
		format(YCMDstr,sizeof(YCMDstr), "DELETE FROM `accounts` WHERE `pName` = '%s'", params[0]);
		mysql_query(connects,YCMDstr);
		format(YCMDstr, sizeof(YCMDstr), "Account : [%s] Delleted From : %s", params[0], Name(playerid));
		SendAdminMessage(0xEF545DFF, YCMDstr);	
	}	
	return true;
}
CMD:createtrailer(playerid) {
	if(Login[playerid] == false) return true;
	if(MyCarHouse[playerid] != -1) return true;
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
	CreateTrailer(playerid, x, y, z);
	return true;
}
CMD:trailer(playerid) {
	if(Login[playerid] == false) return true;
	if(admincar[playerid] == -1) return true;
	AttachTrailerToVehicle(attachedcar[MyCarHouse[playerid]], admincar[playerid]);
	return true;
}
CMD:payday(playerid) {
	if(Login[playerid] == false) return true;
	if(!Developer(playerid)) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	PayDay();
	return true;
}
cmd:startcapture(playerid){
	start_capture();
}
CMD:mutelist(playerid) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 1) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	new countmute = 0;
	foreach(new i:Player) {
		if(UserData[i][pMute] >= 1 && IsPlayerConnected(i)) {
			format(YCMDstr, sizeof(YCMDstr), "%s [ID: %d] | %d Wami",Name(i),i,UserData[i][pMuteTime]);
			countmute++;
			SendClientMessage(playerid, 0xEF545DFF, YCMDstr);
		}
	}
	if(countmute == 0) success(playerid, "Arcert motamashes ar adevs chatis bani");
	else {
		format(YCMDstr, sizeof(YCMDstr), "Sul: %d Kaci", countmute);
		SendClientMessage(playerid, 0xEF545DFF, YCMDstr);
	}
	return true;
}
CMD:mute(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 1) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "uds[128]",params[0],params[1],params[2])) return	formatmsg(playerid, "/mute [ID] [Time] [Reason]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
	if(UserData[params[0]][pMute] == 1) {
		format(YCMDstr, sizeof(YCMDstr), "%s[%d] moxsna chatis bani motamashes %s",Name(playerid),playerid,Name(params[0]));
		SendAdminMessage(0xEF545DFF, YCMDstr);
		UserData[params[0]][pMuteTime] = 0;
		UserData[params[0]][pMute] = 0;
		UpdateUserData(params[0], "pMuteTime", UserData[params[0]][pMuteTime]);
		UpdateUserData(params[0], "pMute", UserData[params[0]][pMute]);
		return true;
	}
	UserData[params[0]][pMuteTime] = params[1]*60;
	UserData[params[0]][pMute] = 1;
	UpdateUserData(params[0], "pMuteTime", UserData[params[0]][pMuteTime]);
	UpdateUserData(params[0], "pMute", UserData[params[0]][pMute]);
	format(YCMDstr, sizeof(YCMDstr), "%s[%d] daado %d wutiani chatis bani motamashes %s mizezi: %s",Name(playerid),playerid,params[1],Name(params[0]),params[2]);
	SendAdminMessage(0xEF545DFF, YCMDstr);
	format(YCMDstr, sizeof(YCMDstr), "{FFFFFF}Tqven dagedot chatis bani {F0A45D}%d {FFFFFF}wutit",params[1]);
	SendClientMessage(params[0], -1, YCMDstr);
	return true;
}
CMD:slap(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 2) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "u",params[0])) return formatmsg(playerid, "/slap [ID]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
	new Float:slx, Float:sly, Float:slz;
	GetPlayerPos(params[0], slx, sly, slz);
	SetPlayerPosEx(params[0], slx, sly, slz+5);
	PlayerPlaySound(params[0], 1130, slx, sly, slz+5);
	format(YCMDstr, sizeof(YCMDstr), "[A] Administratorma %s'm(a) uqna slap %s's",Name(playerid), Name(params[0]));
	SendAdminMessage(0x7C91A9FF, YCMDstr);
	return true;
}
CMD:ooc(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 2) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "s[512]", params[0])) return formatmsg(playerid, "/o(oc) [Text]");
	UsingAdress(playerid, params[0]);
	new oocstr[256];
	switch(UserData[playerid][pAdmin]) {
		case 7: format(oocstr, sizeof(oocstr), "{FF0000}<< Server Developer >> %s[%d]:{FFFFFF} %s", Name(playerid), playerid, params[0]);
		case 6: format(oocstr, sizeof(oocstr), "{FF0000}<< Server Owner >> %s[%d]:{FFFFFF} %s", Name(playerid), playerid, params[0]);
		case 5: format(oocstr, sizeof(oocstr), "{FF0000}<< Senior Administrator >> %s[%d]:{FFFFFF} %s", Name(playerid), playerid, params[0]);
		case 4: format(oocstr, sizeof(oocstr), "{FF0000}<< Middle Administrator >> %s[%d]:{FFFFFF} %s", Name(playerid), playerid, params[0]);
		case 3: format(oocstr, sizeof(oocstr), "{FF0000}<< Junior Administrator >> %s[%d]:{FFFFFF} %s", Name(playerid), playerid, params[0]);
		case 2: format(oocstr, sizeof(oocstr), "{FF0000}<< Beta Administrator >> %s[%d]:{FFFFFF} %s", Name(playerid), playerid, params[0]);
		default: format(oocstr, sizeof(oocstr), "{FF0000}<< Administrator >> %s[%d]:{FFFFFF} %s", Name(playerid), playerid, params[0]);
	}
 	SendClientMessageToAll(-1, oocstr);
	return 1;
}
CMD:gzcolor(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 4) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "d",params[0])) return formatmsg(playerid, "/gzcolor [Fraction ID]");
	for(new i = 0; i < 130; i++) {
		if(PlayerInZone(playerid,ZoneInfo[i][gCoords][0], ZoneInfo[i][gCoords][1],ZoneInfo[i][gCoords][2],ZoneInfo[i][gCoords][3])) {
			ZoneInfo[i][gFrakVlad] = params[0];
			GangZoneStopFlashForAll(ZoneInfo[i][gID]);
			GangZoneHideForAll(ZoneInfo[i][gID]);
			GangZoneShowForAll(ZoneInfo[i][gID], GetGangZoneColor(i));
			SaveGZ();
			// [ Log ]
			new year, month, day, hour, minuite, second, data[100], time[100];
			getdate(year, month, day);
			format(data,sizeof(data), "%d/%d/%d", day, month, year);
			gettime(hour,minuite,second);
			if(minuite < 10) {
				format(time, sizeof(time), "%d:0%d", hour, minuite);
			}
			else {
				format(time, sizeof(time), "%d:%d", hour, minuite);
			}
			new cmdlogs[600];
			format(cmdlogs, sizeof(cmdlogs), "INSERT INTO `console` (`CMD`, `Name`, `Recipient`, `Value`, `Data`, `Time`) VALUE ('/gzcolor', '%s', '%s', '%d', '%s', '%s')",
			Name(playerid), params[0], params[0], data, time);
			mysql_query(connects, cmdlogs);
		}
	}
	return true;
}
CMD:aduty(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 1) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	new string[256];
	if(AdminDuty[playerid] == false) {
		AdminDuty[playerid] = true;
		format(string,512,"[A]{FFFFFF} %s Admin Duty - {00FF00}[ ON ]", Name(playerid));
		SendAdminMessage(0xEF545DFF, string);
		GivePlayerServerWeapon(playerid, 38, 99999);
	}
	else if(AdminDuty[playerid] == true) {
		AdminDuty[playerid] = false;
		format(string,512,"[A]{FFFFFF} %s Admin Duty - {EF545D}[ OFF ]", Name(playerid));
		SendAdminMessage(0xEF545DFF, string);
	}
	return true;
}
CMD:goto(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 1) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "u",params[0])) return formatmsg(playerid, "/goto [ID]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
	if(UserData[params[0]][pAdmin] > UserData[playerid][pAdmin]) return error(playerid, "Tkvenze magal leveltan ver mixvalt");
	new Float:plocx,Float:plocy,Float:plocz;
	if(GetPlayerState(params[0]) != 1 && GetPlayerState(params[0]) != 2 && GetPlayerState(params[0]) != 3) return error(playerid, "Motamashe ar daspawnebula");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && gSpectateID[params[0]] != INVALID_PLAYER_ID) return error(playerid, "Admin aris gasuli recon'ze");
	GetPlayerPos(params[0], plocx, plocy, plocz);
	if(GetPlayerState(playerid) == 2) {
		new tmpcar = GetPlayerVehicleID(playerid);
		SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
	}
	else {
		SetPlayerPosEx(playerid,plocx,plocy+2, plocz);
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(params[0]));
		SetPlayerInterior(playerid, GetPlayerInterior(params[0]));
	}
	return true;
}
CMD:gethere(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 1) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "u",params[0])) return formatmsg(playerid, "/gethere [ID]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
	if(UserData[params[0]][pAdmin] > UserData[playerid][pAdmin]) return error(playerid, "Tkvenze magal levels ver uzamt teleports");
	new Float:tpx, Float:tpy, Float:tpz;
	GetPlayerPos(playerid, tpx, tpy, tpz);
	new vw = GetPlayerVirtualWorld(playerid);
	new pi = GetPlayerInterior(playerid);
	SetPlayerPosEx(params[0], tpx+1.0, tpy+1.0, tpz);
	SetPlayerVirtualWorld(params[0], vw);
	SetPlayerInterior(params[0], pi);
	return true;
}
CMD:sethp(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 1) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
    if(sscanf(params, "ud",params[0],params[1])) return	formatmsg(playerid, "/sethp [ID] [HP]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
    if(params[1] < 0 || params[1] > 160) return true;
	SetPlayerHealth(params[0], params[1]);
	success(playerid, "Motamashes dauyenda mititebuli sicocxle");
	return true;
}
CMD:setarm(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 1) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
    if(sscanf(params, "ud",params[0],params[1])) return	formatmsg(playerid, "/setarm [ID] [Value]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
    if(params[1] < 0 || params[1] > 100) return true;
	SetPlayerArmourAC(params[0], params[1]);
	success(playerid, "Motamashes dauyenda mititebuli armori");
	return true;
}
CMD:auninvite(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 4) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "d",params[0])) return formatmsg(playerid, "/auninvite [ID]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
	
	new id = params[0];
	UserData[id][pLeader] = 0; UserData[id][pMember] = 0; UserData[id][pRank] = 0; UserData[id][pForma] = 0;
	UpdateUserData(id, "pLeader", UserData[id][pLeader]); UpdateUserData(id, "pMember", UserData[id][pMember]);
	UpdateUserData(id, "pRank", UserData[id][pRank]); UpdateUserData(playerid, "pForma", UserData[id][pForma]);

	new string[500];
	format(string, sizeof(string), "Administratorma: {F0A45D}%s{FFFFFF}'m(a) mogxsnat organizaciidan", Name(playerid));
	SendClientMessage(id, -1, string);
	format(string, sizeof(string), "Tkven moxsenit motamashe {F0A45D}%s[%d]{FFFFFF} organizaciidan", Name(id), id);
	SendClientMessage(playerid, -1, string);

	SetPlayerSkin(id, UserData[id][pSkin]);
	return true;
}
CMD:recon(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 1) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "d",params[0])) return formatmsg(playerid, "/re(con) [ID]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
	if(params[0] == playerid) return error(playerid, "Tkven tavs ver daakvirdebit");
	if(!IsPlayerConnected(params[0])) return true;
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && gSpectateID[params[0]] != INVALID_PLAYER_ID) return error(playerid, "Motamashes ukve akvirdebian");
	if(GetPlayerState(params[0]) != 1 && GetPlayerState(params[0]) != 2 && GetPlayerState(params[0]) != 3) return error(playerid, "Motamashe ar daspawnebula");
	StartSpectate(playerid, params[0]);
	return true;
}
CMD:reconoff(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 1) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING) return true;
	StopSpectate(playerid);
	return true;
}
CMD:boss(playerid, params[]) {
    if(Login[playerid] == false) return true;
	if(Developer(playerid)) {
		UserData[playerid][pAdmin] = 7;
		UserData[playerid][pAdminLogin] = 1;
		UpdateUserData(playerid, "pAdminLogin", UserData[playerid][pAdminLogin]);
		success(playerid, "Tkven warmatebit gaiaret avtorizacia rogorc serveris mflobelma");
	}
	return 1;
}
CMD:kick(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 1) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "us[256]",params[0],params[1])) return formatmsg(playerid, "/kick [ID] [Reason]");
	UsingAdress(playerid, params[1]);
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
	if(UserData[params[0]][pAdmin] > 0) return error(playerid, "Administrators ver gaagdebt serveridan");
	new kickstr[256];
	format(kickstr, sizeof(kickstr), "%s'm(a) gaagdo serveridan %s. mizezi: %s", Name(playerid), Name(params[0]), params[1]);
	SendAdminMessage(0xEF545DFF, kickstr);
	SendClientMessage(params[0], -1, kickstr);
	srvKick(params[0]);
	return true;
}
CMD:skin(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 1) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "d", params[0])) return formatmsg(playerid, "/skin [Skin ID]");
	if(params[0] > 311 || params[0] < 1 || params[0] == 74) return error(playerid, "Tkven miutitet araswori skinis id");
	SetPlayerSkin(playerid, params[0]);
	UserData[playerid][pSkin] = params[0];
	UpdateUserData(playerid, "pSkin", UserData[playerid][pSkin]);
	return true;
}
CMD:givemoney(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 5) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "ud", params[0], params[1])) return formatmsg(playerid, "/givemoney [ID] [Value]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
	GiveUserMoney(params[0], params[1]);
	// [ Log ]
	new year, month, day, hour, minuite, second, data[100], time[100];
	getdate(year, month, day);
	format(data,sizeof(data), "%d/%d/%d", day, month, year);
	gettime(hour,minuite,second);
	if(minuite < 10) {
		format(time, sizeof(time), "%d:0%d", hour, minuite);
	}
	else {
		format(time, sizeof(time), "%d:%d", hour, minuite);
	}
	new cmdlogs[600];
	format(cmdlogs, sizeof(cmdlogs), "INSERT INTO `console` (`CMD`, `Name`, `Recipient`, `Value`, `Data`, `Time`) VALUE ('/givemoney', '%s', '%s', '%d', '%s', '%s')",
	Name(playerid), Name(params[0]), params[1], data, time);
	mysql_query(connects, cmdlogs);
	return true;
}
CMD:admins(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 4) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
    new dialog[1024];
	strcat(dialog, "{FFFFFF}Name[ID]\t{FFFFFF}Level\n");
	foreach(new i:Player) {
	    if(!IsPlayerConnected(i) || (!Login[i])) continue;
	    if(UserData[i][pAdminLogin] < 1) continue;
	    new string[700];
		format(string, sizeof(string), "{FFFFFF}%s[%d]\t{FFFFFF}%d\n", Name(i), i, UserData[i][pAdmin]);
		strcat(dialog, string);
	}
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Administrators", dialog, "Okay", "");
    return true;
}
CMD:aadmins(playerid, params[])
{
    new AadminsDialogString[4000],Names[MAX_PLAYER_NAME],Rank;
	if(Login[playerid] == false) return true;
    if(UserData[playerid][pAdmin] < 5) return true;
	format(YCMDstr, sizeof(YCMDstr), "SELECT * FROM `accounts` WHERE pAdmin >= '1' ORDER BY `pAdmin` DESC");
	mysql_query(connects,YCMDstr);
	new rows;
	cache_get_row_count(rows);
	if(!rows) return error(playerid,"Administratorebi ar moidzebna");
	strcat(AadminsDialogString, "Name\tLVL\tStatusi\n");
	for new i = 0;i < rows; i++ do
	{
	    cache_get_value_name(i,"pName",Names);
		cache_get_value_name_int(i,"pAdmin",Rank);
		format(YCMDstr, sizeof(YCMDstr), "{FFFFFF}%s\t%d\t%s\t%s\n",Names, Rank, IsOnline(Names) ? ("{7EDF17}Online{FFFFFF}") : ("{DF1717}Offline{FFFFFF}"));
		strcat(AadminsDialogString, YCMDstr);
	}
	ShowPlayerDialog(playerid, 7979, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Administrators", AadminsDialogString, "Close", "");
	return true;
}
CMD:alogin(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 1) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 1) {
		UserData[playerid][pAdminLogin] = 0;
		UpdateUserData(playerid, "pAdminLogin", UserData[playerid][pAdminLogin]);
		success(playerid, "Tkven agar gaqvt gavlili admin login");
		return true;
	}
	ShowPlayerDialog(playerid, 201, DIALOG_STYLE_PASSWORD, "{FFFFFF}Alogin",
	"{FFFFFF}- Mogesalmebat administration system -\n\n\
	{FFFFFF}Uflebebis misagebat sachiroa gaiarot avtorizacia\n\n\
	{F0A45D}* Miutitet tkveni admin paroli da daachiret 'Next' gilaks",
	"Next", "Cancel");
	return true;
}
CMD:veh(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 4) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "ddd",params[0], params[1], params[2])) return formatmsg(playerid, "/veh [Veh ID] [Color 1] [Color 2]");
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X,Y,Z);
	createdvehs ++;
	admincar[playerid] = CreateVehicle(params[0], X,Y,Z, 0.0, params[1], params[2], 60000);
	SetVehicleNumberPlate(admincar[playerid], "SA:LIFE");
	SetVehicleHealth(admincar[playerid], 1300.0);
 	LinkVehicleToInterior(admincar[playerid], GetPlayerInterior(playerid));
 	SetVehicleVirtualWorld(admincar[playerid], GetPlayerVirtualWorld(playerid));
	PutPlayerInVehicleEx(playerid, admincar[playerid], 0);
	SetPlayerArmedWeapon(playerid, 0);
	vehcreat[admincar[playerid]] = 1;
	CreatedCars[CreatedCar] = admincar[playerid];
	success(playerid, "Tkven sheqmenit manqana, ar dagaviwydet washla");
	return true;
}
CMD:delveh(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 3) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(admincar[playerid] != -1) return DestroyVehicle(admincar[playerid]), success(playerid, "Manqana waishala"), admincar[playerid] = -1;
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return true;
	if(vehcreat[GetPlayerVehicleID(playerid)] != 1) return error(playerid, "Am manqanis washla sheudzlebelia");
	DestroyVehicle(GetPlayerVehicleID(playerid));
	createdvehs --;
	vehcreat[GetPlayerVehicleID(playerid)] = 0;
	success(playerid, "Manqana waishala");
	return true;
}
CMD:settime(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 5) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
    if(sscanf(params, "d",params[0])) return formatmsg(playerid, "/settime [0-23]");
	SetWorldTime(params[0]);
	return true;
}
CMD:setweather(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 5) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "d",params[0])) return formatmsg(playerid, "/setweather [0-40]");
	SetWeather(params[0]);
	return true;
}
CMD:jetpack(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 1) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK) {
		
		new Float:X,Float:Y,Float:Z;
		GetPlayerPos(playerid,X,Y,Z);
		SetPlayerPosEx(playerid,X,Y,Z);
		success(playerid, "Jetpack off");
	}
	else {
		SetPlayerSpecialAction(playerid, 2);
		success(playerid, "Jetpack on");
	}
	return true;
}
CMD:addhouse(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(!Developer(playerid)) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
    if(sscanf(params, "d",params[0])) {
		formatmsg(playerid, "/addhouse [Class]");
		formatmsg(playerid, "1 - [N] | 2 - [C] | 3 - [B] | 4 - [A]");
		return true;
	}
	if(params[0] < 1 || params[0] > 4) return formatmsg(playerid, "1 - [N] | 2 - [C] | 3 - [B] | 4 - [A]");
	
	new Float: posX, Float: posY, Float: posZ;
	GetPlayerPos(playerid, posX, posY, posZ);
	new query[200];
	format(query, sizeof(query), "INSERT INTO `house` (`hEnterX`, `hEnterY`,`hEnterZ`, `hLock`,`hClass`) VALUES ('%f', '%f', '%f', '1','%d')", posX, posY, posZ, params[0]);
	mysql_query(connects, query);
	
	TotalHouse++;
	HouseData[TotalHouse][hID] = TotalHouse;
	HouseData[TotalHouse][hEnterX] = posX;
	HouseData[TotalHouse][hEnterY] = posY;
	HouseData[TotalHouse][hEnterZ] = posZ;
	HouseData[TotalHouse][hLock] = 1;
	HouseData[TotalHouse][hClass] = params[0];
	strmid(HouseData[TotalHouse][hOwner], "The State", 0, strlen("The State"), MAX_PLAYER_NAME);
	if(HouseData[TotalHouse][hClass] == 1) {
		HouseData[TotalHouse][hInt] = 10;
		HouseData[TotalHouse][hExitX] = 422.5726;
		HouseData[TotalHouse][hExitY] = 2536.4902;
		HouseData[TotalHouse][hExitZ] = 10.0000;
		HouseData[TotalHouse][hPrice] = 150000;

		HouseData[TotalHouse][hSpawnX] = 416.9297;
		HouseData[TotalHouse][hSpawnY] = 2536.6182;
		HouseData[TotalHouse][hSpawnZ] = 10.0000;
		HouseData[TotalHouse][hSpawnF] = 272.8922;
	}
 	if(HouseData[TotalHouse][hClass] == 2) {
		HouseData[TotalHouse][hInt] = 3;
		HouseData[TotalHouse][hExitX] = 2495.9636;
		HouseData[TotalHouse][hExitY] = -1692.0848;
		HouseData[TotalHouse][hExitZ] = 1014.7422;
		HouseData[TotalHouse][hPrice] = 200000;

		HouseData[TotalHouse][hSpawnX] = 2492.3052;
		HouseData[TotalHouse][hSpawnY] = -1702.5568;
		HouseData[TotalHouse][hSpawnZ] = 1018.3438;
		HouseData[TotalHouse][hSpawnF] = 181.0612;
	}
	if(HouseData[TotalHouse][hClass] == 3) {
		HouseData[TotalHouse][hInt] = 12;
		HouseData[TotalHouse][hExitX] = 2324.4712;
		HouseData[TotalHouse][hExitY] = -1149.5466;
		HouseData[TotalHouse][hExitZ] = 1050.7101;
		HouseData[TotalHouse][hPrice] = 400000;

		HouseData[TotalHouse][hSpawnX] = 2324.3394;
		HouseData[TotalHouse][hSpawnY] = -1136.5311;
		HouseData[TotalHouse][hSpawnZ] = 1051.3047;
		HouseData[TotalHouse][hSpawnF] = 180.4580;
	}
 	if(HouseData[TotalHouse][hClass] == 4) {
		HouseData[TotalHouse][hInt] = 5; 
		HouseData[TotalHouse][hExitX] = 140.3126;
		HouseData[TotalHouse][hExitY] = 1365.9227;
		HouseData[TotalHouse][hExitZ] = 1083.8594;
		HouseData[TotalHouse][hPrice] = 500000;

		HouseData[TotalHouse][hSpawnX] = 140.2303;
		HouseData[TotalHouse][hSpawnY] = 1378.4781;
		HouseData[TotalHouse][hSpawnZ] = 1088.3672;
		HouseData[TotalHouse][hSpawnF] = 180.1680;
	}
	HouseData[TotalHouse][hGarage] = 0;
	HouseCP[TotalHouse] = CreateDynamicPickup(1273, 23, HouseData[TotalHouse][hEnterX], HouseData[TotalHouse][hEnterY], HouseData[TotalHouse][hEnterZ], 0, -1, -1, 50.0);
	HouseData[TotalHouse][hIcon] = CreateDynamicMapIcon(HouseData[TotalHouse][hEnterX], HouseData[TotalHouse][hEnterY], HouseData[TotalHouse][hEnterZ], 31, 0);
	House3DText[TotalHouse] = CreateDynamic3DTextLabel(" PROPERTY ", -1, HouseData[TotalHouse][hEnterX], HouseData[TotalHouse][hEnterY], HouseData[TotalHouse][hEnterZ], 25.0);
	UpdateHouse(TotalHouse);
	SaveHouse(TotalHouse);
	return true;
}
CMD:addbizz(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(!Developer(playerid)) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
    if(sscanf(params, "d",params[0])) {
		formatmsg(playerid, "/addbizz [Class]");
		formatmsg(playerid, "1 - [24/7]");
		formatmsg(playerid, "2 - [Skin Shop]");
		return true;
	}
	if(params[0] < 1 || params[0] > 2) return formatmsg(playerid, "1 - [24/7] || 2 - [Skin Shop]");
	
	new Float: posX, Float: posY, Float: posZ;
	GetPlayerPos(playerid, posX, posY, posZ);
	new query[200];
	format(query, sizeof(query), "INSERT INTO `business` (`bEnterX`, `bEnterY`,`bEnterZ`, `bLock`,`bType`) VALUES ('%f', '%f', '%f', '1','%d')", posX, posY, posZ, params[0]);
	mysql_query(connects, query);
	
	TotalBizz++;
	BizzData[TotalBizz][bID] = TotalBizz;
	BizzData[TotalBizz][bEnterX] = posX;
	BizzData[TotalBizz][bEnterY] = posY;
	BizzData[TotalBizz][bEnterZ] = posZ;
	BizzData[TotalBizz][bLock] = 1;
	BizzData[TotalBizz][bType] = params[0];
	strmid(BizzData[TotalBizz][bOwner], "The State", 0, strlen("The State"), MAX_PLAYER_NAME);
	if(BizzData[TotalBizz][bType] == 1) {
		BizzData[TotalBizz][bInt] = 17;
		BizzData[TotalBizz][bExitX] = -25.9097;
		BizzData[TotalBizz][bExitY] = -187.8146;
		BizzData[TotalBizz][bExitZ] = 1003.5469;
		BizzData[TotalBizz][bPrice] = 2500000;

		BizzData[TotalBizz][bBuyX] = -29.3675;
		BizzData[TotalBizz][bBuyY] = -184.9345;
		BizzData[TotalBizz][bBuyZ] = 1003.5469;

		BizzData[TotalBizz][bTypeID] = 19132;

		BizzData[TotalBizz][bIcon] = 17;
	}
	if(BizzData[TotalBizz][bType] == 2) {
		BizzData[TotalBizz][bInt] = 5;
		BizzData[TotalBizz][bExitX] = 226.8605;
		BizzData[TotalBizz][bExitY] = -8.1114;
		BizzData[TotalBizz][bExitZ] = 1002.2109;
		BizzData[TotalBizz][bPrice] = 4500000;

		BizzData[TotalBizz][bBuyX] = 206.1304;
		BizzData[TotalBizz][bBuyY] = -3.7327;
		BizzData[TotalBizz][bBuyZ] = 1001.2109;

		BizzData[TotalBizz][bTypeID] = 19132;

		BizzData[TotalBizz][bIcon] = 45;
	}
	SaveBizz(TotalBizz);

	new i = TotalBizz;
    BizzIcon[i] = CreateDynamicMapIcon(BizzData[i][bEnterX], BizzData[i][bEnterY], BizzData[i][bEnterZ], BizzData[i][bIcon], 0);
	BizzText[i] = CreateDynamic3DTextLabel("{FFFFFF}Press : {F0A45D}(ALT)", -1, BizzData[i][bEnterX], BizzData[i][bEnterY], BizzData[i][bEnterZ], 5.0);
	BizzCP[i] = CreateDynamicPickup(BizzData[i][bTypeID], 23, BizzData[i][bEnterX], BizzData[i][bEnterY], BizzData[i][bEnterZ], 0, -1, -1, 50.0);

	return true;
}
CMD:cc(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 4) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	for(new i = 0; i < 100; i++) SendClientMessageToAll(-1, "");
	return true;
}
CMD:hp(playerid) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 1) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(IsPlayerInAnyVehicle(playerid)) {
		AnRepairVehicle(GetPlayerVehicleID(playerid));
		SetVehicleHealth(GetPlayerVehicleID(playerid), 1300);
		SetPlayerHealth(playerid, 100.0);
	}
	SetPlayerHealth(playerid, 100.0);
	SetVehicleHealth(GetPlayerVehicleID(playerid), 1300);
	return true;
}
CMD:givegun(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 3) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "udd", params[0], params[1], params[2])) return formatmsg(playerid, "/givegun [ID] [Gun ID] [Bullet]");
	if(params[1] < 1 || params[1] > 46) return true;
	if(params[2] < 1 || params[2] > 500) return error(playerid, "Minimum 1 maqsimum 500 tyvia");
	if(params[1] == 4 || params[1] == 16 || params[1] == 17 || params[1] == 27 || params[1] == 34 || params[1] == 35 || params[1] == 36 || params[1] == 37 || params[1] == 38 || params[1] == 40 || params[1] == 44 || params[1] == 45) return error(playerid, "Am iaragis gacema ar sheidzleba");
	GivePlayerServerWeapon(params[0], params[1], params[2]);
	success(playerid, "Tkvens mier archeuli iaragi gadaeca motamashes");
	return true;
}
CMD:makeadmin(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 6) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "ud", params[0], params[1])) return formatmsg(playerid, "/makeadmin [ID] [Level]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
	if(params[1] > 6 || params[1] < 0) return error(playerid, "Maqsimum 6 leveli, minimum 0 leveli");
	if(params[1] == 0) {
		success(playerid, "Tkven moxsenit motamashe administratoris poziciidan");
		success(params[0], "Tkven mogxsens administratoris poziciidan, amitomac vegar gamoiyenebt adminis brdzanebebs");
		ResetPlayerWeapons(params[0]);
		UserData[params[0]][pAdminLogin] = 0;
		UserData[params[0]][pAdmin] = 0;
		UpdateUserData(params[0], "pAdminLogin", UserData[params[0]][pAdminLogin]);
		UpdateUserData(params[0], "pAdmin", UserData[params[0]][pAdmin]);

		// [ Log ]
		new year, month, day, hour, minuite, second, data[100], time[100];
		getdate(year, month, day);
		format(data,sizeof(data), "%d/%d/%d", day, month, year);
		gettime(hour,minuite,second);
		if(minuite < 10) {
			format(time, sizeof(time), "%d:0%d", hour, minuite);
		}
		else {
			format(time, sizeof(time), "%d:%d", hour, minuite);
		}
		new cmdlogs[600];
		format(cmdlogs, sizeof(cmdlogs), "INSERT INTO `console` (`CMD`, `Name`, `Recipient`, `Value`, `Data`, `Time`) VALUE ('/removeadmin', '%s', '%s', '%d', '%s', '%s')",
		Name(playerid), Name(params[0]), params[1], data, time);
		mysql_query(connects, cmdlogs);
		return true;
	}
	success(playerid, "Tkvens mier archeul motamashes mieca adminis wodeba");
	success(params[0], "Imisatvis, rom gamoiyenot administratoris uflebebi sachiroa miutitot axali admin paroli");
	SetPVarInt(params[0], "AdminLVL", params[1]);
	ShowAdminDialog(params[0]);
	// [ Log ]
	new year, month, day, hour, minuite, second, data[100], time[100];
	getdate(year, month, day);
	format(data,sizeof(data), "%d/%d/%d", day, month, year);
	gettime(hour,minuite,second);
	if(minuite < 10) {
		format(time, sizeof(time), "%d:0%d", hour, minuite);
	}
	else {
		format(time, sizeof(time), "%d:%d", hour, minuite);
	}
	new cmdlogs[600];
	format(cmdlogs, sizeof(cmdlogs), "INSERT INTO `console` (`CMD`, `Name`, `Recipient`, `Value`, `Data`, `Time`) VALUE ('/makeadmin', '%s', '%s', '%d', '%s', '%s')",
	Name(playerid), Name(params[0]), params[1], data, time);
	mysql_query(connects, cmdlogs);
	return true;
}
CMD:spcars(playerid, params[]) {
    if(Login[playerid] == false) return true;
	if(IsPlayerConnected(playerid)) {
		if(UserData[playerid][pAdmin] < 3) {
			error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
			return true;
		}
		format(YCMDstr,sizeof(YCMDstr), "Gamouyenebeli manqnebi darespawndeba 15 wamshi. | %s", Name(playerid));
		SendClientMessageToAll(0xF4D03FFF,YCMDstr);
		SetTimer("CarSpawn", 15000, 0);
	}
	return true;
}
CMD:spawn(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 1) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "u", params[0])) return formatmsg(playerid, "/spawn [ID]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
	SpawnPlayer(params[0]);
	success(playerid, "Tkven warmatebit gauketet respawn motamashes");
	new string[500];
	format(string, sizeof(string), "Tkven dagarespawnat administratorma {F0A45D}%s", Name(playerid));
	SendClientMessage(params[0], -1, string);
	if(KnocInfo[params[0]][kActive] > 0) {
		KnocInfo[params[0]][kID] = 0;
		KnocInfo[params[0]][kActive] = 0;
		KnocInfo[params[0]][kX] = 0;
		KnocInfo[params[0]][kY] = 0;
		KnocInfo[params[0]][kZ] = 0;
		KnocInfo[params[0]][kInt] = 0;
		KnocInfo[params[0]][kVW] = 0;
		Delete3DTextLabel(KnocText[params[0]]);
	}
	return true;
}
CMD:admin(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 1) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "s[128]", params[0])) return formatmsg(playerid, "/admin [Text]");
	new adminchat[256];
	format(adminchat, sizeof(adminchat), "[A] %s[%d]: %s",Name(playerid), playerid, params[0]);
	SendAdminMessage(0xF4D03FFF, adminchat);
	return true;
}
CMD:makeleader(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 4) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "u", params[0])) return formatmsg(playerid, "/makeleader [ID]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
	new string[500];
	format(string, sizeof(string),
	"{F0A45D}[1]{FFFFFF} - Police Departament\n\
	{F0A45D}[2]{FFFFFF} - Hospital Departament\n\
	{F0A45D}[3]{FFFFFF} - City Hall\n\
	{F0A45D}[4]{FFFFFF} - Armed Forces\n");
	ShowPlayerDialog(playerid, 203, DIALOG_STYLE_LIST, "{FFFFFF}Makeleader", string, "Next", "Cancel");	
	SetPVarInt(playerid, "LeaderID", params[0]);
	return true;
}
CMD:makegang(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 4) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "u", params[0])) return formatmsg(playerid, "/makegang [ID]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
	new string[500];
	format(string, sizeof(string),
	"{F0A45D}[7]{FFFFFF} - Ballas\n\
	{F0A45D}[8]{FFFFFF} - Vagos\n\
	{F0A45D}[9]{FFFFFF} - Grove\n\
	{F0A45D}[10]{FFFFFF} - Aztecas\n\
	{F0A45D}[11]{FFFFFF} - Rifa\n");
	ShowPlayerDialog(playerid, 204, DIALOG_STYLE_LIST, "{FFFFFF}Makegang", string, "Next", "Cancel");	
	SetPVarInt(playerid, "LeaderID", params[0]);
	return true;
}
CMD:makedonate(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 7) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
	if(sscanf(params, "u", params[0])) return formatmsg(playerid, "/makeleader [ID]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
	new string[500];
	format(string, sizeof(string),
	"{F0A45D}[1]{FFFFFF} - Sacra Dennaro Unita\n\
	{F0A45D}[1]{FFFFFF} - Sheriff Station\n");
	ShowPlayerDialog(playerid, 205, DIALOG_STYLE_LIST, "{FFFFFF}Makedonate", string, "Next", "Cancel");	
	SetPVarInt(playerid, "LeaderID", params[0]);
	return true;
}
CMD:acure(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] < 2) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");
    if(sscanf(params, "u", params[0])) return formatmsg(playerid, "/acure [ID]");
    if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
    if(KnocInfo[params[0]][kActive] == 0) return error(playerid, "Es motamashe ar aris danokili");
    SetTimerEx("UnFreeze", 1000, false, "i", params[0]);
	SetTimerEx("KnockAnimation", 1000, false, "i", params[0]);
	return true;
}
// CMD:SOC
CMD:suspect(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pMember] == 1) {
		if(sscanf(params, "ud", params[0], params[1])) return formatmsg(playerid, "/su(spect) [ID] [Level]");
		if(UserData[params[0]][pWantedLevel] > 6) return error(playerid, "Motamashes ukve adevs maqsimaluri dzebnis done");
		if(UserData[params[0]][pJailed]) return error(playerid, "Motamashe ukve imyofeba cixeshi");

		if(UserData[params[0]][pWantedLevel] == 0) {
			format(YCMDstr, sizeof(YCMDstr), "{F4D03F}Policielma: %s'm(a) gamoacxada dzebnashi %s, dzebnis done: %d", Name(playerid), Name(params[0]), params[1]);
			SendFractionMessage(UserData[playerid][pMember], YCMDstr);
		}
		else {
			format(YCMDstr, sizeof(YCMDstr), "{F4D03F}Policielma: %s'm(a) gaanaxla dzebna %s'ze, dzebnis done: %d", Name(playerid), Name(params[0]), params[1]);
			SendFractionMessage(UserData[playerid][pMember], YCMDstr);			
		}
		UserData[params[0]][pWantedLevel] = UserData[params[0]][pWantedLevel] + params[1];
		UpdateUserData(params[0], "pWantedLevel", UserData[params[0]][pWantedLevel]);
	}
	return true;
}
CMD:arrest(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pMember] == 1) {
		if(PlayerToPoint(10.0, playerid, 222.2287,120.7666,999.0542)) {
		    new prsid;
			if(sscanf(params, "u", prsid)) return formatmsg(playerid, "/arrest [ID]");
			if(params[0] == INVALID_PLAYER_ID) return error(playerid, "Motamashe ar moidzebna");
			if(KnocInfo[prsid][kActive] == 1) return error(playerid, "Motamashe aris danokili");
	        if(UserData[prsid][pWantedLevel] < 1) return error(playerid, "Motamashes ar adevs arc erti wanted done");

		  	new Float:x, Float:y, Float:z;
		    GetPlayerPos(prsid, x, y, z);
		    if(!PlayerToPoint(2.0, playerid, x, y, z) || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(prsid)) return error(playerid, "Motamashe ar imyofeba tkventan axlos");
		    

			if(UserData[prsid][pJailed]) return error(playerid, "Motamashe ukve imyofeba cixeshi");

			UserData[prsid][pJailed] = 1;
			UpdateUserData(prsid, "pJailed", UserData[prsid][pJailed]);

			UserData[prsid][pJailTime] = UserData[prsid][pWantedLevel]*100;
			UpdateUserData(prsid, "pJailTime", UserData[prsid][pJailTime]);

			UserData[prsid][pWantedLevel] = 0;
			UpdateUserData(prsid, "pWantedLevel", UserData[prsid][pWantedLevel]);

			SetPlayerWantedLevel(prsid, 0);
			TogglePlayerControllable(prsid, 1);
			gotome[prsid] = -1;
			SetPlayerSpecialAction(prsid, SPECIAL_ACTION_NONE);
			RemovePlayerAttachedObject(prsid,0);
			PlayerCuffed[prsid] = 0;
			PlayerCuffedTime[prsid] = 0;

	      	GiveUserMoney(playerid, 20000);
		}
	}
	return true;
}
CMD:clearsuspect(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pMember] == 1) {
		new prsid;
		if(sscanf(params, "u", prsid)) return formatmsg(playerid, "/clearsuspect [ID]");
		if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");	    if(UserData[prsid][pWantedLevel] < 1) return error(playerid, "Motamashes ar adevs arc erti wanted done");
		
		UserData[prsid][pWantedLevel] = 0;
		UpdateUserData(prsid, "pWantedLevel", UserData[prsid][pWantedLevel]);

		success(playerid, "Tkven moxsenit dzebnidan motamashe");
		success(prsid, "Tkven agar xart dzebnashi");
	}	
	return true;
}
CMD:gotome(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pMember] == 1) {
	    if(sscanf(params, "u",params[0])) return formatmsg(playerid, "/gotome [ID]");
	    if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
 		new Float:x, Float:y, Float:z;
    	GetPlayerPos(params[0], x, y, z);
    	if(!PlayerToPoint(3.0, playerid, x, y, z) || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(params[0])) return error(playerid, "Motamashe ar imyofeba tkventan axlos");

	    if(GetPlayerState(params[0]) != 1 || GetPlayerState(playerid) != 1) return error(playerid, "Tkven da damnashave ar unda ijdet manqanashi");
	    if(gotome[params[0]] != -1 && gotome[params[0]] != playerid) {
	    	new stringf[126];
		    format(stringf, sizeof(stringf), "Am motamashes miatrevs: %s",Name(gotome[params[0]]));
		    SendClientMessage(playerid, -1, stringf);
		    return true;
		}
	    if(gotome[params[0]] == -1) {
		    if(GetPlayerSpecialAction(params[0]) != SPECIAL_ACTION_CUFFED) return error(playerid, "Am motamashes ar adevs borkilebi");
		    gotome[params[0]] = playerid;
		    new string[126];
		    format(string, sizeof(string), "Tkven migatrevt officeri: %s",Name(playerid));
		    SendClientMessage(params[0], -1, string);

		    new string1[126];
		    format(string1, sizeof(string1), "Tkven miatrevt: %s's",Name(params[0]));
		    SendClientMessage(playerid, -1, string1);
		}
		else if(gotome[params[0]] == playerid) {
			gotome[params[0]] = -1;
		    new string11[126];
		    format(string11, sizeof(string11), "Tkven agar miatrevt %s's",Name(params[0]));
		    SendClientMessage(playerid, -1, string11);
		}
	}
	return true;
}
CMD:ceject(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pMember] == 1) {
	    new giveplayerid, sendername[MAX_PLAYER_NAME], giveplayer[MAX_PLAYER_NAME];
		if(sscanf(params, "u",giveplayerid)) return  formatmsg(playerid, "/ceject [ID]");
		if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
		if(GetPlayerVehicleID(playerid) != GetPlayerVehicleID(giveplayerid)) return error(playerid, "Motamashe ar zis tkvens manqanashi");
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));

		format(YCMDstr, sizeof(YCMDstr), "{6495ED}Tqven gadaagdet manqanidan %s", Name(giveplayerid));
		SendClientMessage(playerid, -1, YCMDstr);
		format(YCMDstr, sizeof(YCMDstr), "{6495ED}Tqven gadmogagdot manqanidan %s'm(a)", Name(playerid));
		SendClientMessage(giveplayerid, -1, YCMDstr);
		RemovePlayerFromVehicleAC(giveplayerid);
	}
	return true;
}
CMD:cuff(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pMember] == 1) {
		if(sscanf(params, "u",params[0])) return formatmsg(playerid, "/cuff [ID]");
		if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
		if(UserData[params[0]][pMember] == 1) return error(playerid, "Tkven ver gauketebt borkilebs policiis tanamshromels");
		if(PlayerCuffed[params[0]] == 2) return error(playerid, "Motamashes ukve adevs borkilebi");
		if(Tazed[params[0]] == true) return error(playerid, "Scadet borkilebis dadeba ramodenime wamshi");
		if(gotome[params[0]] != -1) return error(playerid, "Tkven ar shegidzliat am momentshi borkilebis moxsna");
		if(params[0] == playerid) return error(playerid, "Tkven tavs ver daadebt borkilebs");
		if(GetPlayerState(playerid) == 1 && GetPlayerState(params[0]) != 1) return error(playerid, "Tkven ver daadebt borkilebs motamashes radgan igi manqanashi zis");
		if(GetPlayerState(playerid) != 1 && GetPlayerState(params[0]) == 1) return error(playerid, "Tkven ver daadebt borkilebs motamashes radgan tkven manqanashi zixart");

 		new Float:x, Float:y, Float:z;
    	GetPlayerPos(params[0], x, y, z);
    	if(!PlayerToPoint(3.0, playerid, x, y, z) || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(params[0])) return error(playerid, "Motamashe ar imyofeba tkventan axlos");

    	AnimOn[params[0]] = true; 

		format(YCMDstr, sizeof(YCMDstr), "{6BB3FF}%s'm(a) dagadot borkilebi",Name(playerid));
		SendClientMessage(params[0], -1, YCMDstr);
		format(YCMDstr, sizeof(YCMDstr), "{6BB3FF}Tqven gauketet borkilebi %s's", Name(params[0]));
		SendClientMessage(playerid, -1, YCMDstr);
		format(YCMDstr, sizeof(YCMDstr), "%s'm(a) daado borkilebi %s's",Name(playerid),Name(params[0]));
		SetPlayerAttachedObject(params[0], 0, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977, -81.700035, 0.891999, 1.000000, 1.168000);
		SetPlayerSpecialAction(params[0], SPECIAL_ACTION_CUFFED);
		ProxDetector(20.0, playerid, YCMDstr, -1);
		TogglePlayerControllable(params[0], 0);
		PlayerCuffed[params[0]] = 2;
		PlayerCuffedTime[params[0]] = 3600;
	}
	return true;
}
CMD:uncuff(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pMember] == 1) {
		if(sscanf(params, "u",params[0])) return formatmsg(playerid, "/uncuff [ID]");
		if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
		if(PlayerCuffed[params[0]] != 2) return error(playerid, "Motamashes ar uketia borkilebi");
 		
 		new Float:x, Float:y, Float:z;
    	GetPlayerPos(params[0], x, y, z);
    	if(!PlayerToPoint(3.0, playerid, x, y, z) || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(params[0])) return error(playerid, "Motamashe ar imyofeba tkventan axlos");

		if(params[0] == playerid) return error(playerid, "Tkven ver moxsnit tkven tavs borkilebs");

		AnimOn[params[0]] = false; 

		new uncuffstr[256];
		format(uncuffstr, sizeof(uncuffstr), "{6BB3FF}%s'm(a) mogxsnat borkilebi",Name(playerid));
		SendClientMessage(params[0], -1, uncuffstr);
		format(uncuffstr, sizeof(uncuffstr), "{6BB3FF}Tqven moxsenit borkilebi %s", Name(params[0]));
		SendClientMessage(playerid, -1, uncuffstr);
		TogglePlayerControllable(params[0], 1);
		SetPlayerSpecialAction(params[0],SPECIAL_ACTION_NONE);
		RemovePlayerAttachedObject(params[0],0);
		PlayerCuffed[params[0]] = 0;
		PlayerCuffedTime[params[0]] = 0;
	}
	return true;
}
CMD:auncuff(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pAdmin] > 0) {
		if(UserData[playerid][pAdminLogin] == 0) return error(playerid, "Tkven ar gagivliat admin avtorizacia");

		if(sscanf(params, "u",params[0])) return formatmsg(playerid, "/auncuff [ID]");
		if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
		if(PlayerCuffed[params[0]] != 2) return error(playerid, "Motamashes ar uketia borkilebi");

		AnimOn[params[0]] = false; 

		new uncuffstr[256];
		format(uncuffstr, sizeof(uncuffstr), "{6BB3FF}Administratorma %s'm(a) mogxsnat borkilebi",Name(playerid));
		SendClientMessage(params[0], -1, uncuffstr);
		format(uncuffstr, sizeof(uncuffstr), "{6BB3FF}Tqven moxsenit borkilebi %s", Name(params[0]));
		SendClientMessage(playerid, -1, uncuffstr);
		TogglePlayerControllable(params[0], 1);
		SetPlayerSpecialAction(params[0],SPECIAL_ACTION_NONE);
		RemovePlayerAttachedObject(params[0],0);
		PlayerCuffed[params[0]] = 0;
		PlayerCuffedTime[params[0]] = 0;
	}
	return true;
}
CMD:cput(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pMember] == 1) {
		new tacha = GetPlayerVehicleID(playerid);
		if(!IsAPlane(tacha) && !IsABoat(tacha) && !IsABike(tacha)) {
	  		if(sscanf(params, "u",params[0], params[1])) return formatmsg(playerid, "/cput [ID]");
			if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
			
			new Float:x, Float:y, Float:z;
    		GetPlayerPos(params[0], x, y, z);
    		if(!PlayerToPoint(5.0, playerid, x, y, z) || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(params[0])) return error(playerid, "Motamashe ar imyofeba tkventan axlos");

			if(params[0] == playerid) return error(playerid, "Tkven tavs ver chaagdebt manqanashi");
			if(GetPlayerState(params[0]) != PLAYER_STATE_ONFOOT) return error(playerid, "Motamashe aris manqanashi");
			new model = GetVehicleModel(GetPlayerVehicleID(playerid));
			if(model != 490 && model != 426 && model != 560 && model != 427 && model != 596 && model != 599 && model != 579 && model != 482) return error(playerid, "Am transportshi daushvebelia motamashis chagdeba"); {
				new veh = GetPlayerVehicleID(playerid);
		 		PutPlayerInVehicle(params[0], veh, 3);
				SetPlayerArmedWeapon(params[0],0);
				new string[256];
				format(string, sizeof(string), "Officer: {8099B5}%s{FFFFFF}'m(a) Chagagdot Manqanashi",Name(playerid));
				SendClientMessage(params[0], -1, string);
				format(string, sizeof(string), "Tkven Chaagdet Manqanashi: {8099B5}%s",Name(params[0]));
				SendClientMessage(playerid, -1, string);
			}
		}
		else {
		    error(playerid, "Am transportshi ver chatenit motamashes");
		}
	}
	return true;
}
CMD:tazer(playerid) {
	new fracid = UserData[playerid][pMember];
	if(Login[playerid] == false) return true;
	if(fracid != 1) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(GetPlayerWeapon(playerid) != 23) return error(playerid, "Am iaragshi ver chadebt tazers");
	if(Tazer[playerid] == false) {
		Tazer[playerid] = true;
		new mestr[500];
		format(mestr, sizeof(mestr), "- %s chado iaragshi tazer'is tyviebi",Name(playerid));
		ProxDetector(20.0, playerid, mestr, 0x988EFFFF);
	}
	else {
		Tazer[playerid] = false;
		new mestr[500];
		format(mestr, sizeof(mestr), "- %s amoigo iaragidan tazer'is tyviebi",Name(playerid));
		ProxDetector(20.0, playerid, mestr, 0x988EFFFF);
	}
	return true;
}
CMD:invite(playerid, params[]) {
	new fracid = UserData[playerid][pMember];
	if(Login[playerid] == false) return true;
	if(fracid == 0) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pRank] < FractionData[UserData[playerid][pMember]][wInviteRank]) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(sscanf(params, "u", params[0])) return formatmsg(playerid, "/invite [ID]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
	if(UserData[params[0]][pMember] != 0) return error(playerid, "Es motamashe ukve aris fraqciashi");
    new Float:x, Float:y, Float:z;
    GetPlayerPos(params[0], x, y, z);
    if(!PlayerToPoint(10.0, playerid, x, y, z)) return error(playerid, "Es motamashe ar aris tkventan axlos");
	
	new skinID;
    switch(fracid) {
    	case 1: skinID = 280;
    	case 2: skinID = 70;
    	case 3: skinID = 57;
    	case 4: skinID = 287;
    	case 5: skinID = 294;
    	case 7: skinID = 102;
    	case 8: skinID = 108;
    	case 9: skinID = 106;
    	case 10: skinID = 114;
    	case 11: skinID = 175;
    }

	new string[500];
	format(string, sizeof(string), "Tkven giwvevt {F0A45D}%s{FFFFFF} fraqciashi({F0A45D}%s{FFFFFF}) gasawevrianeblad", Name(playerid), GetFractionName(fracid));
	SendClientMessage(params[0], -1, string);
	success(params[0], "Tu gnebavt gawevrianeba daachiret 'Y' gilaks, xolo tu ar gnebavt 'N' gilaks");
	
	SetPVarInt(params[0], "InviteFraction", 1);
	SetPVarInt(params[0], "InvFractionID", fracid);
	SetPVarInt(params[0], "InvFractionSkin", skinID);

	success(playerid, "Tkven gaugzavnet motamashes mowveva fraqciashi");
	return true;
}
CMD:giverank(playerid, params[]) {
	new fracid = UserData[playerid][pMember];
	if(Login[playerid] == false) return true;
	if(fracid == 0) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pRank] < FractionData[UserData[playerid][pMember]][wInviteRank]) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(sscanf(params, "ud", params[0], params[1])) return formatmsg(playerid, "/giverank [ID] [Rank]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
	if(UserData[playerid][pRank] <= params[1]) return error(playerid, "Tkven ver gascemt tkven rankze mets");
	if(UserData[params[0]][pMember] != UserData[playerid][pMember]) return error(playerid, "Es motamashe ar aris tkvens fraqciashi");
	if(params[0] == playerid) return error(playerid, "Tkven ver sheucvlit tkven tavs ranks");

	UserData[params[0]][pRank] = params[1];
	UpdateUserData(params[0], "pRank" ,UserData[params[0]][pRank]);

	new string[500];
	format(string, sizeof(string), "Tkven shegicvalat %s'm(a) rank, axlandeli ranki aris: %d",Name(playerid), params[1]);
	SendClientMessage(params[0], -1, string);

	success(playerid, "Tkven sheucvalet motamashes rank");
	return true;
}
CMD:uninvite(playerid, params[]) {
	new fracid = UserData[playerid][pMember];
	if(Login[playerid] == false) return true;
	if(fracid == 0) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(UserData[playerid][pRank] < FractionData[UserData[playerid][pMember]][wInviteRank]) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	if(sscanf(params, "u", params[0])) return formatmsg(playerid, "/uninvite [ID]");
	if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
	if(UserData[playerid][pRank] <= UserData[params[0]][pRank]) return error(playerid, "Tkven ver gaagdebt fraqciidan am motamashes");
	if(UserData[params[0]][pMember] != UserData[playerid][pMember]) return error(playerid, "Es motamashe ar aris tkvens fraqciashi");
	if(params[0] == playerid) return error(playerid, "Tkven ver gaagdebt tkven tavs");

	UserData[params[0]][pLeader] = 0;
	UserData[params[0]][pMember] = 0;
	UserData[params[0]][pForma] = 0;
	UserData[params[0]][pRank] = 0;

	UpdateUserData(params[0], "pLeader" ,UserData[params[0]][pLeader]);
	UpdateUserData(params[0], "pMember" ,UserData[params[0]][pMember]);
	UpdateUserData(params[0], "pForma" ,UserData[params[0]][pForma]);
	UpdateUserData(params[0], "pRank" ,UserData[params[0]][pRank]);

	SetPlayerSkin(params[0], UserData[playerid][pSkin]);
	success(playerid, "Tkven gaagdet motamashe fraqciidan");
	success(params[0], "Tkven gagagdes fraqciidan");
	return true;
}
CMD:changeskin(playerid, params[]) {
	new fracid = UserData[playerid][pMember];
	if(Login[playerid] == false) return true;
	if(fracid == 0) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	new string[500];
	format(string, sizeof(string),
	"{F0A45D}[1]{FFFFFF} - Pirveli skin - {F0A45D}[ %d ]\n\
	{F0A45D}[2]{FFFFFF} - Meore skin - {F0A45D}[ %d ]\n\
	{F0A45D}[3]{FFFFFF} - Mesame skin - {F0A45D}[ %d ]\n\
	{F0A45D}[4]{FFFFFF} - Meotxe skin - {F0A45D}[ %d ]\n\
	{F0A45D}[5]{FFFFFF} - Mexute skin - {F0A45D}[ %d ]\n\
	{F0A45D}[6]{FFFFFF} - Meeqvse skin - {F0A45D}[ %d ]",
	FractionData[fracid][wSkin][0], FractionData[fracid][wSkin][1], 
	FractionData[fracid][wSkin][2], FractionData[fracid][wSkin][3], 
	FractionData[fracid][wSkin][4], FractionData[fracid][wSkin][5]);
	SetPVarInt(playerid, "ChangeSkinUser", playerid);
	ShowPlayerDialog(playerid, 710, DIALOG_STYLE_LIST, "{FFFFFF}Change Skin", string, "Next", "Cancel");	
	return true;
}
CMD:lpanel(playerid) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pLeader] == 0) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
	new string[500];
	format(string, sizeof(string),
	"{F0A45D}[1]{FFFFFF} - Fraqciis informacia\n\
	{F0A45D}[2]{FFFFFF} - Fraqciis aqtiuri wevrebi\n\
	{F0A45D}[3]{FFFFFF} - Migebis minimaluri ranki\n\
	{F0A45D}[4]{FFFFFF} - Fraqciis skinebis archeva");
	ShowPlayerDialog(playerid, 700, DIALOG_STYLE_LIST, "{FFFFFF}Leader Menu", string, "Next", "Cancel");	
	return true;
}
CMD:time(playerid) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pClock] == 0) return error(playerid, "Tkven ar gaqvt nayidi saati");

	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && AnimOn[playerid] == false) {
		AnimOn[playerid] = true;
       	ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_watch",4.1,0,0,0,0,0);
       	AnimOn[playerid] = false;
	}
	new string[64], mtext[20], year, month,day;
	getdate(year, month, day);
	format(string, sizeof(string), "%s'm(a) daxeda saats", Name(playerid));
	ProxDetector(20.0, playerid, string, 0x988EFFFF);
	switch(month) {
	    case 1:mtext = "January";
	    case 2: mtext = "February";
	    case 3: mtext = "March";
	    case 4: mtext = "April";
	    case 5:mtext = "Maya";
	    case 6: mtext = "June";
	    case 7: mtext = "July";
	    case 8: mtext = "August";
	    case 9: mtext = "Sentebrya";
	    case 10:mtext = "October";
	    case 11: mtext = "November";
	    case 12: mtext = "December";
	}
	new hour,minuite,second;
	gettime(hour,minuite,second);
	if (minuite < 10) {
		format(string, sizeof(string), "~g~played time: %d~n~~y~%d ~y~%s~n~~w~%d:0%d", LoginTime[playerid], day, mtext, hour, minuite);
	}
	else {
		format(string, sizeof(string), "~g~played time: %d~n~~y~%d ~y~%s~n~~w~%d:%d", LoginTime[playerid], day, mtext, hour, minuite);
	}
	GameTextForPlayer(playerid, string, 1000, 1);
	return true;
}
CMD:unrent(playerid) {
	if(Login[playerid] == false) return true;
	if(rentID[playerid] == -1) return error(playerid, "Tkven ar gyavt manqana naqiravebi");
	DestroyVehicle(rentID[playerid]);
	rentID[playerid] = -1;
	SetPVarInt(playerid, "veh_rent", -1);
	success(playerid, "Tkven agar gyavt naqiravebi manqana");
	return true;
}
CMD:dm(playerid) {
    if(Login[playerid] == false) return true;
    if(!IsInAllowed(playerid)) return true;
	if(!PlayerToPoint(3.0,playerid,2695.4736,-1704.6350,11.8438)) return error(playerid, "Tkven ar imyofebit arenastan axlos");
    if(DMArena[playerid] != 0)return error(playerid, "Tkven ukve imyofebit dm arenaze, gasavlelat - /exitdm");
	new string[500];
	format(string, sizeof(string),
	"{F0A45D}[1]{FFFFFF} - 160 HP\n\
	{F0A45D}[2]{FFFFFF} - 100 HP\n\
	{F0A45D}[3]{FFFFFF} - 50 HP");
	ShowPlayerDialog(playerid, 604, DIALOG_STYLE_LIST, "{FFFFFF}DeathMatch", string, "Next", "Cancel");	
    return true;
}
CMD:exitdm(playerid) {
	if(Login[playerid] == false) return true;
    if(!IsInAllowed(playerid)) return true;
    if(DMArena[playerid] != 1)return error(playerid, "Tkven ar imyofebit arenaze");
    DeletePVar(playerid, "DMGun1");
    DeletePVar(playerid, "DMGun2");
    DMArena[playerid] = 0;
    SpawnPlayer(playerid);
    return true;
}
CMD:exit(playerid) {
	if(Login[playerid] == false) return true;
	new h = UserData[playerid][pHouse];
	if(h == -1) return error(playerid, "Tkven ar gaqvt saxli");
	if(PlayerToPoint(2.0, playerid, HouseData[h][hExitX], HouseData[h][hExitY], HouseData[h][hExitZ])) {
		ShowPlayerDialog(playerid, 406, DIALOG_STYLE_LIST, "{FFFFFF}Saxli", "{F0A45D}[1]{FFFFFF} - Garet\n{F0A45D}[2]{FFFFFF} - Garaji", "Next", "Close");
		return true;
	}
	return true;
}
CMD:makegun(playerid, params[]) {
    if(Login[playerid] == false) return true;
    if(!IsInAllowed(playerid)) return true;
	if(sscanf(params, "dd", params[0], params[1])) {
		formatmsg(playerid, "/makegun [Gun ID] [Value]");
		formatmsg(playerid, "GUN ID: 1 - Deagle | 2 - Shotgun | 3 - M4");
		formatmsg(playerid, "GUN ID: 4 - AK-47 | 5 - Country rifle | 6 - MP5");
	}
    switch(params[0]) {
		case 1: {
			if(Materials[playerid] < params[1]) return error(playerid, "Ar gaqvt sakmarisi tyviebi");
	        GivePlayerWeapon(playerid, 24, params[1]),
			Materials[playerid] -= params[1];
	    }
   		case 2: {
   			if(Materials[playerid] < params[1]) return error(playerid, "Ar gaqvt sakmarisi tyviebi");
	        GivePlayerWeapon(playerid, 25, params[1]),
			Materials[playerid] -= params[1];
	    }
   		case 3: {
   			if(Materials[playerid] < params[1]) return error(playerid, "Ar gaqvt sakmarisi tyviebi");
	        GivePlayerWeapon(playerid, 31, params[1]),
			Materials[playerid] -= params[1];
	    }
   		case 4: {
   			if(Materials[playerid] < params[1]) return error(playerid, "Ar gaqvt sakmarisi tyviebi");
	        GivePlayerWeapon(playerid, 30, params[1]),
			Materials[playerid] -= params[1];
	    }
   		case 5: {
   			if(Materials[playerid] < params[1]) return error(playerid, "Ar gaqvt sakmarisi tyviebi");
	        GivePlayerWeapon(playerid, 33, params[1]),
			Materials[playerid] -= params[1];
	    }
   		case 6: {
   			if(Materials[playerid] < params[1]) return error(playerid, "Ar gaqvt sakmarisi tyviebi");
	        GivePlayerWeapon(playerid, 29, params[1]),
			Materials[playerid] -= params[1];
	    }
    }
	return true;
}
CMD:ginfo(playerid, params[])
{
	if(Login[playerid] == true){
		if(IsAGang(playerid)) {
			ClearTotalGz();
			for(new i =0;i<sizeof(ZoneInfo);i++) {
				if(ZoneInfo[i][gFrakVlad] == 11) TotalGzR++;
				if(ZoneInfo[i][gFrakVlad] == 10) TotalGzA++;
				if(ZoneInfo[i][gFrakVlad] == 9) TotalGzG++;
				if(ZoneInfo[i][gFrakVlad] == 8) TotalGzV++;
				if(ZoneInfo[i][gFrakVlad] == 7) TotalGzB++;
			}
			switch(UserData[playerid][pMember]) {
			case 7: {
					format(YCMDstr, sizeof(YCMDstr),"{FFFFFF}Tkveni bandis mier dapyrobili teritoriebi: {F0A45D}%d",TotalGzB);
					ShowPlayerDialog(playerid,5656,DIALOG_STYLE_MSGBOX,"The Ballas Gang",YCMDstr, "Okay", "");
				}
			case 8: {
					format(YCMDstr, sizeof(YCMDstr),"{FFFFFF}Tkveni bandis mier dapyrobili teritoriebi: {F0A45D}%d",TotalGzV);
					ShowPlayerDialog(playerid,5656,DIALOG_STYLE_MSGBOX,"The Vagos Gang",YCMDstr, "Okay", "");
				}
			case 9: {
					format(YCMDstr, sizeof(YCMDstr),"{FFFFFF}Tkveni bandis mier dapyrobili teritoriebi: {F0A45D}%d",TotalGzG);
					ShowPlayerDialog(playerid,5656,DIALOG_STYLE_MSGBOX,"The Grove Street Gang",YCMDstr, "Okay", "");
				}
			case 10: {
					format(YCMDstr, sizeof(YCMDstr),"{FFFFFF}Tkveni bandis mier dapyrobili teritoriebi: {F0A45D}%d",TotalGzA);
					ShowPlayerDialog(playerid,5656,DIALOG_STYLE_MSGBOX,"The Azteca Gang",YCMDstr, "Okay", "");
				}
			case 11: {
					format(YCMDstr, sizeof(YCMDstr),"{FFFFFF}Tkveni bandis mier dapyrobili teritoriebi: {F0A45D}%d",TotalGzR);
					ShowPlayerDialog(playerid,5656,DIALOG_STYLE_MSGBOX,"The Rifa Gang",YCMDstr, "Okay", "");
				}
			}
			ClearTotalGz();
		}
	}
	return true;
}
CMD:members(playerid, params[]) {
    if(Login[playerid] == false || !UserData[playerid][pLeader] && !UserData[playerid][pMember]) return true;
	new string[64];
	foreach(new i:Player)
	{
		format(string, sizeof(string), "");
	    if(UserData[playerid][pMember] == UserData[i][pLeader]) format(string, sizeof(string), "%s[%d] Rang: Leader", Name(i), i);
		else if(UserData[playerid][pMember] == UserData[i][pMember]) format(string, sizeof(string), "%s[%d] Rang: %d", Name(i), i, UserData[i][pRank]);
		if(strlen(string)) SendClientMessage(playerid, 0x059BD3FF, string);
	}
	return 1;
}
CMD:offmembers(playerid) {
    if(Login[playerid] == false) return true;
	if(UserData[playerid][pLeader] == 0) return error(playerid, "Tkven ar gakvt am brdzanebis gamoyenebis ufleba");
    format(YCMDstr, sizeof(YCMDstr), "SELECT * FROM `accounts` WHERE `pMember` = '%d'",UserData[playerid][pMember]);
	mysql_tquery(connects, YCMDstr, "Offline Members", "i",playerid);
	return true;
}
CMD:offuninvite(playerid, params[])
{
    if(Login[playerid] == false) return true;
    if(UserData[playerid][pLeader] == 0) return 1;
    if(sscanf(params, "s[64]",params[0])) return error(playerid, "/offuninvite [NickName]");
    if(IsPlayerConnected(Getplayerid(params[0]))) return error(playerid, "Es motamashe shemosulia serverze");
    format(YCMDstr, sizeof(YCMDstr), "SELECT * FROM `accounts` WHERE Name = '%s'",params[0]);
	mysql_tquery(connects, YCMDstr, "OffUninvite", "is", playerid, params[0]);
	return true;
}
CMD:f(playerid, params[]) {
    if(Login[playerid] == false) return true;
    if(!IsInAllowed(playerid) && UserData[playerid][pMember] != 5) return true;
   	if(UserData[playerid][pMute] == 1) return error(playerid, "Tkven gadevt chatis bani");
	if(sscanf(params, "s[128]", params[0])) return formatmsg(playerid, "/f [text]");
	new id = UserData[playerid][pMember];
 	new string[256];
	format(string, sizeof(string), "{6DA3B5}[F] %s[%d]: %s", Name(playerid), playerid, params[0]);
	SendFractionMessage(id, string);
	return true;
}
CMD:r(playerid, params[]) {
    if(Login[playerid] == false) return true;
    if(!IsInGoverement(playerid)) return true;
   	if(UserData[playerid][pMute] == 1) return error(playerid, "Tkven gadevt chatis bani");
	if(sscanf(params, "s[128]", params[0])) return formatmsg(playerid, "/r [text]");
	new id = UserData[playerid][pMember];
 	new string[256];
	format(string, sizeof(string), "{6DA3B5}[R] %s[%d]: %s", Name(playerid), playerid, params[0]);
	SendFractionMessage(id, string);
	return true;
}
CMD:rr(playerid, params[]) {
    if(Login[playerid] == false) return true;
    if(!IsInGoverement(playerid)) return true;
   	if(UserData[playerid][pMute] == 1) return error(playerid, "Tkven gadevt chatis bani");
	if(sscanf(params, "s[128]", params[0])) return formatmsg(playerid, "/rr [text]");
	new id = UserData[playerid][pMember];
 	new string[256];
	format(string, sizeof(string), "{6DA3B5}[OOC] %s[%d]: %s", Name(playerid), playerid, params[0]);
	SendFractionMessage(id, string);
	return true;
}
CMD:d(playerid, params[]) {
    if(Login[playerid] == false) return true;
    if(!IsInGoverement(playerid)) return true;
   	if(UserData[playerid][pMute] == 1) return error(playerid, "Tkven gadevt chatis bani");
	if(sscanf(params, "s[128]", params[0])) return formatmsg(playerid, "/d [text]");
 	new string[256];
	format(string, sizeof(string), "[D] (%s) %s[%d]: %s",GetFractionName(UserData[playerid][pMember]), Name(playerid), playerid, params[0]);
	SendGovMessage(0xEF545DFF, string);
	return true;
}
CMD:cure(playerid,params[]) {
	if(Login[playerid] == false) return true;
    if(sscanf(params, "u", params[0])) return formatmsg(playerid, "/cure [ID]");
    if(UserData[playerid][pMember] != 2) return error(playerid, "Gacocxleba sheudzliat mxolod hospital tanamshromlebs");
    if(params[0] == INVALID_PLAYER_ID || !IsPlayerConnected(params[0])) return error(playerid, "Motamashe ar moidzebna");
    if(KnocInfo[params[0]][kActive] == 0) return error(playerid, "Es motamashe ar aris danokili");
    new Float:x, Float:y, Float:z;
    GetPlayerPos(params[0], x, y, z);
    if(!PlayerToPoint(2.0, playerid, x, y, z) || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(params[0])) return error(playerid, "Motamashe ar imyofeba tkventan axlos");
    if(params[0] == playerid) return error(playerid, "Tkven ver gaacocxlebt tkven tavs");
    if(UserData[playerid][pMember] == 2) {
    	AnimOn[playerid] = true;
        ApplyAnimation(playerid,"MEDIC","CPR",4.0,0,0,0,0,0);
        SetTimerEx("UnFreeze", 5000, false, "i", params[0]);
	    SetTimerEx("KnockAnimation", 5000, false, "i", params[0]);
	    AnimOn[playerid] = false;
	}
	else return error(playerid, "Tkven ar mushaobt hospital departament'shi");
	return true;
}
CMD:mm(playerid, params[]) {
	if(Login[playerid] == false) return true;
	new string[1500];
	format(string, sizeof(string),
	"{F0A45D}[1]{FFFFFF} - Personajis statistika\n\
	{F0A45D}[2]{FFFFFF} - Parametrebi\n\
	{F0A45D}[3]{FFFFFF} - Serveris brdzanebebi\n\
	{F0A45D}[4]{FFFFFF} - Report\n\
	{F0A45D}[5]{FFFFFF} - Promocode\n\
	{F0A45D}[6]{FFFFFF} - Quest");
	ShowPlayerDialog(playerid, 800, DIALOG_STYLE_LIST, "{FFFFFF}Mainmenu", string, "Next", "Cancel");	
	return true;
}
CMD:hpanel(playerid, params[]) {
  	if(Login[playerid] == false) return true;
    new h = UserData[playerid][pHouse];
	if(h == -1 || strcmp(Name(playerid), HouseData[UserData[playerid][pHouse]][hOwner], true) == -1) return error(playerid, "Tkven ar gaqvt saxli");
	new string[1500];
	format(string, sizeof(string),
	"{F0A45D}[1]{FFFFFF} - Saxlis informacia\n\
	{F0A45D}[2]{FFFFFF} - Karebis gageba/chaketva\n\
	{F0A45D}[3]{FFFFFF} - Saxlis gayidva\n\
	{F0A45D}[4]{FFFFFF} - Garajis yidva");
	ShowPlayerDialog(playerid, 404, DIALOG_STYLE_LIST, "{FFFFFF}Saxli", string, "Next", "Cancel");
	return true;
}
CMD:bpanel(playerid, params[]) {
  	if(Login[playerid] == false) return true;
    new h = UserData[playerid][pBizz];
	if(h == -1 || strcmp(Name(playerid), BizzData[UserData[playerid][pBizz]][bOwner], true) == -1) return error(playerid, "Tkven ar gaqvt biznesi");
	new string[1500];
	format(string, sizeof(string),
	"{F0A45D}[1]{FFFFFF} - Biznesis informacia\n\
	{F0A45D}[2]{FFFFFF} - Biznesis gageba/chaketva\n\
	{F0A45D}[3]{FFFFFF} - Biznesis gayidva\n\
	{F0A45D}[4]{FFFFFF} - Produqtebis shekveta");
	ShowPlayerDialog(playerid, 412, DIALOG_STYLE_LIST, "{FFFFFF}Business", string, "Next", "Cancel");
	return true;
}
CMD:sellhouse(playerid) {
    if(Login[playerid] == false) return true;
    new h = UserData[playerid][pHouse];
	if(h == -1 || strcmp(Name(playerid), HouseData[UserData[playerid][pHouse]][hOwner], true) == -1) return error(playerid, "Tkven ar gaqvt saxli");
	if(!PlayerToPoint(10.0, playerid, HouseData[h][hEnterX], HouseData[h][hEnterY], HouseData[h][hEnterZ])) return error(playerid, "Tkven ar xart tkveni saxlis karebtan axlos");
	new string[1500];
	format(string, sizeof(string), "{FFFFFF}Tqven gsurt saxlis gayidva - {F0A45D}ID: %d{FFFFFF}\
	\n\n{FFFFFF}Namdvilad gsurt gayidot tkveni saxli?\
	\n{FFFFFF}Tqveni saxlis girebuleba aris: {F0A45D}%d${FFFFFF}, tkven dagibrundebat - {F0A45D}75 procenti\
	\n\n{F0A45D}* Tu namdvilad gusrt saxlis gayidva daachiret 'Next' gilaks", HouseData[h][hID], HouseData[h][hPrice]);
	ShowPlayerDialog(playerid, 403, DIALOG_STYLE_MSGBOX, "{FFFFFF}Saxli", string, "Next", "Cancel");
	return true;
}
CMD:sellbizz(playerid) {
    if(Login[playerid] == false) return true;
    new h = UserData[playerid][pBizz];
	if(h == -1 || strcmp(Name(playerid), BizzData[UserData[playerid][pBizz]][bOwner], true) == -1) return error(playerid, "Tkven ar gaqvt saxli");
	if(!PlayerToPoint(10.0, playerid, BizzData[h][bEnterX], BizzData[h][bEnterY], BizzData[h][bEnterZ])) return error(playerid, "Tkven ar xart tkveni saxlis karebtan axlos");
	new string[1500];
	format(string, sizeof(string), "{FFFFFF}Tqven gsurt Biznesis gayidva - {F0A45D}ID: %d{FFFFFF}\
	\n\n{FFFFFF}Namdvilad gsurt gayidot tkveni biznesi?\
	\n{FFFFFF}Tqveni biznesis girebuleba aris: {F0A45D}%d${FFFFFF}, tkven dagibrundebat - {F0A45D}75 procenti\
	\n\n{F0A45D}* Tu namdvilad gusrt biznesis gayidva daachiret 'Next' gilaks", BizzData[h][bID], BizzData[h][bPrice]);
	ShowPlayerDialog(playerid, 413, DIALOG_STYLE_MSGBOX, "{FFFFFF}Business", string, "Next", "Cancel");
	return true;
}
CMD:fbullet(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(TotalBullet == 0) return error(playerid, "Am droistivs arc erti tyvia ar aris dagdebuli");
	if(sscanf(params, "d", params[0])) return formatmsg(playerid, "/fbullet [Bullet ID]");
	if(!BulletInfo[params[0]][BulletID] || BulletInfo[params[0]][bUsed] != 0) return error(playerid, "Aseti tyviis nomeri ar aris dzirs.");
	
	if(!PlayerToPoint(1.0, playerid, BulletInfo[params[0]][BulletX], BulletInfo[params[0]][BulletY], BulletInfo[params[0]][BulletZ])
	|| GetPlayerVirtualWorld(playerid) != BulletInfo[params[0]][bVW]) return error(playerid, "Tkven ar xart am vaznastan axlos");
	
	new string[500];
	format(string, sizeof(string), "{FFFFFF}Tqven ipovet iaragis tyvia - {F0A45D}ID: %d{FFFFFF}\n\n\
	{FFFFFF}Tqven gaqvt archevani, an gaanadgurot vazna an gamoikvliot\n\n\
	{F0A45D}* Tu gsurt ganadgureba daachiret 'Destroy' gilaks\n\
	{F0A45D}* Tu gsurt chaatarot eqspertiza daachiret 'Research' gilaks", params[0]);
	ShowPlayerDialog(playerid, 500, DIALOG_STYLE_MSGBOX, "{FFFFFF}Bullet", string, "Research", "Destroy");	
	SetPVarInt(playerid, "Bullet", params[0]);
	return true;
}
CMD:me(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(sscanf(params, "s[64]", params[0])) return formatmsg(playerid, "/me [Text]");
   	if(UserData[playerid][pMute] == 1) return error(playerid, "Tkven gadevt chatis bani");
	UsingAdress(playerid, params[0]);
	new mestr[500];
	format(mestr, sizeof(mestr), "- %s %s",Name(playerid), params[0]);
	ProxDetector(20.0, playerid, mestr, 0x988EFFFF);
	return true;
}
CMD:do(playerid, params[]) {
	if(Login[playerid] == false) return true;
   	if(UserData[playerid][pMute] == 1) return error(playerid, "Tkven gadevt chatis bani");
	if(sscanf(params, "s[64]", params[0])) return formatmsg(playerid, "/do [Text]");
	UsingAdress(playerid, params[0]);
	new mestr[500];
	format(mestr, sizeof(mestr), "- %s (( %s ))",params[0], Name(playerid));
	ProxDetector(20.0, playerid, mestr, 0x988EFFFF);
	return true;
}
CMD:shout(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(UserData[playerid][pMute] == 1) return error(playerid, "Tkven gadevt chatis bani");
	if(sscanf(params, "s[64]", params[0])) return formatmsg(playerid, "/s(hout) [Text]");
	UsingAdress(playerid, params[0]);
	new mestr[500];
	format(mestr, sizeof(mestr), "%s yviris: %s!",Name(playerid), params[0]);
	ProxDetector(40.0, playerid, mestr, -1);
	return true;
}
CMD:b(playerid, params[]) {
	if(Login[playerid] == false) return true;
   	if(UserData[playerid][pMute] == 1) return error(playerid, "Tkven gadevt chatis bani");
	if(sscanf(params, "s[64]", params[0])) return formatmsg(playerid, "/do [Text]");
	UsingAdress(playerid, params[0]);
	new mestr[500];
	format(mestr, sizeof(mestr), "%s (( %s ))", Name(playerid), params[0]);
	ProxDetector(20.0, playerid, mestr, -1);
	return true;
}
CMD:megaphone(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(!IsInGoverement(playerid)) return true;
	if(GetPlayerVehicleID(playerid) == INVALID_VEHICLE_ID) return true;
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return true;
	if(sscanf(params, "s[64]", params[0])) return formatmsg(playerid, "/megaphone [Text]");
   	if(UserData[playerid][pMute] == 1) return error(playerid, "Tkven gadevt chatis bani");
	UsingAdress(playerid, params[0]);
	new mestr[500];
	format(mestr, sizeof(mestr), "{F1C40F}- %s: [ %s ] [MEGAPHONE]",Name(playerid), params[0]);
	ProxDetector(50.0, playerid, mestr, -1);
	return true;
}
CMD:engine(playerid) {
    if(Login[playerid] == false) return true;
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 481 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 509 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 510) return error(playerid, "Am transports ar gaachnia dzravi");
    if(GetPlayerVehicleID(playerid) == INVALID_VEHICLE_ID) return true;
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return true;
    new car = GetPlayerVehicleID(playerid);
	if(vInfo[car][vEngine] == false) {
		GetVehicleParamsEx(car,engine,carlights,alarm,cardoors,bonnet,boot,objective);
		SetVehicleParamsEx(car,VEHICLE_PARAMS_ON,carlights,alarm,cardoors,bonnet,boot,objective);
		vInfo[car][vEngine] = true;

		new mestr[500];
		format(mestr, sizeof(mestr), "- %s daqoqa manqanis dzravi",Name(playerid));
		ProxDetector(20.0, playerid, mestr, 0x988EFFFF);
	}
	else if(vInfo[car][vEngine] == true) {
		GetVehicleParamsEx(car,engine,carlights,alarm,cardoors,bonnet,boot,objective);
		SetVehicleParamsEx(car,VEHICLE_PARAMS_OFF,carlights,alarm,cardoors,bonnet,boot,objective);
		vInfo[car][vEngine] = false;

		new mestr[500];
		format(mestr, sizeof(mestr), "- %s chaaqro manqanis dzravi",Name(playerid));
		ProxDetector(20.0, playerid, mestr, 0x988EFFFF);
	}
	return true;
}
CMD:carlights(playerid) {
	if(Login[playerid] == false) return true;
    if(GetPlayerVehicleID(playerid) == INVALID_VEHICLE_ID) return true;
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return true;
	if(vInfo[GetPlayerVehicleID(playerid)][vLights] == false) {
		GetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,carlights,alarm,cardoors,bonnet,boot,objective);
		SetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,VEHICLE_PARAMS_ON,alarm,cardoors,bonnet,boot,objective);
		vInfo[GetPlayerVehicleID(playerid)][vLights] = true;

		new mestr[500];
		format(mestr, sizeof(mestr), "- %s charto manqanis shuqebi",Name(playerid));
		ProxDetector(20.0, playerid, mestr, 0x988EFFFF);
	}
	else {
		GetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,carlights,alarm,cardoors,bonnet,boot,objective);
		SetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,VEHICLE_PARAMS_OFF,alarm,cardoors,bonnet,boot,objective);
		vInfo[GetPlayerVehicleID(playerid)][vLights] = false;

		new mestr[500];
		format(mestr, sizeof(mestr), "- %s chaaqro manqanis shuqebi",Name(playerid));
		ProxDetector(20.0, playerid, mestr, 0x988EFFFF);
	}
	return true;
}
CMD:quest(playerid) {
	if(Login[playerid] == false) return true;
	new qtext[12][32];
    if(UserData[playerid][pQuest1] == 0) qtext[0] = "{D49D26}Mimdinareobs{FFFFFF}";
	if(UserData[playerid][pQuest1] > 0) qtext[0] = "{28B83B}Shesrulebulia{FFFFFF}";

	if(UserData[playerid][pQuest2] == 0) qtext[1] = "{D49D26}Mimdinareobs{FFFFFF}";
	if(UserData[playerid][pQuest2] > 0) qtext[1] = "{28B83B}Shesrulebulia{FFFFFF}";

	if(UserData[playerid][pQuest3] == 0) qtext[2] = "{D49D26}Mimdinareobs{FFFFFF}";
	if(UserData[playerid][pQuest3] > 0) qtext[2] = "{28B83B}Shesrulebulia{FFFFFF}";

	new string[500];
	format(string, sizeof(string), "{FFFFFF}Quest Name\t{FFFFFF}Status\t{FFFFFF}Money\
	\n{FFFFFF}Cleaner Job\t[ %s ]\t[ 12000$ ]\
	\n{FFFFFF}Material Job\t[ %s ]\t[ 10000$ ]\
	\n{FFFFFF}Mtvirtavi\t[ %s ]\t[ 20000$ ]"

	,qtext[0], qtext[1], qtext[2]);
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Quest", string, "Cancel", "");
	return true;
}
CMD:capture(playerid, params[]) {
	if(Login[playerid] == false) return true;
	if(!IsAGang(playerid)) return error(playerid, "Tkven ar gaqvt am brdzanebis gamoyenebis ufleba");
  	if(!startcapture) return error(playerid,"Am dros teritoriis dapyroba daushvebelia, daelodet paydays");
  	ShowPlayerDialog(playerid, 9000, DIALOG_STYLE_MSGBOX, "{FFFFFF}Capture",
  	"{FFFFFF}- Tkven iwyebt teritoriis dapyrobas -\
  	\n\n{FFFFFF}Imisatvis, rom chaigdot xelshi teritoria, sachiroa ebrdzolot teritoriis mflobel bandas\
  	\n{FFFFFF}Teritoriisatvis brdzola gagrdzeldeba {F0A45D}- 15 wuti\
  	\n\n{F0A45D}* Tu gsurt daiwyot brdzola daachiret 'Start' gilaks", "Cancel", "Start");
    return true;
}
// ======================== < [ Trash ] >
main() { }
