Plus = {}

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
    game = "engine/game"
}
Plus.LoadedState = nil

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

    if state == 'mod_hub' then
        load({"optionSel", "selectMod", "modSel"})
    elseif state == 'game' then
        load({"loaded"})
    end
end

function Plus:loadState(state)
    print(state.." loaded!")
    Plus.LoadedState = state
    Plus.trueState = require(Plus.States[Plus.LoadedState]) --love.filesystem.load(Plus.States[Plus.LoadedState] ..'.lua')()
    Plus.game_last_modified = love.filesystem.getInfo(Plus.States[Plus.LoadedState] ..'.lua').modtime
end

function love.load()

    love.filesystem.createDirectory("mods")
    love.filesystem.createDirectory("saves")

    love.graphics.setDefaultFilter("nearest", "nearest")
    print("main".." loaded!")

    game_data = love.filesystem.load('data.lua')()
    Plus.loaded_mod = game_data["mod_dir"]
    mod_loaded = 'mods/'.. Plus.loaded_mod..'/'
    mod_data = love.filesystem.load(mod_loaded ..'data.lua')()

    if game_data.mod_hub == false then
        Plus:loadState('game')
    else
        Plus:loadState('mod_hub')
    end
end


Plus.game_last_modified = 0

function love.update(dt)
    if love.filesystem.getInfo(Plus.States[Plus.LoadedState] ..'.lua').modtime ~= Plus.game_last_modified then
        Plus:reloadState()
    end
    Plus.trueState.update(dt)
end

function love.draw()
    Plus.trueState.draw()
end