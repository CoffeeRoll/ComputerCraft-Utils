--Gets command line args
args = {...}	

local move = require("utils.MovementManager")
local trash = require("utils.TrashManager")
local inventory = require("utils.InventoryManager")

function digLayer(width, height, checkInv)
    local num = move.moveDown(1, true)
    
    if num == 1 then
        inspectWalls(width, height)
        if checkInv then
        	checkInventory()
        end
        return true
    else
    	return false
    end
end

function inspectWalls(width, height)
    for i=0,3 do
        move.turnRight()
        success, data = turtle.inspect()
        if success and blockIsWithinBounds(width, height) then
            if not trash.isTrash(data.name) then
                print("Mining...")
                turtle.dig()
            end
        end
    end
end

function pillarDown(width, height, checkInv, maxDepth)
	local pillaring = true
    local depth = 0;
    
    while pillaring do
        pillaring = digLayer(width, height, checkInv)
        depth = depth + 1
        
        if maxDepth ~= nil and depth >= maxDepth then
            pillaring = false
        end
    end
    
    --Reset Z Pos
    move.moveTo(move.getX(), move.getY(), 0, "zyx", true)
end

function checkInventory()
	--Store current robot location
	local tempX = move.getX()
	local tempY = move.getY()
	local tempZ = move.getZ()

	if not inventory.hasEmptySlot() then
		emptyInventory(tempX, tempY, tempZ)
	end
end

function emptyInventory(tempX, tempY, tempZ)
    move.moveTo(0,0,0, "zyx", true) --Move back to origin by zeroing Z-Y-X in that order

    move.turnRight(2) --Turn around
    inventory.dump()

    move.turnRight(2)
    move.moveTo(tempX, tempY, tempZ, "xyz", true)
end

function blockIsWithinBounds(width, height)
    local xPosOfFacingBlock = move.getX() + move.getOrientation().x
    local yPosOfFacingBlock = move.getY() + move.getOrientation().y
    
    if xPosOfFacingBlock < 0 or xPosOfFacingBlock > width then
        return false
    end
    if yPosOfFacingBlock < 0 or yPosOfFacingBlock > height then
        return false
    end
    
    return true;
end

function quarry(width, height, maxDepth)
	local xPos = {2,4,1,3,0} -- x positions of the first block to mine in each row

	for dx=0,width do
    	for dy=0,height do
       		pillarDown(width, height, true, maxDepth)
        	if move.getY() + 5 > height then
            	local num = move.getY() - xPos[(move.getX()%5) + 1]
            	move.moveBack(num, true)
            	break
        	else
        		move.moveForward(5, true)
    	    end
    	end
        if move.getX() < width then
           move.moveRight(1,true)
        end
	end
end

function main()
    --Sets ignore file
    trash.setTrashData("quarryIgnore")
    
    -- -1 to prevent mining area outside of desired
    quarry(tonumber(args[1] - 1), tonumber(args[2] - 1), tonumber(args[3]))
    
    --Resets position back to start
    move.moveTo(0, 0, 0, "zyx", false)
    emptyInventory(0, 0, 0)
end

main()
