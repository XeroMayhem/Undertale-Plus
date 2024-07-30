local item = {}

function item:init()
    item.name = "Toy Gun"
    item.btname = "* Toy Gun"
    item.type = "atk"
    item.power = 5
    item.hits = 1
    item.hit_speed = 5
    item.desc = "* \""..item.name.."\" - Weapon AT " .. item.power.."^* A Toy Gun, you've had it since you were 5."
end

return item