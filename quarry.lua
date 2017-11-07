--Gets command line args
args = {...}	

local move = require("scripts.movementManager")
local trash = require("scripts.trashManager")

function digLayer(checkInv)
    local num = move.moveDown(1, true)
    --print("digLayer(): " .. num)
    if num == 1 then
        inspectWalls()
        if checkInv then
        	checkInventory()
        end
        return true
    else
    	return false
    end
end

function inspectWalls()
    for i=0,3 do
        turtle.turnRight()
        success, data = turtle.inspect()
        if success then
            if not trash.isTrash(data.name) then
                turtle.dig()
            end
        end
    end
end

function pillarDown(checkInv)
	local pillaring = true
    
    while pillaring do
        pillaring = digLayer(checkInv)
    end
    
    --Reset Z Pos
    move.goto(move.getX(), move.getY(), 0, "zyx", true)
end

function checkInventory()
	local tempX = move.getX()
	local tempY = move.getY()
	local tempZ = move.getZ()
	
	turtle.select(16)
	
	if turtle.getItemCount() > 0 then
		move.goto(0,0,0, "zyx", true)
		
		turtle.turnRight()
		turtle.turnRight()
		
		for i=1,16 do
			turtle.select(i)
			turtle.drop()
		end	
		
		turtle.turnRight()
		turtle.turnRight()	
		move.goto(tempX, tempY, tempZ, "xyz", true)
	end
--Prevent dumping every block
turtle.select(1)
end

function quarry(x, y)
	--Defines movement
	local xPos = {2,4,1,3,0}

	for dx=0,x do
    	for dy=0,y do
         turtle.digDown()
         --	pillarDown(true)
        	if move.getY() + 5 > y then
        		--Sets the distance from the X-Axis given the column
            	local num = move.getY() - xPos[(move.getX()%5) + 1]
            	print("Movement Info " .. num .. " " .. x .. " " .. y)
            	move.moveBack(num, true)
        	    break
      	    else
        		move.moveForward(5, true)
        	end
    	end
    	move.moveRight(1,true)
	end
end

function main()
    --Sets ignore file
    trash.setTrashData("quarryIgnore")
    
    quarry(tonumber(args[1]), tonumber(args[2] -1))
    
    --Resets position back to start
    move.goto(0, 0, 0, "zyx", true)
end

main()
