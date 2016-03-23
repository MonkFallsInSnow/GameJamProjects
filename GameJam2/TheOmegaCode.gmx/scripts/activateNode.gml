//argument0 is the puzzle data grid, argument1 is activated node

var thisNode = false;
var currentCol = 0;

for(var col = 0; col <= ds_grid_width(argument0); col++)
{
    if(argument0[# col,0] == argument1)
    {
        thisNode = true;
        currentCol = col;
        break;
    }
}

if(thisNode)
{
    for(var row = 0; row <= ds_grid_height(argument0); row++)
    {
        if(argument0[# currentCol,row] != 0)
        {
            with(argument0[# currentCol,row])
            {
                if(on == false)
                {
                    on = true;
                }
                else if(on)
                {
                    on = false;
                }
            }
        }
    }
}