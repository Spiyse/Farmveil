local hoverOver = {}

local config = require("src/config")
local gridUtils = require("src/utils/gridUtils")
local assets = require("src/core/assets")

local farm = nil
local mouseX, mouseY = 0, 0

function hoverOver.init(farmModule)
    farm = farmModule
end

function hoverOver.load()
    
end

function hoverOver.update(dt)
    mouseX, mouseY = love.mouse.getPosition()
end

function hoverOver.draw()
    if not farm then return end

    local i, j = farm.hoverTileX, farm.hoverTileY
    if not (i and j) then return end

    local hx, hy = gridUtils.gridToScreen(i, j)
    local tile = farm.getTile(i, j)
    if not tile then return end

    -- tooltip
    local text
    if tile.state == "ready" then
        text = "Ready"
    elseif tile.state == "planted" then
        local growth = tile.growth or 0
        local remaining = math.max(0, config.GROW_TIME - growth)
        text = string.format("%.1fs", remaining)
    elseif tile.unlocked == false then
        text = "Locked"
    elseif tile.centerTile then
        text = "Center"
    end

    if text then
        local padding = config.TOOLTIP_PADDING
        local font = love.graphics.getFont()
        local w = (font and font:getWidth(text) or 30) + padding * 2
        local h = (font and font:getHeight() or 12) + padding * 2
        local rectX = mouseX + config.TOOLTIP_OFFSET_X
        local rectY = mouseY + config.TOOLTIP_OFFSET_Y

        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle("fill", rectX, rectY, w, h, 4, 4)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print(text, rectX + padding, rectY + padding)
    end

    -- hover outline
    
    if tile.unlocked == true then
        love.graphics.setColor(1, 1, 1, 0.95)
    elseif tile.unlocked == false then
        love.graphics.draw(assets.TileHoverLock, hx, hy)
        love.graphics.setColor(1, 0.2, 0.1, 0.95)
    end
    if assets.TileHoverOutline then
        love.graphics.draw(assets.TileHoverOutline, hx, hy)
    end

end

return hoverOver
