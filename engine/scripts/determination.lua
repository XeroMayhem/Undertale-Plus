local dt = {}

function dt:save()
    local filename = "saves/" ..Plus.loaded_mod ..".json"
    local file = love.filesystem.newFile(filename)
    file:open("w")
    
    if not file then return nil else
        local data = {}
        --player
        data.x = player.collider:getX()
        data.y = player.collider:getY()
        data.hp = player.hp
        data.hpmax = player.hpmax
        data.love = player.love
        data.name = player.name
        data.gold = player.gold
        data.exp = player.exp
        data.weapon = player.weapon.id
        data.armor = player.armor.id

        data.time = game_time

        data.has_cell = overworld_menu.has_cell

        --world
        data.room = room
        data.area_killed = area_killed

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
    local filename = "saves/" ..Plus.loaded_mod ..".json"

    if not love.filesystem.getInfo(filename) then return nil else
        local save_data = json.decode(love.filesystem.read(filename))
        
        room = save_data.room
        area_killed = save_data.area_killed
        reset_world()
        require('engine/scripts/transition'):transition(nil, room)

        player:setPosition(save_data.x, save_data.y)
        player.hp = save_data.hp
        player.hpmax = save_data.hpmax
        player.name = save_data.name
        player.love = save_data.love
        player.gold = save_data.gold
        player.exp = save_data.exp
        inventory:setWeapon(save_data.weapon)
        inventory:setArmor(save_data.armor)
        player.gold = save_data.gold
        game_time = save_data.time

        overworld_menu.has_cell = save_data.has_cell

        for i = 1, #save_data.flag do
            flag[i] = save_data.flag[i]
        end

        --Inventory
        inventory:create()
        for i, item in pairs(save_data.inventory) do
            inventory:addItem(item)
        end

    end

end

return dt