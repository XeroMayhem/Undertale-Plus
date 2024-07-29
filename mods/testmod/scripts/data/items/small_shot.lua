local item = {}

function item:init()
    item.name = "{small shot}"
    item.btname = "* smallshot"
    item.type = "atk"
    item.power = 1
    item.hits = 1
    item.hit_speed = 5
    item.desc = "* \""..item.name.."\" - Weapon AT " .. item.power.."^* A REAL [[small]] SHOT MOVE KID!^* INCREASE'S ATTACK BY [99 Cents]!!!!"
end

return item