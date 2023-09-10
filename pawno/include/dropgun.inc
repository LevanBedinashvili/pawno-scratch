
#if defined dropgun_included
	#endinput
#endif
#define dropgun_included

#if !defined _samp_included
	#error "include 'a_samp' before dropgun"
#endif

#if !defined dg_debug
    #define dg_debug false
#endif

#if !defined dg_max_drop
    #define dg_max_drop 85
#endif

#if !defined dg_color
    #define dg_color 0x648DD6FF
#endif

#if !defined INVALID_GUN_OBJECT
    #define INVALID_GUN_OBJECT 1575
#endif

#if !defined dg_KEY_TAKE_GUN
    #define dg_KEY_TAKE_GUN 1024
#endif

#if !defined DROPGUN_ERROR_1
    #define DROPGUN_ERROR_1 "Am Momentshi Ver Daadgeb Iarags"
#endif

#if !defined DROPGUN_ERROR_2
    #define DROPGUN_ERROR_2 "Axlos Araa Dagdebuli Iaragi"
#endif

#if defined foreach
    new Iterator:DropGuns<dg_max_drop>;
#endif

#define dg_sendmes(%0,%1) SendClientMessage(%0, dg_color,"[DropGun]:{ffffff} "%1)

enum dg_Drop_Gun
{
    bool: dg_status,
    
    dg_player,
    dg_object,
    dg_model,
    dg_ammo,
    Text3D: dg_text
}
new dg_DropGunInfo[dg_max_drop][dg_Drop_Gun];

new dg_GundObjectIDz[200] = 
{
   INVALID_GUN_OBJECT,  331, 333, 334, 335, 336, 337, 338, 339, 341, 321, 322, 323, 324, 325, 326, 342, 343, 344, INVALID_GUN_OBJECT, INVALID_GUN_OBJECT,
   INVALID_GUN_OBJECT, 346, 347, 348, 349, 350, 351, 352, 353, 355, 356, 372, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 1575
};

// callbacks
forward OnPlayerDropGun(playerid, weaponid, ammo, Float:fx, Float:fy, Float:fz);

public OnPlayerDropGun(playerid, weaponid, ammo, Float:fx, Float:fy, Float:fz)
{
    #if dg_debug == true
        printf("[DG_DEBUG]: OnPlayerDropGun(%d, %d, %d, %f, %f, %f)",playerid,weaponid,ammo,fx,fy,fz);
    #endif

    #if defined dg_OnPlayerDropGun
		return dg_OnPlayerDropGun(playerid, weaponid, ammo, Float:fx, Float:fy, Float:fz);
	#else
		return 1;
	#endif
}

// publics
public OnGameModeInit()
{
    #if defined foreach
        #if dg_debug == true
            printf("[DG_DEBUG]: DropGun System Working On Foreach !");
        #endif
    foreach(new i : DropGuns)
    #else
        #if dg_debug == true
            printf("[DG_DEBUG]: DropGun System Working On Defalut Loop ! (if you using foreach, please include it before 'dropgun.inc')");
        #endif
    for(new i = 0; i < dg_max_drop; i ++)
    #endif
    {
        dg_DropGunInfo[i][dg_status] = false;
        dg_DropGunInfo[i][dg_player] = INVALID_PLAYER_ID;
        dg_DropGunInfo[i][dg_object] = INVALID_OBJECT_ID;
        dg_DropGunInfo[i][dg_model] = -1;
        dg_DropGunInfo[i][dg_ammo] = -1;
    }
    #if defined dg_OnGameModeInit
		return dg_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit dg_OnGameModeInit
#if defined dg_OnGameModeInit
	forward dg_OnGameModeInit();
#endif

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == dg_KEY_TAKE_GUN)
    {
        new i = dg_GetNearGun(playerid);
        if(i != -1)
        {
            dg_TakeGun(playerid, i);
        }
    }
    #if defined dg_OnPlayerKeyStateChange
		return dg_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange dg_OnPlayerKeyStateChange
#if defined dg_OnPlayerKeyStateChange
	forward dg_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

// stocks
stock dg_DropGun(playerid, weaponid, ammo)
{
    if((!weaponid) && (!ammo)) return false;
    if(IsPlayerConnected(playerid))
    {
        for(new i = 0; i < dg_max_drop; i ++)
        {
            if(dg_DropGunInfo[i][dg_status]) continue;
            dg_DropGunInfo[i][dg_status] = true;
            dg_DropGunInfo[i][dg_player] = playerid;
            dg_DropGunInfo[i][dg_model] = weaponid;
            dg_DropGunInfo[i][dg_ammo] = ammo;

            new Float:X, Float:Y, Float:Z;
            GetPlayerPos(playerid, X, Y, Z);
            dg_GetXYInFrontOfPlayer(playerid, X, Y, 2.0);

            dg_DropGunInfo[i][dg_text] = Create3DTextLabel("Press: {ffffff}ALT", dg_color, X, Y, Z-0.3, 10.0, 0);

            #if defined _streamer_included
                dg_DropGunInfo[i][dg_object] = CreateDynamicObject(dg_GetWeaponModel(weaponid), X, Y, Z - 0.9, 90, 0, 0);
            #else
                dg_DropGunInfo[i][dg_object] = CreateObject(dg_GetWeaponModel(weaponid), X, Y, Z - 0.9, 90, 0, 0);
            #endif
    
            #if defined foreach
                Iter_Add(DropGuns, i);
            #endif

            SetPlayerAmmo(playerid, weaponid, 0);

            CallLocalFunction("OnPlayerDropGun", "dddfff", playerid, weaponid, ammo, X, Y, Z);
            break;
        }
    }
    return true;
}
stock dg_TakeGun(playerid, dg_id)
{
    if(dg_id == -1) return false;
    
    GivePlayerWeapon(playerid, dg_DropGunInfo[dg_id][dg_model], dg_DropGunInfo[dg_id][dg_ammo]);

    ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_LOOP", 4.1, 0, 0, 0, 0, 0, 0);

    dg_DropGunInfo[dg_id][dg_status] = false;
    dg_DropGunInfo[dg_id][dg_player] = INVALID_PLAYER_ID;
    dg_DropGunInfo[dg_id][dg_model] = -1;
    dg_DropGunInfo[dg_id][dg_ammo] = -1;

    Delete3DTextLabel(dg_DropGunInfo[dg_id][dg_text]);

    #if defined _streamer_included
        DestroyDynamicObject(dg_DropGunInfo[dg_id][dg_object]);
    #else
        DestroyObject(dg_DropGunInfo[dg_id][dg_object]);
    #endif

    #if defined foreach
        Iter_Remove(DropGuns, dg_id);
    #endif
    return true;
}

stock dg_GetWeaponModel(WeaponID)
{
	if (WeaponID < 0 || WeaponID > sizeof(dg_GundObjectIDz))
	{
	    return INVALID_GUN_OBJECT;
	}
	return dg_GundObjectIDz[WeaponID];
}
stock dg_GetNearGun(playerid)
{
    new Float:x, Float:y, Float:z;
	#if defined foreach
    foreach(new i : DropGuns)
    #else
    for(new i = 0; i < dg_max_drop; i ++)
    #endif
	{
		if(!dg_DropGunInfo[i][dg_status]) continue;
        #if defined _streamer_included
            GetDynamicObjectPos(dg_DropGunInfo[i][dg_object], x, y, z);
        #else
            GetObjectPos(dg_DropGunInfo[i][dg_object], x, y, z);
        #endif
		if(IsPlayerInRangeOfPoint(playerid, 3.0, x, y, z)) {
			return i;
		}
	}
	return -1;
}

stock dg_GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
    new Float:a;
    
    GetPlayerPos(playerid, x, y, a);
    GetPlayerFacingAngle(playerid, a);
    
    if (GetPlayerVehicleID(playerid)) {
        GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
    }
    
    x += (distance * floatsin(-a, degrees));
    y += (distance * floatcos(-a, degrees));
}