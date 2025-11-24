local assets = {}

function assets.load()
    assets.grassImage = love.graphics.newImage("assets/sprites/grass_test.png")
    assets.dirtImage  = love.graphics.newImage("assets/sprites/dirt_test.png")
    assets.seedsImage = love.graphics.newImage("assets/sprites/seeds_test.png")
    assets.wheatImage = love.graphics.newImage("assets/sprites/wheat_test.png")

    if love.filesystem.getInfo("assets/audio/sfx/hoe_dirt.wav") then
        assets.hoeDirt = love.audio.newSource("assets/audio/sfx/hoe_dirt.wav", "static")
    end
    if love.filesystem.getInfo("assets/audio/sfx/plant_seed.wav") then
        assets.plantSeeds = love.audio.newSource("assets/audio/sfx/plant_seed.wav", "static")
    end
    if love.filesystem.getInfo("assets/audio/sfx/pickup_wheat.wav") then
        assets.pickup = love.audio.newSource("assets/audio/sfx/pickup_wheat.wav", "static")
    end
    if love.filesystem.getInfo("assets/sprites/hover_tile_outline.png") then
        assets.TileHoverOutline = love.graphics.newImage("assets/sprites/hover_tile_outline.png")
    end
    if love.filesystem.getInfo("assets/sprites/lock.png") then
        assets.TileHoverLock = love.graphics.newImage("assets/sprites/lock.png")
    end
    if love.filesystem.getInfo("assets/sprites/flag.png") then
        assets.flagImage = love.graphics.newImage("assets/sprites/flag.png")
    end
end

return assets