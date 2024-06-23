local dt = {}

function dt:save()
    local open = io.open
    local file = open(mod_loaded .."save.json", "w")
    if not file then return nil else
        local data = {}
        --player
        data.x = player.collider:getX()
        data.y = player.collider:getY()
        data.hp = player.hp
        data.hpmax = player.hpmax

        --world
        data.room = room

        --inventory
        data.inventory = {}
        for i = 1, #inventory.items do
            table.insert(data.inventory, inventory.items[i].id)
        end

        --flags
        data.flag = {}
        for i = 1, #flag do
            table.insert(data.flag, flag[i])
        end

        file:write(json.encode(data))
    end
    file:close()

end

function dt:load()
    local file = io.open(mod_loaded .."save.json", "r")
    if not file then return nil end
    local jsonString = file:read "*a"
    file:close()
    
    local save_data = json.decode(jsonString)

    room = save_data.room
    reset_world()
    require('engine/scripts/transition'):transition(nil, room)

    player:setPosition(save_data.x, save_data.y)
    player.hp = save_data.hp
    player.hpmax = save_data.hpmax

    for i = 1, #save_data.flag do
        flag[i] = save_data.flag[i]
    end

    --Inventory
    inventory:create()
    for i, item in pairs(save_data.inventory) do
        inventory:addItem(item)
    end

end

return dt