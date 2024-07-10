Plus = {}
math.randomseed(os.time())

json = require 'engine.libraries.json'

function defaultValue(value, new_value)
    if value == nil then
        return new_value
    end
    return value
end

function draw_box(x, y, width, height, border)

    border = defaultValue(border, 3 *gameScale)
    
    love.graphics.rectangle("fill", x, y, width, height)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", x +(border), y +(border), (width -(border *2)), (height -(border *2)))
    love.graphics.setColor(255, 255, 255)

end

--Plus.Mods = require("src.engine.mods")
Plus.States = {
    mod_hub = "engine/mod_loader",
    title = "engine/mainmenu",
    game = "engine/game",
    battle = "engine/battle"
}
Plus.LoadedState = nil
game_time = 0
charname = "Chara"

function Plus:reloadState(state)
    
    state = defaultValue(state, Plus.LoadedState)
    local load = function (excluded)
        local saved_vars = {}
        for i = 1, #excluded do
            saved_vars[excluded[i]] = Plus.trueState[excluded[i]]
        end

        package.loaded[Plus.States[state]] = nil
        Plus:loadState(state)

        for i = 1, #excluded do
            Plus.trueState[excluded[i]] = saved_vars[excluded[i]]
        end
    end

    load(Plus.trueState.excluded_vars)
end

function Plus:loadState(state)
    print(state.." loaded!")
    Plus.LoadedState = state
    Plus.trueState = require(Plus.States[Plus.LoadedState])
    Plus.state_last_modified = love.filesystem.getInfo(Plus.States[Plus.LoadedState] ..'.lua').modtime
    Plus.game_last_modified = love.filesystem.getInfo(Plus.States[Plus.LoadedState] ..'.lua').modtime
end

function love.load()

    love.filesystem.createDirectory("mods")
    love.filesystem.createDirectory("saves")

    love.graphics.setDefaultFilter("nearest", "nearest")
    print("main".." loaded!")

    game_data = json.decode(love.filesystem.read('data.json'))
    Plus.loaded_mod = game_data["mod_dir"]
    mod_loaded = 'mods/'.. Plus.loaded_mod..'/'
    mod_data = json.decode(love.filesystem.read(mod_loaded ..'data.json'))

    Plus:loadState(game_data.state)
end


Plus.state_last_modified = 0
Plus.game_last_modified = 0
Plus.lastKey = ''
Plus.keyPress = ''
gameScale = 2

function love.update(dt)
    math.randomseed(os.time())
    if love.filesystem.getInfo(Plus.States[Plus.LoadedState] ..'.lua').modtime ~= Plus.state_last_modified then
        Plus:reloadState()
    end
    Plus.trueState.update(dt)

end

function love.draw()
    Plus.trueState.draw()
    Plus.lastKey = Plus.keyPress
    Plus.keyPress = ''
end

function love.keypressed(key)

    if Plus.lastKey ~= key then
        Plus.keyPress = key
    end
    
end