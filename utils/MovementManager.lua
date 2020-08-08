-- Class to manage movements of a Mining turtle in ComputerCraft
-- Written by Joseph Chouinard - Aug 8, 2017

local MovementManager = {}

local position = {}
position.x = 0 --Increases Right
position.y = 0 --Increases Forward
position.z = 0 --Increases Up

local orientation = {}
orientation.x = 0
orientation.y = 1

function MovementManager.moveDown(num, mine)
	local spacesMoved = 0
    for i=1,num do
        if turtle.down() then
            position.z = position.z - 1
            spacesMoved = spacesMoved + 1
        elseif mine then
            turtle.digDown()
            if turtle.down() then
                position.z = position.z - 1
                spacesMoved = spacesMoved + 1
            end
        end
    end
    return spacesMoved
end

function MovementManager.moveUp(num, mine)
	local spacesMoved = 0
    for i=1,num do
        if turtle.up() then
            position.z = position.z + 1
            spacesMoved = spacesMoved + 1
        elseif mine then
        	turtle.digUp()
        	if turtle.up() then
            	position.z = position.z + 1
            	spacesMoved = spacesMoved + 1
            end
        end
    end
    return spacesMoved
end

function MovementManager.moveRight(num, mine)
	local spacesMoved = 0
    if num > 0 then
        MovementManager.turnRight()
        MovementManager.moveForward(num, mine)
        MovementManager.turnLeft()
    end
    return spacesMoved
end

function MovementManager.moveLeft(num, mine)
	local spacesMoved = 0
    if num > 0 then
        MovementManager.turnLeft()
        MovementManager.moveForward(num, mine)
        MovementManager.turnRight()
    end
    return spacesMoved
end

function MovementManager.moveForward(num, mine)
	local spacesMoved = 0
    print("moveForward - " .. num)
    for i=1,num do
        if turtle.forward() then
            position.x = position.x + orientation.x
            position.y = position.y + orientation.y
            spacesMoved = spacesMoved + 1
        elseif mine then
        	turtle.dig()
        	if turtle.forward() then
            	position.x = position.x + orientation.x
                position.y = position.y + orientation.y
            	spacesMoved = spacesMoved + 1
            end
        end
    end
    return spacesMoved
end

function MovementManager.moveBack(num, mine)
	local spacesMoved = 0
	
	--turn around so force dig can work
	if mine then
		MovementManager.turnRight(2)
	end
	
    for i=1,num do
        MovementManager.printLocation()
        if not mine and turtle.back() then
            position.x = position.x - orientation.x
            position.y = position.y - orientation.y
            spacesMoved = spacesMoved + 1
        elseif mine then
        	turtle.dig()
        	if turtle.forward() then
            	position.x = position.x + orientation.x
                position.y = position.y + orientation.y
            	spacesMoved = spacesMoved + 1
            end
        end
    end
    
    --reorient
    if mine then
		MovementManager.turnRight(2)
	end
    
    return spacesMoved
end

function MovementManager.moveTo(sx, sy, sz, str, mine)
	for i = 1, #str do
		local c = str:sub(i,i)
		if c == 'x' or c == 'X' then
			local dx = sx - position.x
            print("dx - " .. dx)
			if dx < 0 then
				MovementManager.moveLeft(math.abs(dx), mine)
			else
				MovementManager.moveRight(math.abs(dx), mine)
			end
		elseif c == 'y' or c == 'Y' then
			local dy = sy - position.y
            print("dy - " .. dy)
			if dy < 0 then
				MovementManager.moveBack(math.abs(dy), mine)
			else
				MovementManager.moveForward(math.abs(dy), mine)
			end
		elseif c == 'z' or c == 'Z' then
			local dz = sz - position.z
            print("dz - " .. dz)
			if dz < 0 then
				MovementManager.moveDown(math.abs(dz), mine)
			else
				MovementManager.moveUp(math.abs(dz), mine)
			end
		else
			print("Invalid Direction Specified! No such direction: " .. c)
		end
	end
end

function MovementManager.turnRight(num)
    if num == nil then
        num = 1
    end
    
    for i=1,num do
        turtle.turnRight()
        MovementManager.updateOrientation(1)
    end
end

function MovementManager.turnLeft(num)
    if num == nil then
        num = 1
    end
    
    for i=1,num do
        turtle.turnLeft()
        MovementManager.updateOrientation(3)
    end
end

function MovementManager.updateOrientation(rightTurnCount)
    for turn=1,rightTurnCount do
        if orientation.x == 1 then
            orientation.x = 0
            orientation.y = -1
        elseif orientation.x == -1 then
            orientation.x = 0
            orientation.y = 1
        elseif orientation.y == 1 then
            orientation.x = 1
            orientation.y = 0
        elseif orientation.y == -1 then
            orientation.x = -1
            orientation.y = 0
        end
    end
end

function MovementManager.getX()
	return position.x
end

function MovementManager.getY()
	return position.y
end

function MovementManager.getZ()
	return position.z
end

function MovementManager.getOrientation()
    return orientation
end

-------------------------------------

function MovementManager.printLocation()
    print("[" .. os.getComputerLabel() .. "]")
    print("Location: (X:" .. position.x .. ", Y:" .. position.y .. ", Z:" .. position.z .. ")")
    print("Orientation: (X:" .. orientation.x .. ", Y:" .. orientation.y .. ")")
end

return MovementManager
