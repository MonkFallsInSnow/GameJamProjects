var player = argument0;
var playerStack = argument1;
var maxCount = 3;
var weaponCount = 0;
var aCount = 0;
var bCount = 0;
var cCount = 0;
var dCount = 0;
var eCount = 0;
var fCount = 0;
var gCount = 0;

for(var i = 0; i < array_length_1d(playerStack.activeWeapons); i++)
{
    weaponCount++;
    
    switch(playerStack.activeWeapons[--playerStack.top])
    {
        case WEAPON_A:
            aCount++;
            break;
        case WEAPON_B:
            bCount++;
            break;
        case WEAPON_C:
            cCount++;
            break;
        case WEAPON_D:
            dCount++
            break;
        case WEAPON_E:
            eCount++;
            break;
        case WEAPON_F:
            fCount++;
            break;
        case WEAPON_G:
            gCount++
            break;
        default:
            break;
    }
}

//A minor - omni laser
if(aCount == 1 && cCount == 1 && eCount == 1)
{
    var maxLasers = 5;
    var maxSpeed = 5;
    for(var i = 0; i < maxLasers; i++)
    {
        player.shotsFired[i] = instance_create(player.x,player.y,objShotA);
        player.shotsFired[i].direction = i * 46;
        player.shotsFired[i].image_angle = player.shotsFired[i].direction;
        player.shotsFired[i].speed = maxSpeed;
        with(player.nodeA[0])
        {
            player.nodeA[0] = noone;
            instance_destroy();
        }
        with(player.nodeC[0])
        {
            player.nodeC[0] = noone;
            instance_destroy();
        }
        with(player.nodeE[0])
        {
            player.nodeE[0] = noone;
            instance_destroy();
        }
    }
}
//G major - shield
else if(gCount == 1 && bCount == 1 && dCount == 1)
{
    if(player == objPlayer)
    {
        if(!instance_exists(objShield))
        {
            instance_create(player.x,player.y,objShield);
            player.shieldUp = true;
        }
    }
    else
    {
        if(!instance_exists(objShield2))
        {
            instance_create(player.x,player.y,objShield2);
            player.shieldUp = true;
        }
    }
    with(player.nodeG[0])
    {
        player.nodeG[0] = noone;
        instance_destroy();
    }
    with(player.nodeB[0])
    {
        player.nodeB[0] = noone;
        instance_destroy();
    }
    with(player.nodeD[0])
    {
        player.nodeD[0] = noone;
        instance_destroy();
    }
}
//F major - spinning electric wall
else if(fCount == 1 && aCount == 1 && cCount == 1)
{
    instance_create(player.nodeF[0].x,player.nodeF[0].y,objElectricWall);
    instance_create(player.nodeA[0].x,player.nodeA[0].y,objElectricWall);
    instance_create(player.nodeC[0].x,player.nodeC[0].y,objElectricWall);
    
    with(player.nodeF[0])
    {
        player.nodeF[0] = noone;
        instance_destroy();
    }
    with(player.nodeA[0])
    {
        player.nodeA[0] = noone;
        instance_destroy();
    }
    with(player.nodeC[0])
    {
        player.nodeC[0] = noone;
        instance_destroy();
    }
    
}
//E minor - explosions
else if(eCount == 1 && gCount == 1 && bCount == 1)
{
    player.canMove = false;
    player.image_speed = 0;
    instance_create(player.x + 100,player.y,objExplosion)
    instance_create(player.x - 100,player.y,objExplosion)
    instance_create(player.x, player.y + 100,objExplosion)
    instance_create(player.x, player.y - 100,objExplosion)
    
    with(player.nodeE[0])
    {
        player.nodeE[0] = noone;
        instance_destroy();
    }
    with(player.nodeG[0])
    {
        player.nodeG[0] = noone;
        instance_destroy();
    }
    with(player.nodeB[0])
    {
        player.nodeB[0] = noone;
        instance_destroy();
    }
}
//D minor - create decoys
else if(dCount == 1 && fCount == 1 && aCount == 1)
{
    if(player == objPlayer)
    {
        if(objPlayer.decoyCount < 1)
        {
            objPlayer.copies[objPlayer.decoyCount++] = instance_create(objPlayer.x, objPlayer.y, objDecoy);
            instance_create(player.x, player.y,objTeleport);
        }
    }
    else
    {
        if(objPlayer2.decoyCount < 1)
        {
            objPlayer2.copies[objPlayer2.decoyCount++] = instance_create(objPlayer2.x, objPlayer2.y, objDecoy2);;
            instance_create(player.x, player.y,objTeleport2);
        }
    }
    
    with(player.nodeD[0])
    {
        player.nodeD[0] = noone;
        instance_destroy();
    }
    
    with(player.nodeF[0])
    {
        player.nodeF[0] = noone;
        instance_destroy();
    }
    
    with(player.nodeA[0])
    {
        player.nodeA[0] = noone;
        instance_destroy();
    }
}
//C major - increase player speed
else if(cCount == 1 && eCount == 1 && gCount == 1)
{   
    if(player.moveSpeed < player.topSpeed)
    {
        instance_create(player.x,player.y,objSpeedUp);
        player.moveSpeed *= 2;
    }
    
    with(player.nodeC[0])
    {
        player.nodeC[0] = noone;
        instance_destroy();
    }
    with(player.nodeE[0])
    {
        player.nodeE[0] = noone;
        instance_destroy();
    }
    with(player.nodeG[0])
    {
        player.nodeG[0] = noone;
        instance_destroy();
    }
}
//not a valid chord
else if(weaponCount == 3)
{
    for(var i = 0; i < array_length_1d(player.nodeA); i++)
    {
        if(instance_exists(player.nodeA[i]))
        {
            with(player.nodeA[i])
            {
                player.nodeA[i] = noone;
                instance_destroy();
            }
        }
    }
    
    for(var i = 0; i < array_length_1d(player.nodeB); i++)
    {
        if(instance_exists(player.nodeB[i]))
        {
            with(player.nodeB[i])
            {
                player.nodeB[i] = noone;
                instance_destroy();
            }
        }
    }
    
    for(var i = 0; i < array_length_1d(player.nodeC); i++)
    {
        if(instance_exists(player.nodeC[i]))
        {
            with(player.nodeC[i])
            {
                player.nodeC[i] = noone;
                instance_destroy();
            }
        }
    }
    
    for(var i = 0; i < array_length_1d(player.nodeD); i++)
    {
        if(instance_exists(player.nodeD[i]))
        {
            with(player.nodeD[i])
            {
                player.nodeD[i] = noone;
                instance_destroy();
            }
        }
    }
    
    for(var i = 0; i < array_length_1d(player.nodeE); i++)
    {
        if(instance_exists(player.nodeE[i]))
        {
            with(player.nodeE[i])
            {
                player.nodeE[i] = noone;
                instance_destroy();
            }
        }
    }
    
    for(var i = 0; i < array_length_1d(player.nodeF); i++)
    {
        if(instance_exists(player.nodeF[i]))
        {
            with(player.nodeF[i])
            {
                player.nodeF[i] = noone;
                instance_destroy();
            }
        }
    }
    
    for(var i = 0; i < array_length_1d(player.nodeG); i++)
    {
        if(instance_exists(player.nodeG[i]))
        {
            with(player.nodeG[i])
            {
                player.nodeG[i] = noone;
                instance_destroy();
            }
        }
    }
}

player.nodeIndexA = 0;
player.nodeIndexB = 0;
player.nodeIndexC = 0;
player.nodeIndexD = 0;
player.nodeIndexE = 0;
player.nodeIndexF = 0;
player.nodeIndexG = 0;