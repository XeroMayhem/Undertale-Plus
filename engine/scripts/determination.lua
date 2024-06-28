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
        data.gold = player.gold
        data.exp = player.exp
        data.weapon = player.weapon.id
        data.armor = player.armor.id

        data.has_cell = overworld_menu.has_cell

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
    print("Saved to ".. filename.." successfully!")
    
    print("----------------   "..Plus.loaded_mod)

end

function dt:load()
    local filename = "saves/" ..Plus.loaded_mod ..".json"

    if not love.filesystem.getInfo(filename) then return nil else
        --file:open("r")
        local save_data = json.decode(love.filesystem.read(filename))
        --file:close()
        
        room = save_data.room
        reset_world()
        require('engine/scripts/transition'):transition(nil, room)

        player:setPosition(save_data.x, save_data.y)
        player.hp = save_data.hp
        player.hpmax = save_data.hpmax
        player.love = save_data.love
        player.gold = save_data.gold
        player.exp = save_data.exp
        inventory:setWeapon(save_data.weapon)
        inventory:setArmor(save_data.armor)
        player.gold = save_data.gold

        overworld_menu.has_cell = save_data.has_cell

        for i = 1, #save_data.flag do
            flag[i] = save_data.flag[i]
        end

        --Inventory
        inventory:create()
        for i, item in pairs(save_data.inventory) do
            inventory:addItem(item)
        end

        print("Loaded from ".. filename.." successfully!")
    end

    print("----------------   "..Plus.loaded_mod)

end

return dt