args = {...}

local x = tonumber(args[1]-1)
local y = tonumber(args[2]-1)

local move = require("Scripts.movement_mine")

local xPos = {2,4,1,3,0}

for dx=0,x do
    for dy=0,y do
        turtle.digDown()
        if move.getY() + 5 > y then
            local num = move.getY() - xPos[(move.getX()%5) + 1]
            move.moveBack(num, true)
            break
        else
        	move.moveForward(5, true)
        end
    end
    move.moveRight(1,true)
end
