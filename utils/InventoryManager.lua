local InventoryManager = {}

function InventoryManager.dump()
		--Dump inv.
	for i=1,16 do
		turtle.select(i)
		turtle.drop()
	end	
	turtle.select(1)
end

function InventoryManager.hasEmptySlot()
	for i=1,16 do
		turtle.select(i)
		if turtle.getItemCount() == 0 then
			turtle.select(1)
			return true
		end
	end	
	turtle.select(1)
	return false
end

function InventoryManager.selectEmptySlot()
	for i=1,16 do
		turtle.select(i)
		if turtle.getItemCount()== 0 then
			turtle.select(1)
			return i
		end
	end	
	turtle.select(1)
	return -1
end

--[[
If inspected block can fit into the inventory, function returns true with that slot selected
else it returns false with slot 1 selected
--]]
function InventoryManager.canFit()
	for i=1,16 do
		turtle.select(i)
		if turtle.compare() or turtle.getItemCount() == 0 then
			return true
		end
	end
	turtle.select(1)
	return false
end

--[[
If block variable can fit into the inventory, function returns true with that slot selected
else it returns false with slot 1 selected
--]]
function InventoryManager.canFit(block)
	for i=1,16 do
		if (block.name == turtle.getItemDetail(i).name and turtle.getItemSpace(i) > 0) or turtle.getItemCount(i) == 0 then
			return true
		end
	end
	return false
end

return InventoryManager