-- Class to manage movements of a Mining turtle in ComputerCraft
-- Written by Joseph Chouinard - Aug 8, 2017

local movement = {}

local X = 0 --Increases Right
local Y = 0 --Increases Forward
local Z = 0 --Increases Up

function movement.moveDown(num, mine)
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

function movement.moveUp(num, mine)
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

function movement.moveRight(num, mine)
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

function movement.moveLeft(num, mine)
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

function movement.moveForward(num, mine)
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

function movement.moveBack(num, mine)
	local spacesMoved = 0
    for i=1,num do
        if turtle.back() then
            Y = Y - 1
            spacesMoved = spacesMoved + 1
        elseif mine then
        	turtle.dig()
        	if turtle.back() then
            	X = X - 1
            	spacesMoved = spacesMoved + 1
            end
        end
    end
    return spacesMoved
end

function movement.getX()
	return X
end

function movement.getY()
	return Y
end

function movement.getZ()
	return Z
end
-------------------------------------

function movement.printLocation()
    print("[" .. os.getComputerLabel() .. "]" .. " Location:")
    print("Location: (X:" .. X .. ", Y:" .. Y .. ", Z:" .. Z .. ")")
end

return movement

