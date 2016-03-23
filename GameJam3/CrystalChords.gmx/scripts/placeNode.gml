player = argument0;
currentWeapon = argument1;
playerStack = argument2;

var maxNodes = 3;
var placeDelay = 10;

if(canShoot == true && player.nodeCount <= maxNodes && currentWeapon != noone)
{
    if(!place_meeting(player.x,player.y,objWeapon))
    {
        player.nodeCount++;
        fireWeapon(player,currentWeapon);
        playerStack.activeWeapons[playerStack.top++] = currentWeapon;
        player.canShoot = false;
        player.alarm[0] = placeDelay;
    }
}