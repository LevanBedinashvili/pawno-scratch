

new OWNABLECARS = 0;
new ShowCar[MAX_PLAYERS][MAX_VEHICLES];
new ShowVeh[MAX_PLAYERS];

#define MAX_OWNABLECARS 1000
new OwnableCar[MAX_OWNABLECARS];

enum cInfo {
    cID,
    cModel,
    cOwner[32],
    Float:cSell_X,
	Float:cSell_Y,
	Float:cSell_Z,
	Float:cSell_A,
	Float:cPos_X,
	Float:cPos_Y,
	Float:cPos_Z,
    Float:cPos_A,
    cInterior,
	cVirtualWorld,
	cColor_1,
	cColor_2,
	cSpoiler,
	cHood,
	cSideskirt,
	cNitro,
	cLamps,
	cExhaust,
	cWheels,
	cRoof,
	cHydraulics,
	cBullbar,
	cRearBullbars,
	cFrontSign,
	cFrontBullbars,
	cFrontBumper,
	cRearBumper,
	cVents,
	cPaintJob,
	cLock
};
new CarInfo[MAX_OWNABLECARS][cInfo];

#define NONE_3D_TEXT (Text3D:-1)
new Text3D:CarText[MAX_OWNABLECARS] = {NONE_3D_TEXT, ...};
