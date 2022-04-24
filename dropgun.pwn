/*
    drop gun
*/
#include <a_samp>
#include <zcmd>

new TotalDropGun;
new DropGunObject[100];
new DropGunAmmo[100];
new DropGunID[100];
new Text3D:DropGunText[100];

main (){}

CMD:dropgun(playerid, params[])
{  
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    new weapon = GetPlayerWeapon(playerid);
    new ammo = GetPlayerAmmo(playerid);
    if(TotalDropGun > 100) return SendClientMessage(playerid, -1, "{E8217F}[Shecdoma]{ffffff} Am Dros Ver Daagdebt Iarags");
    if(weapon == 0) return SendClientMessage(playerid, -1, "{E8217F}[Shecdoma]{ffffff} Tqven Ar Gaqvt Iaragi");
    new str[256];

    DropGunObject[TotalDropGun] = CreateObject(GetWeaponObjectID(weapon), x, y, z - 0.9, 90, 0, 0);
    DropGunAmmo[TotalDropGun] = ammo;
    DropGunID[TotalDropGun] = weapon;
    format(str, sizeof(str), "{E8217F}%s\nGunID: {ffffff}%d\n{E8217F}Ammo: {ffffff}%d\n\n{E8217F}/pickgun",GetWeaponNames(weapon),weapon,ammo);
    DropGunText[TotalDropGun] = Create3DTextLabel(str, 0xFFFFFF, x - 0.2, y, z, 10.0, GetPlayerVirtualWorld(playerid));

    SetPlayerAmmo(playerid, weapon, 0);

    TotalDropGun ++;
    return true;
}
CMD:pickgun(playerid, params[])
{
    new araperi = 0;
    for(new i = 0; i < sizeof(DropGunObject); i ++)
    {
        new Float:aX, Float:aY, Float:aZ;
        GetObjectPos(DropGunObject[i], aX, aY, aZ);

        if(IsPlayerInRangeOfPoint(playerid, 2.0, aX, aY, aZ))
        {
            DestroyObject(DropGunObject[i]);
            Delete3DTextLabel(DropGunText[i]);
            GivePlayerWeapon(playerid, DropGunID[i], DropGunAmmo[i]);
            araperi ++;
        }
    }
    if(araperi == 0) return SendClientMessage(playerid, -1, "{E8217F}[Shecdoma]{ffffff} Am Adgilas Araferi Ar Gdia");
    else TotalDropGun --;
    return true;
}

stock GetWeaponObjectID(weaponid)
{
	switch(weaponid)
	{
	    case 24: return weaponid = 348;
	    case 31: return weaponid = 356;
	    case 33: return weaponid = 357;
	    case 30: return weaponid = 355;
	    case 29: return weaponid = 353;
	    case 27: return weaponid = 351;
	    case 25: return weaponid = 349;
	    case 34: return weaponid = 358;
	}
	return weaponid;
}
stock GetWeaponNames(weaponid)
{
	new str[100];
	switch(weaponid)
	{
		case 24: format(str, sizeof(str), "Desert Eagle");
		case 31: format(str, sizeof(str), "M4");
		case 33: format(str, sizeof(str), "Rifle");
		case 30: format(str, sizeof(str), "AK - 47");
		case 29: format(str, sizeof(str), "MP 5");
		case 27: format(str, sizeof(str), "Combat Shotgun");
		case 25: format(str, sizeof(str), "Shotgun");
		case 34: format(str, sizeof(str), "Sniper");
	}
	return str;
}
