local input = {}

local config = require("src/config")
local farm = nil

function input.init(farmModule)
    farm = farmModule
end

function input.keypressed(key)
    if not farm then return end
    
    for _, tool in ipairs(config.TOOLS) do
        if key == tool.key then
            farm.setTool(tool.id)
            return
        end
    end
end

return input
