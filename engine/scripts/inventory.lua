local inventory = {}

function inventory:create()
    inventory.items = {}
end

function inventory:addItem(id)
    if #inventory.items < 8 then
        local item = require (mod_loaded ..'scripts.data.items.' ..id)
        table.insert(inventory.items, item)
        inventory.items[#inventory.items].id = id
        inventory.items[#inventory.items]:init()
    else
        Textbox:create()
        Textbox:pageParams("* You can't carry any more.")
    end
end

function inventory:useItem(id)
    local item = inventory.items[id]
    local finText = ""
    if item.type == "reg" then
        local text = "You recovered " .. item.power.. " HP!"

        player.hp = player.hp +item.power
        player.hp = math.max(player.hp, 0)
        player.hp = math.min(player.hp, player.hpmax)

        if player.hp == player.hpmax then
            text = "Your HP was maxed out."
        end
        finText = "* You ate the " ..item.name ..".^* ".. text
    elseif item.type == "atk" then
        local prev = player.weapon.id
        inventory:setWeapon(item.id)
        if prev ~= "" then
            inventory:addItem(prev)
        end
        finText = "* You equipped the ".. item.name.."."
    elseif item.type == "def" then
        local prev = player.armor.id
        inventory:setArmor(item.id)
        if prev ~= "" then
            inventory:addItem(prev)
        end
        finText = "* You equipped the ".. item.name.."."
    end

    table.remove(inventory.items, id)
    return finText
end

function inventory:setWeapon(id)
    player.weapon = require (mod_loaded ..'scripts.data.items.' ..id)
    player.weapon.id = id
    player.weapon:init()
end

function inventory:setArmor(id)
    player.armor = require (mod_loaded ..'scripts.data.items.' ..id)
    player.armor.id = id
    player.armor:init()
end

return inventory