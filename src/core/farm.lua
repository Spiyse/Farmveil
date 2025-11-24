local farm = {}

local config = require("src/config")
local gridUtils = require("src/utils/gridUtils")
local assets = require("src/core/assets")
local audio = require("src/systems/audio")

function farm.load()
    farm.tiles = {}
    for j = 1, config.GRID_HEIGHT do
        farm.tiles[j] = {}
        for i = 1, config.GRID_WIDTH do

            local dx = i - config.CENTER_X
            local dy = j - config.CENTER_Y
            local dist2 = dx * dx + dy * dy
            local unlocked = dist2 <= (config.START_UNLOCK_RADIUS * config.START_UNLOCK_RADIUS)
            local isCenter = (i == config.CENTER_X and j == config.CENTER_Y)


            farm.tiles[j][i] = {
                state = "empty",
                timer = 0,
                crop = nil,
                growth = 0,
                watered = false,
                unlocked = unlocked,
                centerTile = isCenter
            }
        end
    end

    farm.selectedTool = "hoe"
    farm.hoverTileX = nil
    farm.hoverTileY = nil
end

function farm.setTool(toolName)
    farm.selectedTool = toolName
end

function farm.getTile(i, j)
    if not gridUtils.isValidTile(i, j) then
        return nil
    end
    return farm.tiles[j][i]
end

function farm.update(dt)
    for j = 1, config.GRID_HEIGHT do
        for i = 1, config.GRID_WIDTH do
            if not gridUtils.isValidTile(i, j) then goto continue end

            local tile = farm.tiles[j][i]
            if tile.state == "planted" then
                local speed = tile.watered and config.WATERED_GROWTH_MULTIPLIER or 1
                tile.growth = tile.growth + dt * speed
                if tile.growth >= config.GROW_TIME then
                    tile.state = "ready"
                    tile.growth = config.GROW_TIME
                    tile.watered = false
                end
            end

            ::continue::
        end
    end
end

function farm.draw()
    for j = 1, config.GRID_HEIGHT do
        for i = 1, config.GRID_WIDTH do
            if not gridUtils.isValidTile(i, j) then goto continue end

            local tile = farm.tiles[j][i]
            local x, y = gridUtils.gridToScreen(i, j)

            love.graphics.setColor(1, 1, 1)

            if tile.state == "empty" then
                love.graphics.draw(assets.grassImage, x, y)
            elseif tile.state == "hoed" then
                love.graphics.draw(assets.dirtImage, x, y)
            elseif tile.state == "planted" then
                love.graphics.draw(assets.dirtImage, x, y)
                love.graphics.draw(assets.seedsImage, x, y)
            elseif tile.state == "ready" then
                love.graphics.draw(assets.wheatImage, x, y)
            end

            if tile.centerTile then
                love.graphics.draw(assets.flagImage, x, y)
            end

            love.graphics.setColor(0, 0, 0, 0.2)
            love.graphics.rectangle("line", x, y, config.TILE_SIZE, config.TILE_SIZE)

            ::continue::
        end
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Tool { [1] Hoe | [2] Seed | [3] Watering Can | [4] Hand }: " .. tostring(farm.selectedTool), 10, 10)
end

function farm.mousepressed(x, y, button)
    if button ~= 1 then return end

    local i, j = gridUtils.screenToGrid(x, y)
    if not i then return end

    local tile = farm.getTile(i, j)
    if not tile then return end

    if farm.selectedTool == "hoe" then
        farm.useHoe(tile)
    elseif farm.selectedTool == "seed" then
        farm.useSeed(tile)
    elseif farm.selectedTool == "water" then
        farm.useWater(tile)
    elseif farm.selectedTool == "hand" then
        farm.useHand(tile)
    end
end

function farm.mousemoved(x, y, dx, dy)
    local i, j = gridUtils.screenToGrid(x, y)
    farm.hoverTileX = i
    farm.hoverTileY = j
end

-- tool actions (for now here)
function farm.useHoe(tile)
    if tile.state == "empty" and tile.unlocked == true then
        audio.play("hoeDirt")
        tile.state = "hoed"
        tile.crop = nil
        tile.growth = 0
        tile.watered = false
    end
end

function farm.useSeed(tile)
    if tile.state == "hoed" and not tile.crop then
        audio.play("plantSeeds")
        tile.state = "planted"
        tile.crop = "wheat"
        tile.growth = 0
        tile.watered = false
    end
end

function farm.useWater(tile)
    if tile.state == "planted" then
        tile.watered = true
    end
end

function farm.useHand(tile)
    if tile.state == "ready" then
        audio.play("pickup")
        tile.state = "empty"
        tile.crop = nil
        tile.growth = 0
        tile.watered = false
    end
end

return farm