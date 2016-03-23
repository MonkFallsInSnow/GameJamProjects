//argument0 = current enemy, argument1 = player
var xpos = 512;
var ypos = 608;
var percentage = 100;

var playerHealth = argument1.characterSheet[# headers.COL1,charSheetY.HP];
var enemyHealth = argument0.characterSheet[# headers.COL1,charSheetY.HP];
var healthLeft = 0;
var chanceToHeal = 0;

if(argument0.priority == CAUSE_DAMAGE)
{
    healthLeft = (25 * argument0.totalHitPoints) / 100;
    
    //if enemy has 25 percent or less health then try to heal, otherwise attack
    if(enemyHealth <= healthLeft)
    {
        chanceToHeal = irandom(percentage);
        if(chanceToHeal <= 25)
        {
            instance_create(argument0.x,argument0.y - 110,objHeal);
            
            if(objBattleControl.playSound)
            {
                audio_play_sound(sndEnemyHeal,0.5,false);
            }
            
            argument0.characterSheet[# headers.COL1,charSheetY.HP] += argument0.totalHitPoints / 3;
        }
        else
        {
            //display battle animation
            instance_create(xpos,ypos,objEnemyAttack);
            
            if(objBattleControl.playSound)
            {
                audio_play_sound(sndEnemyAttack,0.5,false);
            }
            
            //calculate damage
            damageOutput = argument0.characterSheet[# headers.COL1, charSheetY.ATTACK_POWER] * (irandom(argument0.characterSheet[# headers.COL1,charSheetY.TACTICS]) + 1)
            argument0.abilities[# headers.COL1, abilityHeaderY.DAMAGE] = damageOutput;
                
            //assign damage 
            playerHealth -= damageOutput;
            argument1.characterSheet[# headers.COL1,charSheetY.HP] = playerHealth;
        }
    }
    else
    {
        //display battle animation
        instance_create(xpos,ypos,objEnemyAttack);
        
        if(objBattleControl.playSound)
        {
            audio_play_sound(sndEnemyAttack,0.5,false);
        }
          
        //calculate damage
        damageOutput = argument0.characterSheet[# headers.COL1, charSheetY.ATTACK_POWER] * (irandom(argument0.characterSheet[# headers.COL1,charSheetY.TACTICS]) + 1)
        argument0.abilities[# headers.COL1, abilityHeaderY.DAMAGE] = damageOutput;
            
        //assign damage 
        playerHealth -= damageOutput;
        argument1.characterSheet[# headers.COL1,charSheetY.HP] = playerHealth;
    }   
}
else if(argument0.priority == SURVIVAL)
{
    healthLeft = (50 * argument0.totalHitPoints) / 100;
    
    //if enemy has 25 percent or less health then try to heal, otherwise attack
    if(enemyHealth <= healthLeft)
    {
        chanceToHeal = irandom(percentage);
        if(chanceToHeal <= 50)
        {
            instance_create(argument0.x,argument0.y - 110,objHeal);
            
            if(objBattleControl.playSound)
            {
                audio_play_sound(sndEnemyHeal,0.5,false);
            }
            
            argument0.characterSheet[# headers.COL1,charSheetY.HP] += argument0.totalHitPoints / 3;
        }
        else
        {
            //display battle animation
            instance_create(xpos,ypos,objEnemyAttack);
            
            if(objBattleControl.playSound)
            {
                audio_play_sound(sndEnemyAttack,0.5,false);
            }
            
            //calculate damage
            damageOutput = argument0.characterSheet[# headers.COL1, charSheetY.ATTACK_POWER] * (irandom(argument0.characterSheet[# headers.COL1,charSheetY.TACTICS]) + 1)
            argument0.abilities[# headers.COL1, abilityHeaderY.DAMAGE] = damageOutput;
                
            //assign damage 
            playerHealth -= damageOutput;
            argument1.characterSheet[# headers.COL1,charSheetY.HP] = playerHealth;
        }
    }
    else
    {
        //display battle animation
        instance_create(xpos,ypos,objEnemyAttack);
        
        if(objBattleControl.playSound)
        {
            audio_play_sound(sndEnemyAttack,0.5,false);
        }
           
        //calculate damage
        damageOutput = argument0.characterSheet[# headers.COL1, charSheetY.ATTACK_POWER] * (irandom(argument0.characterSheet[# headers.COL1,charSheetY.TACTICS]) + 1)
        argument0.abilities[# headers.COL1, abilityHeaderY.DAMAGE] = damageOutput;
            
        //assign damage 
        playerHealth -= damageOutput;
        argument1.characterSheet[# headers.COL1,charSheetY.HP] = playerHealth;
    }
}