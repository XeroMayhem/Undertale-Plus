Plus = {}

--Plus.Mods = require("src.engine.mods")
Plus.States = {
    mod_hub = "engine/mod_loader",
    game = "engine/game"
}
Plus.LoadedState = nil

function love.load()

    local json = require 'engine.libraries.json'
    local open = io.open
    local file = open("config.json", "rb")
    if not file then return nil end
    local jsonString = file:read "*a"
    file:close()

    local data = json.decode(jsonString)

    if data.mod_hub == false then
        Plus:loadState('game')
    else
        Plus:loadState('mod_hub')
    end

end

function Plus:loadState(state)
    Plus.LoadedState = state
    dofile(Plus.States[Plus.LoadedState] ..'.lua')
end