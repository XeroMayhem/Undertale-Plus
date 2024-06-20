local inventory = {}

function inventory:create()
    inventory.items = {}
end

function inventory:addItem(id)
    if #inventory.items < 8 then
        local item = require (mod_loaded ..'scripts.data.items.' ..id)
        table.insert(inventory.items, item)
        inventory.items.id = id
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
        local prev = player.weapon
        player.weapon = item.id
        if prev ~= "" then
            inventory:addItem(prev)
        end
        finText = "* You equipped the ".. item.name.."."
    elseif item.type == "def" then
        local prev = player.armour
        player.armour = item.id
        if prev ~= "" then
            inventory:addItem(prev)
        end
        finText = "* You equipped the ".. item.name.."."
    end

    table.remove(inventory.items, id)
    return finText
end

return inventory