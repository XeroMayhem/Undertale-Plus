Plus = {}
math.randomseed(os.time())

json = require 'engine.libraries.json'

function table.shuffle(list)
    for i = #list, 2, -1 do
        local j = math.random(i)
        list[i], list[j] = list[j], list[i]
      end
    return list
end

function defaultValue(value, new_value)
    if value == nil then
        return new_value
    end
    return value
end

function moveObject(id, speed, direction)
    id.x = id.x - (math.cos(direction) * speed)
    id.y = id.y - (math.sin(direction) * speed)
end

function point_direction(x1, y1, x2, y2)
    return math.atan2(y2 - y1, x2 - x1)  -- atan2 returns radians
end

function moveToPoint(id, speed, x, y)
    local direction = point_direction(id.x, id.y, x, y)
    
    if math.abs(id.x - x) <= speed and math.abs(id.y - y) <= speed then
        id.x = x
        id.y = y
    else
        id.x = id.x + (math.cos(direction) * speed)  -- Use + to move towards the target
        id.y = id.y + (math.sin(direction) * speed)
    end
end

function math.clamp(val, min, max) return math.min(math.max(val, min), max) end

function draw_box(x, y, width, height, border)

    border = defaultValue(border, 3 *gameScale)
    
    love.graphics.rectangle("fill", x, y, width, height)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", x +(border), y +(border), (width -(border *2)), (height -(border *2)))
    love.graphics.setColor(255, 255, 255)

end

function localTimer()
    local timer = {}
    function timer.makeTimer(goal, func)
        table.insert(timer, {time = 1, goal = goal, func = func})
    end

    function timer.updateTimers()
        local t_offset = 0
        for t, time in ipairs(timer) do
            
            time.time = time.time +1
            if time.time >= time.goal then
                time.func()
                timer[t].func = nil
                
                table.remove(timer, t -t_offset)
                t_offset = t_offset +1
            end
            
        end
    end
    return timer
end

function load_enemy(name)
    local enemy_list = mod_loaded ..'scripts/battle/enemies/'
    return require(enemy_list .. name)
end

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
    Plus.LoadedState = state
    Plus.trueState = require(Plus.States[Plus.LoadedState])
    Plus.state_last_modified = love.filesystem.getInfo(Plus.States[Plus.LoadedState] ..'.lua').modtime
    Plus.game_last_modified = love.filesystem.getInfo(Plus.States[Plus.LoadedState] ..'.lua').modtime
end

function love.load()

    love.filesystem.createDirectory("mods")
    love.filesystem.createDirectory("saves")

    love.graphics.setDefaultFilter("nearest", "nearest")

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
    math.randomseed(dt)
    if love.filesystem.getInfo(Plus.States[Plus.LoadedState] ..'.lua').modtime ~= Plus.state_last_modified then
        Plus:reloadState()
    end
    Plus.trueState.update(dt)
    if Plus.keyPress == 'f4' then
        love.window.setFullscreen(not love.window.getFullscreen())
    end

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