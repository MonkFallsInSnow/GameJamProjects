player = argument0;
weaponType = argument1;

switch(weaponType)
{
    case WEAPON_A:
        player.nodeA[player.nodeIndexA++] = instance_create(player.x,player.y,objWeaponA);
        break;
    case WEAPON_B:
        player.nodeB[player.nodeIndexB++] = instance_create(player.x,player.y,objWeaponB);
        break;
    case WEAPON_C:
        player.nodeC[player.nodeIndexC++] = instance_create(player.x,player.y,objWeaponC);
        break;
    case WEAPON_D:
        player.nodeD[player.nodeIndexD++] = instance_create(player.x,player.y,objWeaponD);
        break;
    case WEAPON_E:
        player.nodeE[player.nodeIndexE++] = instance_create(player.x,player.y,objWeaponE);
        break;
    case WEAPON_F:
        player.nodeF[player.nodeIndexF++] = instance_create(player.x,player.y,objWeaponF);
        break;
    case WEAPON_G:
        player.nodeG[player.nodeIndexG++] = instance_create(player.x,player.y,objWeaponG);
        break;
    default:
        break;
}