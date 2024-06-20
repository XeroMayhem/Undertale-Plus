local item = {}

function item:init()
    item.name = "Fur Armour"
    item.type = "def"
    item.power = 3
    item.desc = "* \""..item.name.."\" - Armour DF " .. item.power.."^* A vest covered in white dog fur."
end

return item