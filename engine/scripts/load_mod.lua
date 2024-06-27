local dt = {}

function dt:load()
    local open = io.open
    local file = open("config.json", "rb")
    if not file then return nil end
    local jsonString = file:read "*a"
    file:close()

    game_data = love.filesystem.load('data.lua')()
    mod_loaded = 'mods/'.. game_data["mod_dir"]..'/'

    local open = io.open
    local file = open(mod_loaded .."config.json", "rb")
    if not file then return nil end
    local jsonString = file:read "*a"
    file:close()

    mod_data = json.decode(jsonString)   

end

return dt