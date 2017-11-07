-- Class to manage movements of a Mining turtle in ComputerCraft
-- Written by Joseph Chouinard - Aug 8, 2017

local MovementManager = {}

local X = 0 --Increases Right
local Y = 0 --Increases Forward
local Z = 0 --Increases Up

function MovementManager.moveDown(num, mine)
	local spacesMoved = 0
    for i=1,num do
        if turtle.down() then
            Z = Z - 1
            spacesMoved = spacesMoved + 1
        elseif mine then
            turtle.digDown()
            if turtle.down() then
                Z = Z - 1
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
            Z = Z + 1
            spacesMoved = spacesMoved + 1
        elseif mine then
        	turtle.digUp()
        	if turtle.up() then
            	Z = Z + 1
            	spacesMoved = spacesMoved + 1
            end
        end
    end
    return spacesMoved
end

function MovementManager.moveRight(num, mine)
	local spacesMoved = 0
	turtle.turnRight()
    for i=1,num do
        if turtle.forward() then
            X = X + 1
            spacesMoved = spacesMoved + 1
        elseif mine then
        	turtle.dig()
        	if turtle.forward() then
            	X = X + 1
            	spacesMoved = spacesMoved + 1
            end
        end
    end
    turtle.turnLeft()
    return spacesMoved
end

function MovementManager.moveLeft(num, mine)
	local spacesMoved = 0
	turtle.turnLeft()
    for i=1,num do
        if turtle.forward() then
            X = X - 1
            spacesMoved = spacesMoved + 1
        elseif mine then
        	turtle.dig()
        	if turtle.forward() then
            	X = X - 1
            	spacesMoved = spacesMoved + 1
            end
        end
    end
    turtle.turnRight()
    return spacesMoved
end

function MovementManager.moveForward(num, mine)
	local spacesMoved = 0
    for i=1,num do
        if turtle.forward() then
            Y = Y + 1
            spacesMoved = spacesMoved + 1
        elseif mine then
        	turtle.dig()
        	if turtle.forward() then
            	Y = Y + 1
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
		turtle.turnRight()
		turtle.turnRight()
	end
	
    for i=1,num do
        if not mine and turtle.back() then
            Y = Y - 1
            spacesMoved = spacesMoved + 1
        elseif mine then
        	turtle.dig()
        	if turtle.forward() then
            	Y = Y - 1
            	spacesMoved = spacesMoved + 1
            end
        end
    end
    
    --reorient
    if mine then
		turtle.turnRight()
		turtle.turnRight()
	end
    
    return spacesMoved
end

function MovementManager.moveTo(sx, sy, sz, str, mine)
	for i = 1, #str do
		local c = str:sub(i,i)
		if c == 'x' or c == 'X' then
			local dx = sx - X
			if dx < 0 then
				MovementManager.moveLeft(math.abs(dx), mine)
			else
				MovementManager.moveRight(math.abs(dx), mine)
			end
		elseif c == 'y' or c == 'Y' then
			local dy = sy - Y
			if dy < 0 then
				MovementManager.moveBack(math.abs(dy), mine)
			else
				MovementManager.moveForward(math.abs(dy), mine)
			end
		elseif c == 'z' or c == 'Z' then
			local dz = sz - Z
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

function MovementManager.getX()
	return X
end

function MovementManager.getY()
	return Y
end

function MovementManager.getZ()
	return Z
end
-------------------------------------

function MovementManager.printLocation()
    print("[" .. os.getComputerLabel() .. "]" .. " Location:")
    print("Location: (X:" .. X .. ", Y:" .. Y .. ", Z:" .. Z .. ")")
end

return MovementManager
