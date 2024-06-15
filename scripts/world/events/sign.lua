local x = 0
local y = 0
for i, obj in pairs(gameMap.layers["Objects"].objects) do
    if obj.name == "sign" then
        x = obj.x *2
        y = obj.y *2
    end
end

local SignEvent = instance:create(x, y, 'assets/sprites/npcs/sign.png', nil, 20, 10, 0, -5)
SignEvent.index = "sign"

function SignEvent:onInteract()
    local text = gameMap:getObjectProperties("Objects", SignEvent.index).text
    Textbox:create({text})
end

return SignEvent