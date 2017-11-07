-- Class to manage movements of a turtle in ComputerCraft
-- Written by Joseph Chouinard - Aug 8, 2017

local movement = {}

local X = 0 --Increases Right
local Y = 0 --Increases Forward
local Z = 0 --Increases Up

function movement.move_down(num)
    for i=1,num do
        if turtle.down() then
            Z = Z - 1
        end
    end
end

function movement.move_up(num)
    for i=1,num do
        if turtle.up() then
            Z = Z + 1
        end
    end
end

function movement.move_right(num)
	turtle.turnRight()
    for i=1,num do
        if turtle.forward() then
            X = X + 1
        end
    end
    turtle.turnLeft()
end

function movement.move_left(num)
	turtle.turnLeft()
    for i=1,num do
        if turtle.forward() then
            X = X - 1
        end
    end
    turtle.turnRight()
end

function movement.move_forward(num)
    for i=1,num do
        if turtle.forward() then
            Y = Y + 1
        end
    end
end

function movement.move_back(num)
    for i=1,num do
        if turtle.back() then
            Y = Y - 1
        end
    end
end
-------------------------------------

function movement.print_location()
    print("[" .. os.getComputerLabel() .. "]" .. " Location:")
    print("Location: (X:" .. X .. ", Y:" .. Y .. ", Z:" .. Z .. ")")
end


return movement

