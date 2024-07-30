local item = {}

function item:init()
    item.name = "Bandana"
    item.btname = "* Bandana"
    item.type = "def"
    item.power = 0
    item.desc = "* \""..item.name.."\" - Armour DF " .. item.power.."^* A red bandana. It hates blue."
end

return item