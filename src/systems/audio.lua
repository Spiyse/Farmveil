local audio = {}

local sounds = {}

function audio.load()
    audio.loadSound("hoeDirt", "assets/audio/sfx/hoe_dirt.wav")
    audio.loadSound("plantSeeds", "assets/audio/sfx/plant_seed.wav")
    audio.loadSound("pickup", "assets/audio/sfx/pickup_wheat.wav")
end

function audio.loadSound(id, path)
    if love.filesystem.getInfo(path) then
        sounds[id] = love.audio.newSource(path, "static")
    end
end

function audio.play(id)
    if sounds[id] then
        sounds[id]:stop()
        sounds[id]:play()
    end
end

function audio.stop(id)
    if sounds[id] then
        sounds[id]:stop()
    end
end

return audio
