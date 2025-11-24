local assets = require("src/core/assets")
local audio = require("src/systems/audio")
local farm = require("src/core/farm")
local customCursor = require("src/ui/customCursor")
local hoverOver = require("src/ui/hoverOver")
local input = require("src/systems/input")

function love.load()
    assets.load()
    audio.load()
    farm.load()
    

    hoverOver.init(farm)
    input.init(farm)
    
    hoverOver.load()
    customCursor.load()
end

function love.update(dt)
    farm.update(dt)
    hoverOver.update(dt)
    customCursor.update(dt)
end

function love.draw()
    farm.draw()
    hoverOver.draw()
    customCursor.draw()
end

function love.mousepressed(x, y, button)
    farm.mousepressed(x, y, button)
    customCursor.mousepressed(x, y, button)
end

function love.mousemoved(x, y, dx, dy)
    farm.mousemoved(x, y, dx, dy)
end

function love.keypressed(key)
    input.keypressed(key)
end
