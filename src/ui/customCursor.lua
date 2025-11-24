local CustomCursor = {}

local config = require("src/config")

local cursorNormal, cursorGray, activeCursor
local mouseX, mouseY = 0, 0
local clickTimer = 0

function CustomCursor.load()
    love.mouse.setVisible(false)
    cursorNormal = love.graphics.newImage("assets/cursor.png")
    cursorGray   = love.graphics.newImage("assets/cursor_gray.png")
    activeCursor = cursorNormal
end

function CustomCursor.update(dt)
    mouseX, mouseY = love.mouse.getPosition()
    if clickTimer > 0 then
        clickTimer = clickTimer - dt
        if clickTimer <= 0 then
            clickTimer = 0
            activeCursor = cursorNormal
        end
    end
end

function CustomCursor.draw()
    if activeCursor then
        love.graphics.draw(activeCursor, mouseX, mouseY)
    end
end

function CustomCursor.mousepressed(x, y, button)
    if button ~= 1 then return end
    if cursorGray then activeCursor = cursorGray end
    clickTimer = config.CURSOR_CLICK_DURATION
end

return CustomCursor