player = argument0;
moveDirection = argument1;
movementSprite = argument2;
moveSpeed = argument3;

if(player.canMove == true)
{
    if(moveDirection == UP)
    {
        player.y -= moveSpeed;
        player.image_speed = PLAYER_IMAGE_SPEED;
        player.sprite_index = movementSprite;
    }
    else if(moveDirection == DOWN)
    {
        player.y += moveSpeed;
        player.image_speed = PLAYER_IMAGE_SPEED;
        player.sprite_index = movementSprite;
    }
    else if(moveDirection == LEFT)
    {
        player.x -= moveSpeed;
        player.image_speed = PLAYER_IMAGE_SPEED;
        player.sprite_index = movementSprite;
    }
    else if(moveDirection == RIGHT)
    {
        player.x += moveSpeed;
        player.image_speed = PLAYER_IMAGE_SPEED;
        player.sprite_index = movementSprite;
    }
    else if(moveDirection == IDLE)
    {
        player.image_speed = 0;
        player.image_index = 0;
    }
}