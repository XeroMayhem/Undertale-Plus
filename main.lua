Plus = {}

--Plus.Mods = require("src.engine.mods")
Plus.States = {
    mod_hub = "engine/mod_loader",
    game = "engine/game"
}
Plus.LoadedState = nil

function Plus:loadState(state)
    print(state.." loaded!")
    Plus.LoadedState = state
    love.filesystem.load(Plus.States[Plus.LoadedState] ..'.lua')()
end

function love.load()
    
    love.graphics.setDefaultFilter("nearest", "nearest")
    print("main".." loaded!")

    game_data = love.filesystem.load('data.lua')()
    mod_loaded = 'mods/'.. game_data["mod_dir"]..'/'
    mod_data = love.filesystem.load(mod_loaded ..'data.lua')()

    if game_data.mod_hub == false then
        Plus:loadState('game')
    else
        Plus:loadState('mod_hub')
    end
end