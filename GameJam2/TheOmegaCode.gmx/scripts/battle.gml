//arguments include action cost, energy cost, enemy object, player object, ..?
//argument0 = player, argument1 = actionCost, argument2 = targeted enemy object, argument3 = ability used, argument4 = ability animation
//show_message("ap: " + string(argument0.currentActionPoints) + " ep: " + string(argument0.currentEnergyPoints));
var maxChance = 10;
var checkAction = argument0.characterSheet[# headers.COL1,charSheetY.ACTION_POINTS] - argument1;
var enemy = 0;
//var objBattleControl.damageDone = 0;
//var objBattleControl.damageRecieved = 0;
var enemyHp = 0;

objBattleControl.abilityType = argument0.abilities[# argument3,abilityHeaderY.TYPE];
objBattleControl.abilityUsed = true;

objBattleControl.damageRecieved = 0;
objBattleControl.damageDone = 0;
objBattleControl.totalDamage = 0;

if(checkAction >= 0)
{
    objBattleControl.noAp = false;
    //reduce action points
    argument0.characterSheet[# headers.COL1,charSheetY.ACTION_POINTS] = checkAction; 
    
    //check if enemy evaded attack
    if(irandom(maxChance) <= argument2.characterSheet[# headers.COL1,charSheetY.EVASION_CHANCE])
    {
        objBattleControl.evaded = true;
        //show_message(string(argument2.characterSheet[# headers.COL1,charSheetY.NAME]) + " dodged your attack!");
    }
    else //if evasion fails
    {
        objBattleControl.evaded = false;
        //if a basic attack
        if(objBattleControl.abilityType == BASIC)
        {
            instance_create(argument2.x,argument2.y,argument4);
            //check for critical hit
            if(irandom(maxChance) <= argument0.characterSheet[# headers.COL1,charSheetY.CRIT_CHANCE])
            {
                //show_message("Critical hit!");
                objBattleControl.critical = true;
                objBattleControl.damageDone = argument0.abilities[# argument3,abilityHeaderY.DAMAGE] * argument0.tactics;
            }
            else //if crit fails, then do normal damage
            {
                objBattleControl.critical = false;
                objBattleControl.damageDone = argument0.abilities[# argument3,abilityHeaderY.DAMAGE];
            }
            
            //remove health from enemy
            objBattleControl.damageRecieved += objBattleControl.damageDone - argument2.characterSheet[# headers.COL1, charSheetY.ARMOR_RATING];
            if(objBattleControl.damageRecieved <= 0)
            {
                objBattleControl.damageRecieved = 1;
            }
            //show_message("You hit " + string(argument2.characterSheet[# headers.COL1,charSheetY.NAME] + " for " + string(objBattleControl.damageDone)));
            
            if(objBattleControl.damageRecieved >= argument2.characterSheet[# headers.COL1,charSheetY.HP])
            {
                argument2.characterSheet[# headers.COL1,charSheetY.ALIVE] = false;
                argument2.enemyId = argument2.id;
            }
            else
            {
                enemyHp = argument2.characterSheet[# headers.COL1,charSheetY.HP] 
                enemyHp -= objBattleControl.damageRecieved;
                argument2.characterSheet[# headers.COL1,charSheetY.HP] = enemyHp;
            }
        }
        //if ability IS an AOE attack
        else if(objBattleControl.abilityType == AOE)
        {
            
            objBattleControl.damageDone = argument0.abilities[# argument3,abilityHeaderY.DAMAGE];
            for(var i = 0; i < instance_number(objEnemy); i++)
            {
                enemy = instance_find(objEnemy,i);
                instance_create(enemy.x,enemy.y,argument4);
                
                //remove health from all enemies
                objBattleControl.damageRecieved = objBattleControl.damageDone - enemy.characterSheet[# headers.COL1, charSheetY.ARMOR_RATING];
                
                if(objBattleControl.damageRecieved <= 0)
                {
                    objBattleControl.damageRecieved = 1;
                }
                //show_message("You hit " + string(enemy.characterSheet[# headers.COL1,charSheetY.NAME] + " for " + string(objBattleControl.damageRecieved)));
                
                if(objBattleControl.damageRecieved >= enemy.characterSheet[# headers.COL1,charSheetY.HP])
                {
                    enemy.characterSheet[# headers.COL1,charSheetY.ALIVE] = false;
                    enemy.enemyId = enemy.id;
                }
                else
                {
                    enemyHp = enemy.characterSheet[# headers.COL1,charSheetY.HP];
                    enemyHp -= objBattleControl.damageRecieved;
                    enemy.characterSheet[# headers.COL1,charSheetY.HP] = enemyHp;
                }
                
                //for battle dialogue draw
                objBattleControl.totalDamage += objBattleControl.damageRecieved;
            }
        }
        else if(objBattleControl.abilityType == INST_KILL)
        {
            if(objBattleControl.miss)
            {
                //show_message("You missed.");
                //objBattleControl.miss = false;
            }
            else
            {
                instance_create(argument2.x,argument2.y,argument4);
                argument2.characterSheet[# headers.COL1,charSheetY.ALIVE] = false;
            }
        }
        else if(objBattleControl.abilityType == ADV)
        {
            instance_create(argument2.x,argument2.y,argument4);
            objBattleControl.damageDone = argument0.abilities[# argument3,abilityHeaderY.DAMAGE];
            
            if(objBattleControl.reverseEffect)
            {
                //show_message(string(argument0.abilities[# argument3,abilityHeaderY.NAME]) + " backfired!");
                
                objBattleControl.damageDone = argument0.abilities[# argument3,abilityHeaderY.DAMAGE];
                var ap = argument0.characterSheet[# headers.COL1,charSheetY.ACTION_POINTS]; 
                ap -= objBattleControl.damageDone;
                argument0.characterSheet[# headers.COL1,charSheetY.ACTION_POINTS] = ap;
                
                //show_message("You lost " + string(objBattleControl.damageDone) + " action points");
                //objBattleControl.reverseEffect = false;
            }
            else
            {
                //remove health from enemy
                objBattleControl.damageRecieved = objBattleControl.damageDone - argument2.characterSheet[# headers.COL1, charSheetY.ARMOR_RATING];
                
                //add ap to player's current amount
                var addPoints = argument0.characterSheet[# headers.COL1,charSheetY.ACTION_POINTS]; 
                addPoints += objBattleControl.damageRecieved;
                
                if(addPoints > argument0.totalActionPoints)
                {
                    argument0.characterSheet[# headers.COL1,charSheetY.ACTION_POINTS] = argument0.totalActionPoints;
                }
                else
                {
                    argument0.characterSheet[# headers.COL1,charSheetY.ACTION_POINTS] = addPoints;
                }
                
                if(objBattleControl.damageRecieved <= 0)
                {
                    objBattleControl.damageRecieved = 1;
                }
                //show_message("You hit " + string(argument2.characterSheet[# headers.COL1,charSheetY.NAME] + " for " + string(objBattleControl.damageDone)));
                
                if(objBattleControl.damageRecieved >= argument2.characterSheet[# headers.COL1,charSheetY.HP])
                {
                    argument2.characterSheet[# headers.COL1,charSheetY.ALIVE] = false;
                    argument2.enemyId = argument2.id;
                }
                else
                {
                    enemyHp = argument2.characterSheet[# headers.COL1,charSheetY.HP] 
                    enemyHp -= objBattleControl.damageRecieved;
                    argument2.characterSheet[# headers.COL1,charSheetY.HP] = enemyHp;
                }
            }
        }
        else if(objBattleControl.abilityType == HEAL)
        {   
            instance_create(argument2.x,argument2.y,argument4);
            //show_message("You harvested some useful parts.");
            var hp = argument0.characterSheet[# headers.COL1,charSheetY.HP]; 
            hp += argument0.abilities[# headers.COL4,abilityHeaderY.DAMAGE];
            if(hp >= argument0.totalHitPoints)
            {
                argument0.characterSheet[# headers.COL1,charSheetY.HP] = totalHitPoints;
            }
            else
            {
                 argument0.characterSheet[# headers.COL1,charSheetY.HP] = hp;
            }
            //show_message(string(argument0.abilities[# headers.COL4,abilityHeaderY.DAMAGE]) + " points healed.");
        }
    }
} 
else
{
    objBattleControl.noAp = true;
    objBattleControl.abilityUsed = false;
    //show_message("Not enough action points!");
}

argument2.image_index = 0;
objBattleControl.target = noone;
objBattleControl.button = noone;