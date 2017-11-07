local TrashManager = {}

local fileLines = {}
local fileSize = 0

function TrashManager.setTrashData(file)
    local file = io.open(file)
    if file then
        local i = 0
        for line in file:lines() do
            fileLines[i] = line
            fileSize = i
            i = i + 1
            -- print("Added: " .. line .. " to blacklist")
        end
    else
        error("File Not Found")
    end
end

function TrashManager.isTrash(block)
    for key, val in pairs(fileLines) do
        --print(key .. " - " .. val)
        if block == val then
            return true
        end
    end
    return false
end

return TrashManager
