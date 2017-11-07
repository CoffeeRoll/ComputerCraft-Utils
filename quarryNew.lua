--Gets command line args
args = {...}	

local move = require("utils.MovementManager")
local trash = require("utils.TrashManager")

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
    move.moveTo(move.getX(), move.getY(), 0, "zyx", true)
end

function checkInventory()
	--Store current robot location
	local tempX = move.getX()
	local tempY = move.getY()
	local tempZ = move.getZ()
	
	turtle.select(16) --Select last inv. slot
	
	if turtle.getItemCount() > 0 then
		move.moveTo(0,0,0, "zyx", true) --Move back to origin by zeroing Z-Y-X in that order
		
		turtle.turnRight() --Turn around
		turtle.turnRight()
		
		--Dump inv.
		for i=1,16 do
			turtle.select(i)
			turtle.drop()
		end	
		
		turtle.turnRight()
		turtle.turnRight()	
		move.moveTo(tempX, tempY, tempZ, "xyz", true)
	end
--Prevent dumping every block
turtle.select(1)
end

function quarry(x, y)
	local xPos = {2,4,1,3,0}

	for dx=0,x do
    	for dy=0,y do
       		--pillarDown(true)
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
end

function main()
    --Sets ignore file
    trash.setTrashData("quarryIgnore")
    
    quarry(tonumber(args[1]-1), tonumber(args[2] -1))
    
    --Resets position back to start
    move.moveTo(0, 0, 0, "zyx", true)
end

main()
