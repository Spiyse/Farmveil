local config = {}

-- Grid stuff
config.TILE_SIZE = 32
config.RADIUS = 6
config.GRID_WIDTH = config.RADIUS * 2 + 1
config.GRID_HEIGHT = config.RADIUS * 2 + 1
config.GRID_OFFSET_X = 4
config.GRID_OFFSET_Y = 4

config.CENTER_X = math.floor(config.GRID_WIDTH / 2) + 0.5
config.CENTER_Y = math.floor(config.GRID_HEIGHT / 2) + 0.5


config.START_UNLOCK_RADIUS = 2

-- Farm stuff
config.GROW_TIME = 5
config.WATERED_GROWTH_MULTIPLIER = 2


-- UI stuff
config.CURSOR_CLICK_DURATION = 0.1
config.TOOLTIP_PADDING = 6
config.TOOLTIP_OFFSET_X = 12
config.TOOLTIP_OFFSET_Y = 12

-- Tool definitions for rn
config.TOOLS = {
    { id = "hoe", name = "Hoe", key = "1" },
    { id = "seed", name = "Seed", key = "2" },
    { id = "water", name = "Watering Can", key = "3" },
    { id = "hand", name = "Hand", key = "4" }
}

return config