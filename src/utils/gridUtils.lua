local gridUtils = {}

local config = require("src/config")


function gridUtils.isInside(i, j)
    if not i or not j then return false end
    local dx = i - config.CENTER_X
    local dy = j - config.CENTER_Y
    return (dx * dx + dy * dy) <= (config.RADIUS * config.RADIUS)
end


function gridUtils.screenToGrid(x, y)
    local px = x - config.GRID_OFFSET_X
    local py = y - config.GRID_OFFSET_Y
    
    if px < 0 or py < 0 then
        return nil, nil
    end
    
    local i = math.floor(px / config.TILE_SIZE) + 1
    local j = math.floor(py / config.TILE_SIZE) + 1
    
    if i < 1 or i > config.GRID_WIDTH or j < 1 or j > config.GRID_HEIGHT then
        return nil, nil
    end

    if not gridUtils.isInside(i, j) then
        return nil, nil
    end
    
    return i, j
end


function gridUtils.gridToScreen(i, j)
    local x = config.GRID_OFFSET_X + (i - 1) * config.TILE_SIZE
    local y = config.GRID_OFFSET_Y + (j - 1) * config.TILE_SIZE
    return x, y
end


function gridUtils.isValidTile(i, j)
    if not i or not j then return false end
    if i < 1 or i > config.GRID_WIDTH or j < 1 or j > config.GRID_HEIGHT then
        return false
    end
    return gridUtils.isInside(i, j)
end

return gridUtils